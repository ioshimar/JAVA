/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import BaseDatos.ConexionBD;
import java.io.File;

import java.io.IOException;
import java.io.InputStream;

import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import java.util.Arrays;


import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

//@MultipartConfig  //Agregamos esta linea para que acepte el MultiPartConfig

/**
 *
 * @author RICARDO.MACIAS
 */
public class GrabaCurtP1 extends HttpServlet {

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
          
          
              response.setContentType("text/html;charset=UTF-8");
          PrintWriter out = response.getWriter();
  
        ConexionBD conexion= new ConexionBD(); 
        
        String fecha_llenado = request.getParameter("fecha_llenado");
        String id_ue  = request.getParameter("id_ue");
        String nom_edo =request.getParameter("nom_edo");
        String nombre_muni = request.getParameter("nombre_muni");
        String cve_edo = request.getParameter("cve_edo");
        String name_ue  = request.getParameter("name_ue");
        String fecha_ofic  = request.getParameter("fecha_ofic");
        String fecha_resp  = request.getParameter("fecha_resp");
        String fecha_ofic2  = request.getParameter("fecha_ofic2");
        String fecha_resp2  = request.getParameter("fecha_resp2");
        String fecha_ofic3 = request.getParameter("fecha_ofic3");
        String fecha_resp3  = request.getParameter("fecha_resp3");
        String observaciones = request.getParameter("observaciones");
        
        if(fecha_ofic==null || fecha_ofic.equals("") ){
              fecha_ofic= "01/01/0001";
        }
        
        if(fecha_ofic2==null || fecha_ofic2.equals("") ){
              fecha_ofic2="01/01/0001";
        }
        
         if(fecha_ofic3==null || fecha_ofic3.equals("") ){
              fecha_ofic3="01/01/0001";
        }
         
         
        if(fecha_resp==null || fecha_resp.equals("") ){
              fecha_resp="01/01/0001";
         }
        if(fecha_resp2==null || fecha_resp2.equals("") ){
              fecha_resp2="01/01/0001";
        }
        
         if(fecha_resp3==null || fecha_resp3.equals("") ){
              fecha_resp3="01/01/0001";
        }
           
           
        String acepto  = request.getParameter("acepto");
        if(acepto==null){acepto="";}
        /*
        String que_acepto  = request.getParameter("que_acepto");
            if(que_acepto==null){que_acepto="";}
            */
         String[] arrayQue_acepto = request.getParameterValues("que_acepto"); 
        
   
    String QueaceptoSeparado = Arrays.toString(arrayQue_acepto);  //Convertimos el array a cadena
    QueaceptoSeparado = QueaceptoSeparado.substring(1, QueaceptoSeparado.length()-1);   //le quitamos los corchetes
    if(QueaceptoSeparado.equals("ul")){QueaceptoSeparado="";} //es ul porque con el .substring de arriba le quita la primera "n"  la y ultima "l" de null 
    
        String motivo  = request.getParameter("motivo");
        String first_resp  = request.getParameter("first_resp");
        String second_resp  = request.getParameter("second_resp");
        String third_resp  = request.getParameter("third_resp");
        
        String sin_fechas1 = request.getParameter("sin_fechas1");
        String sin_fechas2 = request.getParameter("sin_fechas2");
        String sin_fechas3 = request.getParameter("sin_fechas3");
        
        String nom_destinatario = request.getParameter("nom_destinatario");
        String nom_remitente = request.getParameter("nom_remitente");

        String nom_destinatario2 = request.getParameter("nom_destinatario2");
        String nom_remitente2 = request.getParameter("nom_remitente2");

        String nom_destinatario3 = request.getParameter("nom_destinatario3");
        String nom_remitente3 = request.getParameter("nom_remitente3");
        
