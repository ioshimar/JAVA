/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Sesiones;

import BaseDatos.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
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
public class cambia_pass extends HttpServlet {

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
       
        String nom_user  = request.getParameter("nom_user").toLowerCase();
        String old_pass = request.getParameter("old_psw");
        String new_pass =request.getParameter("new_psw");
        String repeat_pass = request.getParameter("repeat_psw");
        
        System.out.print(nom_user);
        System.out.print(old_pass);
        System.out.print(new_pass);
        System.out.print(repeat_pass);
        
      
    String usuario = "";
    String psw = "";
   PreparedStatement pst11=(PreparedStatement) conexion.conn.prepareStatement( "SELECT \"user\", pwd FROM seguimiento_cap.usuarios WHERE \"user\" = '"+nom_user+"' AND pwd = '"+old_pass+"' ");
    conexion.rs =pst11.executeQuery(); 
       while(conexion.rs.next()) {
            usuario= conexion.rs.getString("user");
            psw = conexion.rs.getString("pwd");
  // out.print("ambito "+selambito_ins);
       }
       
       
      
       
    if(nom_user.equals(usuario) && old_pass.equals(psw) && new_pass.equals(repeat_pass)){  //Si el usuario y la contraseña anterior que pone el usuario son las mismas que estan en la BD y si las contraseñas nueva y repetida coinciden(esto ultimo se puede omitir ya que esta validado en ajax_psw.js)
       conexion.stmt=conexion.conn.createStatement();      

       conexion.stmt.executeUpdate("UPDATE seguimiento_cap.usuarios SET pwd='"+new_pass+"', cambio_psw=CURRENT_DATE, hora_cambio=now() WHERE \"user\" = '"+nom_user+"' AND pwd = '"+old_pass+"'");
       conexion.closeConnection();//termina la conexion
       
        out.print("succes_psw");  //este resultado se imprime para despues compararlo en el ajax_psw.js
    }
    else{
        if(old_pass != psw){       //Si la contraseña que el usuario escribe NO coincide con la que esta en la BD... mandara error
            out.print("error_psw");  //este resultado se imprime para despues compararlo en el ajax_psw.js
        }
        
        else{
        out.print("ERROR");  //este resultado se imprime para despues compararlo en el ajax_psw.js
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
            Logger.getLogger(cambia_pass.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(cambia_pass.class.getName()).log(Level.SEVERE, null, ex);
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
