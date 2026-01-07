<%-- 
    Document   : getOperativesByDept
    Created on : 12 feb 2025, 14:23:33
    Author     : IOSHIMAR.RODRIGUEZ
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DBConnection" %>
<%@ page session="true" %>

<%
    String dIdStr = request.getParameter("deptId");
    if (session.getAttribute("userId") == null || dIdStr == null || dIdStr.trim().isEmpty()) {
        return;
    }
    int roleId = (Integer) session.getAttribute("roleId");
    if (roleId != 1) {
        return;
    }

    try(Connection conn = DBConnection.getConnection()){
        int deptId = Integer.parseInt(dIdStr);
        String sql = "SELECT id, full_name FROM seguimiento_actividades.users "
                   + "WHERE department_id=? AND role_id=3 ORDER BY full_name";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, deptId);
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            int oId = rs.getInt("id");
            String oName = rs.getString("full_name");
            out.println("<option value=\"" + oId + "\">" + oName + "</option>");
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
%>

