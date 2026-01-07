<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Asignar Actividad</title>
    <!-- Bootstrap 4.6.2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">
    <!-- Tempus Dominus (datetime) CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.39.0/css/tempusdominus-bootstrap-4.min.css" />
    <!-- Select2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" />

    <style>
        .result-table-container {
            margin-top: 1rem;
            display: none; /* Se mostrará tras la búsqueda */
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container mt-5" style="max-width:800px;">
    <h2 class="mb-4 text-center">Asignar Nueva Actividad</h2>

    <form action="ActivityServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="save">

        <!-- Título -->
        <div class="form-group">
            <label>Título (Obligatorio)</label>
            <input type="text" class="form-control" name="title" required>
        </div>

        <!-- Descripción -->
        <div class="form-group">
            <label>Descripción (Opcional)</label>
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

        <!-- Fecha/Hora (Tempus Dominus) -->
        <div class="form-group">
            <label>Fecha y Hora de Entrega</label>
            <div class="input-group" id="datetimepicker1" data-target-input="nearest">
                <input type="text" class="form-control datetimepicker-input"
                       data-target="#datetimepicker1" name="due_date" required placeholder="YYYY-MM-DD HH:mm"/>
                <div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker">
                    <div class="input-group-text"><i class="fas fa-calendar-alt"></i></div>
                </div>
            </div>
        </div>

        <!-- Subir Archivo (opcional) -->
        <div class="form-group">
            <label>Archivos (opcional, múltiples)</label>
            <!-- name="files" multiple -->
            <input type="file" name="files" multiple class="form-control">
        </div>

        <hr>

        <!-- Buscar por nombre -->
        <h5>Buscar Destinatario por nombre (Jefe u Operativo)</h5>
        <div class="form-row">
            <div class="col-md-8">
                <input type="text" class="form-control" id="searchName" placeholder="Ej. Juan Pérez">
            </div>
            <div class="col-md-4">
                <button type="button" id="btnSearchName" class="btn btn-secondary btn-block">Buscar</button>
            </div>
        </div>

        <!-- Resultados de búsqueda -->
        <div class="result-table-container" id="resultContainer">
            <table class="table table-sm table-bordered mt-3">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody id="resultBody"></tbody>
            </table>
        </div>

        <hr>

        <!-- O bien, buscar por Departamento -->
        <h5>O bien, buscar por Departamento</h5>
        <div class="form-row">
            <div class="form-group col-md-6">
                <label>Departamento</label>
                <select class="form-control" id="deptSelect"></select>
            </div>
            <div class="form-group col-md-6">
                <label>Usuario</label>
                <select class="form-control" id="userSelect"></select>
            </div>
        </div>

        <!-- Destinatarios seleccionados (Select Múltiple) -->
        <div class="form-group">
            <label>Destinatarios Seleccionados</label>
            <!-- name="assigned_to" multiple => se envían todos los IDs -->
            <select class="form-control" id="assigned_to" name="assigned_to" multiple style="height:auto;"></select>
        </div>

        <button type="submit" class="btn btn-primary btn-block mt-3">Asignar Actividad</button>
    </form>
</div>

<!-- Scripts: jquery, bootstrap, moment, datetimepicker, sweetalert2, fontawesome, select2 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/locale/es.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.39.0/js/tempusdominus-bootstrap-4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<%
    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");
    if(error != null){
%>
<script>
Swal.fire({
  icon: 'error',
  title: 'Error',
  text: '<%= error.replace("'","\\'") %>'
});
</script>
<%
    } else if(message != null){
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

<script>
$(document).ready(function(){
    // 1) Inicializar calendario Tempus Dominus en español
    moment.locale('es');
    $('#datetimepicker1').datetimepicker({
        locale: 'es',
        format: 'YYYY-MM-DD HH:mm'
    });

    // 2) Cargar departamentos => #deptSelect
    $.ajax({
        url: "getDepartments_subdirector.jsp",
        success: function(data){
            $("#deptSelect").html("<option value=''>-- Seleccionar --</option>" + data);
        }
    });

    // 3) Al cambiar #deptSelect => cargar #userSelect
    $("#deptSelect").on('change', function(){
        let dId = $(this).val();
        if(dId){
            $.ajax({
                url: "getUsersByDept.jsp?deptId=" + dId,
                success: function(options){
                    $("#userSelect").html(options);
                    // Iniciamos select2
                    $("#userSelect").select2({ width: '100%' });
                }
            });
        } else {
            $("#userSelect").html('');
        }
    });
    // Iniciar select2 vacío
    $("#userSelect").select2({ width: '100%' });

    // Aplicar select2 al select de "assigned_to" para que puedan eliminar destinatarios
    $("#assigned_to").select2({
        width: '100%',
        // "tags" habilita agregar/eliminar opciones fácilmente
        // y cada opción se muestra como un "tag" con X
        tags: true
    });

    // 4) Botón "Buscar" => searchUser.jsp
    $("#btnSearchName").on('click', function(){
        let name = $("#searchName").val().trim();
        if(name.length < 2){
            Swal.fire('Error', 'Escribe al menos 2 caracteres para buscar', 'error');
            return;
        }
        $.ajax({
            url: "searchUser.jsp?query=" + encodeURIComponent(name),
            dataType: "html",
            success: function(html){
                $("#resultBody").html(html);
                $("#resultContainer").show();
            }
        });
    });

    // 5) Cuando se hace clic en "Seleccionar" en la tabla de resultados => se agrega como Option(selected=true)
    $(document).on('click', '.select-user-btn', function(){
        let uid = $(this).data('userid');
        let uname = $(this).data('username');
        // Evitar duplicados
        if($("#assigned_to option[value='" + uid + "']").length == 0){
            // new Option(text, value, defaultSelected, selected)
            let newOption = new Option(uname, uid, true, true);
            $("#assigned_to").append(newOption).trigger('change');
        }
        Swal.fire('Seleccionado', 'Se ha agregado a la lista de destinatarios', 'success');
    });

    // 6) Al elegir un usuario en #userSelect => agregarlo con selected=true
    $("#userSelect").on('change', function(){
        let uid = $(this).val();
        let uname = $("#userSelect option:selected").text();
        if(uid && $("#assigned_to option[value='" + uid + "']").length == 0){
            let newOption = new Option(uname, uid, true, true);
            $("#assigned_to").append(newOption).trigger('change');
        }
    });
});
</script>
</body>
</html>