        //String Parametro_oficio1 = request.getParameter("file_oficio1");
       // String Parametro_resp1 = request.getParameter("file_resp1");
       // String file_oficio2 = request.getParameter("file_oficio2");
        //String file_resp2 = request.getParameter("file_resp2");
        //String file_oficio3 = request.getParameter("file_oficio3");
        //String file_resp3 = request.getParameter("file_resp3");
        
        
          if(first_resp==null){  //si esta null es porque NO se marco el check, y SI hubo respuesta, por tanto es SI,
             first_resp ="SI"; //Si hubo respuesta
             second_resp ="";  //No se manda nada
         }
       
        else if(second_resp == null ){
                second_resp ="SI";
         }
        
        else if(third_resp == null ){
               third_resp ="SI";
         }
        else{}
      
          
          
         //******String sin_fechas1 = request.getParameter("sin_fechas1"); *************
         if(sin_fechas1==null){  //si esta null es porque NO se marco el check, y SI hubo respuesta es  sin fechas,
             sin_fechas1 =""; //Si hubo respuesta
         } else{}

        
        //**************** String sin_fechas2 = request.getParameter("sin_fechas2"); **************************
         if(sin_fechas2==null){  //si esta null es porque NO se marco el check, y SI hubo respuesta es  sin fechas,
             sin_fechas2 =""; //Si hubo respuesta
         }else{}
         
         //**************** String sin_fechas3 = request.getParameter("sin_fechas3"); **************************
         if(sin_fechas3==null){  //si esta null es porque NO se marco el check, y SI hubo respuesta es  sin fechas,
             sin_fechas3 =""; //Si hubo respuesta
         }else{}
         
 

   String activa_2doOf  = request.getParameter("activa_2doOf");
    if(activa_2doOf==null){activa_2doOf="false";}
    
   String activa_3erOf  = request.getParameter("activa_3erOf");
        if(activa_3erOf==null){activa_3erOf="false";} 
         
        
    String privilegio  =  request.getParameter("privilegio"); 
    String concerta  =  request.getParameter("concerta");  //checkbox 
        if(concerta==null){concerta="";} 
    
    String usuario_resp  =  request.getParameter("usuario_resp"); //SESION RESPONSABLE
         
  
        
        try {
                    
        conexion.stmt=conexion.conn.createStatement();
        conexion.stmt.executeUpdate("SET DATESTYLE TO dmy; INSERT INTO \"seguim_CURT\".concertacion(\n" +
"             id_concer, id_ue, nom_ent, cve_ent, nom_ue, fec_pri_env, fec_pri_res, \n" +
"            fec_seg_env, fec_seg_res, acepto, que_acepto, motivo, fecha_llenado, \n" +
"            respuesta1, respuesta2,fechas_primer_oficio, fechas_segundo_oficio, fec_ter_env, fec_ter_res, respuesta3, fechas_tercer_oficio,  nombre_destin1, nombre_remi1, nombre_destin2, \n" +
"            nombre_remi2, nombre_destin3, nombre_remi3, municipio, observaciones, activa_2of, activa_3of, privilegio, concerta, usuario_resp)"
             +"VALUES(nextval('\"seguim_CURT\".id_concer'),'"+id_ue+"','"+nom_edo+"','"+cve_edo+"','"+name_ue+"','"+fecha_ofic+"','"+fecha_resp+"','"+fecha_ofic2+"','"+fecha_resp2+"',"
                + "'"+acepto+"','"+QueaceptoSeparado+"','"+motivo+"','"+fecha_llenado+"','"+first_resp+"','"+second_resp+"', '"+sin_fechas1+"','"+sin_fechas2+"', '"+fecha_ofic3+"', "
                + "'"+fecha_resp3+"','"+third_resp+"','"+sin_fechas3+"', '"+nom_destinatario+"', '"+nom_remitente+"', '"+nom_destinatario2+"', '"+nom_remitente2+"', '"+nom_destinatario3+"', '"+nom_remitente3+"',"
                + "'"+nombre_muni+"', '"+observaciones+"', '"+activa_2doOf+"', '"+activa_3erOf+"', '"+privilegio+"','"+concerta+"', '"+usuario_resp+"' )");
                     
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
