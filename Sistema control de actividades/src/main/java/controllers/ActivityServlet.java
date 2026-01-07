package controllers;

import utils.DBConnection;
import utils.EmailUtil;
import java.io.*;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig
public class ActivityServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Establecer codificación UTF-8 para manejar acentos y ñ
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if ("save".equalsIgnoreCase(action)) {
            saveActivity(request, response);
        } else {
            // Si no se reconoce la acción, redirigir a alguna página
            response.sendRedirect("activityForm_jefe.jsp");
        }
    }

    /**
     * Guarda (crea) una nueva actividad, permitiendo subir múltiples archivos (cualquier tipo),
     * asignar a múltiples operativos, y enviar correo a cada uno.
     */
    private void saveActivity(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Verificar sesión
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = (Integer) session.getAttribute("userId");
        int roleId = (Integer) session.getAttribute("roleId");

        // Obtener parámetros obligatorios
        String title = request.getParameter("title");
        String priority = request.getParameter("priority");
        String dueDateStr = request.getParameter("due_date");
        // Destinatarios múltiples
        String[] assignedArr = request.getParameterValues("assigned_to");

        // Opcional
        String description = request.getParameter("description");

        // Validar
        if (title == null || title.trim().isEmpty() ||
            priority == null || priority.trim().isEmpty() ||
            dueDateStr == null || dueDateStr.trim().isEmpty() ||
            assignedArr == null || assignedArr.length == 0) {

            request.setAttribute("error", "Faltan campos obligatorios: título, prioridad, fecha/hora o destinatarios.");
            request.getRequestDispatcher("activityForm_jefe.jsp").forward(request, response);
            return;
        }

        // Parsear la fecha/hora
        Timestamp dueTs;
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            LocalDateTime ldt = LocalDateTime.parse(dueDateStr, formatter);
            dueTs = Timestamp.valueOf(ldt);
        } catch (Exception e) {
            request.setAttribute("error", "Formato de fecha/hora inválido.");
            request.getRequestDispatcher("activityForm_jefe.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement psAct = null;
        ResultSet rsKey = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // 1) Insertar la actividad con assigned_to = NULL inicialmente
            String sqlAct = "INSERT INTO seguimiento_actividades.activities "
                          + "(title, description, priority, due_date, assigned_by, assigned_to, creation_date, status) "
                          + "VALUES (?, ?, ?, ?, ?, NULL, NOW(), 'Pendiente') RETURNING id";
            psAct = conn.prepareStatement(sqlAct);
            psAct.setString(1, title.trim());
            psAct.setString(2, (description == null ? "" : description.trim()));
            psAct.setString(3, priority.trim());
            psAct.setTimestamp(4, dueTs);
            psAct.setInt(5, userId);
            rsKey = psAct.executeQuery();

            int activityId = -1;
            if (rsKey.next()) {
                activityId = rsKey.getInt("id");
            }
            rsKey.close();
            psAct.close();

            // 2) Procesar múltiples archivos adjuntos (input name="files", multiple)
            Collection<Part> parts = request.getParts();
            for (Part part : parts) {
                if ("files".equals(part.getName()) && part.getSize() > 0) {
                    // Carpeta "uploads" (mismo criterio que en ThreadServlet)
                    String uploadsDir = getServletContext().getRealPath("") + File.separator + "uploads";
                    File folder = new File(uploadsDir);
                    if (!folder.exists()) {
                        folder.mkdirs();
                    }
                    String fileName = getFileName(part);
                    String newFileName = System.currentTimeMillis() + "_" + fileName;
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
                    String sqlAttach = "INSERT INTO seguimiento_actividades.attachments (activity_id, file_path, uploaded_at) "
                                     + "VALUES (?, ?, NOW())";
                    try (PreparedStatement psAttach = conn.prepareStatement(sqlAttach)) {
                        psAttach.setInt(1, activityId);
                        psAttach.setString(2, filePath);
                        psAttach.executeUpdate();
                    }
                }
            }

            // 3) Insertar múltiples destinatarios en la tabla activity_collaborators
            String sqlCol = "INSERT INTO seguimiento_actividades.activity_collaborators (activity_id, user_id, created_at) "
                          + "VALUES (?, ?, NOW())";
            try (PreparedStatement psC = conn.prepareStatement(sqlCol)) {
                for (String sUid : assignedArr) {
                    int uid = Integer.parseInt(sUid);
                    psC.setInt(1, activityId);
                    psC.setInt(2, uid);
                    psC.addBatch();
                }
                psC.executeBatch();
            }

            // 4) Actualizar el campo assigned_to con el primer destinatario (destinatario "principal")
            int principalUser = Integer.parseInt(assignedArr[0]);
            String sqlPrin = "UPDATE seguimiento_actividades.activities SET assigned_to = ? WHERE id = ?";
            try (PreparedStatement psPrin = conn.prepareStatement(sqlPrin)) {
                psPrin.setInt(1, principalUser);
                psPrin.setInt(2, activityId);
                psPrin.executeUpdate();
            }

            // 5) Enviar correo a cada destinatario
            String sqlUser = "SELECT institutional_email, full_name FROM seguimiento_actividades.users WHERE id = ?";
            try (PreparedStatement psU = conn.prepareStatement(sqlUser)) {
                for (String sUid : assignedArr) {
                    int uid = Integer.parseInt(sUid);
                    psU.setInt(1, uid);
                    try (ResultSet rsU = psU.executeQuery()) {
                        if (rsU.next()) {
                            String recipientEmail = rsU.getString("institutional_email");
                            String recipientName  = rsU.getString("full_name");
                            String subject = "Nueva actividad asignada: " + title.trim();
                            String msg = "<html><body>"
                                    + "<h3>¡Hola " + (recipientName == null ? "" : recipientName) + "!</h3>"
                                    + "<p>Se te ha asignado una nueva actividad en el sistema.</p>"
                                    + "<ul>"
                                    + "<li><strong>📌 Título:</strong> " + title + "</li>"
                                    + "<li><strong>⏳ Prioridad:</strong> " + priority + "</li>"
                                    + "<li><strong>📅 Fecha y Hora de Entrega:</strong> " + dueDateStr + "</li>"
                                    + "</ul>"
                                    + "<p>Puedes acceder al sistema para ver más detalles:</p>"
                                    + "<p><a href='http://10.107.12.36:8080/actividades/login.jsp'>Acceder al Sistema</a></p>"
                                    + "<br><br><strong>Saludos,</strong><br>Sistema de Seguimiento de Actividades."
                                    + "</body></html>";
                            EmailUtil.sendEmail(recipientEmail, subject, msg);
                        }
                    }
                }
            }

            conn.commit();
            request.setAttribute("message", "Actividad asignada exitosamente a los colaboradores.");
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try { conn.rollback(); } catch (Exception ex2) { ex2.printStackTrace(); }
            }
            request.setAttribute("error", "Error al asignar la actividad: " + e.getMessage());
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (Exception e) { }
            }
        }

        // Redirigir al formulario con el mensaje correspondiente
        // (si subdirector => "assignActivity.jsp", si jefe => "activityForm_jefe.jsp", etc.)
        // En tu caso, este JSP es para el jefe, se mantiene:
        if (roleId == 1) {
            // Subdirector (por si lo usas en otro JSP)
            request.getRequestDispatcher("assignActivity.jsp").forward(request, response);
        } else {
            // Jefe
            request.getRequestDispatcher("activityForm_jefe.jsp").forward(request, response);
        }
    }

    /**
     * Método auxiliar para obtener el nombre original del archivo subido (sin restricciones).
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
