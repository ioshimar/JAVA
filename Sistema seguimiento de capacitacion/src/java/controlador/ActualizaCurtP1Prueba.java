/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import BaseDatos.ConexionBD;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig

/**
 *
 * @author RICARDO.MACIAS
 */
public class ActualizaCurtP1Prueba extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
 /*   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
         ConexionBD conexion= new ConexionBD(); 
         PrintWriter out = response.getWriter();
        
       List<String> parameterNameList = new ArrayList<String>();
                try {
                    for (Part part : request.getParts()) {
                        if (request.getParameter(part.getName()) != null) {
                            parameterNameList.add(part.getName());
                        }
                    }
                    
                } catch (IOException e) {
                    throw new IllegalArgumentException(e);
                } catch (ServletException e) {
                    throw new IllegalArgumentException(e);
                }
             out.print(parameterNameList);
                
                
    }*/



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
        final Part filePart = request.getPart("file_oficio1");
        String bookId = request.getParameter("id_ue");
 
        InputStream pdfFileBytes = null;
        final PrintWriter writer = response.getWriter();
 
        try {
 
          if (!filePart.getContentType().equals("application/pdf"))
            {
                       writer.println("<br/> Invalid File");
                       return;
            }
 
           else if (filePart.getSize()>1048576 ) { //2mb
               {
              writer.println("<br/> File size too big");
              return;
               }
           }
 
            pdfFileBytes = filePart.getInputStream();  // to get the body of the request as binary data
 
            final byte[] bytes = new byte[pdfFileBytes.available()];
             pdfFileBytes.read(bytes);  //Storing the binary data in bytes array.
 
            Connection  con=null;
             Statement stmt=null;
 
               try {
                     Class.forName("com.mysql.jdbc.Driver");
                     con = DriverManager.getConnection("jdbc:postgresql://10.152.11.61:5434/db_seguimientos","us_seguimientos","normAcAt");
                  } catch (Exception e) {
                        System.out.println(e);
                        System.exit(0);
                              }
 
           
 
                int success=0;
                PreparedStatement pstmt = con.prepareStatement("INSERT INTO Book VALUES(?,?)");
                pstmt.setString(1, bookId);
                pstmt.setBytes(2,bytes);    //Storing binary data in blob field.
                success = pstmt.executeUpdate();
                if(success>=1)  System.out.println("Book Stored");
                 con.close(); 
 
                 writer.println("<br/> Book Successfully Stored");
 
        } catch (FileNotFoundException fnf) {
            writer.println("You  did not specify a file to upload");
            writer.println("<br/> ERROR: " + fnf.getMessage());
 
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
 
            if (pdfFileBytes != null) {
                pdfFileBytes.close();
            }
            if (writer != null) {
                writer.close();
            }
        }
 
    }
    

  
}
