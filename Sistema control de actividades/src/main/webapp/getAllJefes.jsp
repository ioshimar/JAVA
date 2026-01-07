<%-- 
    Document   : getAllJefes
    Created on : 12 feb 2025, 14:22:18
    Author     : IOSHIMAR.RODRIGUEZ
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DBConnection" %>
<%@ page session="true" %>

<%
    if (session.getAttribute("userId") == null) {
        // No hay sesión => no devolvemos nada
        return;
    }
    int roleId = (Integer) session.getAttribute("roleId");
    if (roleId != 1) {
        // Si no es subdirector => no devolvemos nada
        return;
    }

    try(Connection conn = DBConnection.getConnection()){
        // Lista todos los jefes role_id=2
        String sql = "SELECT id, full_name FROM seguimiento_actividades.users WHERE role_id=2 ORDER BY full_name";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            int jId = rs.getInt("id");
            String jName = rs.getString("full_name");
            out.println("<option value=\"" + jId + "\">" + jName + "</option>");
        }
    } catch(Exception e){
        e.printStackTrace();
    }
%>

