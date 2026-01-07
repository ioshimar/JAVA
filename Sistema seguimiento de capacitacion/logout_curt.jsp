<%-- 
    Document   : logout_ue
    Created on : 21/07/2017, 11:31:52 AM
    Author     : RICARDO.MACIAS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logged out</title>
    </head>
    <body>
        <%
            session.removeAttribute("session_curt");  //MATAMOS LA SESIÓN UE
            response.sendRedirect("index.jsp");
        %>

        
    </body>
</html>