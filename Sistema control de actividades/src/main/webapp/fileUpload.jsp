<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Subir Archivo</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<div class="container mt-5" style="max-width: 600px;">
    <h2>Subir Archivo</h2>
    <form action="uploadFile" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label>ID de la Actividad</label>
            <input type="number" class="form-control" name="activity_id" required>
        </div>
        <div class="form-group">
            <label>Archivo</label>
            <input type="file" class="form-control-file" name="file" required>
        </div>
        <button type="submit" class="btn btn-primary btn-block">Subir</button>
    </form>
</div>
</body>
</html>
