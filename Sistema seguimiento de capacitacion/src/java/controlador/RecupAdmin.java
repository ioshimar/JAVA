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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author RICARDO.MACIAS
 */
public class RecupAdmin extends HttpServlet {

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
            throws ServletException, IOException {
     
    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
     PrintWriter out = response.getWriter();
     response.setContentType("text/html;charset=UTF-8");
     HttpSession objsesion_enc =request.getSession(false);
    String session_admin_curt = (String)objsesion_enc.getAttribute("session_admin_curt"); //se crea la variable de Sesión
     if(session_admin_curt!=null){  //SI NO ES NULLA   la sesion 
       
         ConexionBD conexion= new ConexionBD(); 
       
         String nom_usuario = request.getParameter("nom_usuario");
         String psw = request.getParameter("psw");
                try {
                    
                    /*Evitar inyeccion SQL*/
                        PreparedStatement stmt = conexion.conn.prepareStatement(" UPDATE \"seguim_CURT\".tbl_admin SET password= MD5(?) WHERE usuario = ? ");
                                stmt.setString(1, psw);
                                stmt.setString(2, nom_usuario);
                                stmt.executeUpdate(); 
                   
                           
                          if(stmt.executeUpdate() > 0){//si las dilas afectadas es mayor a 0... es que si se actualizo algun registro
                             out.print("succes");
                          }
                          else{
                              out.print("error");
                          }
                    
                    
                    }catch (Exception ex) {
                        out.print("Error_al_conectar_la_bd");
                        out.println(ex);
                        ex.printStackTrace();

                    } finally {
                       
                        conexion.closeConnection();
                    }
     }//if sesion
     else{
         out.print("ERROR, inicia sesión como administrador");
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
