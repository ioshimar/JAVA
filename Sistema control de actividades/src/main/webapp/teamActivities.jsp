<%@ page import="java.sql.*, java.time.*, utils.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Actividades del Jefe de Departamento</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
      .hero-section {
        background: linear-gradient(to right, #002752, #003366);
        color: white;
        padding: 2rem;
        border-radius: 10px;
        margin-top: 2rem;
        box-shadow: 0 5px 15px rgba(0,0,0,0.3);
      }
      .section-title {
        margin-top: 2rem;
        margin-bottom: 1rem;
        font-weight: bold;
      }
      .pagination-links a {
        margin: 0 5px;
        text-decoration: none;
      }
      /* Dot para semáforo */
      .semaforo-dot {
        display: inline-block;
        width: 12px;
        height: 12px;
        border-radius: 50%;
        margin-right: 5px;
      }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="container">
    <div class="hero-section">
        <h1>Actividades - Jefe de Departamento</h1>
        <p class="lead">
            Visualiza las actividades que asignaste (directamente y reasignadas) y las que te asignaron a ti (sin delegar). Ahora con paginación.
        </p>
    </div>

    <%
        // Verificar sesión y rol (solo jefe)
        if(session.getAttribute("userId") == null){
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = (Integer) session.getAttribute("userId");
        int roleId = (Integer) session.getAttribute("roleId");
        if(roleId != 2){
            response.sendRedirect("dashboard.jsp");
            return;
        }

        // Parámetros de paginación
        int pageDirect=1, limitDirect=5;
        int pageReassigned=1, limitReassigned=5;
        int pageB=1, limitB=5;

        try{ pageDirect = Integer.parseInt(request.getParameter("pageDirect")); }catch(Exception e){}
        try{ pageReassigned = Integer.parseInt(request.getParameter("pageReassigned")); }catch(Exception e){}
        try{ pageB = Integer.parseInt(request.getParameter("pageB")); }catch(Exception e){}

        if(pageDirect<1) pageDirect=1;
        if(pageReassigned<1) pageReassigned=1;
        if(pageB<1) pageB=1;

        int offsetDirect = (pageDirect-1)*limitDirect;
        int offsetReassigned = (pageReassigned-1)*limitReassigned;
        int offsetB = (pageB-1)*limitB;
    %>

    <!-- Sección 1A: Actividades Asignadas Directamente -->
    <h3 class="section-title">Actividades Asignadas Directamente</h3>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Título</th>
                <th>Prioridad</th>
                <th>Estado</th>
                <th>Semáforo</th>
                <th>Fecha de Entrega</th>
                <th>Destinatarios</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        <%
            int totalRowsDirect=0;
            try(Connection conn = DBConnection.getConnection()){
                // Contar
                String sqlCountDirect = "SELECT COUNT(*) FROM seguimiento_actividades.activities a "
                    + "WHERE a.assigned_by=? AND (a.delegation_note IS NULL OR a.delegation_note='')";
                PreparedStatement psCountDirect = conn.prepareStatement(sqlCountDirect);
                psCountDirect.setInt(1, userId);
                try(ResultSet rsCD= psCountDirect.executeQuery()){
                    if(rsCD.next()) totalRowsDirect= rsCD.getInt(1);
                }
                psCountDirect.close();

                // Consulta: directas => sin delegación
                String sqlDirect = "SELECT a.id, a.title, a.priority, a.status, a.due_date, "
                    + "       string_agg(u.full_name, ', ') as assignedNames "
                    + "FROM seguimiento_actividades.activities a "
                    + "JOIN seguimiento_actividades.activity_collaborators ac ON a.id=ac.activity_id "
                    + "JOIN seguimiento_actividades.users u ON ac.user_id=u.id "
                    + "WHERE a.assigned_by=? "
                    + "  AND (a.delegation_note IS NULL OR a.delegation_note='') "
                    + "GROUP BY a.id, a.title, a.priority, a.status, a.due_date "
                    + "ORDER BY a.creation_date DESC OFFSET ? LIMIT ?";
                PreparedStatement psDirect = conn.prepareStatement(sqlDirect);
                psDirect.setInt(1, userId);
                psDirect.setInt(2, offsetDirect);
                psDirect.setInt(3, limitDirect);
                try(ResultSet rsD= psDirect.executeQuery()){
                    boolean noRowsDirect=true;
                    while(rsD.next()){
                        noRowsDirect=false;
                        int actId= rsD.getInt("id");
                        String ttl= rsD.getString("title");
                        String prio= rsD.getString("priority");
                        String st= rsD.getString("status");
                        Timestamp dueDate= rsD.getTimestamp("due_date");
                        String assignedNames= rsD.getString("assignedNames");

                        // Convertir prio en badge
                        String priorityBadgeClass="badge-secondary";
                        if("Alta".equalsIgnoreCase(prio)) priorityBadgeClass="badge-danger";
                        else if("Media".equalsIgnoreCase(prio)) priorityBadgeClass="badge-warning";
                        else if("Baja".equalsIgnoreCase(prio)) priorityBadgeClass="badge-secondary";

                        // Convertir status en badge
                        String statusBadgeClass="badge-secondary";
                        if("Pendiente".equalsIgnoreCase(st)) statusBadgeClass="badge-warning";
                        else if("En Progreso".equalsIgnoreCase(st)) statusBadgeClass="badge-info";
                        else if("Terminado".equalsIgnoreCase(st)) statusBadgeClass="badge-success";

                        // Semáforo: si no es "Terminado"
                        String semColor="";
                        if(!"Terminado".equalsIgnoreCase(st) && dueDate!=null){
                            LocalDateTime now= LocalDateTime.now();
                            LocalDateTime dd= dueDate.toLocalDateTime();
                            long hours= java.time.Duration.between(now, dd).toHours();
                            if(hours<=48) semColor="#d9534f"; // rojo
                            else semColor="#f0ad4e"; // amarillo
                        }
                        String fechaEntrega= (dueDate!=null? dueDate.toString():"");
        %>
            <tr>
                <td><%= ttl %></td>
                <td>
                  <span class="badge <%= priorityBadgeClass %>"><%= prio %></span>
                </td>
                <td>
                  <span class="badge <%= statusBadgeClass %>"><%= st %></span>
                </td>
                <td>
                  <%
                    if("Terminado".equalsIgnoreCase(st)){
                  %>
                    -
                  <%
                    } else {
                  %>
                    <span class="semaforo-dot" style="background-color:<%= semColor %>;"></span>
                  <%
                    }
                  %>
                </td>
                <td><%= fechaEntrega %></td>
                <td><%= assignedNames %></td>
                <td>
                    <a href="activityThread.jsp?activityId=<%= actId %>" class="btn btn-info btn-sm">Ver Hilo</a>
                </td>
            </tr>
        <%
                    }
                    if(noRowsDirect){
        %>
            <tr><td colspan="7">No has asignado ninguna actividad directamente.</td></tr>
        <%
                    }
                }
                psDirect.close();
            } catch(Exception e){
                out.println("<tr><td colspan='7'>Error: "+ e.getMessage() +"</td></tr>");
            }
        %>
        </tbody>
    </table>
    <%
        int totalPagesDirect= (int)Math.ceil((double)totalRowsDirect/limitDirect);
        if(totalRowsDirect>0 && totalPagesDirect>1){
    %>
    <div class="pagination-links mb-5">
        <%
            if(pageDirect>1){
        %>
        <a href="teamActivities.jsp?pageDirect=<%= (pageDirect-1) %>&pageReassigned=<%= pageReassigned %>&pageB=<%= pageB %>">&laquo; Anterior</a>
        <%
            }
            if(pageDirect<totalPagesDirect){
        %>
        <a href="teamActivities.jsp?pageDirect=<%= (pageDirect+1) %>&pageReassigned=<%= pageReassigned %>&pageB=<%= pageB %>">Siguiente &raquo;</a>
        <%
            }
        %>
        <span style="margin-left:10px;">Página <%= pageDirect %> de <%= totalPagesDirect %></span>
    </div>
    <%
        }
    %>

    <!-- Sección 1B: Actividades Reasignadas -->
    <h3 class="section-title">Actividades Reasignadas</h3>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Título</th>
                <th>Prioridad</th>
                <th>Estado</th>
                <th>Semáforo</th>
                <th>Fecha de Entrega</th>
                <th>Fecha de Reasignación</th>
                <th>Destinatarios</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        <%
            int totalRowsReassigned=0;
            try(Connection conn= DBConnection.getConnection()){
                String sqlCountReassigned= "SELECT COUNT(*) FROM seguimiento_actividades.activities a "
                    + "WHERE a.assigned_by=? AND (a.delegation_note IS NOT NULL AND a.delegation_note<>'')";
                PreparedStatement psCountR= conn.prepareStatement(sqlCountReassigned);
                psCountR.setInt(1, userId);
                try(ResultSet rsCR= psCountR.executeQuery()){
                    if(rsCR.next()) totalRowsReassigned= rsCR.getInt(1);
                }
                psCountR.close();

                String sqlReassigned= 
                    "SELECT a.id, a.title, a.priority, a.status, a.due_date, a.creation_date as reassigned_date, "
                  + "       COALESCE(string_agg(u.full_name, ', '), '') as assignedNames "
                  + "FROM seguimiento_actividades.activities a "
                  + "LEFT JOIN seguimiento_actividades.activity_collaborators ac ON a.id=ac.activity_id "
                  + "LEFT JOIN seguimiento_actividades.users u ON ac.user_id=u.id "
                  + "WHERE a.assigned_by=? AND (a.delegation_note IS NOT NULL AND a.delegation_note<>'') "
                  + "GROUP BY a.id, a.title, a.priority, a.status, a.due_date, a.creation_date "
                  + "ORDER BY a.creation_date DESC OFFSET ? LIMIT ?";
                PreparedStatement psR= conn.prepareStatement(sqlReassigned);
                psR.setInt(1, userId);
                psR.setInt(2, offsetReassigned);
                psR.setInt(3, limitReassigned);
                try(ResultSet rsR= psR.executeQuery()){
                    boolean noRowsR=true;
                    while(rsR.next()){
                        noRowsR=false;
                        int actId= rsR.getInt("id");
                        String ttl= rsR.getString("title");
                        String prio= rsR.getString("priority");
                        String st= rsR.getString("status");
                        Timestamp dueDate= rsR.getTimestamp("due_date");
                        Timestamp reassignedDate= rsR.getTimestamp("reassigned_date");
                        String assignedNames= rsR.getString("assignedNames");

                        // Badge para prioridad
                        String priorityBadgeClass="badge-secondary";
                        if("Alta".equalsIgnoreCase(prio)) priorityBadgeClass="badge-danger";
                        else if("Media".equalsIgnoreCase(prio)) priorityBadgeClass="badge-warning";
                        else if("Baja".equalsIgnoreCase(prio)) priorityBadgeClass="badge-secondary";

                        // Badge para estado
                        String statusBadgeClass="badge-secondary";
                        if("Pendiente".equalsIgnoreCase(st)) statusBadgeClass="badge-warning";
                        else if("En Progreso".equalsIgnoreCase(st)) statusBadgeClass="badge-info";
                        else if("Terminado".equalsIgnoreCase(st)) statusBadgeClass="badge-success";

                        // Semáforo => si no está Terminado
                        String semColor="";
                        if(!"Terminado".equalsIgnoreCase(st) && dueDate!=null){
                            LocalDateTime now= LocalDateTime.now();
                            LocalDateTime dd= dueDate.toLocalDateTime();
                            long hrs= java.time.Duration.between(now, dd).toHours();
                            if(hrs<=48) semColor="#d9534f"; // rojo
                            else semColor="#f0ad4e"; // amarillo
                        }
                        String fechaEntrega= (dueDate!=null? dueDate.toString():"");
                        String fechaReasig= (reassignedDate!=null? reassignedDate.toString():"");
        %>
            <tr>
                <td><%= ttl %></td>
                <td><span class="badge <%= priorityBadgeClass %>"><%= prio %></span></td>
                <td><span class="badge <%= statusBadgeClass %>"><%= st %></span></td>
                <td>
                  <%
                    if("Terminado".equalsIgnoreCase(st)){
                  %>
                    -
                  <%
                    } else {
                  %>
                    <span class="semaforo-dot" style="background-color:<%= semColor %>;"></span>
                  <%
                    }
                  %>
                </td>
                <td><%= fechaEntrega %></td>
                <td><%= fechaReasig %></td>
                <td><%= assignedNames %></td>
                <td>
                    <a href="activityThread.jsp?activityId=<%= actId %>" class="btn btn-info btn-sm">Ver Hilo</a>
                </td>
            </tr>
        <%
                    }
                    if(noRowsR){
        %>
            <tr><td colspan="8">No hay actividades reasignadas.</td></tr>
        <%
                    }
                }
                psR.close();
            } catch(Exception e){
                out.println("<tr><td colspan='8'>Error: "+ e.getMessage() +"</td></tr>");
            }
        %>
        </tbody>
    </table>
    <%
        int totalPagesReassigned= (int)Math.ceil((double)totalRowsReassigned/limitReassigned);
        if(totalRowsReassigned>0 && totalPagesReassigned>1){
    %>
    <div class="pagination-links mb-5">
        <%
            if(pageReassigned>1){
        %>
        <a href="teamActivities.jsp?pageDirect=<%= pageDirect %>&pageReassigned=<%= (pageReassigned-1) %>&pageB=<%= pageB %>">&laquo; Anterior</a>
        <%
            }
            if(pageReassigned<totalPagesReassigned){
        %>
        <a href="teamActivities.jsp?pageDirect=<%= pageDirect %>&pageReassigned=<%= (pageReassigned+1) %>&pageB=<%= pageB %>">Siguiente &raquo;</a>
        <%
            }
        %>
        <span style="margin-left:10px;">Página <%= pageReassigned %> de <%= totalPagesReassigned %></span>
    </div>
    <%
        }
    %>

    <!-- Sección 2: Actividades que Me Asignaron (No Delegadas) -->
    <h3 class="section-title">Actividades que Me Asignaron (No Delegadas)</h3>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Título</th>
                <th>Prioridad</th>
                <th>Estado</th>
                <th>Semáforo</th>
                <th>Fecha de Entrega</th>
                <th>Asignado por</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        <%
            int totalRowsB=0;
            try(Connection conn= DBConnection.getConnection()){
                // Contar
                String sqlCountB= "SELECT COUNT(*) FROM seguimiento_actividades.activities a "
                    + "WHERE a.assigned_to=? AND a.assigned_by<>?";
                PreparedStatement psCountB= conn.prepareStatement(sqlCountB);
                psCountB.setInt(1, userId);
                psCountB.setInt(2, userId);
                try(ResultSet rsCB= psCountB.executeQuery()){
                    if(rsCB.next()) totalRowsB= rsCB.getInt(1);
                }
                psCountB.close();

                String sqlMe= "SELECT a.id, a.title, a.priority, a.status, a.due_date, u.full_name as assignedByName "
                    + "FROM seguimiento_actividades.activities a "
                    + "JOIN seguimiento_actividades.users u ON a.assigned_by=u.id "
                    + "WHERE a.assigned_to=? AND a.assigned_by<>? "
                    + "ORDER BY a.creation_date DESC OFFSET ? LIMIT ?";
                PreparedStatement psMe= conn.prepareStatement(sqlMe);
                psMe.setInt(1, userId);
                psMe.setInt(2, userId);
                psMe.setInt(3, offsetB);
                psMe.setInt(4, limitB);
                try(ResultSet rsMe= psMe.executeQuery()){
                    boolean noRowsB=true;
                    while(rsMe.next()){
                        noRowsB=false;
                        int actId= rsMe.getInt("id");
                        String ttl= rsMe.getString("title");
                        String prio= rsMe.getString("priority");
                        String st= rsMe.getString("status");
                        Timestamp dueDate= rsMe.getTimestamp("due_date");
                        String assignedByName= rsMe.getString("assignedByName");

                        // Priority => badge
                        String priorityBadgeClass="badge-secondary";
                        if("Alta".equalsIgnoreCase(prio)) priorityBadgeClass="badge-danger";
                        else if("Media".equalsIgnoreCase(prio)) priorityBadgeClass="badge-warning";
                        else if("Baja".equalsIgnoreCase(prio)) priorityBadgeClass="badge-secondary";

                        // Status => badge
                        String statusBadgeClass="badge-secondary";
                        if("Pendiente".equalsIgnoreCase(st)) statusBadgeClass="badge-warning";
                        else if("En Progreso".equalsIgnoreCase(st)) statusBadgeClass="badge-info";
                        else if("Terminado".equalsIgnoreCase(st)) statusBadgeClass="badge-success";

                        // Semáforo => si no está Terminado
                        String semColor="";
                        if(!"Terminado".equalsIgnoreCase(st) && dueDate!=null){
                            LocalDateTime now= LocalDateTime.now();
                            LocalDateTime dd= dueDate.toLocalDateTime();
                            long hrs= java.time.Duration.between(now, dd).toHours();
                            if(hrs<=48) semColor="#d9534f"; // rojo
                            else semColor="#f0ad4e"; // amarillo
                        }
                        String fechaEntrega= (dueDate!=null? dueDate.toString():"");
        %>
            <tr>
                <td><%= ttl %></td>
                <td><span class="badge <%= priorityBadgeClass %>"><%= prio %></span></td>
                <td><span class="badge <%= statusBadgeClass %>"><%= st %></span></td>
                <td>
                  <%
                    if("Terminado".equalsIgnoreCase(st)){
                  %>
                    -
                  <%
                    } else {
                  %>
                    <span class="semaforo-dot" style="background-color:<%= semColor %>;"></span>
                  <%
                    }
                  %>
                </td>
                <td><%= fechaEntrega %></td>
                <td><%= assignedByName %></td>
                <td>
                    <a href="activityThread.jsp?activityId=<%= actId %>" class="btn btn-info btn-sm">Ver Hilo</a>
                </td>
            </tr>
        <%
                    }
                    if(noRowsB){
        %>
            <tr><td colspan="7">No hay actividades asignadas a ti por otros (sin delegar).</td></tr>
        <%
                    }
                }
                psMe.close();
            } catch(Exception e){
                out.println("<tr><td colspan='7'>Error: "+ e.getMessage() +"</td></tr>");
            }
        %>
        </tbody>
    </table>
    <%
        int totalPagesB= (int)Math.ceil((double)totalRowsB/limitB);
        if(totalRowsB>0 && totalPagesB>1){
    %>
    <div class="pagination-links mb-5">
        <%
            if(pageB>1){
        %>
        <a href="teamActivities.jsp?pageDirect=<%= pageDirect %>&pageB=<%= (pageB-1) %>&pageReassigned=<%= pageReassigned %>">&laquo; Anterior</a>
        <%
            }
            if(pageB<totalPagesB){
        %>
        <a href="teamActivities.jsp?pageDirect=<%= pageDirect %>&pageB=<%= (pageB+1) %>&pageReassigned=<%= pageReassigned %>">Siguiente &raquo;</a>
        <%
            }
        %>
        <span style="margin-left:10px;">Página <%= pageB %> de <%= totalPagesB %></span>
    </div>
    <% } %>
</div>

</body>
</html>
