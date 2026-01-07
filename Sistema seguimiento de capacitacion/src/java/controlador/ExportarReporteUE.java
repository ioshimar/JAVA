/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.SQLException;
import java.sql.ResultSet;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

 import java.io.OutputStream;
import java.io.ByteArrayOutputStream;
 import org.apache.poi.ss.util.CellRangeAddress;
import java.io.FileOutputStream;

import java.sql.PreparedStatement;
import BaseDatos.ConexionBD;
import static java.lang.System.out;

/**
 *
 * @author RICARDO.MACIAS
 */
public class ExportarReporteUE extends HttpServlet {

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
        ConexionBD conexion=new ConexionBD();
        ConexionBD conexion2=new ConexionBD();

    String idue = request.getParameter("ue");
 
    //String idparametro="";
    //int idpar= Integer.parseInt(mun1);
    //out.println("elemeto seleccionado"+mun1);
    /*PreparedStatement pst1 =(PreparedStatement) conexion.conn.prepareStatement( "select \"CVE_EDO\" from db_directorio.cat_edo where \"NOM_EDO\"='"+mun1+"'");
    conexion.rs =pst1.executeQuery();
    while(conexion.rs.next()){
        idparametro=conexion.rs.getString("CVE_EDO");
    }¨*/
  
        //    Properties props = System.getProperties();
        //    props.setProperty("java.awt.headless","true");  
            
        //    Properties props = System.getProperties();
        //    props.setProperty("java.awt.headless","true");  
            
        XSSFWorkbook objLibro = new XSSFWorkbook();//creacion del documento
        XSSFSheet hoja1 = objLibro.createSheet("hoja1");// Creo la hoja

          
      
  
        XSSFRow Encabezado = hoja1.createRow((short)1); 
        XSSFRow FilaSubtitulo = hoja1.createRow((short)4); 
        
        XSSFRow fila = hoja1.createRow((short)8); // creo la fila.
        XSSFRow fila1 = hoja1.createRow((short)9);
         fila1.setHeight((short)0x100);
       
         XSSFRow fila14 = hoja1.createRow((short)14); 
         XSSFRow fila15 = hoja1.createRow((short)15);
         XSSFRow fila16 = hoja1.createRow((short)16); 
         XSSFRow fila18 = hoja1.createRow((short)18);
         XSSFRow fila19 = hoja1.createRow((short)19);
                 fila19.setHeight((short)0x300);
         XSSFRow fila21 = hoja1.createRow((short)21);    
         XSSFRow fila23 = hoja1.createRow((short)23); 
        // XSSFRow fila24 = hoja1.createRow((short)24); 
         XSSFRow fila25 = hoja1.createRow((short)25); 
         XSSFRow fila29 = hoja1.createRow((short)29); 
         XSSFRow fila31 = hoja1.createRow((short)31); 
                 fila31.setHeight((short)0x180);
         XSSFRow fila32 = hoja1.createRow((short)32); 
                 fila32.setHeight((short)0x180);
         XSSFRow fila33 = hoja1.createRow((short)33);
                 fila33.setHeight((short)0x180);
         XSSFRow fila34 = hoja1.createRow((short)34);
         XSSFRow fila35 = hoja1.createRow((short)35); 
         XSSFRow fila37 = hoja1.createRow((short)37); 
         XSSFRow fila39 = hoja1.createRow((short)39); 
         
        // establecer estilos a las celdas para encabezados.
        // tipo de fuente
        //Inmovilizar 0 columnas y 3 filas
        //hoja1.createFreezePane(4,4);  //Inmovilizar columnas    0 columnas inmovilizadas, y el 3  filas inmovilizadas  
        
