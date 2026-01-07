<%@ page import="java.sql.*, java.time.*, java.util.*, utils.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>Detalles de la Actividad</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <!-- jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- Select2 -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

    <style>
        .section-header {
            background: #f1f1f1;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
        }
        /* Estilos base de hilos */
        .thread-item {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
            color: #333;
        }
        .thread-header {
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        .status-indicator {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 5px;
        }
        .dot-pendiente { background-color: #ffc107; }
        .dot-en-progreso { background-color: #17a2b8; }
        .dot-terminado { background-color: #28a745; }

        /* Ejemplo de responsividad simple */
        @media (max-width: 576px) {
            .section-header h3 {
                font-size: 1.2rem;
            }
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="container mt-4">
<%
    // Verificar sesión
    if(session.getAttribute("userId") == null){
        response.sendRedirect("login.jsp");
        return;
    }
    int currentUserId = (Integer) session.getAttribute("userId");
    int roleId = (Integer) session.getAttribute("roleId");

    String actIdParam = request.getParameter("activityId");
    if(actIdParam == null || actIdParam.isEmpty()){
        out.println("<h3>Error: Falta activityId.</h3>");
        return;
    }
    int activityId = Integer.parseInt(actIdParam);

    // Variables de la actividad
    String title="", description="", priority="", status="", delegationNote = "";
    Timestamp dueDate = null;
    int assignedBy = 0; // ID del asignador original

    // Lista de colaboradores (destinatarios)
    ArrayList<Integer> collaborators = new ArrayList<>();

    try(Connection conn = DBConnection.getConnection()){
        // 1. Cargar datos de la actividad
        String sqlAct = "SELECT title, description, priority, due_date, status, assigned_by, delegation_note "
                      + "FROM seguimiento_actividades.activities WHERE id=?";
        try(PreparedStatement psA = conn.prepareStatement(sqlAct)){
            psA.setInt(1, activityId);
            try(ResultSet rsA = psA.executeQuery()){
                if(rsA.next()){
                    title = rsA.getString("title");
                    description = rsA.getString("description");
                    priority = rsA.getString("priority");
                    dueDate = rsA.getTimestamp("due_date");
                    status = rsA.getString("status");
                    assignedBy = rsA.getInt("assigned_by");
                    delegationNote = rsA.getString("delegation_note");
                }
            }
        }

        // 2. Obtener colaboradores de activity_collaborators
        String sqlCollab = "SELECT user_id FROM seguimiento_actividades.activity_collaborators WHERE activity_id = ?";
        try(PreparedStatement psC = conn.prepareStatement(sqlCollab)){
            psC.setInt(1, activityId);
            try(ResultSet rsC = psC.executeQuery()){
                while(rsC.next()){
                    collaborators.add(rsC.getInt("user_id"));
                }
            }
        }
%>
    <div class="section-header">
        <h3><%= title %></h3>
        <p>
            <strong>Prioridad:</strong> <%= priority %><br>
            <strong>Fecha de Entrega:</strong> <%= (dueDate != null ? dueDate.toString() : "-") %><br>
            <strong>Estado:</strong>
            <span class="status-indicator 
                <%= ("Terminado".equalsIgnoreCase(status) ? "dot-terminado" : 
                      ("En Progreso".equalsIgnoreCase(status) ? "dot-en-progreso" : "dot-pendiente")) %>"></span>
            <%= status %><br>
            <strong>Descripción:</strong> <%= (description == null ? "" : description) %>
        </p>
        <%
            // Mostrar información de asignación/reasignación
            if(delegationNote != null && !delegationNote.trim().isEmpty()){
        %>
            <p><strong>Información de Reasignación:</strong> <%= delegationNote %></p>
        <%
            } else {
                // Para asignación directa, mostrar quién asignó
                String originalAssigner = "";
                String sqlUser = "SELECT full_name FROM seguimiento_actividades.users WHERE id=?";
                try(PreparedStatement psUser = conn.prepareStatement(sqlUser)){
                    psUser.setInt(1, assignedBy);
                    try(ResultSet rsUser = psUser.executeQuery()){
                        if(rsUser.next()){
                            originalAssigner = rsUser.getString("full_name");
                        }
                    }
                }
        %>
            <p><strong>Asignada por:</strong> <%= originalAssigner %></p>
        <%
            }
        %>

        <!-- Botón "Marcar como Terminado" para subdirector (role 1) o jefe (role 2), si no está terminada -->
        <% if((roleId == 1 || roleId == 2) && !"Terminado".equalsIgnoreCase(status)) { %>
            <button id="markFinishedBtn" class="btn btn-warning btn-sm">Marcar como Terminado</button>
        <% } %>

        <!-- Reasignar Actividad a varios: SOLO para jefes (role=2) en este ejemplo,
             si la actividad NO está terminada y assigned_by != currentUserId -->
        <% if(roleId == 2 && assignedBy != currentUserId && !"Terminado".equalsIgnoreCase(status)) { %>
            <hr>
            <h5>Reasignar Actividad a varios</h5>
            <form id="reassignForm">
                <input type="hidden" name="action" value="reassignActivity">
                <input type="hidden" name="activityId" value="<%= activityId %>">
                <div class="form-group">
                    <label>Seleccionar Destinatarios</label>
                    <%
                        // Obtener el department_id del jefe
                        int departmentId = 0;
                        String sqlDept = "SELECT department_id FROM seguimiento_actividades.users WHERE id = ?";
                        try(PreparedStatement psDept2 = conn.prepareStatement(sqlDept)){
                            psDept2.setInt(1, currentUserId);
                            try(ResultSet rsDept2 = psDept2.executeQuery()){
                                if(rsDept2.next()){
                                    departmentId = rsDept2.getInt("department_id");
                                }
                            }
                        }
                    %>
                    <select class="form-control" id="newAssignedSelect" name="newAssignedTo" multiple required>
                        <%
                            // Seleccionar operativos del mismo departamento
                            String sqlOps = "SELECT id, full_name FROM seguimiento_actividades.users "
                                          + "WHERE department_id = ? AND role_id = 3 ORDER BY full_name";
                            try(PreparedStatement psOps = conn.prepareStatement(sqlOps)){
                                psOps.setInt(1, departmentId);
                                try(ResultSet rsOps = psOps.executeQuery()){
                                    while(rsOps.next()){
                                        int uid = rsOps.getInt("id");
                                        String uname = rsOps.getString("full_name");
                        %>
                        <option value="<%= uid %>"><%= uname %></option>
                        <%
                                    }
                                }
                            }
                        %>
                    </select>
                </div>
                <button class="btn btn-secondary btn-sm">Reasignar</button>
            </form>
            <script>
            $(document).ready(function(){
                $('#newAssignedSelect').select2({ 
                    placeholder:'Selecciona uno o más destinatarios...', 
                    width:'100%' 
                });
                $('#reassignForm').submit(function(e){
                    e.preventDefault();
                    let formData = new FormData(this);
                    fetch("ThreadServlet", {
                        method:"POST",
                        body: formData
                    })
                    .then(resp=>{
                        if(resp.ok){
                            Swal.fire("Reasignada","La actividad fue reasignada.","success")
                                .then(()=>location.reload());
                        } else {
                            resp.text().then(msg=>{
                                Swal.fire("Error al reasignar", msg, "error");
                            });
                        }
                    })
                    .catch(err=>{
                        Swal.fire("Error","Problema de conexión.", "error");
                    });
                });
            });
            </script>
        <% } %>
    </div>

    <!-- NUEVAS FUNCIONALIDADES -->
    <%
        // Solo mostramos el botón para subdirector(1) o jefe(2) que no esté Terminada
        boolean puedeVerOpciones = ((roleId == 1 || roleId == 2) && !"Terminado".equalsIgnoreCase(status));
        if(puedeVerOpciones){
    %>
    <div class="mb-3">
        <button class="btn btn-info btn-sm" id="toggleEditBtn">Mostrar Opciones de Edición</button>
    </div>

    <div id="editOptions" style="display:none;">
        <hr>
        <%
            // 1) Botón Eliminar Actividad
            boolean puedeEliminar = false;
            // Mismas condiciones: asignador original, sin delegationNote, etc.
            if((roleId == 1 || roleId == 2) && !"Terminado".equalsIgnoreCase(status)){
                if(assignedBy == currentUserId && (delegationNote == null || delegationNote.trim().isEmpty())){
                    puedeEliminar = true;
                }
            }
            if(puedeEliminar){
        %>
        <div class="mb-3">
            <h5>Eliminar Actividad</h5>
            <button id="deleteActivityBtn" class="btn btn-danger btn-sm">Eliminar Actividad</button>
        </div>
        <script>
        document.getElementById("deleteActivityBtn")?.addEventListener("click", function(){
            Swal.fire({
                title: "¿Eliminar la actividad?",
                text: "Esta acción no se puede deshacer.",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Sí, eliminar",
                cancelButtonText: "Cancelar"
            }).then((result)=>{
                if(result.isConfirmed){
                    let formData = new URLSearchParams();
                    formData.append("action","deleteActivity");
                    formData.append("activityId","<%= activityId %>");
                    fetch("ThreadServlet", {
                        method:"POST",
                        headers: {"Content-Type":"application/x-www-form-urlencoded"},
                        body: formData
                    })
                    .then(resp=>{
                        if(resp.ok){
                            Swal.fire("Eliminada","La actividad fue eliminada.","success")
                                .then(()=> window.location.href="dashboard.jsp");
                        } else {
                            resp.text().then(msg=>{
                                Swal.fire("Error al eliminar", msg, "error");
                            });
                        }
                    })
                    .catch(err=>{
                        Swal.fire("Error","Problema de conexión.","error");
                    });
                }
            });
        });
        </script>
        <%
            }
        %>

        <%
            // 2) Form para actualizar fecha
            boolean puedeCambiarFecha = false;
            if((roleId == 1 || roleId == 2) && !"Terminado".equalsIgnoreCase(status)){
                if(assignedBy == currentUserId && (delegationNote == null || delegationNote.trim().isEmpty())){
                    puedeCambiarFecha = true;
                }
            }
            if(puedeCambiarFecha){
        %>
        <div class="mb-3">
            <h5>Cambiar Fecha de Entrega</h5>
            <form id="dueDateForm">
                <input type="hidden" name="action" value="updateDueDate">
                <input type="hidden" name="activityId" value="<%= activityId %>">
                <div class="form-group">
                    <label>Nueva fecha/hora de entrega:</label>
                    <input type="datetime-local" name="newDueDate" class="form-control" required>
                </div>
                <button class="btn btn-info btn-sm">Actualizar Fecha</button>
            </form>
        </div>
        <script>
        document.getElementById("dueDateForm")?.addEventListener("submit", function(e){
            e.preventDefault();
            let fData = new FormData(this);
            fetch("ThreadServlet", {
                method:"POST",
                body:fData
            })
            .then(resp=>{
                if(resp.ok){
                    Swal.fire("Fecha actualizada","Se ha notificado a los colaboradores","success")
                        .then(()=> location.reload());
                } else {
                    resp.text().then(msg=>{
                        Swal.fire("Error", msg, "error");
                    });
                }
            })
            .catch(err=>{
                Swal.fire("Error","Problema de conexión.","error");
            });
        });
        </script>
        <%
            }
        %>

        <%
            // 3) Form para editar colaboradores (añadir/quitar)
            boolean puedeEditarColabs = false;
            if((roleId == 1 || roleId == 2) && !"Terminado".equalsIgnoreCase(status)){
                puedeEditarColabs = true;
            }
            if(puedeEditarColabs){
        %>
        <div class="mb-3">
            <h5>Editar Colaboradores (Quitar / Agregar)</h5>
            <form id="editCollabsForm">
                <input type="hidden" name="action" value="updateCollaborators">
                <input type="hidden" name="activityId" value="<%= activityId %>">
                <div class="form-group">
                    <label>Seleccionar Colaboradores</label>
                    <%
                        // NO USAMOS departmentId2 para subdirector
                        // Subdirector: usando subdirector_id = currentUserId
                        // Jefe: su department_id

                        int departmentId2 = 0;
                        String sqlDept2 = "SELECT department_id FROM seguimiento_actividades.users WHERE id = ?";
                        try(PreparedStatement psDept = conn.prepareStatement(sqlDept2)){
                            psDept.setInt(1, currentUserId);
                            try(ResultSet rsD = psDept.executeQuery()){
                                if(rsD.next()){
                                    departmentId2 = rsD.getInt("department_id");
                                }
                            }
                        }

                        String sqlOps2;
                        if(roleId == 1) {
                            // Subdirector => ver jefes(2) + operativos(3)
                            // Usamos d.subdirector_id = currentUserId
                            sqlOps2 = "SELECT u.id, u.full_name "
                                    + "FROM seguimiento_actividades.users u "
                                    + "JOIN seguimiento_actividades.departments d ON u.department_id = d.id "
                                    + "WHERE d.subdirector_id = ? "
                                    + "  AND u.role_id IN (2,3) "
                                    + "ORDER BY u.full_name";
                        } else {
                            // Jefe => ver solo role=3 en su department_id
                            sqlOps2 = "SELECT u.id, u.full_name "
                                    + "FROM seguimiento_actividades.users u "
                                    + "WHERE u.department_id=? AND u.role_id=3 "
                                    + "ORDER BY u.full_name";
                        }

                        ArrayList<Integer> alreadySelected = new ArrayList<>(collaborators);
                    %>
                    <select class="form-control" id="collaboratorsSelect" name="collaboratorsSelected" multiple required>
                    <%
                        try(PreparedStatement psOps2 = conn.prepareStatement(sqlOps2)){
                            if(roleId == 1) {
                                // Subdirector => user ID en subdirector_id
                                psOps2.setInt(1, currentUserId);
                            } else {
                                // Jefe => department_id
                                psOps2.setInt(1, departmentId2);
                            }
                            try(ResultSet rsOps2 = psOps2.executeQuery()){
                                while(rsOps2.next()){
                                    int ouid = rsOps2.getInt("id");
                                    String oname = rsOps2.getString("full_name");
                                    String sel = (alreadySelected.contains(ouid)) ? "selected" : "";
                    %>
                        <option value="<%= ouid %>" <%= sel %>><%= oname %></option>
                    <%
                                }
                            }
                        }
                    %>
                    </select>
                </div>
                <button class="btn btn-primary btn-sm">Guardar Cambios</button>
            </form>
        </div>
        <script>
        $(document).ready(function(){
            $('#collaboratorsSelect').select2({
                placeholder: 'Selecciona uno o más colaboradores...',
                width: '100%'
            });
            $('#editCollabsForm').submit(function(e){
                e.preventDefault();
                let formData = new FormData(this);
                fetch("ThreadServlet", {
                    method:"POST",
                    body: formData
                })
                .then(resp=>{
                    if(resp.ok){
                        Swal.fire("Colaboradores Actualizados","Se agregó notificación a los nuevos colaboradores","success")
                           .then(()=> location.reload());
                    } else {
                        resp.text().then(msg=>{
                            Swal.fire("Error", msg, "error");
                        });
                    }
                })
                .catch(err=>{
                    Swal.fire("Error","Problema de conexión.","error");
                });
            });
        });
        </script>
        <%
            }
        %>
    </div>

    <script>
    // Toggle para mostrar/ocultar las opciones de edición
    document.getElementById("toggleEditBtn")?.addEventListener("click", function(){
        const editDiv = document.getElementById("editOptions");
        if(editDiv.style.display === "none"){
            editDiv.style.display = "block";
            this.textContent = "Ocultar Opciones de Edición";
        } else {
            editDiv.style.display = "none";
            this.textContent = "Mostrar Opciones de Edición";
        }
    });
    </script>

    <%
        } // fin if(puedeVerOpciones)
    %>
    <!-- FIN NUEVAS FUNCIONALIDADES -->

    <!-- Archivos de la actividad (sin thread_id) -->
    <h5>Archivos de la Actividad</h5>
    <ul class="mb-4">
    <%
        String sqlAttachAct = "SELECT file_path FROM seguimiento_actividades.attachments "
                            + "WHERE activity_id=? AND thread_id IS NULL";
        boolean hasAttachAct = false;
        try(PreparedStatement psAttA = conn.prepareStatement(sqlAttachAct)){
            psAttA.setInt(1, activityId);
            try(ResultSet rsAttA = psAttA.executeQuery()){
                while(rsAttA.next()){
                    hasAttachAct = true;
    %>
        <li><a href="<%= rsAttA.getString("file_path") %>" target="_blank"><%= rsAttA.getString("file_path") %></a></li>
    <%
                }
            }
        }
        if(!hasAttachAct){
    %>
        <li>No hay archivos adjuntos de la actividad.</li>
    <%
        }
    %>
    </ul>

    <!-- Comentarios (con colores distintos para cada usuario) -->
    <h5>Comentarios</h5>
    <%
        LinkedHashMap<Integer,String> userColorsMap = new LinkedHashMap<>();
        ArrayList<Integer> distinctUserIds = new ArrayList<>();

        String sqlDistinctUsers = "SELECT DISTINCT user_id FROM seguimiento_actividades.activity_threads WHERE activity_id=?";
        try(PreparedStatement psDU = conn.prepareStatement(sqlDistinctUsers)){
            psDU.setInt(1, activityId);
            try(ResultSet rsDU = psDU.executeQuery()){
                while(rsDU.next()){
                    distinctUserIds.add(rsDU.getInt("user_id"));
                }
            }
        }
        String[] palette = {
            "#e3f2fd","#f1f8e9","#fff3e0","#fce4ec","#ede7f6","#e0f7fa","#ffebee","#f9fbe7","#ffffff","#f5f5f5",
            "#d7ccc8","#c8e6c9","#b3e5fc","#b2dfdb","#d1c4e9","#ffcdd2","#fff9c4","#ffe0b2","#dcedc8","#f8bbd0"
        };
        for(int i=0; i<distinctUserIds.size(); i++){
            int uid = distinctUserIds.get(i);
            String chosenColor = palette[i % palette.length];
            userColorsMap.put(uid, chosenColor);
        }

        String sqlThreads = "SELECT t.id, t.comment, t.comment_date, t.user_id, u.full_name "
                          + "FROM seguimiento_actividades.activity_threads t "
                          + "JOIN seguimiento_actividades.users u ON t.user_id = u.id "
                          + "WHERE t.activity_id=? ORDER BY t.comment_date ASC";
        boolean noComments = true;
        try(PreparedStatement psThr = conn.prepareStatement(sqlThreads)){
            psThr.setInt(1, activityId);
            try(ResultSet rsThr = psThr.executeQuery()){
                while(rsThr.next()){
                    noComments = false;
                    int tId = rsThr.getInt("id");
                    String cmt = rsThr.getString("comment");
                    Timestamp cDate = rsThr.getTimestamp("comment_date");
                    int commentUserId = rsThr.getInt("user_id");
                    String uname = rsThr.getString("full_name");

                    String bgColor = userColorsMap.getOrDefault(commentUserId, "#ffffff");
    %>
    <div class="thread-item" style="background-color:<%= bgColor %>;">
        <div class="thread-header">
            <strong><%= uname %></strong>
            <em style="font-size:0.9rem;">(<%= cDate %>)</em>
        </div>
        <p><%= cmt %></p>
        <%
            // Archivos de este comentario (thread_id=tId)
            String sqlTAtt = "SELECT file_path FROM seguimiento_actividades.attachments WHERE thread_id=?";
            try(PreparedStatement psTAtt = conn.prepareStatement(sqlTAtt)){
                psTAtt.setInt(1, tId);
                try(ResultSet rsTAtt = psTAtt.executeQuery()){
                    boolean hasThFiles = false;
                    while(rsTAtt.next()){
                        hasThFiles = true;
        %>
            <p style="font-size:0.9rem;">
                <strong>Archivo:</strong>
                <a href="<%= rsTAtt.getString("file_path") %>" target="_blank">
                    <%= rsTAtt.getString("file_path") %>
                </a>
            </p>
        <%
                    }
                    if(!hasThFiles){
        %>
            <p style="font-size:0.8rem;color:#888;">(Sin archivos en este comentario)</p>
        <%
                    }
                }
            }
        %>
    </div>
    <%
                }
            }
        }
        if(noComments){
    %>
    <p>No hay comentarios aún.</p>
    <%
        }
    %>

    <!-- Form para nuevo comentario -->
    <%
        boolean canComment = false;
        if(!"Terminado".equalsIgnoreCase(status)){
            // subdirector(1) => canComment = true
            // jefe(2) => canComment si assignedBy == currentUserId o es parte
            if(roleId == 1) {
                canComment = true;
            } else if(assignedBy == currentUserId) {
                canComment = true;
            } else if(collaborators.contains(currentUserId)) {
                canComment = true;
            }
        }
        if(canComment){
    %>
    <h5>Responder</h5>
    <form id="commentForm" enctype="multipart/form-data">
        <input type="hidden" name="action" value="addComment">
        <input type="hidden" name="activityId" value="<%= activityId %>">
        <div class="form-group">
            <label>Mensaje</label>
            <textarea name="comment" class="form-control" rows="3" required></textarea>
        </div>
        <div class="form-group">
            <label>Archivos (cualquier tipo, opcional, múltiples)</label>
            <input type="file" name="files" multiple class="form-control">
        </div>
        <button class="btn btn-primary">Enviar</button>
    </form>
    <%
        } else {
    %>
    <p><em>No puedes comentar porque la actividad está terminada o no eres parte de ella.</em></p>
    <%
        }
    } catch(Exception e){
        e.printStackTrace();
        out.println("<div class='alert alert-danger'>Error al cargar la actividad: " + e.getMessage() + "</div>");
    }
%>
</div>

<script>
document.addEventListener("DOMContentLoaded", function(){
    // Botón para marcar actividad como Terminada
    const markFinishedBtn = document.getElementById("markFinishedBtn");
    if(markFinishedBtn){
        markFinishedBtn.addEventListener("click", ()=>{
            Swal.fire({
                title: "¿Terminar la actividad?",
                text: "Se cambiará el estado a 'Terminado'.",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Sí, terminar",
                cancelButtonText: "Cancelar"
            }).then(result=>{
                if(result.isConfirmed){
                    const formData = new URLSearchParams();
                    formData.append("action","markFinished");
                    formData.append("activityId","<%= activityId %>");
                    fetch("ThreadServlet", {
                        method:"POST",
                        headers: {"Content-Type": "application/x-www-form-urlencoded"},
                        body: formData
                    })
                    .then(resp=>{
                        if(resp.ok){
                            Swal.fire("Hecho","Actividad terminada.","success")
                                .then(()=> location.reload());
                        } else {
                            Swal.fire("Error","No se pudo terminar la actividad.","error");
                        }
                    })
                    .catch(err=>{
                        Swal.fire("Error","Problema de conexión.","error");
                    });
                }
            });
        });
    }

    // Enviar comentario
    const commentForm = document.getElementById("commentForm");
    if(commentForm){
        commentForm.addEventListener("submit", (e)=>{
            e.preventDefault();
            let fData = new FormData(commentForm);
            fetch("ThreadServlet", {
                method:"POST",
                body: fData
            })
            .then(resp=>{
                if(resp.ok){
                    Swal.fire("Comentario agregado","","success")
                        .then(()=> location.reload());
                } else {
                    Swal.fire("Error","No se pudo enviar el comentario.","error");
                }
            })
            .catch(err=>{
                Swal.fire("Error","Error de conexión.","error");
            });
        });
    }
});
</script>

</body>
</html>
