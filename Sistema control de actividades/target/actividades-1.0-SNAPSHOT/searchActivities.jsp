<%@ page import="java.sql.*, java.time.*, java.util.ArrayList" %>
<%@ page import="utils.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Buscar Actividades - Seguimiento</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        .search-form {
            margin-top: 20px;
            margin-bottom: 20px;
        }
        .pagination {
            margin-top: 20px;
        }
        @media (max-width: 576px){
            .form-row > .form-group {
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="container">
    <h2 class="mt-4">Búsqueda de Actividades</h2>

    <%
        // Verificar sesión y rol
        if (session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = (Integer) session.getAttribute("userId");
        int roleId = (Integer) session.getAttribute("roleId");

        // Parámetros
        String startDateParam    = request.getParameter("startDate");   // Fecha inicio
        String endDateParam      = request.getParameter("endDate");     // Fecha fin
        String statusParam       = request.getParameter("status");      // Pendiente/En Progreso/Terminado/Todas
        String semaforoParam     = request.getParameter("semaforo");    // Rojo/Amarillo/Todas

        // Subdirector
        String departmentParam   = request.getParameter("department");  // Filtrar por departamento
        String destinatarioParam = request.getParameter("destinatario");// Filtrar por un usuario
        // Jefe
        String tipoAsignacion    = request.getParameter("tipoAsignacion"); // "Directas"/"Subdirector"/"Todas"
    %>

    <!-- Formulario de búsqueda -->
    <form class="search-form" method="get" action="searchActivities.jsp">
      <div class="form-row">
        <!-- Fecha Inicio -->
        <div class="form-group col-sm-6 col-md-2">
            <label>Fecha Inicio</label>
            <input type="date" name="startDate" class="form-control"
                   value="<%= (startDateParam != null ? startDateParam : "") %>">
        </div>
        <!-- Fecha Fin -->
        <div class="form-group col-sm-6 col-md-2">
            <label>Fecha Fin</label>
            <input type="date" name="endDate" class="form-control"
                   value="<%= (endDateParam != null ? endDateParam : "") %>">
        </div>
        <!-- Estatus -->
        <div class="form-group col-sm-6 col-md-2">
            <label>Estatus</label>
            <select name="status" class="form-control">
                <option value="Todas" <%= (statusParam == null || "Todas".equals(statusParam)) ? "selected" : "" %>>Todas</option>
                <option value="Pendiente"    <%= "Pendiente".equals(statusParam)    ? "selected" : "" %>>Pendiente</option>
                <option value="En Progreso"  <%= "En Progreso".equals(statusParam)  ? "selected" : "" %>>En Progreso</option>
                <option value="Terminado"    <%= "Terminado".equals(statusParam)    ? "selected" : "" %>>Terminado</option>
            </select>
        </div>
        <!-- Semáforo -->
        <div class="form-group col-sm-6 col-md-2">
            <label>Semáforo</label>
            <select name="semaforo" class="form-control">
                <option value="Todas"    <%= (semaforoParam==null || "Todas".equals(semaforoParam)) ? "selected" : "" %>>Todas</option>
                <option value="Rojo"     <%= "Rojo".equals(semaforoParam)     ? "selected" : "" %>>Rojo</option>
                <option value="Amarillo" <%= "Amarillo".equals(semaforoParam) ? "selected" : "" %>>Amarillo</option>
            </select>
        </div>

        <!-- Filtros extras -->
        <%
          if(roleId == 1){ // Subdirector
        %>
        <!-- Departamento -->
        <div class="form-group col-sm-6 col-md-2">
            <label>Departamento</label>
            <select name="department" class="form-control">
                <option value="">Todos</option>
                <%
                  Connection connDept = DBConnection.getConnection();
                  PreparedStatement psDept = connDept.prepareStatement(
                    "SELECT id, name FROM seguimiento_actividades.departments WHERE subdirector_id=? ORDER BY name"
                  );
                  psDept.setInt(1, userId);
                  ResultSet rsDept = psDept.executeQuery();
                  while(rsDept.next()){
                      int dId   = rsDept.getInt("id");
                      String dNm= rsDept.getString("name");
                %>
                <option value="<%= dId %>" <%= (departmentParam!=null && departmentParam.equals(String.valueOf(dId)))?"selected":""%>>
                    <%= dNm %>
                </option>
                <%
                  }
                  rsDept.close();
                  psDept.close();
                  connDept.close();
                %>
            </select>
        </div>
        <!-- Destinatario -->
        <div class="form-group col-sm-6 col-md-2">
            <label>Destinatario</label>
            <select name="destinatario" class="form-control">
                <option value="">Todos</option>
                <%
                  Connection connSub = DBConnection.getConnection();
                  PreparedStatement psSub = connSub.prepareStatement(
                     "SELECT id, full_name FROM seguimiento_actividades.users ORDER BY full_name"
                  );
                  ResultSet rsSub = psSub.executeQuery();
                  while(rsSub.next()){
                      int uid= rsSub.getInt("id");
                      String uname= rsSub.getString("full_name");
                %>
                <option value="<%= uid %>" <%= (destinatarioParam!=null && destinatarioParam.equals(""+uid))?"selected":""%>>
                    <%= uname %>
                </option>
                <%
                  }
                  rsSub.close(); psSub.close(); connSub.close();
                %>
            </select>
        </div>
        <%
          } else if(roleId == 2){ // Jefe
        %>
        <!-- Tipo Asignacion -->
        <div class="form-group col-sm-6 col-md-3">
            <label>Tipo Asignación</label>
            <select name="tipoAsignacion" class="form-control">
                <option value="Todas"      <%= (tipoAsignacion==null||"Todas".equals(tipoAsignacion)) ?"selected":""%>>Todas</option>
                <option value="Directas"   <%= "Directas".equals(tipoAsignacion)   ?"selected":""%>>Asignadas/Reasignadas por mí</option>
                <option value="Subdirector"<%= "Subdirector".equals(tipoAsignacion)?"selected":""%>>Asignadas por Subdirector</option>
            </select>
        </div>
        <!-- Destinatario -->
        <div class="form-group col-sm-6 col-md-3">
            <label>Destinatario</label>
            <select name="destinatario" class="form-control">
                <option value="">Todos</option>
                <%
                  Connection connJefe = DBConnection.getConnection();
                  // Filtrar solo su departamento (operativos)
                  PreparedStatement psJefe = connJefe.prepareStatement(
                    "SELECT id, full_name FROM seguimiento_actividades.users "
                  + "WHERE department_id=(SELECT department_id FROM seguimiento_actividades.users WHERE id=?) "
                  + "  AND role_id=3 ORDER BY full_name"
                  );
                  psJefe.setInt(1, userId);
                  ResultSet rsJefe = psJefe.executeQuery();
                  while(rsJefe.next()){
                      int uid= rsJefe.getInt("id");
                      String uname= rsJefe.getString("full_name");
                %>
                <option value="<%= uid %>" <%= (destinatarioParam!=null && destinatarioParam.equals(""+uid))?"selected":""%>>
                  <%= uname %>
                </option>
                <%
                  }
                  rsJefe.close(); psJefe.close(); connJefe.close();
                %>
            </select>
        </div>
        <%
          } // role=3 => operativo => no extras
        %>
      </div>

      <div class="form-row">
        <div class="form-group col-md-2">
            <button type="submit" class="btn btn-primary btn-block">Buscar</button>
        </div>
        <div class="form-group col-md-2">
            <a href="searchActivities.jsp" class="btn btn-secondary btn-block">Ver Todas</a>
        </div>
      </div>
    </form>

    <%
      // Construir Query base
      // Solo mostrar la actividad si:
      // - Subdirector => a.assigned_by = userId
      // - Jefe => a.assigned_by = userId OR a.assigned_to=userId OR user en activity_collaborators
      // - Operativo => a.assigned_to=userId OR user en activity_collaborators
      // Usamos una subconsulta/condición "1=1" y luego un AND (...) segun rol

      String baseQuery =
        "SELECT a.id, a.title, a.priority, a.creation_date, a.due_date, a.status, "
      + "COALESCE(string_agg(u.full_name, ', '), 'N/A') AS assignedNames, "
      + "COUNT(u.id) AS totalCols "
      + "FROM seguimiento_actividades.activities a "
      + "LEFT JOIN seguimiento_actividades.activity_collaborators ac ON a.id=ac.activity_id "
      + "LEFT JOIN seguimiento_actividades.users u ON ac.user_id=u.id "
      + "WHERE 1=1 ";  // base

      ArrayList<Object> params = new ArrayList<>();

      if(roleId==1){
          // Subdirector => solo lo que él asignó
          baseQuery += " AND a.assigned_by = ? ";
          params.add(userId);
      } else if(roleId==2){
          // Jefe => (a.assigned_by = userId OR a.assigned_to = userId OR user en collabs)
          baseQuery += " AND (a.assigned_by = ?"
                     + "  OR a.assigned_to = ?"
                     + "  OR a.id IN (SELECT activity_id FROM seguimiento_actividades.activity_collaborators WHERE user_id=?)) ";
          params.add(userId);
          params.add(userId);
          params.add(userId);
      } else if(roleId==3){
          // Operativo => (a.assigned_to = userId OR user in collabs)
          baseQuery += " AND (a.assigned_to = ?"
                     + "  OR a.id IN (SELECT activity_id FROM seguimiento_actividades.activity_collaborators WHERE user_id=?)) ";
          params.add(userId);
          params.add(userId);
      }

      // Fechas
      if(startDateParam!=null && !startDateParam.trim().isEmpty()){
          baseQuery+=" AND a.due_date >= ? ";
          params.add(java.sql.Date.valueOf(startDateParam));
      }
      if(endDateParam!=null && !endDateParam.trim().isEmpty()){
          baseQuery+=" AND a.due_date < (?::date + INTERVAL '1 day') ";
          params.add(endDateParam);
      }

      // Estatus
      if(statusParam!=null && !"Todas".equals(statusParam)){
          baseQuery+=" AND a.status=? ";
          params.add(statusParam);
      }

      // Semaforo
      if(semaforoParam!=null && !"Todas".equals(semaforoParam)){
          baseQuery+=" AND EXTRACT(EPOCH FROM (a.due_date - ?))/3600 ";
          Timestamp now = Timestamp.valueOf(LocalDateTime.now());
          if("Rojo".equals(semaforoParam)){
              baseQuery+=" <= 48 ";
          } else {
              baseQuery+=" > 48 ";
          }
          params.add(now);
      }

      // Filtros extra subdirector
      if(roleId==1){
          if(departmentParam!=null && !departmentParam.trim().isEmpty()){
              baseQuery+=" AND a.id IN (SELECT a2.id FROM seguimiento_actividades.activities a2 "
                       +"JOIN seguimiento_actividades.activity_collaborators ac2 ON a2.id=ac2.activity_id "
                       +"JOIN seguimiento_actividades.users u2 ON ac2.user_id=u2.id "
                       +"WHERE u2.department_id=?) ";
              params.add(Integer.parseInt(departmentParam));
          }
          if(destinatarioParam!=null && !destinatarioParam.trim().isEmpty()){
              baseQuery+=" AND a.id IN (SELECT a3.id FROM seguimiento_actividades.activities a3 "
                       +"JOIN seguimiento_actividades.activity_collaborators ac3 ON a3.id=ac3.activity_id "
                       +"WHERE ac3.user_id=?) ";
              params.add(Integer.parseInt(destinatarioParam));
          }
      }
      // Filtros extra jefe
      else if(roleId==2){
          if(tipoAsignacion!=null && !"Todas".equals(tipoAsignacion)){
              if("Directas".equals(tipoAsignacion)){
                  // Asignadas/Reasignadas por él
                  baseQuery+=" AND a.assigned_by=? ";
                  params.add(userId);
              } else if("Subdirector".equals(tipoAsignacion)){
                  // Asignadas por subdirector (o sea no por este jefe)
                  baseQuery+=" AND a.assigned_by<>? ";
                  params.add(userId);
              }
          }
          if(destinatarioParam!=null && !destinatarioParam.trim().isEmpty()){
              baseQuery+=" AND a.id IN (SELECT a4.id FROM seguimiento_actividades.activities a4 "
                       +"JOIN seguimiento_actividades.activity_collaborators ac4 ON a4.id=ac4.activity_id "
                       +"WHERE ac4.user_id=?) ";
              params.add(Integer.parseInt(destinatarioParam));
          }
      }

      // Agrupar y ordenar
      baseQuery+=" GROUP BY a.id, a.title, a.priority, a.creation_date, a.due_date, a.status "
               +" ORDER BY a.creation_date DESC, a.due_date ASC ";

      // Paginación
      int currentPage=1, limit=10;
      try {
          currentPage = Integer.parseInt(request.getParameter("page"));
      } catch(Exception e){}
      if(currentPage<1) currentPage=1;
      int offset=(currentPage-1)*limit;

      baseQuery+=" OFFSET ? LIMIT ? ";
      params.add(offset);
      params.add(limit);

      Connection conn = DBConnection.getConnection();
      PreparedStatement ps= conn.prepareStatement(baseQuery);
      for(int i=0; i<params.size(); i++){
          ps.setObject(i+1, params.get(i));
      }
      ResultSet rs= ps.executeQuery();
    %>

    <h4 class="mt-4">Resultados</h4>
    <div class="table-responsive">
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>No. Actividad</th>
                <th>Título</th>
                <th>Prioridad</th>
                <th>Creado</th>
                <th>Entrega</th>
                <th>Estatus</th>
                <th>
                  <% if(roleId==3){ %>
                      Destinatario/Colaboración
                  <% } else { %>
                      Destinatarios
                  <% } %>
                </th>
            </tr>
        </thead>
        <tbody>
        <%
           while(rs.next()){
               int actId        = rs.getInt("id");
               String ttl       = rs.getString("title");
               String prio      = rs.getString("priority");
               Timestamp crea   = rs.getTimestamp("creation_date");
               Timestamp due    = rs.getTimestamp("due_date");
               String st        = rs.getString("status");
               String assignedNames = rs.getString("assignedNames");
               int totalCols    = rs.getInt("totalCols"); // cuántos colaboran
        %>
          <tr>
            <td><%= actId %></td>
            <td>
              <a href="activityThread.jsp?activityId=<%= actId %>"><%= ttl %></a>
            </td>
            <td><%= prio %></td>
            <td><%= (crea!=null ? crea.toString() : "") %></td>
            <td><%= (due!=null  ? due.toString()  : "") %></td>
            <td><%= st %></td>
            <td>
            <%
              if(roleId==3) {
                  // Operativo => si hay >1 colaboradores => "En colaboración con: X"
                  if(totalCols>1){
            %>
                     En colaboración con: <%= assignedNames %>
            <%
                  } else {
            %>
                     -
            <%
                  }
              } else {
                  // Subdirector / Jefe => mostrar la lista normal
            %>
                 <%= assignedNames %>
            <%
              }
            %>
            </td>
          </tr>
        <%
           }
           rs.close();
           ps.close();

           // Cálculo de la paginación (conteo total)
           String countQuery = 
             "SELECT COUNT(*) AS total FROM ( "
           + "SELECT a.id FROM seguimiento_actividades.activities a "
           + " WHERE 1=1 ";

           ArrayList<Object> countParams = new ArrayList<>();

           // Misma lógica de roles:
           if(roleId==1){
               countQuery += " AND a.assigned_by=? ";
               countParams.add(userId);
           } else if(roleId==2){
               countQuery += " AND (a.assigned_by=? OR a.assigned_to=? "
                            + "  OR a.id IN (SELECT activity_id FROM seguimiento_actividades.activity_collaborators WHERE user_id=?)) ";
               countParams.add(userId);
               countParams.add(userId);
               countParams.add(userId);
           } else if(roleId==3){
               countQuery += " AND (a.assigned_to=? OR a.id IN (SELECT activity_id FROM seguimiento_actividades.activity_collaborators WHERE user_id=?)) ";
               countParams.add(userId);
               countParams.add(userId);
           }

           // Fechas
           if(startDateParam!=null && !startDateParam.trim().isEmpty()){
               countQuery+=" AND a.due_date >= ? ";
               countParams.add(java.sql.Date.valueOf(startDateParam));
           }
           if(endDateParam!=null && !endDateParam.trim().isEmpty()){
               countQuery+=" AND a.due_date < (?::date + INTERVAL '1 day') ";
               countParams.add(endDateParam);
           }

           // Estatus
           if(statusParam!=null && !"Todas".equals(statusParam)){
               countQuery+=" AND a.status=? ";
               countParams.add(statusParam);
           }

           // Semáforo
           if(semaforoParam!=null && !"Todas".equals(semaforoParam)){
               countQuery+=" AND EXTRACT(EPOCH FROM (a.due_date - ?))/3600 ";
               Timestamp now = Timestamp.valueOf(LocalDateTime.now());
               if("Rojo".equals(semaforoParam)){
                   countQuery+=" <= 48 ";
               } else {
                   countQuery+=" > 48 ";
               }
               countParams.add(now);
           }

           // Filtros extra subdirector
           if(roleId==1){
               if(departmentParam!=null && !departmentParam.trim().isEmpty()){
                   countQuery+=" AND a.id IN (SELECT a2.id FROM seguimiento_actividades.activities a2 "
                             +"JOIN seguimiento_actividades.activity_collaborators ac2 ON a2.id=ac2.activity_id "
                             +"JOIN seguimiento_actividades.users u2 ON ac2.user_id=u2.id "
                             +"WHERE u2.department_id=?) ";
                   countParams.add(Integer.parseInt(departmentParam));
               }
               if(destinatarioParam!=null && !destinatarioParam.trim().isEmpty()){
                   countQuery+=" AND a.id IN (SELECT a3.id FROM seguimiento_actividades.activities a3 "
                             +"JOIN seguimiento_actividades.activity_collaborators ac3 ON a3.id=ac3.activity_id "
                             +"WHERE ac3.user_id=?) ";
                   countParams.add(Integer.parseInt(destinatarioParam));
               }
           }
           // Jefe => tipoAsignacion, destinatario
           else if(roleId==2){
               if(tipoAsignacion!=null && !"Todas".equals(tipoAsignacion)){
                   if("Directas".equals(tipoAsignacion)){
                       countQuery+=" AND a.assigned_by=? ";
                       countParams.add(userId);
                   } else if("Subdirector".equals(tipoAsignacion)){
                       countQuery+=" AND a.assigned_by<>? ";
                       countParams.add(userId);
                   }
               }
               if(destinatarioParam!=null && !destinatarioParam.trim().isEmpty()){
                   countQuery+=" AND a.id IN (SELECT a4.id FROM seguimiento_actividades.activities a4 "
                             +"JOIN seguimiento_actividades.activity_collaborators ac4 ON a4.id=ac4.activity_id "
                             +"WHERE ac4.user_id=?) ";
                   countParams.add(Integer.parseInt(destinatarioParam));
               }
           }
           countQuery+=" GROUP BY a.id ) as sub";

           PreparedStatement psCount = conn.prepareStatement(countQuery);
           for(int i=0; i<countParams.size(); i++){
               psCount.setObject(i+1, countParams.get(i));
           }
           ResultSet rsCount = psCount.executeQuery();

           // totalRows => sumamos las filas (cada fila = un activity distinto)
           int totalRows=0;
           while(rsCount.next()){
               totalRows++;
           }
           rsCount.close();
           psCount.close();
           conn.close();

           int totalPages = (int)Math.ceil((double)totalRows / limit);
        %>
        </tbody>
    </table>
    </div>

    <!-- Paginación -->
    <nav aria-label="Page navigation">
      <ul class="pagination justify-content-center">
        <li class="page-item <%= (currentPage==1?"disabled":"") %>">
          <a class="page-link"
             href="searchActivities.jsp?page=<%= (currentPage-1) %>&startDate=<%= (startDateParam!=null?startDateParam:"") %>&endDate=<%= (endDateParam!=null?endDateParam:"") %>&status=<%= (statusParam!=null?statusParam:"Todas") %>&semaforo=<%= (semaforoParam!=null?semaforoParam:"Todas") %><%= (roleId==2 ? "&tipoAsignacion="+(tipoAsignacion!=null?tipoAsignacion:"Todas") : "") %>&destinatario=<%= (destinatarioParam!=null?destinatarioParam:"") %>&department=<%= (departmentParam!=null?departmentParam:"") %>">
            &laquo; Anterior
          </a>
        </li>
        <%
          for(int p=1; p<=totalPages; p++){
            if(p==currentPage){
        %>
          <li class="page-item active">
            <a class="page-link" href="#"><%= p %></a>
          </li>
        <%
            } else {
        %>
          <li class="page-item">
            <a class="page-link"
               href="searchActivities.jsp?page=<%= p %>&startDate=<%= (startDateParam!=null?startDateParam:"") %>&endDate=<%= (endDateParam!=null?endDateParam:"") %>&status=<%= (statusParam!=null?statusParam:"Todas") %>&semaforo=<%= (semaforoParam!=null?semaforoParam:"Todas") %><%= (roleId==2 ? "&tipoAsignacion="+(tipoAsignacion!=null?tipoAsignacion:"Todas") : "") %>&destinatario=<%= (destinatarioParam!=null?destinatarioParam:"") %>&department=<%= (departmentParam!=null?departmentParam:"") %>">
              <%= p %>
            </a>
          </li>
        <%
            }
          }
        %>
        <li class="page-item <%= (currentPage==totalPages?"disabled":"") %>">
          <a class="page-link"
             href="searchActivities.jsp?page=<%= (currentPage+1) %>&startDate=<%= (startDateParam!=null?startDateParam:"") %>&endDate=<%= (endDateParam!=null?endDateParam:"") %>&status=<%= (statusParam!=null?statusParam:"Todas") %>&semaforo=<%= (semaforoParam!=null?semaforoParam:"Todas") %><%= (roleId==2 ? "&tipoAsignacion="+(tipoAsignacion!=null?tipoAsignacion:"Todas") : "") %>&destinatario=<%= (destinatarioParam!=null?destinatarioParam:"") %>&department=<%= (departmentParam!=null?departmentParam:"") %>">
            Siguiente &raquo;
          </a>
        </li>
      </ul>
    </nav>

</div> <!-- container -->

<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
