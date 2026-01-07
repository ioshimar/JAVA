<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>SIIT CURT</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap y FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
        .form-container { margin: 30px auto; padding: 20px; max-width: 500px; background-color: white; border-radius: 15px; box-shadow: 0px 0px 15px rgba(0,0,0,0.08);}
        .btn-primary { width: 100%; }
        .error-msg { color: red; font-size: 13px; }
        .radio-group {
            display: flex;
            gap: 20px;
            margin-bottom: 10px;
        }
        .form-label { font-weight: 500; }
        @media (max-width: 576px) {
            .logo-system-container { flex-direction: column; }
            .system-title { font-size: 20px; }
        }
    </style>
</head>
<body>
<div class="container-fluid p-0">
    <div class="header-container">
        <img src="images/Logo_INEGI_a.jpg" alt="Encabezado" class="header-img">
    </div>
</div>
<div class="container">
    <div class="logo-system-container">
        <img src="images/Logo_CURT.png" alt="Logo del sistema" class="logo-img">
        <h2 class="system-title">SIIT CURT</h2>
    </div>
</div>

<br>

<div class="container">
    <div class="form-container">
        <h3 class="mb-4">Crear una cuenta nueva</h3>
        <form action="RegisterServlet" method="post" id="registerForm" autocomplete="off">
            <!-- Nombre completo -->
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre completo</label>
                <input type="text" class="form-control" id="nombre" name="nombre_completo" maxlength="80" required placeholder="Tu nombre y apellidos">
            </div>
            <!-- Correo electrónico -->
            <div class="mb-3">
                <label for="correo" class="form-label">Correo electrónico</label>
                <input type="email" class="form-control" id="correo" name="correo" maxlength="100" required placeholder="usuario@ejemplo.com">
            </div>

            <!-- ¿Eres Unidad del Estado? -->
            <div class="mb-3">
                <label class="form-label">¿Eres Unidad del Estado?</label>
                <div class="radio-group">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="tipo_usuario" id="unidad_si" value="unidad" required>
                        <label class="form-check-label" for="unidad_si">
                            Sí
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="tipo_usuario" id="unidad_no" value="publico" required>
                        <label class="form-check-label" for="unidad_no">
                            No, soy público en general
                        </label>
                    </div>
                </div>
            </div>

            <!-- Unidad del Estado (solo si responde SÍ) -->
            <div class="mb-3" id="unidadEstadoField" style="display:none;">
                <label for="unidad_estado" class="form-label">
                    Nombre de la Unidad del Estado
                </label>
                <input type="text" class="form-control" id="unidad_estado" name="unidad_estado"
                       maxlength="80"
                       placeholder="Ej: Catastro Municipal de Chihuahua">
            </div>

            <!-- Contraseña -->
            <div class="mb-3">
                <label for="password" class="form-label">Contraseña</label>
                <input type="password" class="form-control" id="password" name="password" maxlength="50" required placeholder="Crea una contraseña segura">
            </div>
            <!-- Confirmar contraseña -->
            <div class="mb-3">
                <label for="password2" class="form-label">Confirmar contraseña</label>
                <input type="password" class="form-control" id="password2" name="password2" maxlength="50" required placeholder="Repite tu contraseña">
                <div id="pwError" class="error-msg"></div>
            </div>

            <button type="submit" class="btn btn-primary">Registrarse</button>
        </form>
        <div class="mt-3 text-center">
            ¿Ya tienes cuenta? <a href="login.jsp">Iniciar sesión</a>
        </div>
    </div>
</div>

<script>
    // Mostrar/Ocultar el campo "Unidad del Estado"
    document.addEventListener('DOMContentLoaded', function() {
        const unidadSi = document.getElementById('unidad_si');
        const unidadNo = document.getElementById('unidad_no');
        const unidadEstadoField = document.getElementById('unidadEstadoField');
        const unidadEstadoInput = document.getElementById('unidad_estado');

        function toggleUnidadField() {
            if (unidadSi.checked) {
                unidadEstadoField.style.display = '';
                unidadEstadoInput.required = true;
            } else {
                unidadEstadoField.style.display = 'none';
                unidadEstadoInput.value = '';
                unidadEstadoInput.required = false;
            }
        }

        unidadSi.addEventListener('change', toggleUnidadField);
        unidadNo.addEventListener('change', toggleUnidadField);

        // Ejecuta al cargar (por si viene del back y queda marcado)
        toggleUnidadField();
    });

    // Validación de contraseñas
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        let pw1 = document.getElementById('password').value;
        let pw2 = document.getElementById('password2').value;
        let pwError = document.getElementById('pwError');
        if (pw1 !== pw2) {
            pwError.textContent = "Las contraseñas no coinciden";
            e.preventDefault();
        } else {
            pwError.textContent = "";
        }
    });
</script>

<%-- Mensajes de error o éxito desde el Servlet, usando SweetAlert2 --%>
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
        title: '¡Registro exitoso!',
        text: '<%= successMsg.replace("'", "\\'") %>',
        confirmButtonText: 'Ir al login'
    }).then(function() {
        window.location.href = 'login.jsp';
    });
</script>
<% } %>

</body>
</html>
