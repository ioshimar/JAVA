/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import BaseDatos.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig  //Agregamos esta linea para que acepte el MultiPartConfig

/**
 *
 * @author RICARDO.MACIAS
 */
public class PruebaActualizaC1 extends HttpServlet {



 

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
      
           response.setContentType("text/html;charset=UTF-8");
          PrintWriter out = response.getWriter();
  
        ConexionBD conexion= new ConexionBD(); 
        
        String fecha_act = request.getParameter("fecha_llenado");
        String id_ue  = request.getParameter("id_ue");
        String nom_edo =request.getParameter("nom_edo");
        String cve_edo =request.getParameter("cve_edo");
        String name_ue  = request.getParameter("name_ue");
        String fecha_ofic  = request.getParameter("fecha_ofic");
        String fecha_resp  = request.getParameter("fecha_resp");
        String fecha_ofic2  = request.getParameter("fecha_ofic2");
        String fecha_resp2  = request.getParameter("fecha_resp2");
        String fecha_ofic3 = request.getParameter("fecha_ofic3");
        String fecha_resp3  = request.getParameter("fecha_resp3");
        
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
    QueaceptoSeparado = new String(QueaceptoSeparado.substring(1, QueaceptoSeparado.length()-1).getBytes("ISO-8859-1"),"UTF-8");   //le quitamos los corchetes
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
        
        //String file_oficio1 = request.getParameter("file_oficio1");
        //String file_resp1 = request.getParameter("file_resp1");
       // String file_oficio2 = request.getParameter("file_oficio2");
       // String file_resp2 = request.getParameter("file_resp2");
        //String file_oficio3 = request.getParameter("file_oficio3");
       // String file_resp3 = request.getParameter("file_resp3");
        
        
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
         
         
       /********************Procesamos los archivos***************************/   
    Part file_oficio1 = request.getPart("file_oficio1"); // Retrieves <input type="file" name="file">
    String NombreOficio1 = file_oficio1.getSubmittedFileName(); // MSIE fix.
  //  InputStream fileContent1 = file_oficio1.getInputStream();
    
       Part file_resp1 = request.getPart("file_resp1"); // Retrieves <input type="file" name="file">
    String NombreOficioResp1 = "asa"; //Paths.get(file_resp1.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
   // InputStream fileContent2 = file_resp1.getInputStream();
   
   Part file_oficio2 = request.getPart("file_oficio2"); // Retrieves <input type="file" name="file">
    String NombreOficio2 = "asa";// Paths.get(file_oficio2.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
    
     Part file_resp2 = request.getPart("file_resp2"); // Retrieves <input type="file" name="file">
    String NombreResp2 = "asa"; //Paths.get(file_resp2.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
    
     Part file_oficio3 = request.getPart("file_oficio3"); // Retrieves <input type="file" name="file">
    String NombreOficio3 = "asa"; //Paths.get(file_oficio3.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
    
      Part file_resp3 = request.getPart("file_resp3"); // Retrieves <input type="file" name="file">
    String NombreResp3 = "asa"; //Paths.get(file_resp3.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
    
    
     
        
        
        try {
                    
        conexion.stmt=conexion.conn.createStatement();
        conexion.stmt.executeUpdate("SET DATESTYLE TO dmy; UPDATE \"seguim_CURT\".concertacion\n" +
                                "   SET nom_ue='"+name_ue+"', fec_pri_env='"+fecha_ofic+"', \n" +
                                "  fec_pri_res='"+fecha_resp+"', fec_seg_env='"+fecha_ofic2+"', fec_seg_res='"+fecha_resp2+"', acepto='"+acepto+"', que_acepto='"+QueaceptoSeparado+"', \n" +
                                "  motivo='"+motivo+"', fecha_actualizacion='"+fecha_act+"', respuesta1='"+first_resp+"', \n" +
                                "  respuesta2='"+second_resp+"',fechas_primer_oficio ='"+sin_fechas1+"', fechas_segundo_oficio='"+sin_fechas2+"', \n" +
                                "  fec_ter_env = '"+fecha_ofic3+"', fec_ter_res='"+fecha_resp3+"', respuesta3='"+third_resp+"', fechas_tercer_oficio='"+sin_fechas3+"',"
                              + " nombre_destin1='"+nom_destinatario+"', nombre_remi1='"+nom_remitente+"', nombre_destin2='"+nom_destinatario2+"', nombre_remi2='"+nom_remitente2+"', nombre_destin3='"+nom_destinatario3+"', nombre_remi3='"+nom_remitente3+"',"
                              + " ruta_ofi_env1='"+NombreOficio1+"', ruta_ofi_recib1='"+NombreOficioResp1+"', \n" +
                                " ruta_ofi_env2='"+NombreOficio2+"', ruta_ofi_recib2='"+NombreResp2+"', ruta_ofi_env3='"+NombreOficio3+"', ruta_ofi_recib3='"+NombreResp3+"' WHERE id_ue = '"+id_ue+"'");
                     
                   out.print("Datos Actualizados correctamenteeeee");
                       
                    }catch (Exception ex) {
                        out.print("Error al conectar a la base de datos ");
                        out.println(ex);
                        ex.printStackTrace();

                    } finally {
                       
                        conexion.closeConnection();
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
