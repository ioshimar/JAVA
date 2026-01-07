<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Asignar Actividad (Subdirector)</title>

    <!-- Bootstrap 4.6.2 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <!-- Eonasdan Datetimepicker (v4.17.47) CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/eonasdan-bootstrap-datetimepicker@4.17.47/build/css/bootstrap-datetimepicker.min.css">
</head>
<body>

<!-- Incluir encabezado global -->
<jsp:include page="header.jsp"/>

<%
    // Verificar rol SUBDIRECTOR
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = (Integer) session.getAttribute("userId");
    int roleId = (Integer) session.getAttribute("roleId");

    // Si no es subdirector => redirigir
    if (roleId != 1) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>

<div class="container mt-5" style="max-width: 650px;">
    <h2 class="mb-4">Asignar Actividad (Subdirector)</h2>
    <form action="activity" method="post" enctype="multipart/form-data">
        <!-- Título -->
        <div class="form-group">
            <label>Título de la Actividad</label>
            <input type="text" class="form-control" name="title" required>
        </div>
        
        <!-- Descripción -->
        <div class="form-group">
            <label>Descripción</label>
            <textarea class="form-control" name="description" rows="3"></textarea>
        </div>
        
        <!-- Prioridad (con íconos) -->
        <div class="form-group">
            <label>Prioridad</label>
            <select class="form-control" name="priority" required>
                <option value="Alta">🔺 Alta</option>
                <option value="Media">🔸 Media</option>
                <option value="Baja">🔻 Baja</option>
            </select>
        </div>

        <!-- Fecha y Hora (calendario en español) -->
        <div class="form-group">
            <label>Fecha y Hora de Entrega</label>
            <div class="input-group date" id="fechaEntrega">
                <input type="text" class="form-control" name="due_date" placeholder="YYYY-MM-DD HH:mm" required>
                <span class="input-group-append input-group-text">
                    <i class="fas fa-calendar-alt"></i>
                </span>
            </div>
        </div>

        <!-- Tipo de Destinatario -->
        <div class="form-group">
            <label>Tipo de Destinatario</label>
            <select id="tipoDestinatario" class="form-control">
                <option value="">-- Seleccionar --</option>
                <option value="jefe">Jefe de Departamento</option>
                <option value="operativo">Operativo</option>
            </select>
        </div>

        <!-- Seleccionar Departamento (para ambos casos) -->
        <div class="form-group d-none" id="seccionDepto">
            <label>Seleccionar Departamento</label>
            <select class="form-control" id="selectDepto">
                <option value="">-- Departamentos --</option>
                <%
                    // Suponiendo que "departments" tiene "subdirector_id" referencing "users(id)"
                    // y que userId es el Subdirector actual
                    try(Connection conn = utils.DBConnection.getConnection()){
                        String sqlDept = "SELECT id, name FROM seguimiento_actividades.departments WHERE subdirector_id=? ORDER BY name";
                        PreparedStatement psD = conn.prepareStatement(sqlDept);
                        psD.setInt(1, userId);
                        ResultSet rsD = psD.executeQuery();
                        while(rsD.next()){
                %>
                <option value="<%= rsD.getInt("id") %>"><%= rsD.getString("name") %></option>
                <%
                        }
                    } catch(Exception e) {
                        e.printStackTrace();
                    }
                %>
            </select>
        </div>

        <!-- SELECT donde cargaremos jefes u operativos (vía AJAX) -->
        <div class="form-group d-none" id="seccionUsers">
            <label id="labelUsuario"></label>
            <select class="form-control" name="assigned_to" id="selectUsers">
                <option value="">-- Destinatarios --</option>
            </select>
        </div>

        <!-- Adjuntar archivo (opcional) -->
        <div class="form-group">
            <label>Adjuntar Archivo (opcional)</label>
            <input type="file" class="form-control" name="file">
        </div>

        <button type="submit" class="btn btn-primary btn-block">Asignar</button>
    </form>

    <!-- Mostrar error si existe -->
    <% if(request.getAttribute("error") != null){ %>
        <div class="alert alert-danger mt-3">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
</div>

<!-- Scripts: jquery -> moment -> bootstrap -> datetimepicker -> tu script -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment/min/moment-with-locales.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/eonasdan-bootstrap-datetimepicker@4.17.47/build/js/bootstrap-datetimepicker.min.js"></script>
<!-- Font Awesome (para iconos) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js"></script>

<script>
$(document).ready(function(){
    // 1) Calendario en español
    moment.locale('es');
    $('#fechaEntrega').datetimepicker({
        format: 'YYYY-MM-DD HH:mm',
        locale: 'es',
        sideBySide: true
    });

    // 2) Al cambiar tipoDestinatario => mostrar "departamento" + "seccionUsers"
    $("#tipoDestinatario").on('change', function(){
        let val = $(this).val();
        if(val){
            // Mostrar selectDepto, ocultar seccionUsers
            $("#seccionDepto").removeClass('d-none');
            $("#selectDepto").val('');
            $("#seccionUsers").addClass('d-none');
            $("#selectUsers").html('<option value="">-- Destinatarios --</option>');
            
            if(val === 'jefe'){
                $("#labelUsuario").text("Seleccionar Jefe(s)");
            } else {
                $("#labelUsuario").text("Seleccionar Operativo(s)");
            }
        } else {
            $("#seccionDepto, #seccionUsers").addClass('d-none');
        }
    });

    // 3) Al elegir un departamento => AJAX a getDeptUsers_subdirector.jsp
    $("#selectDepto").on('change', function(){
        let deptId = $(this).val();
        let tipo = $("#tipoDestinatario").val(); // "jefe" o "operativo"
        if(deptId && tipo){
            $.ajax({
                url: "getOperatives_subdirector.jsp",
                type: "GET",
                data: { deptId: deptId, tipo: tipo },
                success: function(data){
                    $("#selectUsers").html(data);
                    $("#seccionUsers").removeClass('d-none');
                }
            });
        } else {
            $("#seccionUsers").addClass('d-none');
        }
    });
});
</script>
</body>
</html>
