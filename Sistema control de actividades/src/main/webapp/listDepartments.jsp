<%-- 
    Document   : listDepartments
    Created on : 10 feb 2025, 15:48:35
    Author     : IOSHIMAR.RODRIGUEZ
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <title>Departamentos</title>
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
    <h2>Departamentos</h2>
    <% if(request.getAttribute("error") != null){ %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <!-- Formulario para Crear un nuevo departamento -->
    <form action="departments" method="post" class="row g-3 mb-4">
        <div class="col-auto">
            <input type="hidden" name="action" value="create">
            <input type="text" name="name" class="form-control" placeholder="Nuevo departamento" required>
        </div>
        <div class="col-auto">
            <button class="btn btn-primary">Crear</button>
        </div>
    </form>

    <!-- Tabla de departamentos -->
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th style="width:200px;">Acciones</th>
            </tr>
        </thead>
        <tbody>
        <%
          List<Map<String,Object>> deptList = (List<Map<String,Object>>) request.getAttribute("departments");
          if (deptList != null) {
            for (Map<String,Object> d : deptList) {
        %>
            <tr>
                <td><%= d.get("id") %></td>
                <td><%= d.get("name") %></td>
                <td>
                    <!-- Formulario para editar -->
                    <form action="departments" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="<%= d.get("id") %>">
                        <input type="text" name="name" value="<%= d.get("name") %>" class="form-control d-inline" style="width:100px;">
                        <button class="btn btn-sm btn-success">Guardar</button>
                    </form>

                    <!-- Formulario para eliminar -->
                    <form action="departments" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= d.get("id") %>">
                        <button class="btn btn-sm btn-danger" onclick="return confirm('¿Seguro de eliminar?');">
                            Eliminar
                        </button>
                    </form>
                </td>
            </tr>
        <%
            }
          }
        %>
        </tbody>
    </table>
</div>
</body>
</html>

