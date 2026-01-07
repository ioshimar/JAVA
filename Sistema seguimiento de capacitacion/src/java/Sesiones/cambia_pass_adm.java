/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Sesiones;

import BaseDatos.ConexionBD;
import static Sesiones.getMD5.getMD5;
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
public class cambia_pass_adm extends HttpServlet {

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
     
    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
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
        response.setContentType("text/html;charset=UTF-8");
       PrintWriter out = response.getWriter();
        
       ConexionBD conexion= new ConexionBD(); 
       
        String user  = request.getParameter("usuario");
        String old_pass = request.getParameter("old_psw");
        String new_pass =request.getParameter("new_psw");
        String repeat_pass = request.getParameter("repeat_psw");
        
        
      
    String usuario = "";
    String psw = "";
   PreparedStatement pst11;
        try {
            pst11 = (PreparedStatement) conexion.conn.prepareStatement( "SELECT nombre, usuario, password \n" +
                    "  FROM \"seguim_CURT\".tbl_admin WHERE usuario = '"+user+"' AND password = MD5('"+old_pass+"') ");
        
    conexion.rs =pst11.executeQuery(); 
       while(conexion.rs.next()) {
            usuario= conexion.rs.getString("usuario");
            psw = conexion.rs.getString("password");
  // out.print("ambito "+selambito_ins);
       }
       
       
      //El getMD5(old_pass).. es para que convierta el texto  del input old_psw en MD5
       
    if(user.equals(usuario) && getMD5(old_pass).equals(psw) && new_pass.equals(repeat_pass)){  //Si el usuario y la contraseña anterior que pone el usuario son las mismas que estan en la BD y si las contraseñas nueva y repetida coinciden(esto ultimo se puede omitir ya que esta validado en ajax_psw.js)
       conexion.stmt=conexion.conn.createStatement();      
                
       conexion.stmt.executeUpdate("UPDATE \"seguim_CURT\".tbl_admin SET  password= MD5('"+new_pass+"'), fec_cambio_pass=CURRENT_DATE, hora_cambio_psw=now()"
               + " WHERE usuario = '"+user+"' AND password = MD5('"+old_pass+"')");
       conexion.closeConnection();//termina la conexion
       
        out.print("succes_psw");  //este resultado se imprime para despues compararlo en el ajax_psw.js
    }
    else{
        if( !getMD5(old_pass).equals(psw)){       //Si la contraseña que el usuario escribe NO coincide con la que esta en la BD... mandara error
            out.print("error_psw");  //este resultado se imprime para despues compararlo en el ajax_psw.js
        }
        
        else{
        out.print("ERROR");  //este resultado se imprime para despues compararlo en el ajax_psw.js
        }
        
    }
            
        
        
} catch (SQLException ex) {
                    Logger.getLogger(cambia_pass_adm.class.getName()).log(Level.SEVERE, null, ex);
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
