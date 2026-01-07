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
import java.util.Hashtable;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadBean;
import javazoom.upload.UploadException;
import javazoom.upload.UploadFile;


/**
 *
 * @author RICARDO.MACIAS
 */
@MultipartConfig  //Agregamos esta linea para que acepte el MultiPartConfig

public class GrabaCurtP1Archivos extends HttpServlet {

      private static final long serialVersionUID = 1L;
       
    
    public GrabaCurtP1Archivos() {
        super();
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     //   processRequest(request, response);
    }

    
    
    
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       // processRequest(request, response);
      
          /**
             * Declaramos MultipartFormDaaRequest por que un Request normal no trae los valores del input Text
             * y tampoco trae la imagen.
             */
              PrintWriter out = response.getWriter();
           ConexionBD conexion= new ConexionBD(); 
            MultipartFormDataRequest mrequest = null;
            
            RequestDispatcher dispatcher = null;
            /**
             * UploadBean es una libreria que se usa para poder llevar objetos al servidor en este caso
             * la imagen.
             */
            UploadBean upBean = null;
            
           
            
            
        String fecha_llenado = null;
        String id_ue  = null;
        String nom_edo = null;
        String nombre_muni = null;
        String cve_edo = null;
        String name_ue  = null;
        String fecha_ofic  = null;
        String fecha_resp  = null;
        String fecha_ofic2  = null;
        String fecha_resp2  = null;
        String fecha_ofic3 = null;
        String fecha_resp3  = null;
        String acepto  = null;
        String[] arrayQue_acepto = null;
        String QueaceptoSeparado = null;
        String motivo  = null;
        String first_resp  =null;
        String second_resp  = null;
        String third_resp  = null;
        
        String sin_fechas1 = null;
        String sin_fechas2 =null;
        String sin_fechas3 = null;
        
        String nom_destinatario = null;
        String nom_remitente = null;

        String nom_destinatario2 = null;
        String nom_remitente2 =null;

        String nom_destinatario3 =null;
        String nom_remitente3 = null;
        
        //String Parametro_oficio1 = request.getParameter("file_oficio1");
       // String Parametro_resp1 = request.getParameter("file_resp1");
        String file_oficio2 = null;
        String file_resp2 = null;
        String file_oficio3 = null;
        String file_resp3 = null;
        
