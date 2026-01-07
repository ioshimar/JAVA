<%-- 
    Document   : getDepartments_subdirector
    Created on : 12 feb 2025, 13:51:08
    Author     : IOSHIMAR.RODRIGUEZ
--%>

<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %>
<%@page import="utils.DBConnection" %>
<%@page session="true" %>

<%
    // Verificar si es subdirector
    if (session.getAttribute("userId") == null || (Integer)session.getAttribute("roleId") != 1) {
        // Si no es subdirector, no devolvemos nada
        return;
    }
    int subdirectorId = (Integer) session.getAttribute("userId");

    // Conexión
    try(Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT id, name FROM seguimiento_actividades.departments WHERE subdirector_id=? ORDER BY name";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, subdirectorId);
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            int dId = rs.getInt("id");
            String dName = rs.getString("name");
            out.println("<option value=\"" + dId + "\">" + dName + "</option>");
        }
    } catch(Exception e){
        e.printStackTrace();
    }
%>

