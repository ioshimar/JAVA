<%-- 
    Document   : departmentDirectory
    Created on : 24 feb 2025, 16:00:57
    Author     : IOSHIMAR.RODRIGUEZ
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, utils.DBConnection" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>Directorio de Departamentos</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <style>
        .card-header { background-color: #f8f9fa; }
        .card { margin-bottom: 20px; }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container mt-5">
        <h1 class="mb-4">Directorio de Departamentos</h1>
        <%
            // Verificar sesión y obtener el ID del subdirector
            if(session.getAttribute("userId") == null){
                response.sendRedirect("login.jsp");
                return;
            }
            int subdirectorId = (Integer) session.getAttribute("userId");
            Connection conn = null;
            PreparedStatement psDept = null;
            ResultSet rsDept = null;
            try {
                conn = DBConnection.getConnection();
                String sqlDept = "SELECT id, name, extension_phone FROM seguimiento_actividades.departments " +
                                 "WHERE subdirector_id = ? ORDER BY name";
                psDept = conn.prepareStatement(sqlDept);
                psDept.setInt(1, subdirectorId);
                rsDept = psDept.executeQuery();
                while(rsDept.next()){
                    int deptId = rsDept.getInt("id");
                    String deptName = rsDept.getString("name");
                    String extension = rsDept.getString("extension_phone");
        %>
        <div class="card">
            <div class="card-header">
                <h4 class="mb-0"><%= deptName %></h4>
                <p class="mb-0"><strong>Extensión:</strong> <%= (extension != null && !extension.trim().isEmpty() ? extension : "-") %></p>
            </div>
            <div class="card-body">
                <h5>Personal del Departamento</h5>
                <%
                    PreparedStatement psEmp = null;
                    ResultSet rsEmp = null;
                    try {
                        String sqlEmp = "SELECT id, full_name, institutional_email, personal_phone " +
                                        "FROM seguimiento_actividades.users " +
                                        "WHERE department_id = ? ORDER BY full_name";
                        psEmp = conn.prepareStatement(sqlEmp);
                        psEmp.setInt(1, deptId);
                        rsEmp = psEmp.executeQuery();
                        if(!rsEmp.isBeforeFirst()){
                %>
                            <p>No hay personal registrado.</p>
                <%
                        } else {
                %>
                            <table class="table table-sm table-bordered">
                                <thead>
                                    <tr>
                                        <th>Nombre</th>
                                        <th>Correo</th>
                                        <th>Teléfono personal</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        while(rsEmp.next()){
                                            String empName = rsEmp.getString("full_name");
                                            String empEmail = rsEmp.getString("institutional_email");
                                            String empPhone = rsEmp.getString("personal_phone");
                                    %>
                                    <tr>
                                        <td><%= empName %></td>
                                        <td><%= empEmail %></td>
                                        <td><%= (empPhone != null && !empPhone.trim().isEmpty() ? empPhone : "-") %></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                <%
                        }
                    } catch(Exception ex){
                        out.println("<p>Error al cargar el personal: " + ex.getMessage() + "</p>");
                    } finally {
                        if(rsEmp != null) rsEmp.close();
                        if(psEmp != null) psEmp.close();
                    }
                %>
            </div>
        </div>
        <%
                } // fin while departamentos
            } catch(Exception e){
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if(rsDept != null) rsDept.close();
                if(psDept != null) psDept.close();
                if(conn != null) conn.close();
            }
        %>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

