<%-- 
    Document   : getUsersByDept
    Created on : 12 feb 2025, 14:45:54
    Author     : IOSHIMAR.RODRIGUEZ
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DBConnection" %>
<%@ page session="true" %>

<%
    String deptIdStr = request.getParameter("deptId");
    if(deptIdStr == null || deptIdStr.trim().isEmpty()) return;
    if(session.getAttribute("userId") == null) return;
    int roleId = (Integer)session.getAttribute("roleId");
    if(roleId != 1) return;

    try(Connection conn = DBConnection.getConnection()){
        int deptId = Integer.parseInt(deptIdStr);
        String sql = "SELECT id, full_name FROM seguimiento_actividades.users "
                   + "WHERE department_id=? AND role_id IN (2,3) ORDER BY full_name";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, deptId);
        ResultSet rs = ps.executeQuery();
        out.println("<option value=''>-- Seleccionar Usuario --</option>");
        while(rs.next()){
            out.println("<option value='"+ rs.getInt("id") +"'>"+ rs.getString("full_name") +"</option>");
        }
    } catch(Exception e){
        e.printStackTrace();
    }
%>


