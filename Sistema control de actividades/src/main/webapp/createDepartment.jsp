<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Crear Departamento</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">
</head>
<body>
<jsp:include page="header.jsp"/>

<%
    String editId = request.getParameter("editId");
    String editName = "";
    String editExtension = "";
    String editFunction = "";

    if (editId != null && !editId.trim().isEmpty()) {
        try(Connection conn = utils.DBConnection.getConnection()){
            int userId = (Integer) session.getAttribute("userId");
            String sqlE = "SELECT id, name, extension_phone, function FROM seguimiento_actividades.departments "
                        + "WHERE id=? AND subdirector_id=?";
            PreparedStatement psE = conn.prepareStatement(sqlE);
            psE.setInt(1, Integer.parseInt(editId));
            psE.setInt(2, (Integer) session.getAttribute("userId"));
            ResultSet rsE = psE.executeQuery();
            if (rsE.next()) {
                editName = rsE.getString("name");
                editExtension = rsE.getString("extension_phone");
                editFunction = rsE.getString("function");
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
%>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h2 class="mb-4 text-center">Crear/Editar Departamento</h2>
            <form action="DepartmentServlet" method="post">
                <input type="hidden" name="action" value="save">
                <input type="hidden" name="deptId" value="<%= (editId != null ? editId : "") %>">

                <div class="form-group">
                    <label>Nombre (Obligatorio)</label>
                    <input type="text" class="form-control" name="name"
                           value="<%= editName %>" required>
                </div>
                <div class="form-group">
                    <label>Extensión Telefónica (Opcional)</label>
                    <input type="text" class="form-control" name="extension"
                           value="<%= (editExtension == null ? "" : editExtension) %>">
                </div>
                <div class="form-group">
                    <label>Función (Opcional)</label>
                    <input type="text" class="form-control" name="function"
                           value="<%= (editFunction == null ? "" : editFunction) %>">
                </div>
                <button type="submit" class="btn btn-primary btn-block">
                    <%= (editId != null ? "Guardar Cambios" : "Crear Departamento") %>
                </button>
            </form>
        </div>
    </div>

    <hr class="mt-5">

    <h4>Mis Departamentos</h4>
    <table class="table table-striped mt-3">
        <thead>
            <tr>
                <th>Nombre</th>
                <th>Extensión</th>
                <th>Función</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        <%
            try(Connection conn2 = utils.DBConnection.getConnection()){
                int userId = (Integer) session.getAttribute("userId");
                String sqlL = "SELECT id, name, extension_phone, function FROM seguimiento_actividades.departments "
                            + "WHERE subdirector_id=? ORDER BY name";
                PreparedStatement psL = conn2.prepareStatement(sqlL);
                psL.setInt(1, userId);
                ResultSet rsL = psL.executeQuery();
                while(rsL.next()){
                    int dId = rsL.getInt("id");
                    String dName = rsL.getString("name");
                    String dExt = rsL.getString("extension_phone");
                    String dFunc = rsL.getString("function");
        %>
            <tr>
                <td><%= dName %></td>
                <td><%= (dExt == null ? "" : dExt) %></td>
                <td><%= (dFunc == null ? "" : dFunc) %></td>
                <td>
                    <a href="createDepartment.jsp?editId=<%= dId %>" class="btn btn-sm btn-warning">Editar</a>
                    <a href="DepartmentServlet?action=delete&deptId=<%= dId %>" class="btn btn-sm btn-danger delete-dept">Eliminar</a>
                </td>
            </tr>
        <%
                }
            } catch(Exception ex){
                ex.printStackTrace();
        %>
            <tr><td colspan="4">Error al listar: <%= ex.getMessage() %></td></tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<!-- JS de Bootstrap + jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- SweetAlert2 JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>
$(document).ready(function(){
    // Interceptar clic en enlaces con clase "delete-dept"
    $(".delete-dept").on("click", function(e){
        e.preventDefault();
        var url = $(this).attr("href");
        Swal.fire({
            title: "¿Eliminar departamento?",
            text: "¿Estás seguro que deseas eliminar este departamento?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Sí, eliminar",
            cancelButtonText: "Cancelar"
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = url;
            }
        });
    });
});
</script>

<%
    // Mostrar mensajes de error o éxito con SweetAlert2
    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");
    if (error != null) {
%>
<script>
Swal.fire({
  icon: 'error',
  title: 'Error',
  text: '<%= error.replace("'","\\'") %>'
});
</script>
<%
    } else if (message != null) {
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
</body>
</html>
