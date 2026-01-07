<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, utils.DBConnection" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>Asignar Actividad (Jefe de Departamento)</title>
    <!-- Bootstrap 4 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <!-- Tempus Dominus CSS (v5, compatible Bootstrap 4/5) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tempusdominus-bootstrap-4@5.39.0/build/css/tempusdominus-bootstrap-4.min.css">
    <!-- Font Awesome (opcional para iconos) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>

<jsp:include page="header.jsp"/>

<%
    // Verificar sesión y rol (solo jefe => role_id=2)
    if(session.getAttribute("userId") == null){
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = (Integer) session.getAttribute("userId");
    int roleId = (Integer) session.getAttribute("roleId");
    if(roleId != 2){
        response.sendRedirect("dashboard.jsp");
        return;
    }

    // Obtener el department_id del jefe
    int myDept = 0;
    try(Connection conn = DBConnection.getConnection()){
        String sqlDept = "SELECT department_id FROM seguimiento_actividades.users WHERE id=?";
        PreparedStatement psDept = conn.prepareStatement(sqlDept);
        psDept.setInt(1, userId);
        ResultSet rsDept = psDept.executeQuery();
        if(rsDept.next()){
            myDept = rsDept.getInt("department_id");
        }
        rsDept.close();
        psDept.close();
    } catch(Exception e){
        e.printStackTrace();
    }
%>

<div class="container mt-5" style="max-width:650px;">
    <h2 class="mb-4">Asignar Actividad (Jefe de Departamento)</h2>
    <!-- Notar que se incluye enctype="multipart/form-data" para subir archivos -->
    <form action="ActivityServlet" method="post" enctype="multipart/form-data">
        <!-- Indicar la acción en el servlet -->
        <input type="hidden" name="action" value="save">

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

        <!-- Prioridad -->
        <div class="form-group">
            <label>Prioridad</label>
            <select class="form-control" name="priority" required>
                <option value="Alta">Alta</option>
                <option value="Media">Media</option>
                <option value="Baja">Baja</option>
            </select>
        </div>

        <!-- Fecha y Hora de Entrega (Tempus Dominus) -->
        <div class="form-group">
            <label>Fecha y Hora de Entrega</label>
            <!-- Estructura recomendada por Tempus Dominus v5: data-target, data-toggle, etc. -->
            <div class="input-group" id="datetimepicker1" data-target-input="nearest">
                <input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker1"
                       name="due_date" placeholder="YYYY-MM-DD HH:mm" required/>
                <div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker">
                    <div class="input-group-text"><i class="fas fa-calendar-alt"></i></div>
                </div>
            </div>
        </div>

        <!-- Seleccionar múltiples operativos del departamento -->
        <div class="form-group">
            <label>Asignar a Operativo(s) de tu Departamento</label>
            <select class="form-control" name="assigned_to" multiple required>
                <%
                    try(Connection conn = DBConnection.getConnection()){
                        String sqlOps = "SELECT id, full_name FROM seguimiento_actividades.users "
                                      + "WHERE department_id=? AND role_id=3 "
                                      + "ORDER BY full_name";
                        PreparedStatement psOps = conn.prepareStatement(sqlOps);
                        psOps.setInt(1, myDept);
                        ResultSet rsOps = psOps.executeQuery();
                        while(rsOps.next()){
                            int opId = rsOps.getInt("id");
                            String opName = rsOps.getString("full_name");
                %>
                <option value="<%= opId %>"><%= opName %></option>
                <%
                        }
                        rsOps.close();
                        psOps.close();
                    } catch(Exception ex2){
                        ex2.printStackTrace();
                    }
                %>
            </select>
            <small class="form-text text-muted">
                Mantén presionada la tecla CTRL (Windows) o CMD (Mac) para seleccionar varios.
            </small>
        </div>

        <!-- Adjuntar varios archivos (cualquier tipo) -->
        <div class="form-group">
            <label>Adjuntar Archivos (opcionales)</label>
            <!-- multiple => subir más de un archivo, sin restricciones => cualquier tipo -->
            <input type="file" class="form-control" name="files" multiple>
            <small class="form-text text-muted">
                Puedes subir uno o varios archivos de cualquier tipo (PDF, ZIP, Imágenes, etc.).
            </small>
        </div>

        <button type="submit" class="btn btn-primary btn-block">Asignar</button>
    </form>

    <!-- Mensajes de error/éxito -->
    <%
        if(request.getAttribute("error") != null){
    %>
    <div class="alert alert-danger mt-3">
        <%= request.getAttribute("error") %>
    </div>
    <%
        } else if(request.getAttribute("message") != null){
    %>
    <div class="alert alert-success mt-3">
        <%= request.getAttribute("message") %>
    </div>
    <%
        }
    %>
</div>

<!-- Scripts: jQuery -> moment -> bootstrap.bundle -> tempusdominus (en español) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment/min/moment-with-locales.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/tempusdominus-bootstrap-4@5.39.0/build/js/tempusdominus-bootstrap-4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js"></script>

<script>
$(function () {
    // Configurar moment en español
    moment.locale('es');
    // Inicializar Tempus Dominus
    $('#datetimepicker1').datetimepicker({
        locale: 'es',
        format: 'YYYY-MM-DD HH:mm'
    });
});
</script>

</body>
</html>
