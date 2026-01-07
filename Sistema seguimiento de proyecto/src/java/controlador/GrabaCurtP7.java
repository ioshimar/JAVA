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
public class GrabaCurtP7 extends HttpServlet {

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
        String fech_dev = request.getParameter("fech_dev");    
        String resp_dev = request.getParameter("resp_dev");
        String resp_reci =request.getParameter("resp_reci");
        String arch_dev = request.getParameter("arch_dev");  
        String total_dev = request.getParameter("total_dev");  
        String motivos_dev = request.getParameter("motivos_dev"); 
        String id_archivo = request.getParameter("id_archivo");
        String usuario_resp = request.getParameter("usuario_resp");
        
        
 
        try{ //consultamos si ya se guardo algún registro con el mismo id_archivo
        PreparedStatement pst2 =(PreparedStatement) conexion.conn.prepareStatement( "SELECT * FROM \"seguim_CURT\".devolucion"
                + " WHERE id_entrega= '"+id_archivo+"' " ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        conexion.rs =pst2.executeQuery(); 
        }catch(SQLException e){
                out.print("exception"+e);
        }
            if(conexion.rs.next()){ //Si encuentra algo...
               out.print("Error ya se ha guardado este registro en la Base de Datos, intenta con otro archivo"); 
           }
      
            else{
        
        try {
                    
        conexion.stmt=conexion.conn.createStatement();
        conexion.stmt.executeUpdate("SET DATESTYLE TO dmy; INSERT INTO \"seguim_CURT\".devolucion(\n" +
                "            id_dev, id_ue, fecha_dev, nom_resp_dev, nom_rec_dev, arch_dev, \n" +
                "            total_regdev, fecha_llenado, motivos_dev, id_entrega, nom_archivo, usuario_resp)\n" +
                "    VALUES (nextval('\"seguim_CURT\".id_devolucion'), '"+id_ue+"', '"+fech_dev+"', '"+resp_dev+"', '"+resp_reci+"', '"+arch_dev+"', \n" +
                "            '"+total_dev+"', '"+fecha_llenado+"', '"+motivos_dev+"', '"+id_archivo+"', '"+arch_dev+"', '"+usuario_resp+"')");
                     
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
            Logger.getLogger(GrabaCurtP7.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(GrabaCurtP7.class.getName()).log(Level.SEVERE, null, ex);
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
