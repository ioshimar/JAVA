<%-- 
    Document   : getOperatives
    Created on : 12 feb 2025, 9:11:37
    Author     : IOSHIMAR.RODRIGUEZ
--%>

<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %>
<%@page import="utils.DBConnection" %>
<%
    String deptId = request.getParameter("deptId");
    if(deptId == null || deptId.isEmpty()){
        // No hay deptId, no devolvemos nada
        return;
    }

    try(Connection conn = DBConnection.getConnection()){
        String sql = "SELECT id, full_name FROM seguimiento_actividades.users WHERE role_id = 3 AND department_id = ? ORDER BY full_name";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(deptId));
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            out.println("<option value=\"" + rs.getInt("id") + "\">" + rs.getString("full_name") + "</option>");
        }
    } catch(Exception e){
        e.printStackTrace();
    }
%>

