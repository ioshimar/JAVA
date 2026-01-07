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
import java.util.Arrays;
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
public class GrabaCurtP4 extends HttpServlet {

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
        
        String fecha_llenado = request.getParameter("fecha_llenado");
        String id_ue  = request.getParameter("id_ue");
        String fecha_ini =request.getParameter("fecha_ini");
        String fecha_fin =request.getParameter("fecha_fin");
        String name_resp  = request.getParameter("name_resp");
        String name_ase = request.getParameter("name_ase");
        String fecha_ini_ap = request.getParameter("fecha_ini_ap");
        String fecha_fin_ap = request.getParameter("fecha_fin_ap");
        String name_resp_ap = request.getParameter("name_resp_ap");
        String name_ase_ap = request.getParameter("name_ase_ap");
        String fecha_ini_conv = request.getParameter("fecha_ini_conv");
        String fecha_fin_conv = request.getParameter("fecha_fin_conv");
        String name_resp_conv = request.getParameter("name_resp_conv");
        String name_ase_conv = request.getParameter("name_ase_conv");
        String fecha_ini_est = request.getParameter("fecha_ini_est");
        String fecha_fin_est = request.getParameter("fecha_fin_est");
        String name_resp_est = request.getParameter("name_resp_est");
        String name_ase_est = request.getParameter("name_ase_est");
        String fecha_ini_ref = request.getParameter("fecha_ini_ref");
        String fecha_fin_ref = request.getParameter("fecha_fin_ref");
        String name_resp_ref = request.getParameter("name_resp_ref");
        String name_ase_ref = request.getParameter("name_ase_ref");
        String fecha_ini_int = request.getParameter("fecha_ini_int");
        String fecha_fin_int = request.getParameter("fecha_fin_int");
        String name_resp_int = request.getParameter("name_resp_int");
        String name_ase_int = request.getParameter("name_ase_int");
        
        String[] arrayTipo_asesoria = request.getParameterValues("tipo_asesoria"); 
        String Tipo_asesoriaSeparado = Arrays.toString(arrayTipo_asesoria);  //Convertimos el array a cadena
    Tipo_asesoriaSeparado = Tipo_asesoriaSeparado.substring(1, Tipo_asesoriaSeparado.length()-1);   //le quitamos los corchetes
            if(Tipo_asesoriaSeparado.equals("ul")){Tipo_asesoriaSeparado="";} //es ul porque con el .substring de arriba le quita la primera "n"  la y ultima "l" de null
      
/*para que no inserte valores vacios en la base de datos, ya que l tipo date no acepta valores vacios*/
        if(fecha_ini==null || fecha_ini.equals("") ){fecha_ini= "01/01/0001"; }    
        if(fecha_fin==null || fecha_fin.equals("") ){fecha_fin= "01/01/0001"; }  
        if(fecha_ini_ap==null || fecha_ini_ap.equals("") ){fecha_ini_ap= "01/01/0001"; }    
        if(fecha_fin_ap==null || fecha_fin_ap.equals("") ){fecha_fin_ap= "01/01/0001"; }  
        if(fecha_ini_conv==null || fecha_ini_conv.equals("") ){fecha_ini_conv= "01/01/0001"; } 
        if(fecha_fin_conv==null || fecha_fin_conv.equals("") ){fecha_fin_conv= "01/01/0001"; }  
        if(fecha_ini_est==null || fecha_ini_est.equals("") ){fecha_ini_est= "01/01/0001"; }  
        if(fecha_fin_est==null || fecha_fin_est.equals("") ){fecha_fin_est= "01/01/0001"; }  
        if(fecha_ini_ref==null || fecha_ini_ref.equals("") ){fecha_ini_ref= "01/01/0001"; } 
        if(fecha_fin_ref==null || fecha_fin_ref.equals("") ){fecha_fin_ref= "01/01/0001"; } 
        if(fecha_ini_int==null || fecha_ini_int.equals("") ){fecha_ini_int= "01/01/0001"; } 
        if(fecha_fin_int==null || fecha_fin_int.equals("") ){fecha_fin_int= "01/01/0001"; } 
         
        String usuario_resp = request.getParameter("usuario_resp");
        
        try {
                    
        conexion.stmt=conexion.conn.createStatement();
        conexion.stmt.executeUpdate("SET DATESTYLE TO dmy; INSERT INTO \"seguim_CURT\".asesoria(\n" +
                        "  id_ase, id_ue, fec_ini_regue, fec_fin_regue, nom_resp_ue, nom_reci_ue, \n" +
                        "  fec_ini_ap, fec_fin_ap, nom_resp_ap, nom_reci_ap, fec_ini_cord, \n" +
                        "  fec_fin_cord, nom_resp_cord, nom_rec_cord, fec_ini_est, fec_fin_est, \n" +
                        "  nom_resp_est, nom_rec_est, fec_ini_info, fec_fin_info, nom_resp_info, \n" +
                        "  nom_rec_info, fec_ini_inte, fec_fin_inte, nom_resp_inte, nom_rec_inte, \n" +
                        "  fecha_llenado, tipo_asesoria, usuario_resp)\n" +
                        "    VALUES (nextval('\"seguim_CURT\".id_asesor'), '"+id_ue+"', '"+fecha_ini+"', '"+fecha_fin+"', '"+name_resp+"', '"+name_ase+"', \n" +
                        "            '"+fecha_ini_ap+"', '"+fecha_fin_ap+"', '"+name_resp_ap+"', '"+name_ase_ap+"', '"+fecha_ini_conv+"', \n" +
                        "            '"+fecha_fin_conv+"', '"+name_resp_conv+"', '"+name_ase_conv+"', '"+fecha_ini_est+"', '"+fecha_fin_est+"', \n" +
                        "            '"+name_resp_est+"', '"+name_ase_est+"', '"+fecha_ini_ref+"', '"+fecha_fin_ref+"', '"+name_resp_ref+"', \n" +
                        "            '"+name_ase_ref+"', '"+fecha_ini_int+"', '"+fecha_fin_int+"', '"+name_resp_int+"', '"+name_ase_int+"', \n" +
                        "            '"+fecha_llenado+"','"+Tipo_asesoriaSeparado+"', '"+usuario_resp+"')");
                     
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(GrabaCurtP4.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(GrabaCurtP4.class.getName()).log(Level.SEVERE, null, ex);
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
