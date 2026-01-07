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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
public class GrabaEntregaFisica extends HttpServlet {
    
     
     public static String getFechaActual() {
        Date ahora=new Date();//creacion de un objeto fecha
        SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy");//se establece un formato 
        return formateador.format(ahora);//regresa la fecha actual con el formato definido
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
          PrintWriter out = response.getWriter();
          
        ConexionBD conexion= new ConexionBD(); 
        String id_ue5  = request.getParameter("id_ue5");
        String fecha_llenado = request.getParameter("fecha_llenado");
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
        
        
         try{ //consultamos si ya se guardo algún registro con el mismo id_archivo
        PreparedStatement pst2 =(PreparedStatement) conexion.conn.prepareStatement( "SELECT * FROM \"seguim_CURT\".datos_entrega_fis"
                + " WHERE idsolicitud= '"+idsolicitud+"' AND nom_archivo = '"+nom_arch+"' AND id_ue = '"+id_ue5+"'  " ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        conexion.rs =pst2.executeQuery(); 
        }catch(SQLException e){
                out.print("exception"+e);
        }
            if(conexion.rs.next()){ //Si encuentra algo...
               out.print("Error ya se ha guardado este registro en la Base de Datos, intenta con otro archivo"); 
           }
      
        
            else{ 
                try {


                 conexion.stmt=conexion.conn.createStatement();
                conexion.stmt.executeUpdate("SET DATESTYLE TO dmy;  INSERT INTO \"seguim_CURT\".datos_entrega_fis(id_entrega, id_ue, fecha, nom_resp_ent, "
                        + "unidad_admin,nom_resp_rec, medio, nom_archivo, tamano, total_reg, fecha_llenado, idsolicitud, tipo_entrega, pred_con_curt, pred_sin_curt, usuario_resp)"
                     +"VALUES(nextval('\"seguim_CURT\".id_entrega'),'"+id_ue5+"','"+fecha_dat+"','"+nom_resp+"',"
              + "'"+nom_ua+"','"+resp_estr+"','"+medio_udo+"','"+nom_arch+"','"+tamano+"','"+no_reg+"', '"+fecha_llenado+"', '"+idsolicitud+"','"+tipo_entrega+"', '"+pred_con_curt+"', '"+pred_sin_curt+"', '"+usuario_resp+"')");

                           out.print("Datos Ingresados correctamente");

                            }catch (Exception ex) {
                                out.print("Error_al_conectar_la_bd");
                                out.println(ex);
                                ex.printStackTrace();

                            } finally {

                                conexion.closeConnection();
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
             Logger.getLogger(GrabaEntregaFisica.class.getName()).log(Level.SEVERE, null, ex);
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
             Logger.getLogger(GrabaEntregaFisica.class.getName()).log(Level.SEVERE, null, ex);
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
