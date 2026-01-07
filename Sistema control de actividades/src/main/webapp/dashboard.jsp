<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.time.*, java.util.ArrayList" %>
<%@ page import="utils.DBConnection" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>Dashboard - Seguimiento</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <style>
      .hero-section {
          background: linear-gradient(to right, #004e92, #000428);
          color: white;
          padding: 2rem;
          border-radius: 10px;
          margin-top: 2rem;
          box-shadow: 0 5px 15px rgba(0,0,0,0.3);
      }
      .table-semaforo {
          font-weight: bold;
          color: white;
          border-radius: 5px;
          padding: 0.2rem 0.4rem;
      }
      .bg-red { background-color: #d9534f; }
      .bg-yellow { background-color: #f0ad4e; }
      .pagination { margin-top: 1rem; }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <div class="hero-section">
            <h1>Panel Principal</h1>
            <p class="lead">Gestiona y haz seguimiento de tus actividades</p>
            <%
                int roleId = (Integer) session.getAttribute("roleId");
                int userId = (Integer) session.getAttribute("userId");
                if(roleId == 2){ 
            %>
                <div class="mt-3">
                    <a href="createUser.jsp" class="btn btn-primary">Crear Colaborador</a>
                </div>
            <%
                }
            %>
        </div>

        <%
            // Parámetros de búsqueda (solo se aplica para subdirector o jefe)
            String nameSearch = request.getParameter("nameSearch");
            if(nameSearch == null) { nameSearch = ""; }

            // Paginación
            int currentPage = 1;
            int limit = 10; // número de actividades por página
            try {
                currentPage = Integer.parseInt(request.getParameter("page"));
            } catch(Exception e){}
            if(currentPage < 1) currentPage = 1;
            int offset = (currentPage - 1) * limit;
        %>

        <%
            // Construir la consulta principal según el rol
            String sql = "";
            if(roleId == 1) {
                // Subdirector: actividades que él asignó (no terminadas)
                sql = "SELECT a.id, a.title, a.priority, a.creation_date, a.due_date, a.status, "
                    + "COALESCE(string_agg(u.full_name || ' (' || COALESCE(d.name, '-') || ')', ', ' ORDER BY d.name), '-') AS assignedNames "
                    + "FROM seguimiento_actividades.activities a "
                    + "LEFT JOIN seguimiento_actividades.activity_collaborators ac ON a.id = ac.activity_id "
                    + "LEFT JOIN seguimiento_actividades.users u ON ac.user_id = u.id "
                    + "LEFT JOIN seguimiento_actividades.departments d ON u.department_id = d.id "
                    + "WHERE a.status IN ('Pendiente','En Progreso') "
                    + "  AND a.assigned_by = ? ";
                if(!nameSearch.trim().isEmpty()){
                    sql += " AND a.title ILIKE ? ";
                }
                sql += "GROUP BY a.id, a.title, a.priority, a.creation_date, a.due_date, a.status "
                    + "ORDER BY a.creation_date DESC OFFSET ? LIMIT ?";

            } else if(roleId == 2) {
                // Jefe: actividades no terminadas donde assigned_to = su id OR assigned_to in (sus operativos)
                sql = "SELECT a.id, a.title, a.priority, a.creation_date, a.due_date, a.status, "
                    + "COALESCE(string_agg(u.full_name, ', '), '-') AS assignedNames "
                    + "FROM seguimiento_actividades.activities a "
                    + "LEFT JOIN seguimiento_actividades.activity_collaborators ac ON a.id = ac.activity_id "
                    + "LEFT JOIN seguimiento_actividades.users u ON ac.user_id = u.id "
                    + "WHERE a.status IN ('Pendiente','En Progreso') "
                    + "  AND (a.assigned_to = ? OR a.assigned_to IN (SELECT id FROM seguimiento_actividades.users WHERE supervisor_id = ?)) ";
                if(!nameSearch.trim().isEmpty()){
                    sql += " AND a.title ILIKE ? ";
                }
                sql += "GROUP BY a.id, a.title, a.priority, a.creation_date, a.due_date, a.status "
                    + "ORDER BY a.creation_date DESC OFFSET ? LIMIT ?";

            } else {
                // Operativo (roleId=3): actividades no terminadas 
                // donde assigned_to = suId OR ac.user_id = suId
                sql = "SELECT a.id, a.title, a.priority, a.creation_date, a.due_date, a.status, "
                    + "COALESCE(string_agg(u.full_name, ', '), '-') AS assignedNames "
                    + "FROM seguimiento_actividades.activities a "
                    + "LEFT JOIN seguimiento_actividades.activity_collaborators ac ON a.id = ac.activity_id "
                    + "LEFT JOIN seguimiento_actividades.users u ON ac.user_id = u.id "
                    + "WHERE a.status IN ('Pendiente','En Progreso') "
                    + "  AND (a.assigned_to = ? OR ac.user_id = ?) "
                    + "GROUP BY a.id, a.title, a.priority, a.creation_date, a.due_date, a.status "
                    + "ORDER BY a.creation_date DESC OFFSET ? LIMIT ?";
            }

            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            // Bind de parámetros
            int paramIndex = 1;
            if(roleId == 1) {
                // Subdirector
                ps.setInt(paramIndex++, userId);
                if(!nameSearch.trim().isEmpty()){
                    ps.setString(paramIndex++, "%" + nameSearch + "%");
                }
                ps.setInt(paramIndex++, offset);
                ps.setInt(paramIndex++, limit);

            } else if(roleId == 2) {
                // Jefe
                ps.setInt(paramIndex++, userId);   // a.assigned_to = ?
                ps.setInt(paramIndex++, userId);   // subconsulta de operativos
                if(!nameSearch.trim().isEmpty()){
                    ps.setString(paramIndex++, "%" + nameSearch + "%");
                }
                ps.setInt(paramIndex++, offset);
                ps.setInt(paramIndex++, limit);

            } else {
                // Colaborador
                ps.setInt(paramIndex++, userId);  // a.assigned_to = ?
                ps.setInt(paramIndex++, userId);  // ac.user_id = ?
                ps.setInt(paramIndex++, offset);
                ps.setInt(paramIndex++, limit);
            }

            ResultSet rs = ps.executeQuery();
        %>

        <div class="mt-4">
            <h3>Actividades Pendientes o en Progreso</h3>
            
            <%-- Campo de búsqueda solo para subdirector y jefe --%>
            <%
                if(roleId == 1 || roleId == 2) {
            %>
            <form method="get" action="dashboard.jsp" class="form-inline mb-3">
                <input type="hidden" name="page" value="1">
                <div class="form-group mr-2">
                    <input type="text" name="nameSearch" class="form-control" placeholder="Buscar por título"
                           value="<%= nameSearch %>">
                </div>
                <button type="submit" class="btn btn-primary">Buscar</button>
                <a href="dashboard.jsp" class="btn btn-secondary ml-2">Limpiar Filtro</a>
            </form>
            <%
                }
            %>

            <div class="table-responsive">
              <table class="table table-bordered table-striped">
                <thead>
                  <tr>
                    <th>Título</th>
                    <th>Prioridad</th>
                    <th>Semáforo</th>
                    <th>Fecha de Entrega</th>
                    <th>Estatus</th>
                    <th>
                      <% if(roleId == 3){ %>
                        Destinatario/Colaboración
                      <% } else { %>
                        Destinatarios
                      <% } %>
                    </th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                <%
                    while(rs.next()){
                        int actId = rs.getInt("id");
                        String ttl = rs.getString("title");
                        String prio = rs.getString("priority");
                        Timestamp due = rs.getTimestamp("due_date");
                        String st = rs.getString("status");
                        String assignedNames = rs.getString("assignedNames");
                        
                        // Semáforo:
                        String semaforoHtml = "-";
                        if(!"Terminado".equalsIgnoreCase(st) && due != null){
                            LocalDateTime now = LocalDateTime.now();
                            LocalDateTime dueDate = due.toLocalDateTime();
                            long hoursBetween = java.time.Duration.between(now, dueDate).toHours();
                            if(hoursBetween <= 48){
                                semaforoHtml = "<span class='table-semaforo bg-red'>ROJO</span>";
                            } else {
                                semaforoHtml = "<span class='table-semaforo bg-yellow'>AMARILLO</span>";
                            }
                        }
                        
                        // Columna de destinatarios / colaboraciones
                        String colDisplay = assignedNames;
                        if(roleId == 3){
                            // Si hay más de un colaborador, lo mostramos
                            if(assignedNames.contains(",")){
                                colDisplay = "En colaboración con: " + assignedNames;
                            } else {
                                colDisplay = "-";
                            }
                        }
                %>
                  <tr>
                    <td><a href="activityThread.jsp?activityId=<%= actId %>"><%= ttl %></a></td>
                    <td><%= prio %></td>
                    <td><%= semaforoHtml %></td>
                    <td><%= (due != null ? due.toString() : "-") %></td>
                    <td><%= st %></td>
                    <td><%= colDisplay %></td>
                    <td>
                        <a href="activityThread.jsp?activityId=<%= actId %>" class="btn btn-info btn-sm">Ver Hilo</a>
                    </td>
                  </tr>
                <%
                    }
                    rs.close();
                    ps.close();
                    conn.close();
                %>
                </tbody>
              </table>
            </div>

            <%
                // Ahora el conteo total para la paginación
                int totalCount = 0;
                String countQuery = "";
                ArrayList<Object> countParams = new ArrayList<>();

                if(roleId == 1) {
                    // Subdirector
                    countQuery = "SELECT COUNT(*) AS total FROM seguimiento_actividades.activities "
                               + "WHERE status IN ('Pendiente','En Progreso') AND assigned_by = ? ";
                    countParams.add(userId);
                    if(!nameSearch.trim().isEmpty()){
                        countQuery += " AND title ILIKE ? ";
                        countParams.add("%" + nameSearch + "%");
                    }
                } else if(roleId == 2) {
                    // Jefe
                    countQuery = "SELECT COUNT(*) AS total FROM seguimiento_actividades.activities "
                               + "WHERE status IN ('Pendiente','En Progreso') "
                               + "  AND (assigned_to = ? OR assigned_to IN (SELECT id FROM seguimiento_actividades.users WHERE supervisor_id = ?)) ";
                    countParams.add(userId);
                    countParams.add(userId);
                    if(!nameSearch.trim().isEmpty()){
                        countQuery += " AND title ILIKE ? ";
                        countParams.add("%" + nameSearch + "%");
                    }
                } else {
                    // Operativo (rol=3): necesitamos contar actividades no terminadas 
                    // donde assigned_to = suId o ac.user_id = suId
                    // Usamos subconsulta con GROUP BY para no duplicar
                    countQuery = "SELECT COUNT(*) AS total "
                               + "FROM ( "
                               + "  SELECT a.id "
                               + "  FROM seguimiento_actividades.activities a "
                               + "  LEFT JOIN seguimiento_actividades.activity_collaborators ac ON a.id = ac.activity_id "
                               + "  WHERE a.status IN ('Pendiente','En Progreso') "
                               + "    AND (a.assigned_to = ? OR ac.user_id = ?) "
                               + "  GROUP BY a.id "
                               + ") sub";
                    countParams.add(userId);
                    countParams.add(userId);
                }

                Connection conn2 = DBConnection.getConnection();
                PreparedStatement psCount = conn2.prepareStatement(countQuery);
                for(int i=0; i < countParams.size(); i++){
                    psCount.setObject(i+1, countParams.get(i));
                }
                ResultSet rsCount = psCount.executeQuery();
                if(rsCount.next()){
                    totalCount = rsCount.getInt("total");
                }
                rsCount.close();
                psCount.close();
                conn2.close();

                int totalPages = (int) Math.ceil((double) totalCount / limit);

                // Para la barra de paginación
                int startPage, endPage;
                if(totalPages <= 5){
                    startPage = 1;
                    endPage = totalPages;
                } else {
                    if(currentPage <= 3){
                        startPage = 1;
                        endPage = 5;
                    } else if(currentPage + 2 >= totalPages){
                        startPage = totalPages - 4;
                        endPage = totalPages;
                    } else {
                        startPage = currentPage - 2;
                        endPage = currentPage + 2;
                    }
                }
            %>
            <nav aria-label="Page navigation">
              <ul class="pagination justify-content-center">
                <li class="page-item <%= (currentPage==1 ? "disabled" : "") %>">
                  <a class="page-link" href="dashboard.jsp?page=<%= (currentPage-1) %>&nameSearch=<%= nameSearch %>">&laquo; Anterior</a>
                </li>
                <%
                    for(int p = startPage; p <= endPage; p++){
                        if(p == currentPage){
                %>
                <li class="page-item active"><a class="page-link" href="#"><%= p %></a></li>
                <%
                        } else {
                %>
                <li class="page-item"><a class="page-link" href="dashboard.jsp?page=<%= p %>&nameSearch=<%= nameSearch %>"><%= p %></a></li>
                <%
                        }
                    }
                %>
                <li class="page-item <%= (currentPage==totalPages ? "disabled" : "") %>">
                  <a class="page-link" href="dashboard.jsp?page=<%= (currentPage+1) %>&nameSearch=<%= nameSearch %>">Siguiente &raquo;</a>
                </li>
              </ul>
            </nav>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
