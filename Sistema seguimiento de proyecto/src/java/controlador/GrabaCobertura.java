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
public class GrabaCobertura extends HttpServlet {

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
       
        String  id_entrega = request.getParameter("id_entrega");
        String  id_ue =  request.getParameter("id_ue");
         String fecha_llenado = request.getParameter("fecha_llenado"); 
      
         //System.out.println();//esta solo espara probar el codigo
        //out.print(id_entrega +" "+ id_ue +"<br/>");
         String[] arrayMunicipio = request.getParameterValues("municipio");  //NOTA Funciona quitandole los corechetes [] desde el html en el atributo name
         String[] arrayNom_shape = request.getParameterValues("nom_shape");
         String[] arrayNo_reg = request.getParameterValues("no_reg");
                   // out.println(arrayMunicipio[1]);
                  // int total= arrayMunicipio.length;
                  
                  
             
               //  out.println(arraySeparadoMuni + "<br/>");
               
                try {
                     for(int i=0; i<(arrayMunicipio.length); i++) {   //tomamos cualquier array
                         conexion.stmt=conexion.conn.createStatement();
                         conexion.stmt.executeUpdate("INSERT INTO \"seguim_CURT\".cobertura( id_cob, id_entrega, id_ue, municipio, nom_shape, num_reg, fecha_llenado)"
                                                     +"VALUES(nextval('\"seguim_CURT\".id_cobertura'),'"+id_entrega+"','"+id_ue+"','"+arrayMunicipio[i]+"','"+arrayNom_shape[i]+"','"+arrayNo_reg[i]+"', '"+fecha_llenado+"')");
                     }
                   out.print("Datos Ingresados correctamente");
                       
                    }catch (Exception ex) {
                        out.print("Error al conectara la base de datos");
                        out.println(ex);
                        ex.printStackTrace();

                    } finally {
                       
                        conexion.closeConnection();
                    }
            
            
    
        
        
   

         /*   
            if (municipio != null && nom_shape != null && no_reg != null) {// checar si los text box estan vacios
             
                if (municipio != "" && nom_shape != "" && no_reg != "") {   // checar si los text box tinen solo espacios en blanco

                    try {
                         conexion.stmt=conexion.conn.createStatement();
                         conexion.stmt.executeUpdate("INSERT INTO \"seguim_CURT\".cobertura( id_cob, id_entrega, id_ue, municipio, nom_shape, num_reg)"
                                                     +"VALUES(nextval('\"seguim_CURT\".id_cobertura'),'"+id_entrega+"','"+id_ue+"','"+municipio+"','"+nom_shape+"','"+no_reg+"')");
             
                            out.print("Datos Ingresados correctamente");
                       
                    }catch (Exception ex) {
                        out.print("Unable to connect to batabase.");
                        out.println(ex);
                        ex.printStackTrace();

                    } finally {
                       
                        conexion.closeConnection();
                    }
                }
            }
   
        
        */
        
  
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
            Logger.getLogger(GrabaCobertura.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(GrabaCobertura.class.getName()).log(Level.SEVERE, null, ex);
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
