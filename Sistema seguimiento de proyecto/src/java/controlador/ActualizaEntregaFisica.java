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
public class ActualizaEntregaFisica extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
       ConexionBD conexion= new ConexionBD(); 
       
        int id_entrega = Integer.parseInt(request.getParameter("id_entrega"));
       // String id_ue5  = request.getParameter("id_ue5");
        String fecha = request.getParameter("fecha_llenado");
        String fecha_dat  = request.getParameter("fecha_dat");
        String nom_resp  = request.getParameter("nom_resp");
        String nom_ua  = request.getParameter("nom_ua");
        String resp_estr  = request.getParameter("resp_estr");
        String medio_udo  = request.getParameter("medio_udo");
        String nom_arch  = request.getParameter("nom_arch");
        String tamano  = request.getParameter("tamano");
        String no_reg  = request.getParameter("no_reg");
        String idsolicitud = request.getParameter("carga_archivos");
         if(idsolicitud.equals("") || idsolicitud == null){ idsolicitud="0";}
        
        String tipo_entrega = request.getParameter("tipo_entrega");
        if(fecha_dat==null || fecha_dat.equals("") ){fecha_dat= "01/01/0001"; } 
        
        String pred_con_curt = request.getParameter("pred_con_curt");
        String pred_sin_curt = request.getParameter("pred_sin_curt");
        
      String usuario_resp = request.getParameter("usuario_resp");  
        
        
        
         try {
                  conexion.stmt=conexion.conn.createStatement();
                         conexion.stmt.executeUpdate("SET DATESTYLE TO dmy; UPDATE \"seguim_CURT\".datos_entrega_fis SET fecha='"+fecha_dat+"', nom_resp_ent='"+nom_resp+"', unidad_admin='"+nom_ua+"', nom_resp_rec='"+resp_estr+"', medio='"+medio_udo+"', nom_archivo='"+nom_arch+"', tamano='"+tamano+"', "
                                 + "total_reg='"+no_reg+"',  tipo_entrega='"+tipo_entrega+"', pred_con_curt='"+pred_con_curt+"', pred_sin_curt='"+pred_sin_curt+"', fecha_actualizacion = '"+fecha+"', usuario_resp='"+usuario_resp+"' "
                                 + "WHERE id_entrega ='"+id_entrega+"'  ");
                 
                   out.print("Datos actualizados correctamente");
                       
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