        XSSFFont fuente = objLibro.createFont();
        fuente.setFontHeightInPoints((short)12);
        fuente.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);//LETRA NEGRITA
        //fuente.setColor(IndexedColors.WHITE.getIndex());
        
        XSSFFont fuenteWhite = objLibro.createFont();
        fuenteWhite.setFontHeightInPoints((short)12);
        fuenteWhite.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);//LETRA NEGRITA
        fuenteWhite.setColor(IndexedColors.WHITE.getIndex());
        
        XSSFFont fuenteGray = objLibro.createFont();
        fuenteGray.setFontHeightInPoints((short)12);
        fuenteGray.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);//LETRA NEGRITA
        fuenteGray.setColor(IndexedColors.GREY_40_PERCENT.getIndex());
        
        
        XSSFFont fuente2 = objLibro.createFont();// tipo de fuente
        fuente2.setFontHeightInPoints((short)10);
        fuente2.setBoldweight(XSSFFont.BOLDWEIGHT_NORMAL);//LETRA NEGRITA
        
         XSSFFont fuenteBold = objLibro.createFont();// tipo de fuente
        fuenteBold.setFontHeightInPoints((short)11);
        fuenteBold.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);//LETRA NEGRITA
        
         XSSFFont fuenteCursiva= objLibro.createFont();// tipo de fuente
        fuenteCursiva.setFontHeightInPoints((short)11);
        fuenteCursiva.setItalic(true);
      
        XSSFCellStyle estiloCelda = objLibro.createCellStyle();// Creamos el objeto de estilo para la celda
        //estiloCelda.setWrapText(true);
        byte[] rgbTitulos = new byte[3];
            rgbTitulos[0] = (byte) 147; // red
            rgbTitulos[1] = (byte) 207; // green
            rgbTitulos[2] = (byte) 79; // blue
            
        byte[] rgbEncabezado = new byte[3];
                rgbEncabezado[0] = (byte) 34; // red
                rgbEncabezado[1] = (byte) 89; // green
                rgbEncabezado[2] = (byte) 102; // blue    
        XSSFColor ColorEncabezado = new XSSFColor(rgbEncabezado); // #f2dcdb       
        
        
         byte[] rgbAzul= new byte[3];
                rgbAzul[0] = (byte) 0; // red
                rgbAzul[1] = (byte) 103; // green
                rgbAzul[2] = (byte) 179; // blue    
        XSSFColor ColorAzul = new XSSFColor(rgbAzul); // #f2dcdb       
            
        estiloCelda.setAlignment(XSSFCellStyle.ALIGN_CENTER);
        estiloCelda.setFont(fuente);
        estiloCelda.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
        //Establecer bordes
        estiloCelda.setBorderBottom(XSSFCellStyle.BORDER_MEDIUM);
        estiloCelda.setBottomBorderColor((short)8);
        estiloCelda.setBorderLeft(XSSFCellStyle.BORDER_MEDIUM);
        estiloCelda.setLeftBorderColor((short)8);
        estiloCelda.setBorderRight(XSSFCellStyle.BORDER_MEDIUM);
        estiloCelda.setRightBorderColor((short)8);
        estiloCelda.setBorderTop(XSSFCellStyle.BORDER_MEDIUM);
        estiloCelda.setTopBorderColor((short)8);
        // Establecemos el tipo de sombreado de nuestra celda
        XSSFColor ColorTit = new XSSFColor(rgbTitulos); // #f2dcdb
        estiloCelda.setFillForegroundColor(ColorTit);
        estiloCelda.setFillPattern(estiloCelda.SOLID_FOREGROUND);
        
          XSSFCellStyle estiloCeldaCebra = objLibro.createCellStyle();// Creamos el objeto de estilo para celda
          byte[] rgb = new byte[3];
            rgb[0] = (byte) 226; // red
            rgb[1] = (byte) 239; // green
            rgb[2] = (byte) 217; // blue
        estiloCeldaCebra.setAlignment(XSSFCellStyle.ALIGN_LEFT);
        estiloCeldaCebra.setFont(fuente2);
        estiloCeldaCebra.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
        // establecer bordes
        estiloCeldaCebra.setBorderBottom(XSSFCellStyle.BORDER_THIN);
        estiloCeldaCebra.setBottomBorderColor((short)22);
        estiloCeldaCebra.setBorderLeft(XSSFCellStyle.BORDER_THIN);
        estiloCeldaCebra.setLeftBorderColor((short)22);
        estiloCeldaCebra.setBorderRight(XSSFCellStyle.BORDER_THIN);
        estiloCeldaCebra.setRightBorderColor((short)22);
        estiloCeldaCebra.setBorderTop(XSSFCellStyle.BORDER_THIN);
        estiloCeldaCebra.setTopBorderColor((short)22);
        // Establecemos el tipo de sombreado de nuestra celda
        XSSFColor myColor = new XSSFColor(rgb); // #f2dcdb
        estiloCeldaCebra.setFillForegroundColor(myColor);
        estiloCeldaCebra.setFillPattern(estiloCeldaCebra.SOLID_FOREGROUND);
        
        
         XSSFCellStyle estiloCeldas = objLibro.createCellStyle();// Creamos el objeto de estilo para celda
         
        estiloCeldas.setAlignment(XSSFCellStyle.ALIGN_CENTER);
        estiloCeldas.setFont(fuente2);
        estiloCeldas.setVerticalAlignment(XSSFCellStyle.VERTICAL_JUSTIFY);
        // establecer bordes
        estiloCeldas.setBorderBottom(XSSFCellStyle.BORDER_THIN);
        estiloCeldas.setBottomBorderColor((short)8);
        estiloCeldas.setBorderLeft(XSSFCellStyle.BORDER_THIN);
        estiloCeldas.setLeftBorderColor((short)8);
        estiloCeldas.setBorderRight(XSSFCellStyle.BORDER_THIN);
        estiloCeldas.setRightBorderColor((short)8);
        estiloCeldas.setBorderTop(XSSFCellStyle.BORDER_THIN);
        estiloCeldas.setTopBorderColor((short)8);
        // Establecemos el tipo de sombreado de nuestra celda
        estiloCeldas.setFillForegroundColor((short)9);
        estiloCeldas.setFillPattern(estiloCeldas.SOLID_FOREGROUND);
        
        
        
         XSSFCellStyle estiloCeldas2 = objLibro.createCellStyle();// Creamos el objeto de estilo para celda
         
        estiloCeldas2.setAlignment(XSSFCellStyle.ALIGN_CENTER);
        estiloCeldas2.setFont(fuente2);
        estiloCeldas2.setVerticalAlignment(XSSFCellStyle.VERTICAL_JUSTIFY);
        // establecer bordes
        estiloCeldas2.setBorderBottom(XSSFCellStyle.BORDER_THIN);
        estiloCeldas2.setBottomBorderColor((short)22);
        estiloCeldas2.setBorderLeft(XSSFCellStyle.BORDER_THIN);
        estiloCeldas2.setLeftBorderColor((short)55);
        estiloCeldas2.setBorderRight(XSSFCellStyle.BORDER_THIN);
        estiloCeldas2.setRightBorderColor((short)55);
        estiloCeldas2.setBorderTop(XSSFCellStyle.BORDER_THIN);
        estiloCeldas2.setTopBorderColor((short)22);
        // Establecemos el tipo de sombreado de nuestra celda
        estiloCeldas2.setFillForegroundColor((short)9);
        estiloCeldas2.setFillPattern(estiloCeldas2.SOLID_FOREGROUND);
        
        
        
        XSSFCellStyle estiloCeldas3 = objLibro.createCellStyle();// Creamos el objeto de estilo para celda
          byte[] rgbCebra = new byte[3];
            rgb[0] = (byte) 242; // red
            rgb[1] = (byte) 242; // green
            rgb[2] = (byte) 242; // blue
         
        estiloCeldas3.setAlignment(XSSFCellStyle.ALIGN_CENTER);
        estiloCeldas3.setFont(fuente2);
        estiloCeldas3.setVerticalAlignment(XSSFCellStyle.VERTICAL_JUSTIFY);
        // establecer bordes
        estiloCeldas3.setBorderBottom(XSSFCellStyle.BORDER_THIN);
        estiloCeldas3.setBottomBorderColor((short)8);
        estiloCeldas3.setBorderLeft(XSSFCellStyle.BORDER_THIN);
        estiloCeldas3.setLeftBorderColor((short)8);
        estiloCeldas3.setBorderRight(XSSFCellStyle.BORDER_THIN);
        estiloCeldas3.setRightBorderColor((short)8);
        estiloCeldas3.setBorderTop(XSSFCellStyle.BORDER_THIN);
        estiloCeldas3.setTopBorderColor((short)8);
        // Establecemos el tipo de sombreado de nuestra celda
         XSSFColor myColorCebra = new XSSFColor(rgb); // #f2dcdb
        estiloCeldas3.setFillForegroundColor(myColorCebra);
        estiloCeldas3.setFillPattern(estiloCeldas3.SOLID_FOREGROUND);
        
        
        /*Estilos BOLD*/
            XSSFCellStyle estiloCeldasBold = objLibro.createCellStyle();// Creamos el objeto de estilo para celda
         
        estiloCeldasBold.setAlignment(XSSFCellStyle.ALIGN_LEFT);
        estiloCeldasBold.setFont(fuenteBold);
        estiloCeldasBold.setVerticalAlignment(XSSFCellStyle.VERTICAL_JUSTIFY);
        // establecer bordes
        estiloCeldasBold.setBorderBottom(XSSFCellStyle.BORDER_THIN);
        estiloCeldasBold.setBottomBorderColor((short)22);
        estiloCeldasBold.setBorderLeft(XSSFCellStyle.BORDER_THIN);
        estiloCeldasBold.setLeftBorderColor((short)22);
        estiloCeldasBold.setBorderRight(XSSFCellStyle.BORDER_THIN);
        estiloCeldasBold.setRightBorderColor((short)22);
        estiloCeldasBold.setBorderTop(XSSFCellStyle.BORDER_THIN);
        estiloCeldasBold.setTopBorderColor((short)22);
        // Establecemos el tipo de sombreado de nuestra celda
      //  XSSFColor myColor = new XSSFColor(rgb); // #f2dcdb
        estiloCeldasBold.setFillForegroundColor((short)9);
        estiloCeldasBold.setFillPattern(estiloCeldasBold.SOLID_FOREGROUND);
        
        
          /*Estilos BOLD RIGHT*/
            XSSFCellStyle estiloCeldasBold_Right = objLibro.createCellStyle();// Creamos el objeto de estilo para celda
         
        estiloCeldasBold_Right.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
        estiloCeldasBold_Right.setFont(fuenteBold);
        estiloCeldasBold_Right.setVerticalAlignment(XSSFCellStyle.VERTICAL_JUSTIFY);
        // establecer bordes
        estiloCeldasBold_Right.setBorderBottom(XSSFCellStyle.BORDER_THIN);
        estiloCeldasBold_Right.setBottomBorderColor((short)22);
        estiloCeldasBold_Right.setBorderLeft(XSSFCellStyle.BORDER_THIN);
        estiloCeldasBold_Right.setLeftBorderColor((short)22);
        estiloCeldasBold.setBorderRight(XSSFCellStyle.BORDER_THIN);
        estiloCeldasBold_Right.setRightBorderColor((short)22);
        estiloCeldasBold_Right.setBorderTop(XSSFCellStyle.BORDER_THIN);
        estiloCeldasBold_Right.setTopBorderColor((short)22);
        // Establecemos el tipo de sombreado de nuestra celda
      //  XSSFColor myColor = new XSSFColor(rgb); // #f2dcdb
        estiloCeldasBold_Right.setFillForegroundColor((short)9);
        estiloCeldasBold_Right.setFillPattern(estiloCeldasBold.SOLID_FOREGROUND);
        
        
        
        
        
        
        
         /*Estilos BOLD*/
            XSSFCellStyle estiloCeldaCursiva = objLibro.createCellStyle();// Creamos el objeto de estilo para celda
         
        estiloCeldaCursiva.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
        estiloCeldaCursiva.setFont(fuenteCursiva);
        estiloCeldaCursiva.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
        // establecer bordes
        estiloCeldaCursiva.setBorderBottom(XSSFCellStyle.BORDER_THIN);
        estiloCeldaCursiva.setBottomBorderColor((short)22);
        estiloCeldasBold.setBorderLeft(XSSFCellStyle.BORDER_THIN);
        estiloCeldaCursiva.setLeftBorderColor((short)22);
        estiloCeldaCursiva.setBorderRight(XSSFCellStyle.BORDER_THIN);
        estiloCeldaCursiva.setRightBorderColor((short)22);
        estiloCeldaCursiva.setBorderTop(XSSFCellStyle.BORDER_THIN);
        estiloCeldaCursiva.setTopBorderColor((short)22);
        // Establecemos el tipo de sombreado de nuestra celda
      
        estiloCeldaCursiva.setFillForegroundColor((short)9);
        estiloCeldaCursiva.setFillPattern(estiloCeldasBold.SOLID_FOREGROUND);
        
        
        /*Estilo celda encabezado*/
        XSSFCellStyle estiloCeldaEncabezado = objLibro.createCellStyle();
            estiloCeldaEncabezado.setAlignment(XSSFCellStyle.ALIGN_CENTER);
            estiloCeldaEncabezado.setFont(fuenteWhite);
            estiloCeldaEncabezado.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
            estiloCeldaEncabezado.setFillForegroundColor(ColorEncabezado);
            estiloCeldaEncabezado.setFillPattern(estiloCeldaEncabezado.SOLID_FOREGROUND);
            
        XSSFCellStyle estiloCeldaSubtitulo = objLibro.createCellStyle();
            estiloCeldaSubtitulo.setAlignment(XSSFCellStyle.ALIGN_CENTER);
            estiloCeldaSubtitulo.setFont(fuenteGray);
            estiloCeldaSubtitulo.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
       
        
            
          /*Estilo celda encabezado*/
        XSSFCellStyle estiloCeldaAzul = objLibro.createCellStyle();
            estiloCeldaAzul.setAlignment(XSSFCellStyle.ALIGN_CENTER);
            estiloCeldaAzul.setFont(fuenteWhite);
            estiloCeldaAzul.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
            estiloCeldaAzul.setFillForegroundColor(ColorAzul);
            estiloCeldaAzul.setFillPattern(estiloCeldaAzul.SOLID_FOREGROUND);    
        
        
        
        //ARRIBA
        XSSFCellStyle estiloTituloVerde = objLibro.createCellStyle();
        estiloTituloVerde.setAlignment(XSSFCellStyle.ALIGN_LEFT);
        estiloTituloVerde.setFont(fuente);
        estiloTituloVerde.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
        // establecer bordes...
      /*  estiloTituloVerde.setBorderLeft(XSSFCellStyle.BORDER_MEDIUM);
        estiloTituloVerde.setLeftBorderColor((short)8);
        estiloTituloVerde.setBorderRight(XSSFCellStyle.BORDER_MEDIUM);
        estiloTituloVerde.setRightBorderColor((short)8);
        estiloTituloVerde.setBorderTop(XSSFCellStyle.BORDER_MEDIUM);
        estiloTituloVerde.setTopBorderColor((short)8);*/
        
        // Establecemos el tipo de sombreado de nuestra celda
          estiloTituloVerde.setFillForegroundColor(ColorTit);
        estiloTituloVerde.setFillPattern(estiloTituloVerde.SOLID_FOREGROUND);
        
        //ABAJO
        XSSFCellStyle estiloCeldaAbajo = objLibro.createCellStyle();
        estiloCeldaAbajo.setAlignment(XSSFCellStyle. ALIGN_CENTER);
        estiloCeldaAbajo.setFont(fuente);
        estiloCeldaAbajo.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
        // establecer bordes...
        estiloCeldaAbajo.setBorderBottom(XSSFCellStyle.BORDER_MEDIUM);
        estiloCeldaAbajo.setBottomBorderColor((short)8);
        estiloCeldaAbajo.setBorderLeft(XSSFCellStyle.BORDER_MEDIUM);
        estiloCeldaAbajo.setLeftBorderColor((short)8);
        estiloCeldaAbajo.setBorderRight(XSSFCellStyle.BORDER_MEDIUM);
        estiloCeldaAbajo.setRightBorderColor((short)8);
        // Establecemos el tipo de sombreado de nuestra celda
        estiloCeldaAbajo.setFillForegroundColor(ColorTit);
        estiloCeldaAbajo.setFillPattern(estiloCeldaAbajo.SOLID_FOREGROUND);
        

       
    String id_concer, id_ue, nom_ent, cve_ent, nom_ue, fec_pri_env, fec_pri_res, 
       fec_seg_env, fec_seg_res, acepto, que_acepto, motivo, fecha_llenado, 
       fecha_actualizacion, respuesta1, respuesta2, fechas_primer_oficio, 
       fechas_segundo_oficio, fec_ter_env, fec_ter_res, respuesta3, 
       fechas_tercer_oficio, nombre_destin1, nombre_remi1, nombre_destin2, 
       nombre_remi2, nombre_destin3, nombre_remi3, ruta_ofi_env1, ruta_ofi_recib1, 
       ruta_ofi_env2, ruta_ofi_recib2, ruta_ofi_env3, ruta_ofi_recib3, municipio,
        /*Capacitacion*/
      id_cap, fecha_cap, lugar, resp_inegi, cant_pers, fecha_llenado_P2, 
       fecha_actualizacion_P2,
       /*registro usuarios*/
        fec_sol_reg, fec_env_doc, fec_rec_doc,
        /*Entrega fisica*/
    fecha_entfis, nom_resp_ent, unidad_admin, nom_resp_rec, medio, nom_archivo, tamano, total_reg,
        /*Devolución*/
    fecha_dev, nom_resp_dev, nom_rec_dev, arch_dev, total_regdev, motivos_dev,
    //asesoria
    tipo_asesoria,
    //Generacion CURT
    fech_ini10, fech_fin10, pred_concurt, pred_sincurt, nom_archivo10, id_gen10, mot_gen, tot_gen,
   //Datos Entrega 12
    tipo_entrega12,fec_dr,fec_ue,arch_dr,arch_ue,cant_dr,cant_ue, nom_resp_ocent, nom_resp_drec, nom_resp_drent, nom_resp_uerec,
    //Constancia
    fec_sol, fec_emi, folio_cons
    
    ; 
     
   
  try{       
    PreparedStatement pst2=(PreparedStatement)conexion.conn.prepareStatement("SELECT id_concer, id_ue, nom_ent, cve_ent, nom_ue, TO_CHAR(fec_pri_env, 'dd/MM/yyyy') as fec_pri_env,  TO_CHAR(fec_pri_res, 'dd/MM/yyyy') as fec_pri_res, \n" +
"       TO_CHAR(fec_seg_env, 'dd/MM/yyyy') as fec_seg_env,  TO_CHAR(fec_seg_res, 'dd/MM/yyyy') as fec_seg_res, acepto, que_acepto, motivo, TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado, \n" +
"       TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as fecha_actualizacion, respuesta1, respuesta2, fechas_primer_oficio, fechas_segundo_oficio,   TO_CHAR(fec_ter_env, 'dd/MM/yyyy') as fec_ter_env, TO_CHAR(fec_ter_res, 'dd/MM/yyyy') as fec_ter_res, respuesta3, fechas_tercer_oficio,"
                + " nombre_destin1, nombre_remi1, nombre_destin2, nombre_remi2, nombre_destin3, nombre_remi3, ruta_ofi_env1, ruta_ofi_recib1, ruta_ofi_env2, ruta_ofi_recib2, ruta_ofi_env3, ruta_ofi_recib3, municipio FROM \"seguim_CURT\".concertacion WHERE id_ue = '"+idue+"'"  ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst2.executeQuery();
    
    if(conexion.rs.next()){//SI encontró algo imprimimos lso encabezados...
     
       
         
     //  conexion.rs.beforeFirst(); //ESTE REGRESA el cursor a la primera fila que devuelve el ResulsSet (lo resetea)..., pero
                                //pero para que este funcione se debe agregar esta línea despues de la conuslta: ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE   
  //  while(conexion.rs.next()){
        nom_ent= conexion.rs.getString("nom_ent");
         if(nom_ent==null){nom_ent="";}
         
        nom_ue= conexion.rs.getString("nom_ue");
        if(nom_ue==null){nom_ue="";}
        
        municipio=conexion.rs.getString("municipio");
        if(municipio==null){municipio="";}
        
        fec_pri_env = conexion.rs.getString("fec_pri_env");
        if(fec_pri_env==null || fec_pri_env.equals("01/01/0001")) {fec_pri_env="";}
        
        fec_pri_res = conexion.rs.getString("fec_pri_res");
        if(fec_pri_res==null || fec_pri_res.equals("01/01/0001")){fec_pri_res="";}
        
        fec_seg_env = conexion.rs.getString("fec_seg_env");
        if(fec_seg_env==null || fec_seg_env.equals("01/01/0001")){fec_seg_env="";}
        
        fec_seg_res = conexion.rs.getString("fec_seg_res");
        if(fec_seg_res==null || fec_seg_res.equals("01/01/0001")){fec_seg_res="";}
        
         fec_ter_env = conexion.rs.getString("fec_ter_env");
        if(fec_ter_env==null || fec_ter_env.equals("01/01/0001") ){fec_ter_env="";}
        
        fec_ter_res = conexion.rs.getString("fec_ter_res");
        if(fec_ter_res==null || fec_ter_res.equals("01/01/0001")){fec_ter_res="";}
        
        
        nombre_destin1 = conexion.rs.getString("nombre_destin1");
        if(nombre_destin1==null ){nombre_destin1="";}
        
        nombre_remi1= conexion.rs.getString("nombre_remi1");
        if(nombre_remi1==null){nombre_remi1="";}
        
        
        nombre_destin2 = conexion.rs.getString("nombre_destin2");
        if(nombre_destin2==null ){nombre_destin2="";}
        
        nombre_remi2= conexion.rs.getString("nombre_remi2");
        if(nombre_remi2==null){nombre_remi2="";}
        
         nombre_destin3 = conexion.rs.getString("nombre_destin3");
        if(nombre_destin3==null ){nombre_destin3="";}
        
        nombre_remi3= conexion.rs.getString("nombre_remi3");
        if(nombre_remi3==null){nombre_remi3="";}
        
        respuesta1= conexion.rs.getString("respuesta1");
        if(respuesta1==null || respuesta1.equals("SI")){respuesta1="   ";}
        else if(respuesta1.equals("NO")){ respuesta1 = "Sin Respuesta";}
        
        respuesta2= conexion.rs.getString("respuesta2");
        if(respuesta2==null || respuesta2.equals("SI")){respuesta2="     ";}
        else if(respuesta2.equals("NO")){ respuesta2 = "Sin Respuesta";}
        
        respuesta3= conexion.rs.getString("respuesta3");
        if(respuesta3 == null || respuesta3.equals("SI") || respuesta3.equals("null") ){respuesta3="    ";}
        else if(respuesta3.equals("NO")){ respuesta3 = "Sin Respuesta";}
        
        
        acepto = conexion.rs.getString("acepto");
        if(acepto==null){acepto="";}
        
        que_acepto = conexion.rs.getString("que_acepto");
        if(que_acepto==null){que_acepto="";}
        
        motivo = conexion.rs.getString("motivo");
        if(motivo==null){motivo="";}
        

        
        /*ENCABEZADOS CAMPOS */
        
         XSSFCell celdaEncabezado = Encabezado.createCell(1);
    celdaEncabezado.setCellValue("SISTEMA DE SEGUIMIENTO DE LA CLAVE ÚNICA DEL REGISTRO DEL TERRITORIO");
    celdaEncabezado.setCellStyle(estiloCeldaEncabezado); 
    hoja1.addMergedRegion(new CellRangeAddress(1,3,1,9)); //fila,fila,columna,columna
    
    XSSFCell celdaSubtitulo = FilaSubtitulo.createCell(1);
        celdaSubtitulo.setCellValue("Informe de la instrumentación  de la CURT por Unidad del Estado");
        celdaSubtitulo.setCellStyle(estiloCeldaSubtitulo); 
        hoja1.addMergedRegion(new CellRangeAddress(4,5,1,9)); //fila,fila,columna,columna

    
                
    
    XSSFRow Filatitulo = hoja1.createRow((short)6);
    Filatitulo.setHeight((short)0x190);
        XSSFCell celda0 = Filatitulo.createCell(1);
        celda0.setCellValue("DATOS DE LA UNIDAD DEL ESTADO");
         celda0.setCellStyle(estiloTituloVerde);  
        hoja1.addMergedRegion(new CellRangeAddress(6,6,1,9)); //fila,fila,columna,columna
 

         XSSFCell celda = fila.createCell(2);
         celda.setCellValue("Nombre");
         celda.setCellStyle(estiloCeldasBold);
         
         XSSFCell celda2 = fila.createCell(3);
         celda2.setCellValue("Entidad");
         celda2.setCellStyle(estiloCeldasBold);
         
          XSSFCell celda3 = fila.createCell(4);
         celda3.setCellValue("Municipio");
         celda3.setCellStyle(estiloCeldasBold);
         
         /*CONCERTACIÓN*/
    XSSFRow FilatituloConcertacion = hoja1.createRow((short)11);
    FilatituloConcertacion.setHeight((short)0x190);
        XSSFCell celdaTitConcert = FilatituloConcertacion.createCell(1);
        celdaTitConcert.setCellValue("CONCERTACIÓN");
         celdaTitConcert.setCellStyle(estiloTituloVerde);  
        hoja1.addMergedRegion(new CellRangeAddress(11,11,1,9)); //fila,fila,columna,columna
        
        XSSFRow fila13 = hoja1.createRow((short)13);
        XSSFCell celdaFechEnv = fila13.createCell(2);
        celdaFechEnv.setCellValue("Fecha de envío del oficio");
        celdaFechEnv.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaFechResp = fila13.createCell(3);
        celdaFechResp.setCellValue("Fecha de respuesta");
        celdaFechResp.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaRemitente= fila13.createCell(4);
        celdaRemitente.setCellValue("Nombre del remitente");
        celdaRemitente.setCellStyle(estiloCeldasBold);
        
        
        XSSFCell celdaDestin= fila13.createCell(5);
        celdaDestin.setCellValue("Nombre del destinatario");
        celdaDestin.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaOficio1= fila14.createCell(1);
        celdaOficio1.setCellValue("1° Oficio");
        celdaOficio1.setCellStyle(estiloCeldaCursiva);
        
        XSSFCell celdaOficio2= fila15.createCell(1);
        celdaOficio2.setCellValue("2° Oficio");
        celdaOficio2.setCellStyle(estiloCeldaCursiva);
        
        XSSFCell celdaOficio3= fila16.createCell(1);
        celdaOficio3.setCellValue("3° Oficio");
        celdaOficio3.setCellStyle(estiloCeldaCursiva);
        
        XSSFCell celdaB18= fila18.createCell(1);
        celdaB18.setCellValue("¿Aceptó?");
        celdaB18.setCellStyle(estiloCeldasBold);
        
        
        XSSFCell celdaC18= fila18.createCell(2);
        celdaC18.setCellValue("¿Qué aceptó?");
        celdaC18.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaD18= fila18.createCell(3);
        celdaD18.setCellValue("Razones por las que la UE NO aceptó");
        celdaD18.setCellStyle(estiloCeldasBold);
        /* TEMINAN LOS ENCABEZADOS DE CAMPOS*/
        
        
        
    

        XSSFCell celda4 = fila1.createCell(2);
        celda4.setCellValue(nom_ue);
        celda4.setCellStyle(estiloCeldas); 
        

        XSSFCell celda5 = fila1.createCell(3);
         celda5.setCellValue(nom_ent);
         celda5.setCellStyle(estiloCeldas); 
         
        XSSFCell celda6 = fila1.createCell(4);
         celda6.setCellValue(municipio); 
         celda6.setCellStyle(estiloCeldas); 
       
       if(!fec_pri_env.equals("")){}  
         XSSFCell celdaC14= fila14.createCell(2);
         celdaC14.setCellValue(fec_pri_env); 
         celdaC14.setCellStyle(estiloCeldas);  
             
         XSSFCell celdaD14= fila14.createCell(3);
         celdaD14.setCellValue(fec_pri_res); 
         celdaD14.setCellStyle(estiloCeldas);  
         
        XSSFCell celdaE14= fila14.createCell(4);
         celdaE14.setCellValue(nombre_destin1); 
         celdaE14.setCellStyle(estiloCeldas);  
         
        XSSFCell celdaF14= fila14.createCell(5);
         celdaF14.setCellValue(nombre_remi1); 
         celdaF14.setCellStyle(estiloCeldas);  
         
         
         XSSFCell celdaC15= fila15.createCell(2);
         celdaC15.setCellValue(fec_seg_env); 
         celdaC15.setCellStyle(estiloCeldas);   
         
         XSSFCell celdaD15= fila15.createCell(3);
         celdaD15.setCellValue(fec_seg_res); 
         celdaD15.setCellStyle(estiloCeldas); 
         
         XSSFCell celdaE15= fila15.createCell(4);
         celdaE15.setCellValue(nombre_destin2); 
         celdaE15.setCellStyle(estiloCeldas);  
         
         XSSFCell celdaF15= fila15.createCell(5);
         celdaF15.setCellValue(nombre_remi2); 
         celdaF15.setCellStyle(estiloCeldas);  
         
         
         
          XSSFCell celdaC16= fila16.createCell(2);
         celdaC16.setCellValue(fec_ter_env); 
         celdaC16.setCellStyle(estiloCeldas);   
         
         XSSFCell celdaD16= fila16.createCell(3);
         celdaD16.setCellValue(fec_ter_res); 
         celdaD16.setCellStyle(estiloCeldas); 
         
         XSSFCell celdaE16= fila16.createCell(4);
         celdaE16.setCellValue(nombre_destin3); 
         celdaE16.setCellStyle(estiloCeldas);  
         
         XSSFCell celdaF16= fila16.createCell(5);
         celdaF16.setCellValue(nombre_remi3); 
         celdaF16.setCellStyle(estiloCeldas);  
         
         
        /* XSSFCell celdaG14= fila14.createCell(7);
         celdaG14.setCellValue(respuesta1); 
         
        XSSFCell celdaG15= fila15.createCell(7);
         celdaG15.setCellValue(respuesta2); 
         
         XSSFCell celdaG16= fila16.createCell(7);
         celdaG16.setCellValue(respuesta3);  */
         
         
         XSSFCell celdaB19= fila19.createCell(1);
         celdaB19.setCellValue(acepto);   
         celdaB19.setCellStyle(estiloCeldas); 
         
       if(acepto.equals("SI")){ 
            XSSFCell celdaC19= fila19.createCell(2);
            celdaC19.setCellValue(que_acepto);   
            celdaC19.setCellStyle(estiloCeldas); 
         } 
       
       else if(acepto.equals("NO")){   
        XSSFCell celdaD19= fila19.createCell(3);
         celdaD19.setCellValue(motivo);   
         celdaD19.setCellStyle(estiloCeldas);
        hoja1.addMergedRegion(new CellRangeAddress(19,19,3,9)); //fila,fila,columna,columna 
             XSSFCell celdaE19= fila19.createCell(4);
             celdaE19.setCellStyle(estiloCeldas);
             XSSFCell celdaF19= fila19.createCell(5);
             celdaF19.setCellStyle(estiloCeldas);
              XSSFCell celdaG19= fila19.createCell(6);
             celdaG19.setCellStyle(estiloCeldas);
     }
     
     
    
  // }       
   }
    
    else{} 
    
    
  }  catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
                       // conexion.closeConnection();
                    }    
  

       

    
  


  try{       
    PreparedStatement pst3=(PreparedStatement)conexion.conn.prepareStatement("SELECT id_cap, id_ue, TO_CHAR(fecha_cap, 'dd/MM/yyyy') as fecha_cap, lugar, resp_inegi, cant_pers, TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado, TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as  fecha_actualizacion\n" +
"  FROM \"seguim_CURT\".capacitacion  WHERE id_ue = '"+idue+"'"  ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst3.executeQuery();
    
    if(conexion.rs.next()){//SI encontró algo imprimimos lso encabezados...
        
        fila21.setHeight((short)0x190);
        XSSFCell celdaCapacitacion = fila21.createCell(1);
        celdaCapacitacion.setCellValue("CAPACITACIÓN");
         celdaCapacitacion.setCellStyle(estiloTituloVerde);  
        hoja1.addMergedRegion(new CellRangeAddress(21,21,1,9)); //fila,fila,columna,columna   
        
        
         fecha_cap= conexion.rs.getString("fecha_cap");
         if(fecha_cap==null){fecha_cap="";}
         
         resp_inegi= conexion.rs.getString("resp_inegi");
         if(resp_inegi==null){resp_inegi="";}
         
        cant_pers= conexion.rs.getString("cant_pers");
         if(cant_pers==null){cant_pers="";} 
         
         resp_inegi = conexion.rs.getString("resp_inegi");
         if(resp_inegi==null){resp_inegi="";} 
      
        
        XSSFCell celdaFecCap= fila23.createCell(2);
        celdaFecCap.setCellValue("Fecha de capacitación");
        celdaFecCap.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaC23= fila23.createCell(3);
        celdaC23.setCellValue(fecha_cap);
        celdaC23.setCellStyle(estiloCeldas);
        
        
        XSSFCell celdaCantPers= fila23.createCell(5);
        celdaCantPers.setCellValue("Cantidad de Personas");
        celdaCantPers.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaG23= fila23.createCell(6);
        celdaG23.setCellValue(cant_pers);
        celdaG23.setCellStyle(estiloCeldas);
        
        
        XSSFCell celdaNomResp= fila25.createCell(2);
        celdaNomResp.setCellValue("Nombre del responsable de quien la impartió");
        celdaNomResp.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaD25= fila25.createCell(3);
        celdaD25.setCellValue(resp_inegi);
        celdaD25.setCellStyle(estiloCeldas);
        
        
        
        
        
    
      }else{} 
    
    
  }  catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
              //          conexion.closeConnection();
                    }   
  
  
  try{       
    PreparedStatement pst4=(PreparedStatement)conexion.conn.prepareStatement("SELECT  TO_CHAR(fec_sol_reg, 'dd/MM/yyyy') as fec_sol_reg, TO_CHAR(fec_env_doc, 'dd/MM/yyyy') as fec_env_doc,  TO_CHAR(fec_val_doc, 'dd/MM/yyyy') as fec_val_doc, "
                + "TO_CHAR(fec_env_firm, 'dd/MM/yyyy') as fec_env_firm, TO_CHAR(fec_regus, 'dd/MM/yyyy') as  fec_regus, TO_CHAR(fec_rec_doc, 'dd/MM/yyyy') as  fec_rec_doc" +
                "  FROM \"seguim_CURT\".registro_ue WHERE id_ue = '"+idue+"'"  ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst4.executeQuery();
    
    if(conexion.rs.next()){//SI encontró algo imprimimos lso encabezados...
        
        
    XSSFRow Fila27 = hoja1.createRow((short)27);
    Fila27.setHeight((short)0x220);
        XSSFCell celda0 = Fila27.createCell(1);
        celda0.setCellValue("APLICATIVO WEB");
         celda0.setCellStyle(estiloCeldaAzul);  
        hoja1.addMergedRegion(new CellRangeAddress(27,27,1,9)); //fila,fila,columna,columna
        
        
     XSSFCell celdaRegUE= fila29.createCell(1);
     fila29.setHeight((short)0x190);
        celdaRegUE.setCellValue("REGISTRO DE LAS UNIDADES DEL ESTADO");
         celdaRegUE.setCellStyle(estiloTituloVerde);  
        hoja1.addMergedRegion(new CellRangeAddress(29,29,1,9)); //fila,fila,columna,columna       
        
        fec_sol_reg= conexion.rs.getString("fec_sol_reg");
         if(fec_sol_reg==null || fec_sol_reg.equals("01/01/0001") ){fec_sol_reg="";}
         
         fec_env_doc= conexion.rs.getString("fec_env_doc");
         if(fec_env_doc==null || fec_env_doc.equals("01/01/0001")){fec_env_doc="";}
         
         fec_rec_doc= conexion.rs.getString("fec_rec_doc");
         if(fec_rec_doc==null || fec_rec_doc.equals("01/01/0001")){fec_rec_doc="";}
  
    XSSFCell celdaFecSoli= fila31.createCell(2);
        celdaFecSoli.setCellValue("Fecha de solicitud de registro");
        celdaFecSoli.setCellStyle(estiloCeldasBold);
        
    XSSFCell celdaD31= fila31.createCell(3);
        celdaD31.setCellValue(fec_sol_reg);
        celdaD31.setCellStyle(estiloCeldas);
        
        
     XSSFCell celdaEnvDOc= fila32.createCell(2);
        celdaEnvDOc.setCellValue("Fecha de envío de los documentos escaneados");
        celdaEnvDOc.setCellStyle(estiloCeldasBold);    
        
    XSSFCell celdaD32= fila32.createCell(3);
        celdaD32.setCellValue(fec_env_doc);
        celdaD32.setCellStyle(estiloCeldas);    
        
     XSSFCell celdaRecDoc= fila33.createCell(2);
        celdaRecDoc.setCellValue("Fecha de recepción de documentos originales");
        celdaRecDoc.setCellStyle(estiloCeldasBold);  
        
     XSSFCell celdaD33= fila33.createCell(3);
        celdaD33.setCellValue(fec_rec_doc);
        celdaD33.setCellStyle(estiloCeldas); 
        
       
    XSSFCell celdaUserResp  = fila31.createCell(5);
        celdaUserResp.setCellValue("Nombre de los usuarios responsables");
        celdaUserResp.setCellStyle(estiloCeldasBold);    
        
        
        
        
        
     }else{} 
    
    
  }  catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
              //          conexion.closeConnection();
                    }   
  
  int j=40;
  
  try{       
    PreparedStatement pst5=(PreparedStatement)conexion.conn.prepareStatement("SELECT id_entrega, id_ue, TO_CHAR(fecha, 'dd/MM/yyyy') as fecha, nom_resp_ent, unidad_admin, nom_resp_rec, medio, nom_archivo, tamano, total_reg FROM \"seguim_CURT\".datos_entrega_fis WHERE id_ue = '"+idue+"'"  ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst5.executeQuery();
    
    if(conexion.rs.next()){//SI encontró algo imprimimos lso encabezados...
        fila35.setHeight((short)0x220);
        XSSFCell celdaEntrega = fila35.createCell(1);
        celdaEntrega.setCellValue("ENTREGA DE INFORMACIÓN DE LA UE AL INEGI");
        celdaEntrega.setCellStyle(estiloCeldaAzul);  
        hoja1.addMergedRegion(new CellRangeAddress(35,35,1,9)); //fila,fila,columna,columna   
        
        
     XSSFCell celdaDatIE = fila37.createCell(1);
     fila37.setHeight((short)0x190);
        celdaDatIE.setCellValue("DATOS DE LA INFORMACIÓN ENTREGADA AL INEGI");
         celdaDatIE.setCellStyle(estiloTituloVerde);  
        hoja1.addMergedRegion(new CellRangeAddress(37,37,1,9)); //fila,fila,columna,columna       
            
          
          
        XSSFCell celdaB39= fila39.createCell(1);
        celdaB39.setCellValue("Fecha de entrega física");
        celdaB39.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaC39= fila39.createCell(2);
        celdaC39.setCellValue("Nombre del archivo");
        celdaC39.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaD39= fila39.createCell(3);
        celdaD39.setCellValue("Número de registros");
        celdaD39.setCellStyle(estiloCeldasBold);
        
       XSSFCell celdaE39= fila39.createCell(4);
        celdaE39.setCellValue("Nombre del responsable del INEGI que recibió");
        celdaE39.setCellStyle(estiloCeldasBold);
        
       XSSFCell celdaF39= fila39.createCell(5);
        celdaF39.setCellValue("Medio Utilizado");
        celdaF39.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaG39= fila39.createCell(6);
        celdaG39.setCellValue("Unidad Administrativa quien recibe ");
        celdaG39.setCellStyle(estiloCeldasBold);  
        
        
        
     
     conexion.rs.beforeFirst(); //ESTE REGRESA el cursor a la primera fila que devuelve el ResulsSet (lo resetea)..., pero
                                //pero para que este funcione se debe agregar esta línea despues de la conuslta: ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE   
   while(conexion.rs.next()){
       
       fecha_entfis= conexion.rs.getString("fecha");
         if(fecha_entfis==null || fecha_entfis.equals("01/01/0001") ){fecha_entfis="";}
         
        nom_resp_ent= conexion.rs.getString("nom_resp_ent");
         if(nom_resp_ent==null ){nom_resp_ent="";}  
         
        unidad_admin= conexion.rs.getString("unidad_admin");
         if(unidad_admin==null ){unidad_admin="";}   
         
        nom_resp_rec= conexion.rs.getString("nom_resp_rec");
         if(nom_resp_rec==null ){nom_resp_rec="";}   
         
        medio= conexion.rs.getString("medio");
         if(medio==null ){medio="";}   
        
        nom_archivo= conexion.rs.getString("nom_archivo");
         if(nom_archivo==null ){nom_archivo="";} 
         
        tamano= conexion.rs.getString("tamano");
         if(tamano==null ){tamano="";}  
         
        total_reg= conexion.rs.getString("total_reg");
         if(total_reg==null ){total_reg="";}   
  
     String[] datosP5 = {fecha_entfis,nom_archivo,total_reg,nom_resp_rec,medio,unidad_admin};
         
         XSSFRow filaJ=hoja1.createRow((short)j);// Nueva fila
          filaJ.setHeight((short)300);  //ALTO DE FILA
          
          
          for (int r = 0; r < datosP5.length; r++){
            //se agreaga el estilo y los valores del vector a la nueva fila
              XSSFCell celdaJ = filaJ.createCell(r+1);  // le puse r + 1 para que inicie desde la celda 1 (uno) ya que r vale 0
              celdaJ.setCellValue(datosP5[r]);
              hoja1.autoSizeColumn(r);
              celdaJ.setCellStyle(estiloCeldas);   //Aplicamos el estilo Cebra
         }
    j++;
    
   }
    
    }}
                    catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
              //          conexion.closeConnection();
                    }
  
  
  int k =0;
  try{       
    PreparedStatement pst6=(PreparedStatement)conexion.conn.prepareStatement("SELECT  TO_CHAR(fecha_dev, 'dd/MM/yyyy') as fecha_dev, nom_resp_dev, nom_rec_dev, arch_dev, \n" +
" total_regdev, fecha_llenado, fecha_actualizacion, motivos_dev,  id_entrega, nom_archivo \n" +
"  FROM \"seguim_CURT\".devolucion WHERE id_ue = '"+idue+"'"  ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst6.executeQuery();
    
    if(conexion.rs.next()){
        
        int fv = j+1; //desde aqui comienzan a ser variables las filas fv:fila variable
  
   XSSFRow filaX = hoja1.createRow((short)fv); 
      filaX.setHeight((short)0x220);
        XSSFCell celdaDevolucion = filaX.createCell(1);
        celdaDevolucion.setCellValue("DEVOLUCIÓN DE INFORMACIÓN POR VALIDACIÓN PREVIA A LA GENERACIÓN");
        celdaDevolucion.setCellStyle(estiloCeldaAzul);  
        hoja1.addMergedRegion(new CellRangeAddress(fv,fv,1,9)); //fila,fila,columna,columna
     
   int fv2 = j+3;     
    XSSFRow filaX2 = hoja1.createRow((short)fv2);
       XSSFCell celdaDatDevo = filaX2.createCell(1);
       filaX2.setHeight((short)0x190);
        celdaDatDevo.setCellValue("DATOS DE DEVOLUCIÓN DE INFORMACIÓN");
         celdaDatDevo.setCellStyle(estiloTituloVerde);  
         hoja1.addMergedRegion(new CellRangeAddress(fv2,fv2,1,9)); //fila,fila,columna,columna        
        
         
  int fv3 = j+5; 
  XSSFRow filaX3 = hoja1.createRow((short)fv3);
        XSSFCell celdaBX3= filaX3.createCell(1);
        celdaBX3.setCellValue("Fecha de devolución");
        celdaBX3.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaCX3= filaX3.createCell(2);
        celdaCX3.setCellValue("Motivo de devolución");
        celdaCX3.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaDX3= filaX3.createCell(3);
        celdaDX3.setCellValue("Nombre del archivo que se devolvió");
        celdaDX3.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaEX3= filaX3.createCell(4);
        celdaEX3.setCellValue("Total de registros en el archivo devuelto");
        celdaEX3.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaFX3= filaX3.createCell(5);
        celdaFX3.setCellValue("Nombre del responsable de INEGI que devolvió");
        celdaFX3.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaGX3= filaX3.createCell(6);
        celdaGX3.setCellValue("Nombre de quien recibió en la UE");
        celdaGX3.setCellStyle(estiloCeldasBold);
     
        
     k = fv3+1;   //le asigno nuevo valor a k
    }//if
    
   conexion.rs.beforeFirst(); //ESTE REGRESA el cursor a la primera fila que devuelve el ResulsSet (lo resetea)..., pero
                               //pero para que este funcione se debe agregar esta línea despues de la conuslta: ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE   
   while(conexion.rs.next()){
   
       
         fecha_dev= conexion.rs.getString("fecha_dev");
         if(fecha_dev==null || fecha_dev.equals("01/01/0001") ){fecha_dev="";}
         
        motivos_dev= conexion.rs.getString("motivos_dev");
         if(motivos_dev==null ){motivos_dev="";}
         
         arch_dev= conexion.rs.getString("arch_dev");
         if(arch_dev==null ){arch_dev="";}
         
         total_regdev= conexion.rs.getString("total_regdev");
         if(total_regdev==null ){total_regdev="";}
         
         nom_resp_dev= conexion.rs.getString("nom_resp_dev");
         if(nom_resp_dev==null ){nom_resp_dev="";}
         
         nom_rec_dev= conexion.rs.getString("nom_rec_dev");
         if(nom_rec_dev==null ){nom_rec_dev="";}
         
          String[] datosP6 = {fecha_dev,motivos_dev,arch_dev,total_regdev,nom_resp_dev,nom_rec_dev};
         
         XSSFRow filaK=hoja1.createRow((short)k);// Nueva fila
          filaK.setHeight((short)300);  //ALTO DE FILA
          
          
          for (int s = 0; s < datosP6.length; s++){
            //se agreaga el estilo y los valores del vector a la nueva fila
              XSSFCell celdaK = filaK.createCell(s+1);  // le puse r + 1 para que inicie desde la celda 1 (uno) ya que r vale 0
              celdaK.setCellValue(datosP6[s]);
              hoja1.autoSizeColumn(s);
              celdaK.setCellStyle(estiloCeldas);   //Aplicamos el estilo Cebra
         }
    k++;
         
   }//while
   
  }//try
  catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
              //          conexion.closeConnection();
                    }
  
  int fw9 =0; //la declar antes de hacer la consulta porque la usaré mas abajo
  try{       
    PreparedStatement pst3=(PreparedStatement)conexion.conn.prepareStatement("SELECT tipo_asesoria  FROM \"seguim_CURT\".asesoria"
            + "  WHERE id_ue = '"+idue+"'",ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst3.executeQuery();
    
    if(conexion.rs.next()){//SI encontró algo imprimimos los encabezados...
        
        
        tipo_asesoria= conexion.rs.getString("tipo_asesoria");
         if(tipo_asesoria==null ){tipo_asesoria="";}
        //Declaro las variable para usarlas mas abajo
        
        String T_regUE ="";
        String T_uso = ""; 
        String T_estructura ="";
        String T_coord ="";
        String T_infoS="";
        String T_interp="";
         
        String[] arrayAsesoria = tipo_asesoria.split(", "); //Creamos el array con la variable tippo_asesoria separada por comas
      
             
                
         for (int i=0; i< arrayAsesoria.length; i++){
                if (arrayAsesoria[i].equals("Registro de la UE en el aplicativo")){  T_regUE = "X"; }
                else if (arrayAsesoria[i].equals("Uso y manejo del aplicativo")){  T_uso = "X";}
                else if (arrayAsesoria[i].equals("Estructuración de la información")){ T_estructura = "X"; }
                else if (arrayAsesoria[i].equals("Convertir coordenadas cartesianas a geográficas")){ T_coord = "X"; }
                else if (arrayAsesoria[i].equals("Convertir información de un sistema de referencia geodésico a otro")){ T_infoS = "X"; }
                else if (arrayAsesoria[i].equals("Interpretación de los resultados de generación/actualización de la CURT")){ T_interp = "X"; }
         }
        
         //RECORRER EL ARRAY
         /*for(int i= 0; i <arrayAsesoria.length; i++){
             System.out.println(arrayAsesoria[i]);
         }*/
        
   //     String encontrado = arrayAsesoria
        
        int fw= k+1; //desde aqui comienzan a ser variables las filas fv:fila variable
        
        
  
   XSSFRow filaW = hoja1.createRow((short)fw); 
      filaW.setHeight((short)0x220);
        XSSFCell celdaAsesoria = filaW.createCell(1);
        celdaAsesoria.setCellValue("ASESORÍAS");
        celdaAsesoria.setCellStyle(estiloCeldaAzul);  
        hoja1.addMergedRegion(new CellRangeAddress(fw,fw,1,9)); //fila,fila,columna,columna
  
   int fw2 = fw + 2;     // creamos una nueva variable con el resultado de la anterior +2
    XSSFRow filaW2 = hoja1.createRow((short)fw2);
       XSSFCell celdaAseUE = filaW2.createCell(1);
       filaW2.setHeight((short)0x190);
        celdaAseUE.setCellValue("ASESORÍA A LA UNIDAD DEL ESTADO");
         celdaAseUE.setCellStyle(estiloTituloVerde);  
         hoja1.addMergedRegion(new CellRangeAddress(fw2,fw2,1,9)); //fila,fila,columna,columna        
  
  
  int fw3 = fw2 + 2; 
  XSSFRow filaW3 = hoja1.createRow((short)fw3);
        XSSFCell celdaBW3= filaW3.createCell(1);
        celdaBW3.setCellValue("Tipo de asesoría que se le ha brindado a la UE:");
        celdaBW3.setCellStyle(estiloCeldasBold);
          hoja1.addMergedRegion(new CellRangeAddress(fw3,fw3,1,2)); //fila,fila,columna,columna    
     
        
        ////////////////////////////////////////Nombre columnas y resultados
  int fw4 = fw3 + 1;     
  XSSFRow filaV4 = hoja1.createRow((short)fw4); 
    XSSFCell celdaCV3= filaV4.createCell(2);
          celdaCV3.setCellValue("Registro de la Unidad del Estado");
          celdaCV3.setCellStyle(estiloCeldasBold);
          
           XSSFCell celdaDV= filaV4.createCell(3); //creo la celda para agregarle la X, si es que existe
            celdaDV.setCellValue(T_regUE);
            celdaDV.setCellStyle(estiloCeldas);
          
  int fw5 = fw4 + 1;     
  XSSFRow filaU5 = hoja1.createRow((short)fw5); 
    XSSFCell celdaCU3= filaU5.createCell(2);
          celdaCU3.setCellValue("Uso y manejo del aplicativo");
          celdaCU3.setCellStyle(estiloCeldasBold);  
          
           XSSFCell celdaDU= filaU5.createCell(3); //creo la celda para agregarle la X, si es que existe
            celdaDU.setCellValue(T_uso);
            celdaDU.setCellStyle(estiloCeldas);
          
   
  int fw6 = fw5 + 1;     
  XSSFRow filaT7 = hoja1.createRow((short)fw6); 
    XSSFCell celdaCT= filaT7.createCell(2);
          celdaCT.setCellValue("Estructuración de la información");
          celdaCT.setCellStyle(estiloCeldasBold);     
          
          XSSFCell celdaDT= filaT7.createCell(3); //creo la celda para agregarle la X, si es que existe
            celdaDT.setCellValue(T_estructura);
            celdaDT.setCellStyle(estiloCeldas);
          
  int fw7 = fw6 + 1;     
  XSSFRow filaS8 = hoja1.createRow((short)fw7); 
    XSSFCell celdaCS3= filaS8.createCell(2);
          celdaCS3.setCellValue("Convertir coordenadas cartesianas a geográficas");
          celdaCS3.setCellStyle(estiloCeldasBold);  
          
          XSSFCell celdaDS= filaS8.createCell(3); //creo la celda para agregarle la X, si es que existe
            celdaDS.setCellValue(T_coord);
            celdaDS.setCellStyle(estiloCeldas);

          
  int fw8 = fw7 + 1;     
  XSSFRow filaR9 = hoja1.createRow((short)fw8); 
    XSSFCell celdaCR3= filaR9.createCell(2);
          celdaCR3.setCellValue("Convertir información de un sistema de referencia geodésico a otro");
          celdaCR3.setCellStyle(estiloCeldasBold);  
          
          XSSFCell celdaDR= filaR9.createCell(3); //creo la celda para agregarle la X, si es que existe
            celdaDR.setCellValue(T_infoS);
            celdaDR.setCellStyle(estiloCeldas);
         
   fw9 = fw8 + 1;     
  XSSFRow filaP10 = hoja1.createRow((short)fw9); 
    XSSFCell celdaCP3= filaP10.createCell(2);
          celdaCP3.setCellValue("Interpretación de los resultados de generación/actualización de la CURT");
          celdaCP3.setCellStyle(estiloCeldasBold);  
          
          XSSFCell celdaDP= filaP10.createCell(3); //creo la celda para agregarle la X, si es que existe
            celdaDP.setCellValue(T_interp);
            celdaDP.setCellStyle(estiloCeldas);
          
          
          
	
        
        
    }else{}
  }catch(SQLException e){out.print("exception"+e);
                    }finally {
              //          conexion.closeConnection();
                    }
  
  int m = 0;
  
  try{       
    PreparedStatement pst7=(PreparedStatement)conexion.conn.prepareStatement("SELECT id_gen, id_ue, nom_resp, TO_CHAR(fech_ini, 'dd/MM/yyyy') as fech_ini,  TO_CHAR(fech_fin, 'dd/MM/yyyy') as fech_fin, pred_concurt, pred_sincurt, \n" +
"       TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado,  TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as fecha_actualizacion, total_motgen, mot_gen, id_entrega, \n" +
"       nom_archivo\n" +
"  FROM \"seguim_CURT\".generacion_curt WHERE id_ue = '"+idue+"' ORDER BY id_gen" ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst7.executeQuery();
    
 if(conexion.rs.next()){
   
        int fr = fw9+2; //desde aqui comienzan a ser variables las filas fv:fila variable
        
   XSSFRow filaO = hoja1.createRow((short)fr); 
      filaO.setHeight((short)0x220);
        XSSFCell celdaGenCurt = filaO.createCell(1);
        celdaGenCurt.setCellValue("GENERACIÓN Y/O ACTUALIZACIÓN DE LA CURT");
        celdaGenCurt.setCellStyle(estiloCeldaAzul);  
        hoja1.addMergedRegion(new CellRangeAddress(fr,fr,1,9)); //fila,fila,columna,columna
  
        
        

        
   int fr2 = fr + 2;     // creamos una nueva variable con el resultado de la anterior +2
    XSSFRow filaN = hoja1.createRow((short)fr2);
       XSSFCell CeldaAct = filaN.createCell(1);
       filaN.setHeight((short)0x190);
        CeldaAct.setCellValue("Generación y/o Actualización de la CURT");
         CeldaAct.setCellStyle(estiloTituloVerde);  
         hoja1.addMergedRegion(new CellRangeAddress(fr2,fr2,1,9)); //fila,fila,columna,columna        
  
  int fr3a = fr2 + 1;     // creamos una nueva variable con el resultado de la anterior +1
  XSSFRow filaLb = hoja1.createRow((short)fr3a);
  XSSFCell CeldaEFL = filaLb.createCell(4);
           CeldaEFL.setCellValue("Fecha y hora de procesamiento");
           CeldaEFL.setCellStyle(estiloCeldasBold); 
           hoja1.addMergedRegion(new CellRangeAddress(fr3a,fr3a,4,5)); //fila,fila,columna,columna        
  
           
  
  int fr3  = fr2 + 2;     // creamos una nueva variable con el resultado de la anterior +1
  
    XSSFRow filaL = hoja1.createRow((short)fr3);
    XSSFCell CeldaBL = filaL.createCell(1);
             CeldaBL.setCellValue("Proceso Realizado");
             CeldaBL.setCellStyle(estiloCeldasBold);  
             
    XSSFCell CeldaCL = filaL.createCell(2);
             CeldaCL.setCellValue("Nombre del archivo");
             CeldaCL.setCellStyle(estiloCeldasBold);   
             
    XSSFCell CeldaDL = filaL.createCell(3);
             CeldaDL.setCellValue("Nombre original del archivo");
             CeldaDL.setCellStyle(estiloCeldasBold);  
             
    XSSFCell CeldaEL = filaL.createCell(4);
             CeldaEL.setCellValue("Inicio");
             CeldaEL.setCellStyle(estiloCeldasBold);
    
    XSSFCell CeldaFL = filaL.createCell(5);
             CeldaFL.setCellValue("Término");
             CeldaFL.setCellStyle(estiloCeldasBold);
             
    XSSFCell CeldaGL = filaL.createCell(6);
             CeldaGL.setCellValue("Predios con curt");
             CeldaGL.setCellStyle(estiloCeldasBold); 
             
    XSSFCell CeldaHL = filaL.createCell(7);
             CeldaHL.setCellValue("Predios sin curt");
             CeldaHL.setCellStyle(estiloCeldasBold);  
             
    m = fr3+1;        
  }//if 
    
  conexion.rs.beforeFirst(); //ESTE REGRESA el cursor a la primera fila que devuelve el ResulsSet (lo resetea)...,
  while (conexion.rs.next()){
     
         fech_ini10= conexion.rs.getString("fech_ini");
         if(fech_ini10==null || fech_ini10.equals("01/01/0001") ){fech_ini10="";}
       
        fech_fin10= conexion.rs.getString("fech_fin");
         if(fech_fin10==null || fech_fin10.equals("01/01/0001") ){fech_fin10="";}
         
    
         
         pred_concurt= conexion.rs.getString("pred_concurt");
         if(pred_concurt==null ){pred_concurt="";}
         
         pred_sincurt= conexion.rs.getString("pred_sincurt");
         if(pred_sincurt==null ){pred_sincurt="";}
         
         nom_archivo10= conexion.rs.getString("nom_archivo");
         if(nom_archivo10==null ){nom_archivo10="";}
         
         id_gen10= conexion.rs.getString("id_gen");
         if(id_gen10==null ){id_gen10="";}
     
         
        String[] datosP10 = {"Generación", nom_archivo10, nom_archivo10, fech_ini10, fech_fin10, pred_concurt, pred_sincurt};
         
         XSSFRow filaH =hoja1.createRow((short)m);// Nueva fila
                 filaH.setHeight((short)300);  //ALTO DE FILA
          
          
          for (int p = 0; p < datosP10.length; p++){
            //se agreaga el estilo y los valores del vector a la nueva fila
              XSSFCell celdaHX = filaH.createCell(p+1);  // le puse r + 1 para que inicie desde la celda 1 (uno) ya que r vale 0
                        celdaHX.setCellValue(datosP10[p]);
                        hoja1.autoSizeColumn(p);
                        celdaHX.setCellStyle(estiloCeldas3);   //Aplicamos el estilo Cebra
                        
    
         }//for
         
         
          
   m++;
    

   
            //Hago otra consulta dentro de la consulta, creo otra conexion (conexion1)
PreparedStatement pst9 = (PreparedStatement)conexion2.conn.prepareStatement("SELECT mot_gen as motg,  total_motgen as totg FROM \"seguim_CURT\".motivos_gen WHERE id_gen = '"+id_gen10+"'" ); 
    conexion2.rs=pst9.executeQuery();
    
    XSSFRow filaH1 =hoja1.createRow((short)m++); //Creo la fila para los encabezados total y motivos
                
                XSSFCell celdaH1C= filaH1.createCell(2);
                celdaH1C.setCellValue("Motivos por lo que no se generó la CURT");
                celdaH1C.setCellStyle(estiloCeldasBold);
                
                XSSFCell celdaH1X = filaH1.createCell(3);
                celdaH1X.setCellValue("Total");
                celdaH1X.setCellStyle(estiloCeldasBold);
                
                
            while(conexion2.rs.next()){   
              mot_gen= conexion2.rs.getString("motg");
                 if(mot_gen==null ){mot_gen="";}

              tot_gen= conexion2.rs.getString("totg");
                 if(tot_gen==null ){tot_gen="";}

                    XSSFRow filaH2 =hoja1.createRow((short)m++);// Nueva fila 
                        XSSFCell celdaHX2 = filaH2.createCell(2);
                                 celdaHX2.setCellValue(mot_gen);
                                 celdaHX2.setCellStyle(estiloCeldas2);

                        XSSFCell celdaHY2 = filaH2.createCell(3);
                                 celdaHY2.setCellValue(tot_gen);  
                                 celdaHY2.setCellStyle(estiloCeldas2);
            }  //while    
            
    //  m++;
   }//while principal   
             
             
  }//try
  catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
                      conexion2.closeConnection();
                      // conexion.closeConnection();
                    }
  
  int n4 = 0;
  int n = m+1;              
try{       
    PreparedStatement pst10=(PreparedStatement)conexion.conn.prepareStatement("SELECT TO_CHAR(fec_dr, 'dd/MM/yyyy') as fec_dr , nom_resp_ocent, nom_resp_drec, arch_dr, "
            + " cant_dr, TO_CHAR(fec_ue, 'dd/MM/yyyy') as fec_ue, nom_resp_drent, nom_resp_uerec, arch_ue, cant_ue, tipo_entrega"
            + " FROM \"seguim_CURT\".datos_entrega WHERE id_ue = '"+idue+"'" ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst10.executeQuery();        
 
    if(conexion.rs.next()){
  XSSFRow filaF = hoja1.createRow((short)n); 
      filaF.setHeight((short)0x220);
        XSSFCell EntregaInf = filaF.createCell(1);
        EntregaInf.setCellValue("ENTREGA DE INFORMACIÓN A LA UE");
        EntregaInf.setCellStyle(estiloCeldaAzul);  
        hoja1.addMergedRegion(new CellRangeAddress(n,n,1,9)); //fila,fila,columna,columna
        
  int n2 = n+2;      
   XSSFRow filaF2 = hoja1.createRow((short)n2);
       XSSFCell CeldaDatEnt= filaF2.createCell(1);
            filaF2.setHeight((short)0x190);
                CeldaDatEnt.setCellValue("DATOS DE LA ENTREGA");
                CeldaDatEnt.setCellStyle(estiloTituloVerde);  
            hoja1.addMergedRegion(new CellRangeAddress(n2,n2,1,9)); //fila,fila,columna,columna      
            
   int n3 = n2 + 2;       
    XSSFRow filaF3 = hoja1.createRow((short)n3);
        XSSFCell CeldaF3B = filaF3.createCell(1);
                 CeldaF3B.setCellValue("Entrega:");
                 CeldaF3B.setCellStyle(estiloCeldasBold);
                 
        XSSFCell CeldaF3C = filaF3.createCell(2);
                 CeldaF3C.setCellValue("Fecha de entrega");
                 CeldaF3C.setCellStyle(estiloCeldasBold);         
                 
        XSSFCell CeldaF3D = filaF3.createCell(3);
                 CeldaF3D.setCellValue("Nombe del archivo");
                 CeldaF3D.setCellStyle(estiloCeldasBold);   
                 
        XSSFCell CeldaF3E = filaF3.createCell(4);
                 CeldaF3E.setCellValue("Cantidad de registros");
                 CeldaF3E.setCellStyle(estiloCeldasBold);  
                 
        XSSFCell CeldaF3F = filaF3.createCell(5);
                 CeldaF3F.setCellValue("Nombre del responsable del INEGI que entrega la información");
                 CeldaF3F.setCellStyle(estiloCeldasBold);  
                
                 
        XSSFCell CeldaF3G = filaF3.createCell(6);
                 CeldaF3G.setCellValue("Nombre del responsable que recibe la información");
                 CeldaF3G.setCellStyle(estiloCeldasBold);            
                
                 
    n4 = n3+1;             
   //}
   
   
   //conexion.rs.beforeFirst(); //ESTE REGRESA el cursor a la primera fila que devuelve el ResulsSet (lo resetea)..., pero   //pero para que este funcione se debe agregar esta línea despues de la conuslta: ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE   
 //while(conexion.rs.next()){
 
        tipo_entrega12= conexion.rs.getString("tipo_entrega");
                 if(tipo_entrega12==null ){tipo_entrega12="";}  
                 
        fec_dr= conexion.rs.getString("fec_dr");
                 if(fec_dr==null ){fec_dr="";}     
                 
        fec_ue= conexion.rs.getString("fec_ue");
                 if(fec_ue==null ){fec_ue="";} 
        
        arch_dr= conexion.rs.getString("arch_dr");
                 if(arch_dr==null ){arch_dr="";}  
                 
        arch_ue= conexion.rs.getString("arch_ue");
                 if(arch_ue==null ){arch_ue="";}    
                 
        cant_dr= conexion.rs.getString("cant_dr");
                 if(cant_dr==null ){cant_dr="";} 
                 
        cant_ue= conexion.rs.getString("cant_ue");
                 if(cant_ue==null ){cant_ue="";}
                 
        nom_resp_drent= conexion.rs.getString("nom_resp_drent");
                 if(nom_resp_drent==null ){nom_resp_drent="";}   
                 
        nom_resp_ocent= conexion.rs.getString("nom_resp_ocent");
                 if(nom_resp_ocent==null ){nom_resp_ocent="";}  
                 
        nom_resp_drec= conexion.rs.getString("nom_resp_drec");
                 if(nom_resp_drec==null ){nom_resp_drec="";}     
                 
        nom_resp_uerec= conexion.rs.getString("nom_resp_uerec");
                 if(nom_resp_uerec==null ){nom_resp_uerec="";}         
           
                 
                 
        String datosP12[] = new String[6];
               
       
           //  datosP12 = {tipo_entrega12, fec_dr, arch_dr, cant_dr};
         if(tipo_entrega12.equals("A Direccion Regional")){
                datosP12[0] = tipo_entrega12;
                datosP12[1] = fec_dr;
                datosP12[2] = arch_dr;
                datosP12[3] = cant_dr;
                datosP12[4] = nom_resp_ocent;
                datosP12[5] = nom_resp_drec;
         }
         
         else if(tipo_entrega12.equals("A Unidad del Estado")){
                datosP12[0] = tipo_entrega12;
                datosP12[1] = fec_ue;
                datosP12[2] = arch_ue;
                datosP12[3] = cant_ue;
                datosP12[4] = nom_resp_drent;
                datosP12[5] = nom_resp_uerec;
         } 
         
         XSSFRow filaE =hoja1.createRow((short)n4);// Nueva fila
                 filaE.setHeight((short)300);  //ALTO DE FILA
          
          
          for (int q = 0; q < datosP12.length; q++){
            //se agreaga el estilo y los valores del vector a la nueva fila
              XSSFCell celdaHX = filaE.createCell(q+1);  // le puse r + 1 para que inicie desde la celda 1 (uno) ya que r vale 0
                        celdaHX.setCellValue(datosP12[q]);
                        hoja1.autoSizeColumn(q);
                        celdaHX.setCellStyle(estiloCeldas);   //Aplicamos el estilo Cebra
                        
    
         }//for         
 }//if
   
   
                 
  }//try
  catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
              //          conexion.closeConnection();
                    }          
                 
  
int d = n4 +2;


try{       
    PreparedStatement pst11=(PreparedStatement)conexion.conn.prepareStatement(" SELECT  TO_CHAR(fec_sol, 'dd/MM/yyyy') as fec_sol, TO_CHAR(fec_emi, 'dd/MM/yyyy') as fec_emi, folio_cons"
            + " FROM \"seguim_CURT\".constancia WHERE id_ue = '"+idue+"'" ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst11.executeQuery();        
 
    if(conexion.rs.next()){
        fec_sol= conexion.rs.getString("fec_sol");
                 if(fec_sol==null ){fec_sol="";}    
                 
        fec_emi= conexion.rs.getString("fec_emi");
                 if(fec_emi==null ){fec_emi="";}  
                 
        folio_cons= conexion.rs.getString("folio_cons");
                 if(folio_cons==null ){folio_cons="";}         
    

       

   XSSFRow filaD =hoja1.createRow((short)d);// Nueva fila   
           filaD.setHeight((short)0x190);
        XSSFCell CeldaConstancia= filaD.createCell(1);
                CeldaConstancia.setCellValue("CONSTANCIA DE COBERTURA");
                CeldaConstancia.setCellStyle(estiloTituloVerde);  
            hoja1.addMergedRegion(new CellRangeAddress(d,d,1,9)); //fila,fila,columna,columna  
   
int d1 = d+2;            
    XSSFRow filaD1 =hoja1.createRow((short)d1);// Nueva fila  
        XSSFCell CeldaDB = filaD1.createCell(1);
                 CeldaDB.setCellValue("Fecha de solicitud");
                 CeldaDB.setCellStyle(estiloCeldasBold);
                 
        XSSFCell CeldaDC = filaD1.createCell(2);
                 CeldaDC.setCellValue(fec_sol);
                 CeldaDC.setCellStyle(estiloCeldas);   
                 
                 
        XSSFCell CeldaDE = filaD1.createCell(4);
                 CeldaDE.setCellValue("No. de folio constancia");
                 CeldaDE.setCellStyle(estiloCeldasBold);   
                 
        XSSFCell CeldaDF = filaD1.createCell(5);
                 CeldaDF.setCellValue(folio_cons);
                 CeldaDF.setCellStyle(estiloCeldas);            
                 
                 
                 
 int d2 = d1 +1;    
 
      XSSFRow filaD2 =hoja1.createRow((short)d2);// Nueva fila  
        XSSFCell CeldaDB2 = filaD2.createCell(1);
                 CeldaDB2.setCellValue("Fecha de emisión");
                 CeldaDB2.setCellStyle(estiloCeldasBold);   
                 
        XSSFCell CeldaDC2 = filaD2.createCell(2);
                 CeldaDC2.setCellValue(fec_emi);
                 CeldaDC2.setCellStyle(estiloCeldas);            
                 
                 
 }//if
   
   
                 
  }//try
  catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
                       conexion.closeConnection();
                    }                 
                 
                 
           
   //Creo la celda A0
    XSSFCell CeldaA0 = fila.createCell(0);
             CeldaA0.setCellValue("");        
             
        // Volcamos la información a un archivo.
        //obtener cadena para descarga en carpeta de descargas del ususario
        String nombre="repor"+idue.toUpperCase()+".xlsx";
       
        
        //String strNombreArchivo = System.getProperty("user.home")+"/Downloads/"+nombre;
        //String strNombreArchivo = System.getProperty("user.home")+"/Documents/respaldo_Angelica/Directorio/web/Reportes/"+nombre;
     //   String strNombreArchivo = System.getProperty("user.home")+"/apps/apache-tomcat-7.0.47-88/webapps/SICA_Directorio/Reportes/"+nombre;
       // File objFile = new File(strNombreArchivo);
        //FileOutputStream archivoSalida = new FileOutputStream(objFile);
        //objLibro.write(archivoSalida); 
       // archivoSalida.close();
        
        hoja1.autoSizeColumn(0);
        hoja1.autoSizeColumn(1);
        hoja1.autoSizeColumn(2);
        hoja1.autoSizeColumn(3, true); // el true es para que acepte las celdas combinadas
        hoja1.autoSizeColumn(4);
        hoja1.autoSizeColumn(5);
        hoja1.autoSizeColumn(6);
        hoja1.autoSizeColumn(7);
        hoja1.autoSizeColumn(8);
        hoja1.autoSizeColumn(9);
          
            ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
                    objLibro.write(outByteStream);
                    byte [] outArray = outByteStream.toByteArray();
                    response.setContentType("application/ms-excel");
                    response.setContentLength(outArray.length);
                    //response.setHeader("Expires:", "no-cache"); // eliminates browser caching
                    //response.setDateHeader("Expires", 0); //prevents caching at the proxy server
                    response.setHeader("Content-Disposition", "attachment; filename="+ nombre);
                    OutputStream outStream = response.getOutputStream();
                    outStream.write(outArray);
                    outStream.flush();
                    outStream.close();//agregado 27 agosto 2018
                    



                    



       
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
