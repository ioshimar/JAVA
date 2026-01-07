<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="utils.DBConnection" %>
<%@ page import="java.sql.*" %>
<%@page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <title>Editar Usuario</title>
    <!-- Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
        }
        .card {
            padding: 2rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .btn-success, .btn-secondary {
            width: 100%;
        }
    </style>
</head>
<body>
<%
  if (session.getAttribute("userId") == null) {
      response.sendRedirect("login.jsp");
      return;
  }
  int roleId = (int) session.getAttribute("roleId");
  if (roleId != 1) {
      request.setAttribute("error", "No tienes permisos");
      response.sendRedirect("dashboard.jsp");
      return;
  }

  String idParam = request.getParameter("id");
  if (idParam == null) {
      response.sendRedirect("users");
      return;
  }
  int userId = Integer.parseInt(idParam);
  String fullName = "", email = "", functions = "", phone = "";
  int userRoleId = 0, supId = 0, deptId = 0;

  // Cargar datos actuales
  try(Connection conn = DBConnection.getConnection()) {
      String sql = "SELECT * FROM seguimiento_actividades.users WHERE id=?";
      PreparedStatement ps = conn.prepareStatement(sql);
      ps.setInt(1, userId);
      ResultSet rs = ps.executeQuery();
      if (rs.next()) {
          fullName = rs.getString("full_name");
          email = rs.getString("institutional_email");
          functions = rs.getString("functions");
          phone = rs.getString("personal_phone");
          userRoleId = rs.getInt("role_id");
          supId = rs.getInt("supervisor_id");
          deptId = rs.getInt("department_id");
      } else {
          response.sendRedirect("users");
          return;
      }
  } catch(Exception e) {
      e.printStackTrace();
  }
%>

<div class="container mt-5">
    <div class="card">
        <h3 class="text-center mb-4"><i class="fas fa-user-edit"></i> Editar Usuario (ID: <%= userId %>)</h3>
        <form action="updateUser" method="post">
            <input type="hidden" name="id" value="<%= userId %>">

            <div class="mb-3">
                <label class="form-label"><i class="fas fa-user"></i> Nombre Completo</label>
                <input type="text" class="form-control" name="full_name" value="<%= fullName %>" placeholder="Ingrese el nombre completo" required>
            </div>

            <div class="mb-3">
                <label class="form-label"><i class="fas fa-envelope"></i> Correo Institucional</label>
                <input type="email" class="form-control" name="institutional_email" value="<%= email %>" placeholder="correo@institucion.edu" required>
            </div>

            <div class="mb-3">
                <label class="form-label"><i class="fas fa-briefcase"></i> Funciones</label>
                <input type="text" class="form-control" name="functions" value="<%= functions %>" placeholder="Funciones del usuario">
            </div>

            <div class="mb-3">
                <label class="form-label"><i class="fas fa-phone"></i> Teléfono</label>
                <input type="text" class="form-control" name="personal_phone" value="<%= phone %>" placeholder="Ingrese el teléfono personal">
            </div>

            <div class="mb-3">
                <label class="form-label"><i class="fas fa-user-tag"></i> Rol</label>
                <select class="form-select" name="role" required>
                    <option value="1" <%= userRoleId == 1 ? "selected" : "" %>>Subdirector</option>
                    <option value="2" <%= userRoleId == 2 ? "selected" : "" %>>Jefe</option>
                    <option value="3" <%= userRoleId == 3 ? "selected" : "" %>>Operativo</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label"><i class="fas fa-user-friends"></i> ID Supervisor</label>
                <input type="number" class="form-control" name="supervisor_id" 
                       value="<%= (supId == 0) ? "" : supId %>" placeholder="ID del supervisor (si aplica)">
            </div>

            <div class="mb-3">
                <label class="form-label"><i class="fas fa-building"></i> ID Departamento</label>
                <input type="number" class="form-control" name="department_id" 
                       value="<%= (deptId == 0) ? "" : deptId %>" placeholder="ID del departamento (si aplica)">
            </div>

            <button class="btn btn-success"><i class="fas fa-save"></i> Guardar Cambios</button>
            <a href="users" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Regresar</a>
        </form>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
