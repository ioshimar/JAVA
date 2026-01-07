<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>Iniciar Sesión - Sistema de Seguimiento</title>
    <!-- Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

    <style>
        body {
            background: #f8f9fa; /* Color más suave */
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            width: 100%;
            max-width: 500px; /* Más grande en escritorio */
            background: #fff;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .logo {
            width: 100px;
            margin-bottom: 1rem;
        }
        .title {
            font-size: 1.8rem;
            font-weight: 700;
            color: #333;
        }
        .input-group-text {
            background: #007bff;
            color: #fff;
            border: none;
        }
        .btn-primary {
            background: #007bff;
            border: none;
            padding: 12px;
            font-size: 1.1rem;
        }
        .btn-primary:hover {
            background: #0056b3;
        }
        .alert {
            font-size: 0.9rem;
        }
        @media (max-width: 576px) {
            .login-container {
                width: 90%; /* En pantallas pequeñas */
                padding: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <!-- Icono de Usuario -->
        <i class="fas fa-user-circle fa-4x text-primary mb-2"></i>

        <!-- Título -->
        <h2 class="title">Iniciar Sesión</h2>

        <!-- Mostrar mensaje de éxito después de cambiar la contraseña -->
        <% 
            String message = request.getParameter("message"); 
            if (message != null && !message.isEmpty()) { 
                message = URLDecoder.decode(message, "UTF-8");
        %>
            <div class="alert alert-success">
                <%= message %>
            </div>
        <% } %>

        <!-- Formulario de Login -->
        <form action="LoginServlet" method="post">
            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                <input type="email" id="email" class="form-control" 
                       name="email" placeholder="Correo Institucional" required>
            </div>

            <div class="mb-3 input-group">
                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                <input type="password" id="password" class="form-control" 
                       name="password" placeholder="Contraseña" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">
                <i class="fas fa-sign-in-alt"></i> Entrar
            </button>
        </form>

        <!-- Enlace para recuperar contraseña -->
        <div class="text-center mt-3">
            <a target="_blank" href="recoverPassword.jsp">¿Olvidaste tu contraseña o es la primera vez que ingresas?</a>
        </div>

        <!-- Mostrar error si existe -->
        <% if(request.getAttribute("error") != null){ %>
            <div class="alert alert-danger mt-3">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
    </div>

    <!-- Scripts Bootstrap 5 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
