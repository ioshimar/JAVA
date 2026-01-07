<%-- 
    Document   : resetPassword
    Created on : 10 feb 2025, 15:28:13
    Author     : IOSHIMAR.RODRIGUEZ
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Restablecer Contraseña</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body>
<%
    String token = request.getParameter("token");
    String firstTime = request.getParameter("firstTime");
%>
<div class="container mt-5" style="max-width: 500px;">
    <h2>Restablecer Contraseña</h2>
    <form action="ResetPasswordServlet" method="post">
        <input type="hidden" name="token" value="<%= token != null ? token : "" %>">
        <input type="hidden" name="firstTime" value="<%= firstTime != null ? firstTime : "" %>">
        <div class="form-group">
            <label>Nueva Contraseña</label>
            <input type="password" class="form-control" name="newPassword" required>
        </div>
        <button type="submit" class="btn btn-success btn-block">Cambiar Contraseña</button>
    </form>
    <% if(request.getAttribute("error") != null){ %>
        <div class="alert alert-danger mt-3">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
</div>
</body>
</html>
