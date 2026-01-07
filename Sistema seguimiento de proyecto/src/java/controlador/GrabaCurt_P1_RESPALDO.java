/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import BaseDatos.ConexionBD;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
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
public class GrabaCurt_P1_RESPALDO extends HttpServlet {

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
   /*     try (PrintWriter out = response.getWriter()) {
        
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GrabaCurt_P1_RESPALDO</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GrabaCurt_P1_RESPALDO at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }*/
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
       
        
        String fecha_llenado = getValue(request.getPart("fecha_llenado"));
        String id_ue  = getValue(request.getPart("id_ue"));
        String nom_edo =  getValue(request.getPart("nom_edo"));
        String nombre_muni = getValue(request.getPart("nombre_muni"));
        String cve_edo =getValue(request.getPart("cve_edo"));
        String name_ue  = getValue(request.getPart("name_ue"));
        String fecha_ofic  = getValue(request.getPart("fecha_ofic"));
        String fecha_resp  = getValue(request.getPart("fecha_resp"));
        String fecha_ofic2  = getValue(request.getPart("fecha_ofic2"));
        String fecha_resp2  = getValue(request.getPart("fecha_resp2"));
        String fecha_ofic3 = getValue(request.getPart("fecha_ofic3"));
        String fecha_resp3  = getValue(request.getPart("fecha_resp3"));
        
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
           
           
        String acepto  = getValue(request.getPart("acepto"));
        if(acepto==null || acepto.equals("") ){
            acepto="";
        }
        /*
        String que_acepto  = request.getPart("que_acepto");
            if(que_acepto==null){que_acepto="";}
            */
         String[] arrayQue_acepto = request.getParameterValues("que_acepto"); 
        
   
    String QueaceptoSeparado = Arrays.toString(arrayQue_acepto);  //Convertimos el array a cadena
    QueaceptoSeparado = new String(QueaceptoSeparado.substring(1, QueaceptoSeparado.length()-1).getBytes("ISO-8859-1"),"UTF-8");   //le quitamos los corchetes
    if(QueaceptoSeparado.equals("ul")){QueaceptoSeparado="";} //es ul porque con el .substring de arriba le quita la primera "n"  la y ultima "l" de null 
    
        String motivo  = getValue(request.getPart("motivo"));
        String first_resp  = getValue(request.getPart("first_resp"));
        String second_resp  = getValue(request.getPart("second_resp"));
        String third_resp  = getValue(request.getPart("third_resp"));
        
        String sin_fechas1 = getValue(request.getPart("sin_fechas1"));
        String sin_fechas2 = getValue(request.getPart("sin_fechas2"));
        String sin_fechas3 = getValue(request.getPart("sin_fechas3"));
        
        String nom_destinatario = new String(getValue(request.getPart("nom_destinatario")).getBytes("ISO-8859-1"),"UTF-8");
        String nom_remitente = new String(getValue(request.getPart("nom_remitente")).getBytes("ISO-8859-1"),"UTF-8");

        String nom_destinatario2 = new String(getValue(request.getPart("nom_destinatario2")).getBytes("ISO-8859-1"),"UTF-8");
        String nom_remitente2 = new String(getValue(request.getPart("nom_remitente2")).getBytes("ISO-8859-1"),"UTF-8");

        String nom_destinatario3 = new String(getValue(request.getPart("nom_destinatario3")).getBytes("ISO-8859-1"),"UTF-8");
        String nom_remitente3 = new String(getValue(request.getPart("nom_remitente3")).getBytes("ISO-8859-1"),"UTF-8");
        
        //String Parametro_oficio1 = request.getPart("file_oficio1");
       // String Parametro_resp1 = request.getPart("file_resp1");
        String file_oficio2 = getValue(request.getPart("file_oficio2"));
        String file_resp2 = getValue(request.getPart("file_resp2"));
        String file_oficio3 = getValue(request.getPart("file_oficio3"));
        String file_resp3 = getValue(request.getPart("file_resp3"));
        
        
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
      
          
          
         //******String sin_fechas1 = request.getPart("sin_fechas1"); *************
         if(sin_fechas1==null){  //si esta null es porque NO se marco el check, y SI hubo respuesta es  sin fechas,
             sin_fechas1 =""; //Si hubo respuesta
         } else{}

        
        //**************** String sin_fechas2 = request.getPart("sin_fechas2"); **************************
         if(sin_fechas2==null){  //si esta null es porque NO se marco el check, y SI hubo respuesta es  sin fechas,
             sin_fechas2 =""; //Si hubo respuesta
         }else{}
         
         //**************** String sin_fechas3 = request.getPart("sin_fechas3"); **************************
         if(sin_fechas3==null){  //si esta null es porque NO se marco el check, y SI hubo respuesta es  sin fechas,
             sin_fechas3 =""; //Si hubo respuesta
         }else{}
         
         
       /********************Procesamos los archivos***************************/   
    String NombreOficio1 ="";
    Part file_oficio1 = request.getPart("file_oficio1"); // Retrieves <input type="file" name="file_oficio1">
   InputStream ContenidoOfic1 = null;
    
