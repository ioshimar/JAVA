<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DBConnection" %>
<%@ page session="true" %>

<%
    // Verificar sesión y rol
    if (session.getAttribute("userId") == null) {
        return; // No hay sesión => no hacemos nada
    }
    int roleId = (Integer) session.getAttribute("roleId");
    // Si solo subdirector (role=1) puede hacer la búsqueda:
    if (roleId != 1) {
        return;
    }

    String query = request.getParameter("query");
    if(query == null || query.trim().length() < 2){
        out.print("<tr><td colspan='2'>Escribe al menos 2 caracteres</td></tr>");
        return;
    }
    // Convertimos a minúsculas para usar en el LIKE
    query = query.trim().toLowerCase();

    try(Connection conn = DBConnection.getConnection()){
        // Ajusta la consulta según tu lógica (roles 2,3 => Jefe u Operativo)
        String sql = "SELECT id, full_name FROM seguimiento_actividades.users "
                   + "WHERE role_id IN (2,3) "
                   + "  AND LOWER(full_name) LIKE ? "
                   + "ORDER BY full_name LIMIT 20";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, "%" + query + "%");
        ResultSet rs = ps.executeQuery();

        boolean found = false;
        while(rs.next()){
            found = true;
            int uid = rs.getInt("id");
            String fname = rs.getString("full_name");
%>
<tr>
    <td><%= fname %></td>
    <td>
        <!-- Atributos data-userid y data-username son esenciales para tu JS -->
        <button type="button" class="btn btn-sm btn-info select-user-btn"
                data-userid="<%= uid %>"
                data-username="<%= fname %>">
            Seleccionar
        </button>
    </td>
</tr>
<%
        }
        if(!found){
            out.print("<tr><td colspan='2'>Sin resultados</td></tr>");
        }
        rs.close();
        ps.close();
    } catch(Exception e){
        e.printStackTrace();
        out.print("<tr><td colspan='2'>Error en la búsqueda: " + e.getMessage() + "</td></tr>");
    }
%>
