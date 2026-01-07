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
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author RICARDO.MACIAS
 */
public class Graba_admin extends HttpServlet {

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
        processRequest(request, response);
        
        response.setContentType("text/html;charset=UTF-8");
          PrintWriter out = response.getWriter();
   HttpSession objsesion_enc =request.getSession(false);
   String session_admin_curt = (String)objsesion_enc.getAttribute("session_admin_curt"); //se crea la variable de Sesión
     if(session_admin_curt!=null){  //SI NO ES NULLA   la sesion 
        
         ConexionBD conexion= new ConexionBD(); 
        
        String nombre = request.getParameter("nombre");
        String nom_usuario  = request.getParameter("nom_usuario");
        String psw =request.getParameter("psw");
        String permisos = request.getParameter("permisos");
        
       
   try{ //consultamos si ya se guardo algún registro con el mismo id_archivo
        PreparedStatement pst2 =(PreparedStatement) conexion.conn.prepareStatement( "SELECT * FROM  \"seguim_CURT\".tbl_admin"
                + " WHERE usuario= '"+nom_usuario+"' " ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        conexion.rs =pst2.executeQuery(); 
        
        if(conexion.rs.next()){ //Si encuentra algo...
               out.print("Error este nombre de  usuario ya Existe"); 
           }
            else{
                try {
                    /*evitar inyeccion SQL*/
                    
                PreparedStatement stmt = conexion.conn.prepareStatement("INSERT INTO \"seguim_CURT\".tbl_admin(\n" +
                        "            id, nombre, usuario, password, permisos)\n" +
                        "    VALUES (nextval('\"seguim_CURT\".id_admin'), ?, ?, MD5(?), ?)");
                             // stmt.setString(1, nextval('id_admin'));
                                stmt.setString(1, nombre);
                                stmt.setString(2, nom_usuario);
                                stmt.setString(3, psw);
                                stmt.setString(4, permisos);
                                stmt.executeUpdate();     
                    
               
                           out.print("Administrador registrado correctamente");
            
                }catch (Exception ex) {
                                out.print("Error_al_conectar_la_bd");
                                out.println(ex);
                                ex.printStackTrace();

                            } finally {
                                //conexion.closeConnection();
                            }
                    }
            
           }catch(SQLException e){
                out.print("exception"+e);
        } finally {conexion.closeConnection(); }
    }//if sesion
     else{
         out.print("Error, vuelve a iniciar sesión como administrador");
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
