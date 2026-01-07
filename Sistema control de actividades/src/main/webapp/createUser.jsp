<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Crear Colaborador</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">
</head>
<body>

<jsp:include page="header.jsp"/>

<%
    // Verificar sesión
    if(session.getAttribute("userId") == null){
        response.sendRedirect("login.jsp");
        return;
    }
    int currentUserId = (Integer) session.getAttribute("userId");
    int currentRole = (Integer) session.getAttribute("roleId");

    // Si es jefe, obtener su department_id
    int myDept = 0;
    if(currentRole == 2){
        try(Connection conn = utils.DBConnection.getConnection()){
            PreparedStatement psDept = conn.prepareStatement(
                "SELECT department_id FROM seguimiento_actividades.users WHERE id=?"
            );
            psDept.setInt(1, currentUserId);
            ResultSet rsDept = psDept.executeQuery();
            if(rsDept.next()){
                myDept = rsDept.getInt("department_id");
            }
            rsDept.close();
            psDept.close();
        } catch(Exception ex){
            ex.printStackTrace();
        }
    }

    // Variables para edición (si "editId" viene en la URL)
    String editId = request.getParameter("editId");
    String editName = "";
    String editEmail = "";
    String editPhone = "";
    String editFunc = "";
    String editRole = ""; // 'jefe' o 'operativo'
    String editAge = "";
    String editAddress = "";
    String editDept = "";

    if(editId != null && !editId.trim().isEmpty()) {
        try(Connection conn = utils.DBConnection.getConnection()) {
            String sqlE = "SELECT id, full_name, institutional_email, personal_phone, functions, "
                        + "age, address, role_id, department_id "
                        + "FROM seguimiento_actividades.users "
                        + "WHERE id=? AND role_id IN (2,3)";
            PreparedStatement psE = conn.prepareStatement(sqlE);
            psE.setInt(1, Integer.parseInt(editId));
            ResultSet rsE = psE.executeQuery();
            if(rsE.next()){
                editName = rsE.getString("full_name");
                editEmail = rsE.getString("institutional_email");
                editPhone = rsE.getString("personal_phone");
                editFunc = rsE.getString("functions");
                int r = rsE.getInt("role_id");
                editRole = (r == 2 ? "jefe" : "operativo");
                int dId = rsE.getInt("department_id");
                if(!rsE.wasNull()){
                    editDept = String.valueOf(dId);
                }
                int a = rsE.getInt("age");
                if(!rsE.wasNull()){
                    editAge = String.valueOf(a);
                }
                String addr = rsE.getString("address");
                editAddress = (addr == null ? "" : addr);
            }
            rsE.close();
            psE.close();
        } catch(Exception ex) {
            ex.printStackTrace();
        }
    }
%>

<div class="container mt-5" style="max-width:700px;">
    <h2 class="mb-4 text-center">Crear/Editar Colaborador</h2>

    <form method="post" action="ColaboradorServlet">
        <input type="hidden" name="action" value="save">
        <input type="hidden" name="uId" value="<%= (editId != null ? editId : "") %>">

        <!-- Nombre -->
        <div class="form-group">
            <label>Nombre Completo (Obligatorio)</label>
            <input type="text" class="form-control" name="full_name" required
                   value="<%= editName %>">
        </div>

        <!-- Correo -->
        <div class="form-group">
            <label>Correo Institucional (Obligatorio)</label>
            <input type="email" class="form-control" name="institutional_email" required
                   value="<%= editEmail %>">
        </div>

        <!-- Teléfono -->
        <div class="form-group">
            <label>Teléfono (Opcional)</label>
            <input type="text" class="form-control" name="personal_phone"
                   value="<%= editPhone %>">
        </div>

        <!-- Funciones -->
        <div class="form-group">
            <label>Funciones (Opcional)</label>
            <input type="text" class="form-control" name="functions"
                   value="<%= editFunc %>">
        </div>

        <!-- Edad -->
        <div class="form-group">
            <label>Edad (Opcional)</label>
            <input type="number" class="form-control" name="age"
                   value="<%= editAge %>">
        </div>

        <!-- Dirección -->
        <div class="form-group">
            <label>Dirección (Opcional)</label>
            <textarea class="form-control" name="address"><%= editAddress %></textarea>
        </div>

        <%
            // SUBDIRECTOR => puede elegir rol y departamento
            // JEFE => forzamos a 'operativo' y dept = myDept
            if(currentRole == 1){
        %>
        <!-- Subdirector => rol y departamento -->
        <div class="form-group">
            <label>Rol</label>
            <select class="form-control" name="role" required>
                <option value="">-- Seleccionar --</option>
                <option value="jefe" <%= "jefe".equals(editRole) ? "selected" : "" %>>Jefe de Departamento</option>
                <option value="operativo" <%= "operativo".equals(editRole) ? "selected" : "" %>>Operativo</option>
            </select>
        </div>
        <div class="form-group">
            <label>Departamento (Obligatorio)</label>
            <select class="form-control" name="department_id" id="deptSelect">
                <option value="">-- Seleccionar Departamento --</option>
                <!-- Se llena vía AJAX en subdirector -->
            </select>
        </div>
        <%
            } else if(currentRole == 2){
        %>
        <!-- Jefe => forzar a 'operativo' y su propio dept -->
        <input type="hidden" name="role" value="operativo">
        <input type="hidden" name="department_id" value="<%= myDept %>">
        <%
            }
        %>

        <button type="submit" class="btn btn-primary btn-block mt-3">
            <%= (editId != null ? "Guardar Cambios" : "Crear Colaborador") %>
        </button>
    </form>
