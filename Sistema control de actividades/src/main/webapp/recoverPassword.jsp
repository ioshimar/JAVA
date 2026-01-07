<%-- 
    Document   : recoverPassword
    Created on : 10 feb 2025, 15:27:42
    Author     : IOSHIMAR.RODRIGUEZ
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Recuperar Contraseña</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5" style="max-width: 500px;">
    <h2>Recuperar Contraseña</h2>
    <form action="RecoverPasswordServlet" method="post">
        <div class="form-group">
            <label>Ingresa tú Correo Institucional</label>
            <input type="email" class="form-control" name="email" required>
        </div>
        <button type="submit" class="btn btn-primary btn-block">Enviar Instrucciones</button>
    </form>
    <% if(request.getAttribute("message") != null){ %>
        <div class="alert alert-success mt-3">
            <%= request.getAttribute("message") %>
        </div>
    <% } else if(request.getAttribute("error") != null){ %>
        <div class="alert alert-danger mt-3">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
</div>
</body>
</html>

