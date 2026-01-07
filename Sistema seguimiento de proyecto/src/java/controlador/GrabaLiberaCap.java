/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import BaseDatos.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.Month;
import java.time.format.TextStyle;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author RICARDO.MACIAS
 */
public class GrabaLiberaCap extends HttpServlet {

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
        
        String fecha_llenado = request.getParameter("fecha_llenado");
        String id_ue  = request.getParameter("id_ue");
        String id_sol =request.getParameter("id_sol");
        String fecha_sol =request.getParameter("fecha_sol");
        String tipo_solicitud  = request.getParameter("tipo_solicitud");
        String responsable_val = request.getParameter("responsable_val");
        
    // Obtienes el mes actual
        Month mes = LocalDate.now().getMonth();
    // Obtienes el nombre del mes
        String nombre = mes.getDisplayName(TextStyle.FULL, new Locale("es", "ES"));
      

       
        try {
                    
        conexion.stmt=conexion.conn.createStatement();
        conexion.stmt.executeUpdate("SET DATESTYLE TO dmy; INSERT INTO \"seguim_CURT\".libera_capacitacion(\n" +
                "            id_libcap, fecha_llenado, id_ue, libera_solicitud, fecha_solicitud, \n" +
                "            mes_liberado, id_solic, resp_liberacion)\n" +
                "    VALUES ( nextval('\"seguim_CURT\".id_libcap'), '"+fecha_llenado+"', '"+id_ue+"', 'TRUE', '"+fecha_sol+"', \n" +
                "            '"+nombre.toUpperCase()+"', '"+id_sol+"', '"+responsable_val+"')");
        
        
        /*Actualizo el campo estatus en tabla solicitud_soporte */
        conexion.stmt.executeUpdate("SET DATESTYLE TO dmy; UPDATE \"seguim_CURT\".solicitud_soporte \n" +
                    " SET estatus='TERMINADO' \n" +
                    " WHERE id_ue = '"+id_ue+"' AND tipo_solicitud = '"+tipo_solicitud+"'");
        
                     
                   out.print("Solicitud atendida correctamente");
                       
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
