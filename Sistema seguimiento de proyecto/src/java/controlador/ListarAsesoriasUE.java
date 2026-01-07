package controlador;

import BaseDatos.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class ListarAsesoriasUE extends HttpServlet {

    /** ayuda: escapa comillas inversas y dobles para JSON */
    private static String esc(String s) {
        if (s == null) return "";
        return s.replace("\\","\\\\").replace("\"","\\\"")
                .replace("\r","").replace("\n"," ");
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
                         throws ServletException, IOException {

        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        String idUE = req.getParameter("id_ue");
        StringBuilder json = new StringBuilder();
        json.append("[");

        Connection  cn  = null;
        PreparedStatement pst = null;
        ResultSet   rs  = null;

        try {
            cn = (new ConexionBD()).conn;              // ① conexión
            pst = cn.prepareStatement(                 // ② consulta
                "SELECT fecha, fecha_fin, lugar, medio_contacto,"+
                "       nombre_persona, nombre_asesor, descripcion "+
                "FROM   \"seguim_CURT\".asesorias_ue "+
                "WHERE  id_ue = ? ORDER BY fecha DESC");
            pst.setInt(1, Integer.parseInt(idUE));
            rs = pst.executeQuery();                   // ③ iterar filas

            boolean first = true;
            while (rs.next()) {
                if (!first) json.append(",");
                first = false;

                json.append("{")
                    .append("\"fecha\":\"").append(esc(rs.getString("fecha"))).append("\",")
                    .append("\"fecha_fin\":\"").append(esc(rs.getString("fecha_fin"))).append("\",")
                    .append("\"lugar\":\"").append(esc(rs.getString("lugar"))).append("\",")
                    .append("\"medio_contacto\":\"").append(esc(rs.getString("medio_contacto"))).append("\",")
                    .append("\"nombre_persona\":\"").append(esc(rs.getString("nombre_persona"))).append("\",")
                    .append("\"nombre_asesor\":\"").append(esc(rs.getString("nombre_asesor"))).append("\",")
                    .append("\"descripcion\":\"").append(esc(rs.getString("descripcion"))).append("\"")
                    .append("}");
            }

        } catch (Exception e) {         // si algo falla devolvemos JSON vacío
            e.printStackTrace();
            json.setLength(1);           // deja sólo “[”
        } finally {                      // ④ liberar recursos
            try { if (rs  != null) rs.close();  } catch (Exception ex) {}
            try { if (pst != null) pst.close(); } catch (Exception ex) {}
            try { if (cn  != null) cn.close(); } catch (Exception ex) {}
        }

        json.append("]");
        out.print(json.toString());
    }
}
