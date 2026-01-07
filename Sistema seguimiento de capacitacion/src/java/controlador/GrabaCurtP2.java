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
public class GrabaCurtP2 extends HttpServlet {

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
        
        String fecha_llenado1 = request.getParameter("fecha_llenado");
        String id_ue  = request.getParameter("id_ue");
        String nom_user  = request.getParameter("nom_user");
        String fecha_impart1 =request.getParameter("fecha_impart");
        String lugar =request.getParameter("lugar");
        String responsable  = request.getParameter("responsable");
        String cantidad_p = request.getParameter("cantidad_p");
        String usuario_resp = request.getParameter("usuario_resp");
        String norma_cat = request.getParameter("norma_cat");
        String norma_curt = request.getParameter("norma_curt");
        String lineamiento = request.getParameter("lineamiento");
        String diccionario = request.getParameter("diccionario");
        String tipo_cap = request.getParameter("tipo_cap");
        
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy"); 
        LocalDate fecha_llenado = LocalDate.parse(fecha_llenado1, formato); 
        System.out.println("nuevooooooo"+fecha_llenado);
        
        DateTimeFormatter formato_imp = DateTimeFormatter.ofPattern("dd/MM/yyyy"); 
        LocalDate fecha_impart = LocalDate.parse(fecha_impart1, formato_imp); 
        System.out.println("nuevooooooo"+fecha_impart);
      
        
        //VALIDA VALORES NULOS
        if(norma_cat==null){
         
             norma_cat="";
         }else{norma_cat = request.getParameter("norma_cat");}
        
         
         if(norma_curt==null){
         
             norma_curt="";
         }else{norma_curt = request.getParameter("norma_curt");}
         
         
         if(lineamiento==null){
         
             lineamiento="";
         }else{lineamiento = request.getParameter("lineamiento");}
         
         
         if(diccionario==null){
         
             diccionario="";
         }else{diccionario = request.getParameter("diccionario");}
         
         
        try {
                    
        conexion.stmt=conexion.conn.createStatement();
        conexion.stmt.executeUpdate("INSERT INTO seguimiento_cap.capacitacion(\n" +
                    "id_cap, id_ue, nom_user, norma_cat, norma_curt, lineamiento, diccionario, fecha_cap, lugar, resp_inegi, cant_pers, fecha_llenado, usuario_resp,tipo_cap)\n" +
                    "VALUES (nextval('seguimiento_cap.id_capacitacion'),'"+id_ue+"', '"+nom_user+"', '"+norma_cat+"', '"+norma_curt+"', '"+lineamiento+"', '"+diccionario+"', '"+fecha_impart+"', '"+lugar+"', '"+responsable+"', '"+cantidad_p+"', '"+fecha_llenado+"', '"+usuario_resp+"', '"+tipo_cap+"')");
                     
                   out.print("Datos Ingresados correctamente");
                       
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
            Logger.getLogger(GrabaCurtP2.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(GrabaCurtP2.class.getName()).log(Level.SEVERE, null, ex);
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
