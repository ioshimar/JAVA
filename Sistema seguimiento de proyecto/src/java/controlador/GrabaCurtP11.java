/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import BaseDatos.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
public class GrabaCurtP11 extends HttpServlet {

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
        
        String fecha_llenado = request.getParameter("fecha_llenado");
        String id_ue  = request.getParameter("id_ue");
        String id_archivo = request.getParameter("id_archivo");
        String nom_archivo = request.getParameter("nom_archivo");    
        String nom_respue = request.getParameter("nom_respue");
        String fech_ini11 =request.getParameter("fech_ini11");
        String fech_ter11  = request.getParameter("fech_ter11");
        String con_curt11  = request.getParameter("con_curt11");
        String sin_curt11  = request.getParameter("sin_curt11");    
        String total_motivo_a  = request.getParameter("total_motivo_a");   
        String motivo_a  = request.getParameter("motivo_a");  
        String usuario_resp  = request.getParameter("usuario_resp");
  
        
         try{ //consultamos si ya se guardo algún registro con el mismo id_archivo
       PreparedStatement pst2 =(PreparedStatement) conexion.conn.prepareStatement( "SELECT * FROM \"seguim_CURT\".actualizacion_curt"
               + " WHERE id_entrega= '"+id_archivo+"' " ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
       conexion.rs =pst2.executeQuery(); 
       }
             catch(SQLException e){
               out.print("exception"+e);
              } 
       
       if(conexion.rs.next()){ //Si encuentra algo...
           out.print("Error ya se ha guardado este registro en la Base de Datos, intenta con otro archivo"); 
       }
      
        
       else{
        try {
                    
        conexion.stmt=conexion.conn.createStatement();
        conexion.stmt.executeUpdate("SET DATESTYLE TO dmy; INSERT INTO \"seguim_CURT\".actualizacion_curt(\n" +
"            id_act, id_ue, nom_resp_ue, fech_ini_a, fech_fin_a, pred_concurt_a, \n" +
"            pred_sincurt_a, fecha_llenado,\n" +
"            total_motgen, mot_gen, id_entrega, nom_archivo, usuario_resp)\n" +
"    VALUES (nextval('\"seguim_CURT\".id_actcurt'), '"+id_ue+"', '"+nom_respue+"', '"+fech_ini11+"', '"+fech_ter11+"', '"+con_curt11+"', \n" +
"            '"+sin_curt11+"', '"+fecha_llenado+"', '"+total_motivo_a+"', '"+motivo_a+"', '"+id_archivo+"', '"+nom_archivo+"', '"+usuario_resp+"')");
                     
                   out.print("Datos Ingresados correctamente");
                       
                    }catch (Exception ex) {
                        out.print("Error_al_conectar_la_bd");
                        out.println(ex);
                        ex.printStackTrace();

                    } finally {
                       
                        conexion.closeConnection();
                    }
        
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
            Logger.getLogger(GrabaCurtP11.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(GrabaCurtP11.class.getName()).log(Level.SEVERE, null, ex);
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
