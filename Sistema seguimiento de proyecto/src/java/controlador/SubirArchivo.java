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
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author RICARDO.MACIAS
 */
@MultipartConfig

public class SubirArchivo extends HttpServlet {

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
        
        
        String id_ue = request.getParameter("id_ue");
        String campo = request.getParameter("colum");
        String nom2 ="";
         if(campo.equals("ruta_ofi_env1")){nom2="e1";}
        if(campo.equals("ruta_ofi_recib1")){nom2="r1";}
        if(campo.equals("ruta_ofi_env2")){nom2="e2";}
        if(campo.equals("ruta_ofi_recib2")){nom2="r2";}
        if(campo.equals("ruta_ofi_env3")){nom2="e3";}
        if(campo.equals("ruta_ofi_recib3")){nom2="r3";}
        
        
        
        
     // ...
    List<Part> filePartS = request.getParts().stream().filter(part -> "archivos".equals(part.getName())).collect(Collectors.toList()); // Retrieves <input type="file" name="file" multiple="true">

  //  ArrayList<String> ArrayNameArchivo = new ArrayList<String>(); //Creamos un Array List
     String NombreArchivo ="";
     String  NombreArchivoOriginal="";
     String RutaCarpeta ="";
     String NombreCarpeta = id_ue;
     
        for (Part filePart : filePartS) { 

            NombreArchivoOriginal = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
            
          
            NombreArchivo = NombreArchivoOriginal.replaceAll("\\s",""); //quitar espacios para evitar problemas al descargar
            NombreArchivo = new String(NombreArchivo.getBytes("ISO-8859-1"),"UTF-8"); //corregimos lo de los acentos
            
                 //^ Negación
                //\\d DíDgitos [0-9]
                //A-Za-z Letras mayúsculas como minúsculas
        //Eliminamos todos los caracteres raros que NO sean Letras, números, acentos o puntos y todos los caracteres que estan dentro de los corchetes (para que acepte el .pdf)        
            NombreArchivo = NombreArchivo.replaceAll("[^\\dA-Za-záéíóúÁÉÍÓÚ.()_]", ""); 
              
          //System.out.println(NombreArchivo);
        //  ArrayNameArchivo.add(NombreArchivo);
           NombreArchivo = id_ue+"_"+nom2+"_"+NombreArchivo; //le concatenamos el id al nombre del archivo
            
            InputStream  ContenidoDocumento = filePart.getInputStream();  //Contenido del Archivo
          
            
           // RutaCarpeta = getServletContext().getRealPath("/")+ "/archivos/"+NombreCarpeta;
           // RutaCarpeta =  "d:/archivos_segcurt/"+NombreCarpeta;
              RutaCarpeta = getServletContext().getRealPath("/")+"../../web/archivos/";
      
         
          
        
             File Archivo = new File(RutaCarpeta, NombreArchivo);
             
              if (!Archivo.exists()) { //si no existe
                    Archivo.mkdirs();     
                }
              
              try (InputStream input = ContenidoDocumento) {
                     Files.copy(input, Archivo.toPath(),StandardCopyOption.REPLACE_EXISTING);
                }catch (IOException e) {
                    //   out.print("Error al subir Oficio 1");
                      // out.println(e);
                       e.printStackTrace();
                }
            
             // out.print(NombreArchivo);
         }
    /*  out.println("Nombre archivo: "+NombreArchivo);
      out.println("ID: "+id_ue);
      out.println("Ruta: "+RutaCarpeta);
        */
      
    //String NuevaRuta = "archivos/"+NombreCarpeta+"/"+NombreArchivo;
   //String NuevaRuta = RutaCarpeta+"/"+NombreArchivo;
       String NuevaRuta = "archivos/"+NombreArchivo;
      
      
       
        try {
                    
        conexion.stmt=conexion.conn.createStatement();
        conexion.stmt.executeUpdate("SET DATESTYLE TO dmy; UPDATE \"seguim_CURT\".concertacion\n" +
                                "   SET  "+campo+" ='"+NuevaRuta+"' "
                              + "  WHERE id_ue = '"+id_ue+"'");
                     
                   out.print("Archivo enviado correctamente");
                //response.sendRedirect("curt_p1.jsp?ue="+id_ue);
                       
        }catch (Exception ex) {
                        out.print("Error al conectar a la base de datos ");
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