 if(file_oficio1 != null && file_oficio1.getSize() > 0){    
    NombreOficio1 = Paths.get(file_oficio1.getSubmittedFileName()).getFileName().toString(); //Nombre del archivo
    
         ContenidoOfic1 = file_oficio1.getInputStream();  //Contenido del Archivo
         
String RutaCarpeta = getServletContext().getRealPath("/")+ "/archivos/"; 
            File Archivo = new File(RutaCarpeta, NombreOficio1);
            if (!Archivo.exists()) {
                    Archivo.mkdirs();     
                }
              
                try (InputStream input = ContenidoOfic1) {
                     Files.copy(input, Archivo.toPath(),StandardCopyOption.REPLACE_EXISTING);
                }catch (IOException e) {
                       out.print("Error al subir Oficio 1");
                       out.println(e);
                         e.printStackTrace();
                }
}
                
                /*AQUI ME QUEDE.... Lunes 06/agosto/2018, sigue marcando error al subir archivos, solo los guarda dando doble clic en guardar*/
String NombreOficioResp1 = ""; 
Part file_resp1 = request.getPart("file_resp1"); // Retrieves <input type="file" name="file">
 
  InputStream ContResp1 = null;

if(file_resp1 != null && file_resp1.getSize() > 0 ){ //SI no esta nulo ...
    NombreOficioResp1 = Paths.get(file_resp1.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
    
    ContResp1 = file_resp1.getInputStream();
    
     String RutaCarpeta2 = getServletContext().getRealPath("/")+ "/archivos/"; //para que copie el archivo
            File ArchivoResp1 = new File(RutaCarpeta2, NombreOficioResp1);
            
                if (!ArchivoResp1.exists()) {
                    ArchivoResp1.mkdirs();     
                }
             
                try (InputStream input2 = ContResp1) {
                            Files.copy(input2, ArchivoResp1.toPath(),StandardCopyOption.REPLACE_EXISTING);
                }catch (IOException e) {
                         e.printStackTrace();
                          out.print("Error al subir Respuesta 1");
                             out.println(e);
                }
    } //si  esta Nulo  
   
   
        
        try {
                    
        conexion.stmt=conexion.conn.createStatement();
        conexion.stmt.executeUpdate("SET DATESTYLE TO dmy; INSERT INTO \"seguim_CURT\".concertacion(\n" +
"             id_concer, id_ue, nom_ent, cve_ent, nom_ue, fec_pri_env, fec_pri_res, \n" +
"            fec_seg_env, fec_seg_res, acepto, que_acepto, motivo, fecha_llenado, \n" +
"            respuesta1, respuesta2,fechas_primer_oficio, fechas_segundo_oficio, fec_ter_env, fec_ter_res, respuesta3, fechas_tercer_oficio,  nombre_destin1, nombre_remi1, nombre_destin2, \n" +
"            nombre_remi2, nombre_destin3, nombre_remi3,  ruta_ofi_env1, ruta_ofi_recib1, \n" +
"            ruta_ofi_env2, ruta_ofi_recib2, ruta_ofi_env3, ruta_ofi_recib3, municipio)"
             +"VALUES(nextval('\"seguim_CURT\".id_concer'),'"+id_ue+"','"+nom_edo+"','"+cve_edo+"','"+name_ue+"','"+fecha_ofic+"','"+fecha_resp+"','"+fecha_ofic2+"','"+fecha_resp2+"',"
                + "'"+acepto+"','"+QueaceptoSeparado+"','"+motivo+"','"+fecha_llenado+"','"+first_resp+"','"+second_resp+"', '"+sin_fechas1+"','"+sin_fechas2+"', '"+fecha_ofic3+"', "
                + "'"+fecha_resp3+"','"+third_resp+"','"+sin_fechas3+"', '"+nom_destinatario+"', '"+nom_remitente+"', '"+nom_destinatario2+"', '"+nom_remitente2+"', '"+nom_destinatario3+"', '"+nom_remitente3+"',"
                + "'"+NombreOficio1+"', '"+NombreOficioResp1+"', '"+file_oficio2+"', '"+file_resp2+"', '"+file_oficio3+"', '"+file_resp3+"', '"+nombre_muni+"' )");
                     
                   out.print("Datos Ingresados correctamente");
                       
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

    private static String getValue(Part part) throws IOException {
    BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), "UTF-8"));
    StringBuilder value = new StringBuilder();
    char[] buffer = new char[1024];
    for (int length = 0; (length = reader.read(buffer)) > 0;) {
        value.append(buffer, 0, length);
    }
    return value.toString();
}
}