        String NombreOficio1 =null;
        String NombreOficioResp1 = null; 
        
        
           String todo = null;
           String file_oficio = null;
           String file_resp1 = null;
            try{
                  try {
                      /**
                       * Aqui estamos confirmando el MultipartFormDataRequest y le indicamos que recoga todo lo que
                       * nos esta mandando el index.
                       */
                      mrequest=   new MultipartFormDataRequest(request);
                  } catch (UploadException ex) {
                      Logger.getLogger(GrabaCurtP1Archivos.class.getName()).log(Level.SEVERE, null, ex);
                  }
                
            if (mrequest != null) {
                todo = mrequest.getParameter("todo");
            }
            if ((todo != null) && (todo.equalsIgnoreCase("upload"))) {
                /**
                 * Usamos un HashTable que es un directorio, se podria usar como una tabla pequeña.
                 * mrequest.getFiles() = recoger todos los archivos de la imagen.
                 */
                Hashtable files = mrequest.getFiles();
                if ((files != null) && (!files.isEmpty())) {
                    /**
                     * si UploadBean sirve para que podamos subir al servidor objetos, entonces 
                     * UploadFile sirve para poder subir Archivos al servidor.
                     * 
                     * En este caso, al usar el comando GET, le estamos diciendo a lo que
                     * tenga dentro de sus parentecis se vaya al objeto file, pero como 
                     * el objeto que obtenemos es de tipo Hashtable le colocamos un cast
                     * para que podamos recuperar la informacion si problemas.
                     */
                    UploadFile file = (UploadFile) files.get("uploadfile");
                    
                    
                    upBean = new UploadBean();
                    upBean.setFolderstore("D:\\Imagenes\\");
                    /**
                     * Empezamos a utilizar el UploadBean y colocamos la opcion setFolderstore
                     * para poder indicar en que direcion vamos a guarda todo archivo que nos mande.
                     */
                    
                        upBean.store(mrequest, "uploadfile");
                        /**
                         * Con el Store le decimos al MultipartFormRequest que obtenta tambien la imagen.
                         */
                        
                    
                        if (file != null) {
                            file_oficio2 = file.getFileName();
                        
                            request.setAttribute("imagen", "D:\\Imagenes\\"+file_oficio2);
                            request.setAttribute("nombre", file_oficio2);
                            request.setAttribute("tipo",file.getContentType() );
                            request.setAttribute("tamanio", file.getFileSize());
                            
                        }
                        
                } else {
            System.out.println("<li>No uploaded files");
                }
                if (mrequest != null) {
                    /**
                     * Usamos el "mrequest" por que como dije al comienzo, el request normal no funciona
                     * cuando usamos un FORM MULTIPART / FORM-DATA
                     */
                    fecha_llenado = mrequest.getParameter("fecha_llenado");
                    id_ue  = mrequest.getParameter("id_ue");
                    nom_edo = mrequest.getParameter("nom_edo");
                    nombre_muni = mrequest.getParameter("nombre_muni");
                    cve_edo =mrequest.getParameter("cve_edo");
                    name_ue  =mrequest.getParameter("name_ue");
                    fecha_ofic  = mrequest.getParameter("fecha_ofic");
                    fecha_resp  = mrequest.getParameter("fecha_resp");
                    fecha_ofic2  = mrequest.getParameter("fecha_ofic2");
                    fecha_resp2  = mrequest.getParameter("fecha_resp2");
                    fecha_ofic3 = mrequest.getParameter("fecha_ofic3");
                    fecha_resp3  = mrequest.getParameter("fecha_resp3");
                    
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
                       
                      acepto  = mrequest.getParameter("acepto");
                      if(acepto==null){acepto="";}   
                      
                      arrayQue_acepto = mrequest.getParameterValues("que_acepto"); 
                      
                      QueaceptoSeparado = Arrays.toString(arrayQue_acepto);  //Convertimos el array a cadena
                    QueaceptoSeparado = new String(QueaceptoSeparado.substring(1, QueaceptoSeparado.length()-1).getBytes("ISO-8859-1"),"UTF-8");   //le quitamos los corchetes
                    if(QueaceptoSeparado.equals("ul")){QueaceptoSeparado="";} //es ul porque con el .substring de arriba le quita la primera "n"  la y ultima "l" de null 
                    
                    
                     motivo  = mrequest.getParameter("motivo");
                     first_resp  = mrequest.getParameter("first_resp");
                     second_resp  = mrequest.getParameter("second_resp");
                     third_resp  = mrequest.getParameter("third_resp");

                     sin_fechas1 = mrequest.getParameter("sin_fechas1");
                     sin_fechas2 = mrequest.getParameter("sin_fechas2");
                     sin_fechas3 = mrequest.getParameter("sin_fechas3");

                     nom_destinatario = mrequest.getParameter("nom_destinatario");
                     nom_remitente = mrequest.getParameter("nom_remitente");

                     nom_destinatario2 = mrequest.getParameter("nom_destinatario2");
                     nom_remitente2 = mrequest.getParameter("nom_remitente2");

                     nom_destinatario3 = mrequest.getParameter("nom_destinatario3");
                     nom_remitente3 = mrequest.getParameter("nom_remitente3");

                    // Parametro_oficio1 = mrequest.getParameter("file_oficio1");
                   //  Parametro_resp1 = mrequest.getParameter("file_resp1");
                     file_oficio2 = mrequest.getParameter("file_oficio2");
                     file_resp2 = mrequest.getParameter("file_resp2");
                     file_oficio3 = mrequest.getParameter("file_oficio3");
                     file_resp3 = mrequest.getParameter("file_resp3");
                     

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
      
                    
                }
                
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
                
            
               // dispatcher = getServletContext().getRequestDispatcher("/mensaje.jsp");
        
            }
            }catch( UploadException exc){
                System.out.println("Error en lo primero: "+exc.getMessage());
            }
    
            dispatcher.forward(request, response);
    }
        


}
