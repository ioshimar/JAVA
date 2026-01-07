package controllers;

import utils.DBConnection;
import utils.EmailUtil;
import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig
public class ThreadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ajustar codificación a UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if ("addComment".equalsIgnoreCase(action)) {
            addComment(request, response);
        } else if ("markFinished".equalsIgnoreCase(action)) {
            markActivityFinished(request, response);
        } else if ("reassignActivity".equalsIgnoreCase(action)) {
            reassignActivity(request, response);
        } else if ("deleteActivity".equalsIgnoreCase(action)) {
            deleteActivity(request, response);
        } else if ("updateDueDate".equalsIgnoreCase(action)) {
            updateDueDate(request, response);
        } else if ("updateCollaborators".equalsIgnoreCase(action)) {
            updateCollaborators(request, response);
        } else {
            response.sendRedirect("dashboard.jsp");
        }
    }

    /**
     * Agrega un comentario a la actividad, procesando múltiples archivos adjuntos (cualquier tipo),
     * y envía correo de notificación a todos los participantes excepto a quien escribió.
     */
    private void addComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No has iniciado sesión.");
            return;
        }
        int userId = (Integer) session.getAttribute("userId");
        String activityIdParam = request.getParameter("activityId");
        String comment = request.getParameter("comment");
        if (activityIdParam == null || comment == null || comment.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Faltan datos para comentar.");
            return;
        }
        int activityId = Integer.parseInt(activityIdParam);

        Connection conn = null;
        PreparedStatement ps = null, psAttach = null;
        ResultSet rsKey = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // 1) Insertar comentario en activity_threads
            String sqlThread = "INSERT INTO seguimiento_actividades.activity_threads "
                             + "(activity_id, user_id, comment, comment_date) "
                             + "VALUES (?, ?, ?, NOW()) RETURNING id";
            ps = conn.prepareStatement(sqlThread);
            ps.setInt(1, activityId);
            ps.setInt(2, userId);
            ps.setString(3, comment.trim());
            rsKey = ps.executeQuery();
            int threadId = -1;
            if (rsKey.next()) {
                threadId = rsKey.getInt("id");
            }
            rsKey.close();
            ps.close();

            // 2) Procesar múltiples archivos adjuntos
            List<String> attachedFileNames = new ArrayList<>();
            Collection<Part> parts = request.getParts();
            for (Part part : parts) {
                if ("files".equals(part.getName()) && part.getSize() > 0) {
                    String uploadsDir = getServletContext().getRealPath("") + File.separator + "uploads";
                    File folder = new File(uploadsDir);
                    if (!folder.exists()) folder.mkdirs();

                    String originalName = getFileName(part);
                    String safeName = originalName.replaceAll("[^A-Za-z0-9._-]", "_");
                    String newFileName = System.currentTimeMillis() + "_" + safeName;

                    File fileToSave = new File(folder, newFileName);
                    try (InputStream in = part.getInputStream();
                         FileOutputStream out = new FileOutputStream(fileToSave)) {
                        byte[] buffer = new byte[1024];
                        int len;
                        while ((len = in.read(buffer)) != -1) {
                            out.write(buffer, 0, len);
                        }
                    }
                    String filePath = "uploads/" + newFileName;

                    // Insertar en attachments
                    String sqlAttach = "INSERT INTO seguimiento_actividades.attachments "
                                     + "(thread_id, file_path, uploaded_at, activity_id) "
                                     + "VALUES (?, ?, NOW(), ?)";
                    psAttach = conn.prepareStatement(sqlAttach);
                    psAttach.setInt(1, threadId);
                    psAttach.setString(2, filePath);
                    psAttach.setInt(3, activityId);
                    psAttach.executeUpdate();
                    psAttach.close();

                    attachedFileNames.add(originalName);
                }
            }

            // 3) Si es el primer comentario => estado = "En Progreso" si estaba "Pendiente"
            String sqlCount = "SELECT COUNT(*) FROM seguimiento_actividades.activity_threads WHERE activity_id=?";
            try (PreparedStatement psCount = conn.prepareStatement(sqlCount)) {
                psCount.setInt(1, activityId);
                try (ResultSet rsCount = psCount.executeQuery()) {
                    if (rsCount.next()) {
                        int totalComments = rsCount.getInt(1);
                        if (totalComments == 1) {
                            String sqlUpdate = "UPDATE seguimiento_actividades.activities "
                                             + "SET status='En Progreso' "
                                             + "WHERE id=? AND status='Pendiente'";
                            try (PreparedStatement psUp = conn.prepareStatement(sqlUpdate)) {
                                psUp.setInt(1, activityId);
                                psUp.executeUpdate();
                            }
                        }
                    }
                }
            }

            // 4) Enviar correo a todos los participantes excepto el autor
            int assignedBy = 0, assignedTo = 0;
            String actTitle = "";
            String sqlAct = "SELECT assigned_by, assigned_to, title FROM seguimiento_actividades.activities WHERE id=?";
            try (PreparedStatement psA = conn.prepareStatement(sqlAct)) {
                psA.setInt(1, activityId);
                try (ResultSet rsA = psA.executeQuery()) {
                    if (rsA.next()) {
                        assignedBy = rsA.getInt("assigned_by");
                        assignedTo = rsA.getInt("assigned_to");
                        actTitle = rsA.getString("title");
                    }
                }
            }
            Set<Integer> participantIds = new HashSet<>();
            participantIds.add(assignedBy);
            participantIds.add(assignedTo);

            String sqlCols = "SELECT user_id FROM seguimiento_actividades.activity_collaborators WHERE activity_id=?";
            try (PreparedStatement psCols = conn.prepareStatement(sqlCols)) {
                psCols.setInt(1, activityId);
                try (ResultSet rsCols = psCols.executeQuery()) {
                    while (rsCols.next()) {
                        participantIds.add(rsCols.getInt("user_id"));
                    }
                }
            }
            participantIds.remove(userId);

            String adjuntosList = "";
            if(!attachedFileNames.isEmpty()){
                adjuntosList = "<p>Archivos adjuntos subidos:</p><ul>";
                for(String fn : attachedFileNames){
                    adjuntosList += "<li>" + fn + "</li>";
                }
                adjuntosList += "</ul>";
            }
            // Nombre del usuario que comenta
            String userNameWhoComment = "";
            String sqlUser = "SELECT full_name FROM seguimiento_actividades.users WHERE id=?";
            try (PreparedStatement psU = conn.prepareStatement(sqlUser)) {
                psU.setInt(1, userId);
                try (ResultSet rsU = psU.executeQuery()) {
                    if(rsU.next()){
                        userNameWhoComment = rsU.getString("full_name");
                    }
                }
            }

            String subject = "[Sistema] Nuevo comentario en la actividad: " + actTitle;
            String msgHtml = "<html><body>"
                           + "<p>Hola,</p>"
                           + "<p>El usuario <b>" + userNameWhoComment + "</b> ha publicado un nuevo comentario "
                           + "en la actividad <b>" + actTitle + "</b>.</p>"
                           + "<p>Mensaje: " + comment + "</p>"
                           + adjuntosList
                           + "<p>Puedes ver la actividad y el comentario en el sistema.</p>"
                           + "</body></html>";

            if(!participantIds.isEmpty()){
                String sqlMail = "SELECT institutional_email FROM seguimiento_actividades.users WHERE id=?";
                try (PreparedStatement psM = conn.prepareStatement(sqlMail)) {
                    for(Integer pid : participantIds){
                        psM.setInt(1, pid);
                        try(ResultSet rsM = psM.executeQuery()){
                            if(rsM.next()){
                                String email = rsM.getString("institutional_email");
                                if(email != null && !email.trim().isEmpty()){
                                    EmailUtil.sendEmail(email, subject, msgHtml);
                                }
                            }
                        }
                    }
                }
            }

            conn.commit();
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (Exception ex2) { ex2.printStackTrace(); }
            }
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al agregar comentario.");
        } finally {
            if (rsKey != null) try { rsKey.close(); } catch (Exception e) { }
            if (ps != null) try { ps.close(); } catch (Exception e) { }
            if (psAttach != null) try { psAttach.close(); } catch (Exception e) { }
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (Exception e) { }
            }
        }
    }

    /**
     * Marcar actividad como terminada. 
     * Subdirector (1) o Jefe (2) pueden hacerlo.
     */
    private void markActivityFinished(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No has iniciado sesión.");
            return;
        }
        int roleId = (Integer) session.getAttribute("roleId");
        // Permitir a roleId 1 o 2
        if (roleId != 1 && roleId != 2) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "No tienes permisos para terminar.");
            return;
        }
        String actIdParam = request.getParameter("activityId");
        if (actIdParam == null || actIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Falta activityId.");
            return;
        }
        int activityId = Integer.parseInt(actIdParam);
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE seguimiento_actividades.activities SET status='Terminado' WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, activityId);
            ps.executeUpdate();
            ps.close();
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al terminar la actividad.");
        }
    }

    /**
     * Reasignar actividad. 
     * Ahora permitir también al subdirector (1) y jefe (2).
     */
    private void reassignActivity(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No has iniciado sesión.");
            return;
        }
        int roleId = (Integer) session.getAttribute("roleId");
        // Permitir roleId=1 (subdirector) o roleId=2 (jefe)
        if (roleId != 1 && roleId != 2) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Solo el subdirector o el jefe pueden reasignar.");
            return;
        }

        String actIdParam = request.getParameter("activityId");
        String[] assignedUsers = request.getParameterValues("newAssignedTo");
        if (actIdParam == null || assignedUsers == null || assignedUsers.length == 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Faltan datos para reasignar.");
            return;
        }
        int activityId = Integer.parseInt(actIdParam);
        int currentUserId = (Integer) session.getAttribute("userId");

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Nombre del asignador original
            String originalAssigner = "";
            String sqlOrig = "SELECT u.full_name FROM seguimiento_actividades.activities a "
                           + "JOIN seguimiento_actividades.users u ON a.assigned_by = u.id "
                           + "WHERE a.id = ?";
            try(PreparedStatement psOrig = conn.prepareStatement(sqlOrig)){
                psOrig.setInt(1, activityId);
                try(ResultSet rsOrig = psOrig.executeQuery()){
                    if(rsOrig.next()){
                        originalAssigner = rsOrig.getString("full_name");
                    }
                }
            }

            // Quien reasigna
            String reassignerName = "";
            String sqlReassigner = "SELECT full_name FROM seguimiento_actividades.users WHERE id = ?";
            try(PreparedStatement psReassigner = conn.prepareStatement(sqlReassigner)){
                psReassigner.setInt(1, currentUserId);
                try(ResultSet rsReassigner = psReassigner.executeQuery()){
                    if(rsReassigner.next()){
                        reassignerName = rsReassigner.getString("full_name");
                    }
                }
            }

            // delegation_note y status = 'En Progreso'
            String newDelegationNote = "Reasignado por: " + reassignerName
                    + " (Original asignado por: " + originalAssigner + ")";
            String sqlActUpd = "UPDATE seguimiento_actividades.activities "
                             + "SET delegation_note = ?, status = 'En Progreso' "
                             + "WHERE id = ? AND status IN ('Pendiente','En Progreso')";
            try(PreparedStatement psUpd = conn.prepareStatement(sqlActUpd)){
                psUpd.setString(1, newDelegationNote);
                psUpd.setInt(2, activityId);
                int rows = psUpd.executeUpdate();
                if (rows == 0) {
                    conn.rollback();
                    response.sendError(HttpServletResponse.SC_CONFLICT, "No se pudo reasignar (quizá está Terminada).");
                    return;
                }
            }

            // Borrar colabs previos
            String sqlDel = "DELETE FROM seguimiento_actividades.activity_collaborators WHERE activity_id = ?";
            try(PreparedStatement psDel = conn.prepareStatement(sqlDel)){
                psDel.setInt(1, activityId);
                psDel.executeUpdate();
            }

            // Insertar nuevos colabs
            String sqlIns = "INSERT INTO seguimiento_actividades.activity_collaborators (activity_id, user_id) VALUES (?, ?)";
            try(PreparedStatement psIns = conn.prepareStatement(sqlIns)){
                for (String userIdStr : assignedUsers) {
                    int uid = Integer.parseInt(userIdStr);
                    psIns.setInt(1, activityId);
                    psIns.setInt(2, uid);
                    psIns.addBatch();
                }
                psIns.executeBatch();
            }

            // Actualizar assigned_to = primer usuario
            int principalUser = Integer.parseInt(assignedUsers[0]);
            String sqlPrin = "UPDATE seguimiento_actividades.activities SET assigned_to = ? WHERE id = ?";
            try(PreparedStatement psPrin = conn.prepareStatement(sqlPrin)){
                psPrin.setInt(1, principalUser);
                psPrin.setInt(2, activityId);
                psPrin.executeUpdate();
            }

            // Enviar correo a cada reasignado
            String sqlActInfo = "SELECT title, priority, due_date FROM seguimiento_actividades.activities WHERE id = ?";
            String actTitle = null, actPriority = null, dueDateStr = "";
            try(PreparedStatement psA = conn.prepareStatement(sqlActInfo)){
                psA.setInt(1, activityId);
                try(ResultSet rsA = psA.executeQuery()){
                    if(rsA.next()){
                        actTitle = rsA.getString("title");
                        actPriority = rsA.getString("priority");
                        Timestamp dueTs = rsA.getTimestamp("due_date");
                        if (dueTs != null) dueDateStr = dueTs.toString();
                    }
                }
            }

            String sqlUser = "SELECT institutional_email, full_name FROM seguimiento_actividades.users WHERE id = ?";
            try(PreparedStatement psU = conn.prepareStatement(sqlUser)){
                for (String userIdStr : assignedUsers) {
                    int uid = Integer.parseInt(userIdStr);
                    psU.setInt(1, uid);
                    try(ResultSet rsU = psU.executeQuery()){
                        if (rsU.next()){
                            String email = rsU.getString("institutional_email");
                            String fullname = rsU.getString("full_name");
                            if (email != null && actTitle != null){
                                String subject = "[Sistema] Se te reasignó la actividad: " + actTitle;
                                String msg = "<html><body>"
                                        + "<p>Hola " + (fullname != null ? fullname : "") + ",</p>"
                                        + "<p>Se te ha reasignado la actividad <b>" + actTitle + "</b> "
                                        + "con prioridad <b>" + actPriority + "</b>.<br>"
                                        + "Originalmente asignada por: " + originalAssigner + "<br>"
                                        + "Reasignada por: " + reassignerName + "<br>"
                                        + "Fecha de entrega: " + dueDateStr + "</p>"
                                        + "<p>Accede al sistema:<br>"
                                        + "<a href='http://10.107.12.36:8080/actividades/login.jsp'>Acceder</a></p>"
                                        + "</body></html>";
                                EmailUtil.sendEmail(email, subject, msg);
                            }
                        }
                    }
                }
            }

            conn.commit();
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (Exception ex2) {}
            }
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al reasignar.");
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (Exception e) {}
            }
        }
    }

    /**
     * Eliminar la actividad si cumple condiciones.
     * Ahora permitir también subdirector (1) o jefe (2).
     */
    private void deleteActivity(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No has iniciado sesión.");
            return;
        }
        int currentUserId = (Integer) session.getAttribute("userId");
        int roleId = (Integer) session.getAttribute("roleId");
        // Permitir subdirector (1) o jefe (2)
        if (roleId != 1 && roleId != 2) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "No tienes permisos para eliminar.");
            return;
        }

        String actIdParam = request.getParameter("activityId");
        if (actIdParam == null || actIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Falta activityId.");
            return;
        }
        int activityId = Integer.parseInt(actIdParam);

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Verificar condiciones (que sea el asignador original y la actividad no esté terminada ni reasignada)
            String checkSql = "SELECT assigned_by, status, delegation_note, title "
                            + "FROM seguimiento_actividades.activities WHERE id=?";
            int assignedBy = 0;
            String status = null, delegationNote = null, actTitle = null;
            try (PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
                psCheck.setInt(1, activityId);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next()) {
                        assignedBy = rs.getInt("assigned_by");
                        status = rs.getString("status");
                        delegationNote = rs.getString("delegation_note");
                        actTitle = rs.getString("title");
                    } else {
                        conn.rollback();
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "La actividad no existe.");
                        return;
                    }
                }
            }

            if(assignedBy != currentUserId){
                conn.rollback();
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "No eres el asignador original.");
                return;
            }
            if("Terminado".equalsIgnoreCase(status)){
                conn.rollback();
                response.sendError(HttpServletResponse.SC_CONFLICT, "La actividad ya está terminada.");
                return;
            }
            if(delegationNote != null && !delegationNote.trim().isEmpty()){
                conn.rollback();
                response.sendError(HttpServletResponse.SC_CONFLICT, "No puedes eliminar una actividad reasignada.");
                return;
            }

            // Borrar en orden
            Set<Integer> collaborators = new HashSet<>();
            // Recolectar colabs para notificación
            int assignedTo = 0;
            String getAssignedToSql = "SELECT assigned_to FROM seguimiento_actividades.activities WHERE id=?";
            try(PreparedStatement psAt = conn.prepareStatement(getAssignedToSql)){
                psAt.setInt(1, activityId);
                try(ResultSet rsAt = psAt.executeQuery()){
                    if(rsAt.next()){
                        assignedTo = rsAt.getInt("assigned_to");
                    }
                }
            }
            collaborators.add(assignedBy);
            collaborators.add(assignedTo);

            String sqlCollabs = "SELECT user_id FROM seguimiento_actividades.activity_collaborators WHERE activity_id=?";
            try (PreparedStatement psCol = conn.prepareStatement(sqlCollabs)) {
                psCol.setInt(1, activityId);
                try (ResultSet rsCol = psCol.executeQuery()) {
                    while(rsCol.next()){
                        collaborators.add(rsCol.getInt("user_id"));
                    }
                }
            }

            try(PreparedStatement psDelCollab = conn.prepareStatement(
                "DELETE FROM seguimiento_actividades.activity_collaborators WHERE activity_id=?")) {
                psDelCollab.setInt(1, activityId);
                psDelCollab.executeUpdate();
            }
            try(PreparedStatement psDelAtt1 = conn.prepareStatement(
                "DELETE FROM seguimiento_actividades.attachments WHERE thread_id IN "
                + "(SELECT id FROM seguimiento_actividades.activity_threads WHERE activity_id=?)")) {
                psDelAtt1.setInt(1, activityId);
                psDelAtt1.executeUpdate();
            }
            try(PreparedStatement psDelAtt2 = conn.prepareStatement(
                "DELETE FROM seguimiento_actividades.attachments WHERE activity_id=? AND thread_id IS NULL")) {
                psDelAtt2.setInt(1, activityId);
                psDelAtt2.executeUpdate();
            }
            try(PreparedStatement psDelThreads = conn.prepareStatement(
                "DELETE FROM seguimiento_actividades.activity_threads WHERE activity_id=?")) {
                psDelThreads.setInt(1, activityId);
                psDelThreads.executeUpdate();
            }
            try(PreparedStatement psDelLogs = conn.prepareStatement(
                "DELETE FROM seguimiento_actividades.activity_logs WHERE activity_id=?")) {
                psDelLogs.setInt(1, activityId);
                psDelLogs.executeUpdate();
            }
            try(PreparedStatement psDelAct = conn.prepareStatement(
                "DELETE FROM seguimiento_actividades.activities WHERE id=?")) {
                psDelAct.setInt(1, activityId);
                psDelAct.executeUpdate();
            }

            // Enviar correo
            if(!collaborators.isEmpty()){
                String subject = "[Sistema] Se ha eliminado la actividad: " + (actTitle != null ? actTitle : "");
                String msg = "<html><body>"
                           + "<p>Estimado colaborador,</p>"
                           + "<p>La actividad <b>" + (actTitle != null ? actTitle : "Desconocida") + "</b> "
                           + "ha sido <strong>eliminada</strong> por su asignador.</p>"
                           + "<p>Si requieres más información, comunícate con el asignador.</p>"
                           + "</body></html>";

                String sqlMail = "SELECT institutional_email FROM seguimiento_actividades.users WHERE id=?";
                try(PreparedStatement psM = conn.prepareStatement(sqlMail)){
                    for(Integer colId : collaborators){
                        psM.setInt(1, colId);
                        try(ResultSet rsM = psM.executeQuery()){
                            if(rsM.next()){
                                String email = rsM.getString("institutional_email");
                                if(email != null && !email.isEmpty()){
                                    EmailUtil.sendEmail(email, subject, msg);
                                }
                            }
                        }
                    }
                }
            }

            conn.commit();
            response.setStatus(HttpServletResponse.SC_OK);

        } catch(Exception e){
            if(conn != null){
                try{ conn.rollback(); } catch(Exception ex2){}
            }
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al eliminar.");
        } finally {
            if(conn != null){
                try{ conn.setAutoCommit(true); conn.close(); } catch(Exception e){}
            }
        }
    }

    /**
     * Actualiza la fecha de entrega, permitiendo también al subdirector (1) y no solo al jefe (2).
     */
    private void updateDueDate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("userId") == null){
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No has iniciado sesión.");
            return;
        }
        int currentUserId = (Integer) session.getAttribute("userId");
        int roleId = (Integer) session.getAttribute("roleId");
        // Permitir 1 o 2
        if(roleId != 1 && roleId != 2){
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "No tienes permisos para actualizar fecha.");
            return;
        }
        String actIdParam = request.getParameter("activityId");
        String newDueDateStr = request.getParameter("newDueDate");
        if(actIdParam == null || newDueDateStr == null){
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Faltan datos de fecha.");
            return;
        }
        int activityId = Integer.parseInt(actIdParam);

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            String sqlCheck = "SELECT assigned_by, status, delegation_note, title, due_date "
                            + "FROM seguimiento_actividades.activities WHERE id=?";
            int assignedBy = 0;
            String status = null;
            String delegationNote = null;
            String actTitle = null;
            Timestamp oldDueDate = null;
            try(PreparedStatement psC = conn.prepareStatement(sqlCheck)){
                psC.setInt(1, activityId);
                try(ResultSet rs = psC.executeQuery()){
                    if(rs.next()){
                        assignedBy = rs.getInt("assigned_by");
                        status = rs.getString("status");
                        delegationNote = rs.getString("delegation_note");
                        actTitle = rs.getString("title");
                        oldDueDate = rs.getTimestamp("due_date");
                    } else {
                        conn.rollback();
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "La actividad no existe.");
                        return;
                    }
                }
            }
            // Debe ser el asignador original
            if(assignedBy != currentUserId){
                conn.rollback();
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "No eres el asignador original.");
                return;
            }
            if("Terminado".equalsIgnoreCase(status)){
                conn.rollback();
                response.sendError(HttpServletResponse.SC_CONFLICT, "La actividad ya está terminada.");
                return;
            }
            if(delegationNote != null && !delegationNote.trim().isEmpty()){
                conn.rollback();
                response.sendError(HttpServletResponse.SC_CONFLICT, "No se puede cambiar fecha en actividad reasignada.");
                return;
            }

            Timestamp newDue = Timestamp.valueOf(newDueDateStr.replace("T"," ") + ":00");

            String sqlUpd = "UPDATE seguimiento_actividades.activities SET due_date=? WHERE id=?";
            try(PreparedStatement psU = conn.prepareStatement(sqlUpd)){
                psU.setTimestamp(1, newDue);
                psU.setInt(2, activityId);
                psU.executeUpdate();
            }

            // Notificar a colaboradores
            Set<Integer> colabs = new HashSet<>();
            colabs.add(assignedBy);
            int assignedTo = 0;
            String sqlAss = "SELECT assigned_to FROM seguimiento_actividades.activities WHERE id=?";
            try(PreparedStatement psAt = conn.prepareStatement(sqlAss)){
                psAt.setInt(1, activityId);
                try(ResultSet rsAt = psAt.executeQuery()){
                    if(rsAt.next()){
                        assignedTo = rsAt.getInt("assigned_to");
                    }
                }
            }
            colabs.add(assignedTo);

            String sqlCol = "SELECT user_id FROM seguimiento_actividades.activity_collaborators WHERE activity_id=?";
            try(PreparedStatement psCol = conn.prepareStatement(sqlCol)){
                psCol.setInt(1, activityId);
                try(ResultSet rsC2 = psCol.executeQuery()){
                    while(rsC2.next()){
                        colabs.add(rsC2.getInt("user_id"));
                    }
                }
            }

            String oldDateStr = (oldDueDate != null) ? oldDueDate.toString() : "(no había fecha)";
            String newDateStr = (newDue != null) ? newDue.toString() : "(nueva fecha desconocida)";
            String subject = "[Sistema] Se modificó la fecha de entrega de la actividad: " + (actTitle != null ? actTitle : "");
            String msg = "<html><body>"
                       + "<p>Hola colaborador,</p>"
                       + "<p>Se ha <strong>modificado</strong> la fecha de entrega de la actividad "
                       + "<b>" + (actTitle != null ? actTitle : "") + "</b>.<br>"
                       + "Fecha anterior: <b>" + oldDateStr + "</b><br>"
                       + "Nueva fecha de entrega: <b>" + newDateStr + "</b></p>"
                       + "<p>Puedes acceder al sistema para más detalles.</p>"
                       + "</body></html>";

            if(!colabs.isEmpty()){
                String sqlMail = "SELECT institutional_email FROM seguimiento_actividades.users WHERE id=?";
                try(PreparedStatement psM = conn.prepareStatement(sqlMail)){
                    for(Integer uid : colabs){
                        psM.setInt(1, uid);
                        try(ResultSet rsM = psM.executeQuery()){
                            if(rsM.next()){
                                String email = rsM.getString("institutional_email");
                                if(email != null && !email.isEmpty()){
                                    EmailUtil.sendEmail(email, subject, msg);
                                }
                            }
                        }
                    }
                }
            }

            conn.commit();
            response.setStatus(HttpServletResponse.SC_OK);
        } catch(Exception e){
            if(conn != null){
                try{ conn.rollback();}catch(Exception ex2){}
            }
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al actualizar fecha.");
        } finally {
            if(conn != null){
                try{ conn.setAutoCommit(true); conn.close(); } catch(Exception e){}
            }
        }
    }

    /**
     * Actualiza la lista de colaboradores.
     * Subdirector (1) o jefe (2) pueden hacerlo.
     */
     private void updateCollaborators(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("userId") == null){
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No has iniciado sesión.");
            return;
        }
        int roleId = (Integer) session.getAttribute("roleId");
        // CAMBIO AQUI: permitir subdirector(1) Y jefe(2)
        if(roleId != 1 && roleId != 2){
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "No tienes permisos para editar colaboradores.");
            return;
        }

        String actIdParam = request.getParameter("activityId");
        String[] newCollabsParam = request.getParameterValues("collaboratorsSelected");
        if(actIdParam == null || newCollabsParam == null){
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Faltan datos de colaboradores.");
            return;
        }
        int activityId = Integer.parseInt(actIdParam);

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Obtenemos la lista previa de colaboradores
            Set<Integer> oldCollabs = new HashSet<>();
            String sqlOld = "SELECT user_id FROM seguimiento_actividades.activity_collaborators WHERE activity_id=?";
            try(PreparedStatement psOld = conn.prepareStatement(sqlOld)){
                psOld.setInt(1, activityId);
                try(ResultSet rsO = psOld.executeQuery()){
                    while(rsO.next()){
                        oldCollabs.add(rsO.getInt("user_id"));
                    }
                }
            }

            // Construimos la nueva lista
            Set<Integer> newCollabs = new HashSet<>();
            for(String uidStr : newCollabsParam){
                newCollabs.add(Integer.parseInt(uidStr));
            }

            // Identificamos quiénes se agregaron
            Set<Integer> added = new HashSet<>(newCollabs);
            added.removeAll(oldCollabs);

            // Identificamos quiénes se quitaron
            Set<Integer> removed = new HashSet<>(oldCollabs);
            removed.removeAll(newCollabs);

            // 1) Eliminamos los removidos
            if(!removed.isEmpty()){
                String sqlDel = "DELETE FROM seguimiento_actividades.activity_collaborators "
                              + "WHERE activity_id=? AND user_id=?";
                try(PreparedStatement psDel = conn.prepareStatement(sqlDel)){
                    for(Integer r : removed){
                        psDel.setInt(1, activityId);
                        psDel.setInt(2, r);
                        psDel.addBatch();
                    }
                    psDel.executeBatch();
                }
            }

            // 2) Insertamos los nuevos
            if(!added.isEmpty()){
                String sqlIns = "INSERT INTO seguimiento_actividades.activity_collaborators (activity_id, user_id) VALUES (?, ?)";
                try(PreparedStatement psIns = conn.prepareStatement(sqlIns)){
                    for(Integer a : added){
                        psIns.setInt(1, activityId);
                        psIns.setInt(2, a);
                        psIns.addBatch();
                    }
                    psIns.executeBatch();
                }
            }

            // 3) Notificar por correo a los nuevos
            if(!added.isEmpty()){
                // Info de la actividad
                String sqlAct = "SELECT title, priority, due_date FROM seguimiento_actividades.activities WHERE id=?";
                String actTitle="", actPriority="", dueDateStr="";
                try(PreparedStatement psA = conn.prepareStatement(sqlAct)){
                    psA.setInt(1, activityId);
                    try(ResultSet rsA = psA.executeQuery()){
                        if(rsA.next()){
                            actTitle = rsA.getString("title");
                            actPriority = rsA.getString("priority");
                            Timestamp dts = rsA.getTimestamp("due_date");
                            if(dts != null) dueDateStr = dts.toString();
                        }
                    }
                }

                // Correo a cada nuevo
                String sqlUser = "SELECT institutional_email, full_name FROM seguimiento_actividades.users WHERE id=?";
                try(PreparedStatement psU = conn.prepareStatement(sqlUser)){
                    for(Integer a : added){
                        psU.setInt(1, a);
                        try(ResultSet rsU = psU.executeQuery()){
                            if(rsU.next()){
                                String email = rsU.getString("institutional_email");
                                String fullname = rsU.getString("full_name");
                                if(email != null && !email.isEmpty()){
                                    String subject = "[Sistema] Nueva tarea asignada: " + actTitle;
                                    String msg = "<html><body>"
                                            + "<p>Hola " + (fullname != null ? fullname : "") + ",</p>"
                                            + "<p>Se te ha asignado la actividad <b>" + actTitle + "</b> con prioridad "
                                            + "<b>" + actPriority + "</b>.<br>"
                                            + "Fecha de entrega: " + dueDateStr + "</p>"
                                            + "<p>Accede al sistema:<br>"
                                            + "<a href='http://10.107.12.36:8080/actividades/login.jsp'>Acceder</a></p>"
                                            + "</body></html>";
                                    EmailUtil.sendEmail(email, subject, msg);
                                }
                            }
                        }
                    }
                }
            }

            conn.commit();
            response.setStatus(HttpServletResponse.SC_OK);

        } catch(Exception e){
            if(conn != null){
                try{conn.rollback();}catch(Exception ex2){}
            }
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al actualizar colaboradores.");
        } finally {
            if(conn != null){
                try{conn.setAutoCommit(true); conn.close();}catch(Exception e){}
            }
        }
    }

    /**
     * Extraer el nombre de archivo de un Part.
     */
    private String getFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
