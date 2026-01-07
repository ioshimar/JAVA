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
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
public class GrabaCurtP10 extends HttpServlet {

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
        String cve_edo  = request.getParameter("cve_edo");
        String id_archivo = request.getParameter("id_archivo");
        String nom_archivo = request.getParameter("nom_archivo");    
        String nom_respgen = request.getParameter("nom_respgen");
        String fech_ini10 =request.getParameter("fech_ini10");
        String fech_ter10  = request.getParameter("fech_ter10");
        String con_curt  = request.getParameter("con_curt");
        String sin_curt  = request.getParameter("sin_curt");    
       // String total_motivo  = request.getParameter("total_motivo");   
      //  String motivo  = request.getParameter("motivo");   
        String usuario_resp  = request.getParameter("usuario_resp"); 
        
      System.out.println("aque-------------------------------------"+fech_ini10);
      
      DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy"); 
        LocalDate fecha_ini = LocalDate.parse(fech_ini10, formato); 
        System.out.println("nuevooooooo"+fecha_ini);
        
      DateTimeFormatter formato_ter = DateTimeFormatter.ofPattern("dd/MM/yyyy"); 
        LocalDate fecha_ter = LocalDate.parse(fech_ini10, formato_ter); 
        System.out.println("nuevooooooo"+fecha_ter);  
        
      DateTimeFormatter formato_llen = DateTimeFormatter.ofPattern("dd/MM/yyyy"); 
        LocalDate fecha_llen = LocalDate.parse(fecha_llenado, formato_llen); 
        System.out.println("nuevooooooo"+fecha_llen);  

       try{ //consultamos si ya se guardo algún registro con el mismo id_archivo
       PreparedStatement pst2 =(PreparedStatement) conexion.conn.prepareStatement( "SELECT * FROM \"seguim_CURT\".generacion_curt"
               + " WHERE id_entrega= '"+id_archivo+"' " ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
       conexion.rs =pst2.executeQuery(); 
       }
             catch(SQLException e){
               out.print("exception"+e);
              } 
       
       if(conexion.rs.next()){ //Si encuentra algo...
           out.print("Error ya se ha guardado este registro en la Base de Datos, intenta con otro archivo"); 
       }
      
      
      
       else{ // Si no hay ningún registro con el id mencionado, pocede a insertar el reistro
          
        try {
                    
        conexion.stmt=conexion.conn.createStatement();
        //conexion.stmt.executeUpdate("SET DATESTYLE TO dmy; INSERT INTO \"seguim_CURT\".generacion_curt(\n" +
        conexion.stmt.executeUpdate("INSERT INTO \"seguim_CURT\".generacion_curt(\n" +
"            id_gen, id_ue, nom_resp, fech_ini, fech_fin, pred_concurt, pred_sincurt, \n" +
"            fecha_llenado, id_entrega,  nom_archivo, usuario_resp, cve_edo)\n" +
"    VALUES (nextval('\"seguim_CURT\".id_gencurt'), '"+id_ue+"', '"+nom_respgen+"', '"+fecha_ini+"','"+fecha_ter+"', '"+con_curt+"', '"+sin_curt+"', \n" +
"            '"+fecha_llen+"', '"+id_archivo+"', '"+nom_archivo+"', '"+usuario_resp+"', '"+cve_edo+"')");
                     
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
            Logger.getLogger(GrabaCurtP10.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(GrabaCurtP10.class.getName()).log(Level.SEVERE, null, ex);
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
