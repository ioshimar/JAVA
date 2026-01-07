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
public class ActualizaCobert extends HttpServlet {

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
  String id_cobertura = request.getParameter("cobertura");
  String id_ue = request.getParameter("ue");    
  String id_entrega = request.getParameter("entrega");  
  String muni = request.getParameter("muni");
  String no_reg = request.getParameter("no_reg");
  String nom_shape = request.getParameter("nom_shape");
             
               //  out.println(arraySeparadoMuni + "<br/>");
             
                try {
                   
                         conexion.stmt=conexion.conn.createStatement();
                         conexion.stmt.executeUpdate("UPDATE \"seguim_CURT\".cobertura SET  municipio='"+muni+"', nom_shape='"+nom_shape+"', num_reg='"+no_reg+"', fecha_actualizacion ='"+fecha_llenado+"' WHERE id_cob = '"+id_cobertura+"'");
                    
                   out.print("Registro Actualizado correctamente");
                   response.sendRedirect("cobertura.jsp?ue="+id_ue+"&entrega="+id_entrega);
                       
                    }catch (Exception ex) {
                        out.print("Error al conectar a la base de datos");
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