</div>

<hr class="mt-5">

<!-- Sección de búsqueda y listado -->
<div class="container">
    <h4>Colaboradores</h4>

    <!-- Formulario de búsqueda (GET) -->
    <form method="get" action="createUser.jsp" class="form-inline mb-3">
        <input type="text" name="search" class="form-control mr-2"
               placeholder="Buscar por nombre"
               value="<%= request.getParameter("search") == null ? "" : request.getParameter("search") %>">
        <button type="submit" class="btn btn-secondary">Buscar</button>
    </form>

    <div class="table-responsive">

        <%
            // Parámetros de búsqueda y paginación
            String searchParam = request.getParameter("search");
            if(searchParam == null) searchParam = "";
            String pageParam = request.getParameter("page");  // nombre del parámetro
            int pageNum = 1;  // evitamos "page" para no chocar con el objeto implícito
            try {
                pageNum = Integer.parseInt(pageParam);
                if(pageNum < 1) pageNum = 1;
            } catch(Exception e){
                // si no es número o es nulo, se queda en 1
            }
            int pageSize = 5;
            int offset = (pageNum - 1) * pageSize;

            int totalCount = 0;
            int totalPages = 1;

            // Construir condición de WHERE
            StringBuilder where = new StringBuilder();
            java.util.List<Object> paramsCount = new java.util.ArrayList<>();
            java.util.List<Object> paramsList = new java.util.ArrayList<>();

            // SUBDIRECTOR(1) => ver jefes(2) y operativos(3) pero de SUS departamentos
            // JEFE(2) => ver solo operativos(3) de su dept y excluirse

            if(currentRole == 1) {
                // Filtrar con un JOIN para solo departamentos donde subdirector_id = currentUserId
                // Adicionalmente filtrar rol en (2,3)
                where.append("u.role_id IN (2,3) ");
                where.append("AND u.department_id IN (SELECT id FROM seguimiento_actividades.departments WHERE subdirector_id=?)");
                paramsCount.add(currentUserId);
                paramsList.add(currentUserId);

                if(!searchParam.trim().isEmpty()) {
                    where.append(" AND u.full_name ILIKE ? ");
                }

            } else {
                // JEFE
                where.append("u.role_id=3 AND u.department_id=? AND u.id<>? ");
                paramsCount.add(myDept);
                paramsCount.add(currentUserId);
                paramsList.add(myDept);
                paramsList.add(currentUserId);

                if(!searchParam.trim().isEmpty()) {
                    where.append(" AND u.full_name ILIKE ? ");
                }
            }

            // Consultas COUNT y LIST
            String countSQL = "SELECT COUNT(*) as total "
                            + "FROM seguimiento_actividades.users u "
                            + "LEFT JOIN seguimiento_actividades.departments d ON u.department_id=d.id "
                            + "WHERE " + where.toString();

            String listSQL = "SELECT u.id, u.full_name, u.institutional_email, u.personal_phone, "
                           + "       u.functions, u.age, u.address, u.role_id, d.name as dept_name "
                           + "FROM seguimiento_actividades.users u "
                           + "LEFT JOIN seguimiento_actividades.departments d ON u.department_id=d.id "
                           + "WHERE " + where.toString()
                           + " ORDER BY d.name, u.full_name "
                           + "LIMIT ? OFFSET ?";

            // Agregar parámetros búsqueda
            // subdirector => primer param subdirector_id, 
            // luego si hay 'search', lo agregamos
            // JEFE => primer param dept, segundo param userID, etc...

            boolean hasSearch = !searchParam.trim().isEmpty();
            try(Connection conn = utils.DBConnection.getConnection()){
                // 1) COUNT
                PreparedStatement psCount = conn.prepareStatement(countSQL);

                int idx = 1;
                for(Object p : paramsCount){
                    psCount.setObject(idx++, p);
                }
                if(hasSearch){
                    psCount.setString(idx++, "%" + searchParam.trim() + "%");
                }

                ResultSet rsCount = psCount.executeQuery();
                if(rsCount.next()){
                    totalCount = rsCount.getInt("total");
                }
                rsCount.close();
                psCount.close();

                if(totalCount > 0){
                    totalPages = (int)Math.ceil((double)totalCount / pageSize);
                } else {
                    totalPages = 1;
                }

                if(pageNum > totalPages) {
                    pageNum = totalPages;
                    offset = (pageNum - 1)*pageSize;
                }

                // 2) LIST
                PreparedStatement psList = conn.prepareStatement(listSQL);

                idx = 1;
                for(Object p : paramsList){
                    psList.setObject(idx++, p);
                }
                if(hasSearch){
                    psList.setString(idx++, "%" + searchParam.trim() + "%");
                }
                // paginación
                psList.setInt(idx++, pageSize);
                psList.setInt(idx, offset);

                ResultSet rsL = psList.executeQuery();

                String lastDept = "";
        %>
        <table class="table table-bordered table-striped mt-3">
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Correo</th>
                    <th>Teléfono</th>
                    <th>Funciones</th>
                    <th>Edad</th>
                    <th>Dirección</th>
                    <th>Rol</th>
                    <th>Departamento</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
            <%
                while(rsL.next()){
                    int cId = rsL.getInt("id");
                    String cName = rsL.getString("full_name");
                    String cEmail = rsL.getString("institutional_email");
                    String cPhone = rsL.getString("personal_phone");
                    String cFunc = rsL.getString("functions");
                    int cAge = rsL.getInt("age");
                    boolean hasAge = !rsL.wasNull();
                    String cAddress = rsL.getString("address");
                    int cRole = rsL.getInt("role_id");
                    String cRoleTxt = (cRole == 2 ? "Jefe" : "Operativo");
                    String dName = rsL.getString("dept_name");
                    if(dName == null) dName = "";

                    if(!dName.equals(lastDept)){
            %>
                <tr class="table-active">
                    <td colspan="9"><strong>Departamento: <%= dName %></strong></td>
                </tr>
            <%
                        lastDept = dName;
                    }
            %>
                <tr>
                    <td><%= cName %></td>
                    <td><%= cEmail %></td>
                    <td><%= (cPhone==null?"":cPhone) %></td>
                    <td><%= (cFunc==null?"":cFunc) %></td>
                    <td><%= (hasAge ? cAge : "") %></td>
                    <td><%= (cAddress==null?"":cAddress) %></td>
                    <td><%= cRoleTxt %></td>
                    <td><%= dName %></td>
                    <td>
                        <a href="createUser.jsp?editId=<%= cId %>" class="btn btn-sm btn-warning">Editar</a>
                        <a href="javascript:void(0);"
                           class="btn btn-sm btn-danger delete-user"
                           data-url="ColaboradorServlet?action=delete&uId=<%= cId %>">
                           Eliminar
                        </a>
                    </td>
                </tr>
            <%
                }
                rsL.close();
                psList.close();
            }
            catch(Exception ex){
                ex.printStackTrace();
            }
            %>
            </tbody>
        </table>
    </div>

    <%
        if(totalCount > pageSize){
    %>
    <nav aria-label="Page navigation">
      <ul class="pagination">
        <%
            String extraParams = "";
            if(!searchParam.trim().isEmpty()){
                extraParams = "&search=" + java.net.URLEncoder.encode(searchParam, "UTF-8");
            }

            if(pageNum > 1){
        %>
        <li class="page-item">
          <a class="page-link" href="createUser.jsp?page=<%= pageNum-1 %><%= extraParams %>">Anterior</a>
        </li>
        <%
            } else {
        %>
        <li class="page-item disabled"><span class="page-link">Anterior</span></li>
        <%
            }

            for(int i=1; i<=totalPages; i++){
                if(i == pageNum){
        %>
        <li class="page-item active"><span class="page-link"><%= i %></span></li>
        <%
                } else {
        %>
        <li class="page-item">
          <a class="page-link"
             href="createUser.jsp?page=<%= i %><%= extraParams %>"><%= i %></a>
        </li>
        <%
                }
            }

            if(pageNum < totalPages){
        %>
        <li class="page-item">
          <a class="page-link"
             href="createUser.jsp?page=<%= pageNum+1 %><%= extraParams %>">Siguiente</a>
        </li>
        <%
            } else {
        %>
        <li class="page-item disabled"><span class="page-link">Siguiente</span></li>
        <%
            }
        %>
      </ul>
    </nav>
    <%
        }
    %>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>
