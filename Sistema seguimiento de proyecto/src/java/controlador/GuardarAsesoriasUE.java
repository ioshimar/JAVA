/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import BaseDatos.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author IOSHIMAR.RODRIGUEZ
 */
public class GuardarAsesoriasUE extends HttpServlet {

      /* ─── convierte dd/MM/yyyy → java.sql.Date (o null) ───────────────── */
    private Date parseFecha(String str) throws ParseException {
        if (str == null || str.trim().isEmpty()) return null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        sdf.setLenient(false);
        return new Date(sdf.parse(str.trim()).getTime());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/plain; charset=UTF-8");
        PrintWriter out = resp.getWriter();

        /* 1) Leer parámetros ------------------------------------------------ */
        int    idUe          = Integer.parseInt( req.getParameter("id_ue") );
        String fechaStr      = req.getParameter("fecha");
        String fechaFinStr   = req.getParameter("fecha_fin");
        String lugar         = req.getParameter("lugar");
        String medioContacto = req.getParameter("medio_contacto");
        String nombrePersona = req.getParameter("nombre_persona");
        String nombreAsesor  = req.getParameter("nombre_asesor");
        String descripcion   = req.getParameter("descripcion");
        String usuarioResp   = req.getParameter("usuario_resp");

        /* 2) Convertir fechas ---------------------------------------------- */
        Date fecha, fechaFin;
        try {
            fecha    = parseFecha(fechaStr);
            fechaFin = parseFecha(fechaFinStr);
        } catch (ParseException pe) {
            out.print("Formato de fecha inválido");
            return;
        }

        /* 3) Insertar ------------------------------------------------------- */
        ConexionBD db = null;
        PreparedStatement pst = null;
        try {
            db  = new ConexionBD();
            Connection con = db.conn;

            String sql =
              "INSERT INTO \"seguim_CURT\".asesorias_ue " +
              "(id_ue, fecha, fecha_fin, lugar, medio_contacto, " +
              " nombre_persona, nombre_asesor, descripcion, usuario_registro) " +
              "VALUES (?,?,?,?,?,?,?,?,?)";

            pst = con.prepareStatement(sql);
            pst.setInt   (1, idUe);
            pst.setDate  (2, fecha);
            pst.setDate  (3, fechaFin);
            pst.setString(4, lugar != null ? lugar.trim() : null);
            pst.setString(5, medioContacto != null ? medioContacto.trim() : null);
            pst.setString(6, nombrePersona != null ? nombrePersona.trim() : null);
            pst.setString(7, nombreAsesor  != null ? nombreAsesor.trim()  : null);
            pst.setString(8, descripcion   != null ? descripcion.trim()   : null);
            pst.setString(9, usuarioResp);

            int filas = pst.executeUpdate();
            out.print(filas > 0
                      ? "Asesoría guardada correctamente"
                      : "No se pudo guardar la asesoría");

        } catch (SQLException ex) {
            ex.printStackTrace(out);
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("Error al acceder a la base de datos");
        } finally {
            try { if (pst != null) pst.close(); } catch (SQLException ignored) {}
            if (db != null) db.closeConnection();   // cierra pool / conexión
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Sólo POST");
    }
}
