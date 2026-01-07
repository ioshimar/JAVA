<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String userName = (String) session.getAttribute("userName");
    int roleId = (Integer) session.getAttribute("roleId");
%>

<!-- Navbar Global -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="dashboard.jsp">Seguimiento</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav mr-auto">
            <!-- Todos ven Dashboard -->
            <li class="nav-item">
                <a class="nav-link" href="dashboard.jsp">Inicio</a>
            </li>

            <!-- Subdirector (role_id=1) -->
            <% if (roleId == 1) { %>
                <li class="nav-item">
                    <a class="nav-link" href="createDepartment.jsp">Crear Departamento</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="createUser.jsp">Crear Colaborador</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="assignActivity.jsp">Nueva Actividad</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="departmentDirectory.jsp">Directorio</a>
                </li>

            <!-- Jefe de Departamento (role_id=2) -->
            <% } else if (roleId == 2) { %>
                <li class="nav-item">
                    <a class="nav-link" href="createUser.jsp">Crear Colaborador</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="activityForm_jefe.jsp">Nueva Actividad</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="teamActivities.jsp">Actividades del Equipo</a>
                </li>

            <!-- Operativo (role_id=3) -->
            <% } else if (roleId == 3) { %>
                <!--<li class="nav-item">
                    <a class="nav-link" href="assignedActivities.jsp">Mis Actividades</a>
                </li>-->
                
            <% } %>
            
            <li class="nav-item">
                <a class="nav-link" href="searchActivities.jsp">Buscar Actividades</a>
            </li>
        </ul>

        <span class="navbar-text mr-3">
            Hola, <%= userName %>
        </span>
        <a class="btn btn-outline-light" href="LogoutServlet">Cerrar Sesión</a>
    </div>
</nav>
