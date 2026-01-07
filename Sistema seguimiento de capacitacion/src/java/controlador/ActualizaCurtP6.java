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
public class ActualizaCurtP6 extends HttpServlet {

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
        
        String fecha = request.getParameter("fecha_llenado");
        String id_ue  = request.getParameter("id_ue");
        String resp_val = request.getParameter("resp_val");    
        String fech_ini6 = request.getParameter("fech_ini6");
        String fech_ter6 =request.getParameter("fech_ter6");
        String f_shape  = request.getParameter("f_shape");
        String extension  = request.getParameter("extension");
        String estruc  = request.getParameter("estruc");    
        String atrib  = request.getParameter("atrib");   
        String coord_geo  = request.getParameter("coord_geo");   
        String total_reg  = request.getParameter("total_reg");  
        String id_validacion = request.getParameter("id_validacion");
        

       if(extension ==null){ extension="";}
        if(estruc ==null){ estruc="";}
        if(atrib ==null){ atrib="";}
        if(coord_geo ==null){ coord_geo="";}
        if(total_reg ==null){ total_reg="";}

       String usuario_resp  = request.getParameter("usuario_resp"); 
        try {
                    
        conexion.stmt=conexion.conn.createStatement();
        conexion.stmt.executeUpdate("SET DATESTYLE TO dmy; UPDATE \"seguim_CURT\".criterios_validacion\n" +
                        "   SET  nom_respval='"+resp_val+"', fec_ini='"+fech_ini6+"', fec_fin='"+fech_ter6+"', for_shape='"+f_shape+"', \n" +
                        "       ext_min='"+extension+"', est_cor='"+estruc+"', atrib='"+atrib+"', info_cord='"+coord_geo+"', code_total='"+total_reg+"', \n" +
                        "       fecha_actualizacion='"+fecha+"', usuario_resp='"+usuario_resp+"' \n" +
                        " WHERE id_val ='"+id_validacion+"'");
                     
                   out.print("Datos actualizados correctamente");
                       
                    }catch (Exception ex) {
                        out.print("Error_al_conectar_la_bd");
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
            Logger.getLogger(ActualizaCurtP6.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ActualizaCurtP6.class.getName()).log(Level.SEVERE, null, ex);
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
