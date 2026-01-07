<%-- 
    Document   : reset_password
    Created on : 8 jul 2025, 0:06:24
    Author     : IOSHIMAR.RODRIGUEZ
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restablecer contraseña | Sistema de Consulta CURT</title>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body { background-color: #f8f9fa; }
        .header-img { width: 200px; height: auto; display: block; margin-left: 0; }
        .header-container { display: flex; align-items: center; padding: 10px 0; background-color: white; }
        .logo-system-container { display: flex; align-items: center; justify-content: center; gap: 10px; }
        .logo-img { width: 80px; height: auto; }
        .system-title { font-size: 24px; font-weight: bold; margin: 0; text-align: center; }
        .form-container {
            margin: 40px auto 20px auto;
            padding: 32px 28px 18px 28px;
            max-width: 480px;
            background-color: white;
            border-radius: 18px;
            box-shadow: 0px 0px 16px rgba(0,0,0,0.07);
        }
        .btn-success { width: 100%; }
        @media (max-width: 576px) {
            .logo-system-container { flex-direction: column; }
            .system-title { font-size: 20px; }
            .form-container { padding: 16px 8px 10px 8px;}
        }
        .form-label { font-weight: 500; }
    </style>
</head>
<body>
<!-- Header igual que index.jsp -->
<div class="container-fluid p-0">
    <div class="header-container">
        <img src="images/Logo_INEGI_a.jpg" alt="Encabezado" class="header-img">
    </div>
</div>
<div class="container mt-2">
    <div class="logo-system-container">
        <img src="images/Logo_CURT.png" alt="Logo del sistema" class="logo-img">
        <h2 class="system-title">SIIT CURT</h2>
    </div>
</div>

<div class="container">
    <div class="form-container">
        <h3 class="mb-3 text-center"><i class="fas fa-unlock-alt"></i> Establece una nueva contraseña</h3>
        <form method="POST" action="RestablecerPasswordServlet" autocomplete="off">
            <input type="hidden" name="correo" value="${correo}" />
            <div class="mb-3">
                <label for="password1" class="form-label">Nueva contraseña</label>
                <input type="password" class="form-control" name="password1" id="password1" required minlength="6" placeholder="Mínimo 6 caracteres">
            </div>
            <div class="mb-3">
                <label for="password2" class="form-label">Confirma contraseña</label>
                <input type="password" class="form-control" name="password2" id="password2" required minlength="6" placeholder="Repite tu contraseña">
            </div>
            <button type="submit" class="btn btn-success mt-2">Guardar nueva contraseña</button>
        </form>
    </div>
</div>
<br><br>

<!-- Mensajes SweetAlert2 desde el servlet -->
<% String errorMsg = (String) request.getAttribute("error"); %>
<% if (errorMsg != null && !errorMsg.isEmpty()) { %>
<script>
    Swal.fire({
        icon: 'error',
        title: 'Error',
        text: '<%= errorMsg.replace("'", "\\'") %>'
    });
</script>
<% } %>
<% String successMsg = (String) request.getAttribute("success"); %>
<% if (successMsg != null && !successMsg.isEmpty()) { %>
<script>
    Swal.fire({
        icon: 'success',
        title: '¡Éxito!',
        text: '<%= successMsg.replace("'", "\\'") %>',
        confirmButtonText: 'Iniciar sesión'
    });
</script>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
