/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import BaseDatos.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author RICARDO.MACIAS
 */
public class GrabaSolicitudSop extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
          PrintWriter out = response.getWriter();
  
        ConexionBD conexion= new ConexionBD(); 
        
        String fecha_hoy = request.getParameter("fecha_hoy");
        String id_ue  = request.getParameter("id_ue");
        String nombre_soli =request.getParameter("nombre_soli");
        String correo =request.getParameter("correo");
        String tipo_solicitud  = request.getParameter("tipo_solicitud");
        String mensaje = request.getParameter("mensaje");
      

        
        try {
                    
        conexion.stmt=conexion.conn.createStatement();
        conexion.stmt.executeUpdate("SET DATESTYLE TO dmy; INSERT INTO \"seguim_CURT\".solicitud_soporte(\n" +
                    "            id_solic, fecha_solicitud, id_ue, nombre_solicitante, correo, \n" +
                    "            tipo_solicitud, estatus, mensaje)\n" +
                    "    VALUES (nextval('\"seguim_CURT\".id_solic'), '"+fecha_hoy+"', '"+id_ue+"', '"+nombre_soli+"', '"+correo+"', \n" +
                    "            '"+tipo_solicitud+"', 'PENDIENTE', '"+mensaje+"')");
                     
                   out.print("Solicitud enviada correctamente");
                       
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
