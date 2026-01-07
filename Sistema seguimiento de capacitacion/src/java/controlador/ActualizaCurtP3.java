/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import BaseDatos.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author RICARDO.MACIAS
 */
public class ActualizaCurtP3 extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
              throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
          PrintWriter out = response.getWriter();
  
        ConexionBD conexion= new ConexionBD(); 
        
        String fecha= request.getParameter("fecha_llenado");
        String id_ue  = request.getParameter("id_ue");
        String sol_registro=request.getParameter("sol_registro");
        String envio_doc =request.getParameter("envio_doc");
        String val_doc  = request.getParameter("val_doc");
        String fec_firma = request.getParameter("fec_firma");
        String fec_usu = request.getParameter("fec_usu");
        String fec_rece = request.getParameter("fec_rece");
        
        if(sol_registro==null || sol_registro.equals("")){sol_registro="01/01/0001";}
        if(envio_doc==null || envio_doc.equals("")){envio_doc="01/01/0001";}     
        if(val_doc==null || val_doc.equals("")){val_doc="01/01/0001";}
        if(fec_firma==null || fec_firma.equals("")){fec_firma="01/01/0001";}
        if(fec_usu==null || fec_usu.equals("")){fec_usu="01/01/0001";}
        if(fec_rece==null || fec_rece.equals("")){fec_rece="01/01/0001";}

      String usuario_resp = request.getParameter("usuario_resp");

        
        try {
                    
        conexion.stmt=conexion.conn.createStatement();
        conexion.stmt.executeUpdate("SET DATESTYLE TO dmy; UPDATE \"seguim_CURT\".registro_ue\n" +
"SET fec_sol_reg='"+sol_registro+"', fec_env_doc='"+envio_doc+"', fec_val_doc='"+val_doc+"',  fec_env_firm='"+fec_firma+"', fec_regus='"+fec_usu+"', fec_rec_doc='"+fec_rece+"', "
                + " fecha_actualizacion='"+fecha+"', usuario_resp='"+usuario_resp+"'\n" +
" WHERE id_ue = '"+id_ue+"'");
                     
                   out.print("Datos Actualizados correctamente");
                       
                    }catch (Exception ex) {
                        out.print("Error al conectara la base de datos");
                        out.println(ex);
                        ex.printStackTrace();

                    } finally {
                       
                        conexion.closeConnection();
                    }
        
    }


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ActualizaCurtP3.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ActualizaCurtP3.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
