<%-- 
    Document   : listUsers
    Created on : 10 feb 2025, 15:51:01
    Author     : IOSHIMAR.RODRIGUEZ
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <title>Usuarios</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<div class="container my-4">
    <h2>Lista de Usuarios</h2>
    <% if(request.getAttribute("error") != null){ %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre Completo</th>
                <th>Correo</th>
                <th>Funciones</th>
                <th>Teléfono</th>
                <th>Rol</th>
                <th>Departamento</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        <%
          List<Map<String,Object>> userList = (List<Map<String,Object>>) request.getAttribute("users");
          if (userList != null) {
            for (Map<String,Object> u : userList) {
        %>
            <tr>
                <td><%= u.get("id") %></td>
                <td><%= u.get("fullName") %></td>
                <td><%= u.get("email") %></td>
                <td><%= u.get("functions") %></td>
                <td><%= u.get("phone") %></td>
                <td><%= u.get("roleName") %></td>
                <td><%= u.get("deptName") %></td>
                <td>
                    <!-- Editar -->
                    <a href="editUser.jsp?id=<%= u.get("id") %>" class="btn btn-sm btn-warning">Editar</a>
                    <!-- Eliminar -->
                    <form action="users" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= u.get("id") %>">
                        <button class="btn btn-sm btn-danger" onclick="return confirm('¿Eliminar usuario?');">Borrar</button>
                    </form>
                </td>
            </tr>
        <%
            }
          }
        %>
        </tbody>
    </table>

    <a href="createUser.jsp" class="btn btn-primary">Crear Nuevo Usuario</a>
</div>
</body>
</html>
