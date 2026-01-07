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
public class GrabaMotivosGenC extends HttpServlet {

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
       
        String  id_gen = request.getParameter("id_gen");
        String  id_ue =  request.getParameter("id_ue");
        String  id_entrega =  request.getParameter("id_entrega");
         String fecha_llenado = request.getParameter("fecha_llenado"); 
      
         //System.out.println();//esta solo espara probar el codigo
        //out.print(id_entrega +" "+ id_ue +"<br/>");
         String[] arrayTotal = request.getParameterValues("total_motivos");  //NOTA Funciona quitandole los corechetes [] desde el html en el atributo name
         String[] arrayMotivo = request.getParameterValues("motivo");
                   // out.println(arrayMunicipio[1]);
                  // int total= arrayMunicipio.length;
               
               //  out.println(arraySeparadoMuni + "<br/>");
               
                try {
                     for(int i=0; i<(arrayTotal.length); i++) {   //tomamos cualquier array
                         conexion.stmt=conexion.conn.createStatement();
                         conexion.stmt.executeUpdate("INSERT INTO \"seguim_CURT\".motivos_gen (id_motgen, id_gen, id_ue, total_motgen, mot_gen, fecha_llenado, id_entrega)"
                                                     +"VALUES(nextval('\"seguim_CURT\".id_motgencurt'),'"+id_gen+"','"+id_ue+"','"+arrayTotal[i]+"','"+arrayMotivo[i]+"', '"+fecha_llenado+"','"+id_entrega+"')");
                         
                    //Agregamos támbien los datos en la tabla mot_gen
                     //     conexion.stmt.executeUpdate("UPDATE \"seguim_CURT\".generacion_curt SET mot_gen = CONCAT(mot_gen,  ', "+arrayMotivo[i]+"') WHERE id_gen = '"+id_gen+"'");
                  
                     }
                   out.print("Datos Ingresados correctamente");
                       
                    }catch (Exception ex) {
                        out.print("Error al conectara la base de datos");
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
