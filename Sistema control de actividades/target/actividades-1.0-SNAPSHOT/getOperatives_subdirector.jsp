<%-- 
    Document   : getOperatives_subdirector
    Created on : 12 feb 2025, 9:22:20
    Author     : IOSHIMAR.RODRIGUEZ
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DBConnection" %>

<%
    String deptId = request.getParameter("deptId");
    String tipo = request.getParameter("tipo"); // "jefe" o "operativo"
    if(deptId == null || deptId.isEmpty() || tipo == null || tipo.isEmpty()){
        return;
    }

    int role = 0;
    if("jefe".equals(tipo)){
        role = 2; // Asumiendo que role_id=2 => Jefe
    } else if("operativo".equals(tipo)){
        role = 3; // Asumiendo role_id=3 => Operativo
    } else {
        return; // Tipo desconocido
    }

    try(Connection conn = DBConnection.getConnection()){
        // Buscar usuarios con department_id=deptId y role_id=2 (jefe) ó 3 (operativo)
        String sql = "SELECT id, full_name FROM seguimiento_actividades.users " +
                     "WHERE department_id=? AND role_id=? ORDER BY full_name";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(deptId));
        ps.setInt(2, role);
        ResultSet rs = ps.executeQuery();

        while(rs.next()){
            int id = rs.getInt("id");
            String name = rs.getString("full_name");
            out.println("<option value=\"" + id + "\">" + name + "</option>");
        }
    } catch(Exception e){
        e.printStackTrace();
    }
%>


