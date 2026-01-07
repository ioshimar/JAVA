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
public class GrabaCurtP12 extends HttpServlet {

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
        String fecha_ent = request.getParameter("fecha_ent");    
        String nom_resp_ent = request.getParameter("nom_resp_ent");
        String resp_rec =request.getParameter("resp_rec");

        String nom_arch =request.getParameter("nom_arch");
        String cant_reg =request.getParameter("cant_reg");
        /*String fecha_ent_ue =request.getParameter("fecha_ent_ue"); 

        String nom_resp_dr =request.getParameter("nom_resp_dr");  
        String resp_reci_ue =request.getParameter("resp_reci_ue"); 
        String nom_arch_ue =request.getParameter("nom_arch_ue"); 
        String cant_reg_ue =request.getParameter("cant_reg_ue"); */
        
        String tipo_entrega =request.getParameter("tipo_entrega"); 
    
        
        
        if(fecha_ent==null || fecha_ent.equals("")){fecha_ent="01/01/0001";}
        //if(fecha_ent_ue==null || fecha_ent_ue.equals("")){fecha_ent_ue="01/01/0001";}
        if(cant_reg==null || cant_reg.equals("")){cant_reg= "0";}
        //if(cant_reg_ue==null || cant_reg_ue.equals("")){cant_reg_ue= "0" ;}
        
        String usuario_resp = request.getParameter("usuario_resp");
        
       
       try{ //consultamos si ya se guardo algún registro con el mismo id_archivo
       PreparedStatement pst2 =(PreparedStatement) conexion.conn.prepareStatement( "SELECT * FROM \"seguim_CURT\".datos_entrega_p12"
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
            conexion.stmt.executeUpdate("SET DATESTYLE TO dmy; INSERT INTO \"seguim_CURT\".datos_entrega_p12(\n" +
                                    "             id_dae, id_ue, fecha_entrega, nom_resp_ent, nom_resp_rec, id_entrega, \n" +
                                    "            nom_arch, cant_reg, fecha_llenado, tipo_entrega, usuario_resp)\n" +
                                    "    VALUES (nextval('\"seguim_CURT\".id_dae'), '"+id_ue+"', '"+fecha_ent+"', '"+nom_resp_ent+"', '"+resp_rec+"', '"+id_archivo+"', '"+nom_arch+"', \n" +
                                    "            '"+cant_reg+"', '"+fecha_llenado+"', '"+tipo_entrega+"', '"+usuario_resp+"')");

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
            Logger.getLogger(GrabaCurtP12.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(GrabaCurtP12.class.getName()).log(Level.SEVERE, null, ex);
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