$(document).ready(function(){
    $(document).on('click', '.delete-user', function(){
        var url = $(this).data('url');
        Swal.fire({
            title: '¿Eliminar colaborador?',
            text: 'Esta acción no se podrá deshacer.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Sí, eliminar',
            cancelButtonText: 'Cancelar'
        }).then((result)=>{
            if(result.isConfirmed){
                window.location.href = url;
            }
        });
    });
});
</script>

<%
    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");
    if(error != null){
%>
<script>
Swal.fire({
  icon: 'error',
  title: 'Error',
  text: '<%= error.replace("'","\\'") %>'
});
</script>
<%
    } else if(message != null){
%>
<script>
Swal.fire({
  icon: 'success',
  title: '¡Éxito!',
  text: '<%= message.replace("'","\\'") %>'
});
</script>
<%
    }
%>

<script>
    // Si es subdirector, cargar departamentos vía AJAX
    var role = <%= currentRole %>;
    if(role === 1){
        $.ajax({
            url: "getDepartments_subdirector.jsp",
            success: function(data){
                $("#deptSelect").html('<option value="">-- Seleccionar Departamento --</option>'+data);
                var editDept = "<%= editDept %>";
                if(editDept !== ""){
                    $("#deptSelect").val(editDept);
                }
            }
        });
    }
</script>

</body>
</html>
