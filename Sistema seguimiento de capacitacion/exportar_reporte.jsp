<%-- 
    Document   : exportar_ugig
    Created on : 17/10/2017, 09:35:20 AM
    Author     : RICARDO.MACIAS
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Properties"%>
<%@page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFColor"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFCellStyle"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFFont"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFCell"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFRow"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
 <%@page import="org.apache.poi.ss.util.CellRangeAddress"%>
<%@page import="java.io.FileOutputStream"%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="BaseDatos.ConexionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page trimDirectiveWhitespaces="true" %>


    <%ConexionBD conexion=new ConexionBD();
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
    %>
 
  
        <%
        //    Properties props = System.getProperties();
        //    props.setProperty("java.awt.headless","true");  
            
        XSSFWorkbook objLibro = new XSSFWorkbook();//creacion del documento
        XSSFSheet hoja1 = objLibro.createSheet("Informe Capacitaciones");// Creo la hoja
        //XSSFSheet hoja2 = objLibro.createSheet("Hoja 2");// Creo la hoja 2
          
      
  
        XSSFRow Encabezado = hoja1.createRow((short)1); 
        XSSFRow FilaSubtitulo = hoja1.createRow((short)4); 
        
        XSSFRow fila = hoja1.createRow((short)8); // creo la fila.
        XSSFRow fila1 = hoja1.createRow((short)9);
         fila1.setHeight((short)0x100);
       
         XSSFRow fila13 = hoja1.createRow((short)13); 
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
        

        %>
        <%! 
       
     static String id_concer, id_ue, nom_ent, cve_ent, nom_ue, fec_pri_env, fec_pri_res, 
       fec_seg_env, fec_seg_res, acepto, que_acepto, motivo, observacionesp1, fecha_llenado, 
       fecha_actualizacion, respuesta1, respuesta2, fechas_primer_oficio, 
       fechas_segundo_oficio, fec_ter_env, fec_ter_res, respuesta3, 
       fechas_tercer_oficio, nombre_destin1, nombre_remi1, nombre_destin2, 
       nombre_remi2, nombre_destin3, nombre_remi3, ruta_ofi_env1, ruta_ofi_recib1, 
       ruta_ofi_env2, ruta_ofi_recib2, ruta_ofi_env3, ruta_ofi_recib3, municipio,
        /*Capacitacion*/
      id_cap, fecha_cap, lugar, resp_inegi, cant_pers, fecha_llenado_P2, 
       fecha_actualizacion_P2, norma_cat, norma_curt, lineamiento,
       diccionario,
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
    //Datos Entrega 12
    tipo_entrega,fecha_entrega12,fec_ue,nom_arch12,arch_ue,cant_reg12,cant_ue, nom_resp_ocent, nom_resp_rec12, nom_resp_ent12, nom_resp_uerec,
   
    //Constancia
    fec_sol, fec_emi, folio_cons
    
    ; 
     
     %>  
    <%
          
       try{       
    PreparedStatement pst2=(PreparedStatement)conexion.conn.prepareStatement("SELECT id_concer, id_ue, nom_ent, cve_ent, nom_ue, TO_CHAR(fec_pri_env, 'dd/MM/yyyy') as fec_pri_env,  TO_CHAR(fec_pri_res, 'dd/MM/yyyy') as fec_pri_res, \n" +
"       TO_CHAR(fec_seg_env, 'dd/MM/yyyy') as fec_seg_env,  TO_CHAR(fec_seg_res, 'dd/MM/yyyy') as fec_seg_res, acepto, que_acepto, motivo, TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado, \n" +
"       TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as fecha_actualizacion, respuesta1, respuesta2, fechas_primer_oficio, fechas_segundo_oficio,   TO_CHAR(fec_ter_env, 'dd/MM/yyyy') as fec_ter_env, TO_CHAR(fec_ter_res, 'dd/MM/yyyy') as fec_ter_res, respuesta3, fechas_tercer_oficio,"
                + " nombre_destin1, nombre_remi1, nombre_destin2, nombre_remi2, nombre_destin3, nombre_remi3, ruta_ofi_env1, ruta_ofi_recib1, ruta_ofi_env2, ruta_ofi_recib2, ruta_ofi_env3, ruta_ofi_recib3, municipio, observaciones FROM \"seguim_CURT\".concertacion WHERE id_ue = '"+idue+"'"  ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
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
        
        observacionesp1 = conexion.rs.getString("observaciones");
        if(observacionesp1==null){observacionesp1="";}
        

        
        /*ENCABEZADOS CAMPOS */
        
         XSSFCell celdaEncabezado = Encabezado.createCell(1);
    celdaEncabezado.setCellValue("SISTEMA PARA EL REGISTRO DE CAPACITACIONES CATASTRALES");
    celdaEncabezado.setCellStyle(estiloCeldaEncabezado); 
    hoja1.addMergedRegion(new CellRangeAddress(1,3,1,9)); //fila,fila,columna,columna
    
    XSSFCell celdaSubtitulo = FilaSubtitulo.createCell(1);
        celdaSubtitulo.setCellValue("Informe de las capacitaciones realizadas sobre documentos catastrales");
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
         
       XSSFCell celda4 = fila1.createCell(2);
        celda4.setCellValue(nom_ue);
        celda4.setCellStyle(estiloCeldas); 
        

        XSSFCell celda5 = fila1.createCell(3);
         celda5.setCellValue(nom_ent);
         celda5.setCellStyle(estiloCeldas); 
         
        XSSFCell celda6 = fila1.createCell(4);
         celda6.setCellValue(municipio); 
         celda6.setCellStyle(estiloCeldas); 
       
       
     
    
  // }       
   }
    
    else{} 
    
    
  }  catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
                       // conexion.closeConnection();
                    }  
         
    int j=16;
  
  try{       
    PreparedStatement pst5=(PreparedStatement)conexion.conn.prepareStatement("SELECT id_cap, id_ue, TO_CHAR(fecha_cap, 'dd/MM/yyyy') as fecha_cap, lugar, resp_inegi, cant_pers, TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado, TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as  fecha_actualizacion,\n" +
"  norma_cat, norma_curt, diccionario, lineamiento FROM seguimiento_cap.capacitacion  WHERE id_ue = '"+idue+"'"  ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst5.executeQuery();
    
    if(conexion.rs.next()){//SI encontró algo imprimimos lso encabezados...
        
    XSSFRow FilatituloConcertacion = hoja1.createRow((short)11);
        FilatituloConcertacion.setHeight((short)0x220);
        XSSFCell celdaEntrega = FilatituloConcertacion.createCell(1);
        celdaEntrega.setCellValue("CAPACITACIÓN");
        celdaEntrega.setCellStyle(estiloCeldaAzul);  
        hoja1.addMergedRegion(new CellRangeAddress(11,11,1,9)); //fila,fila,columna,columna   
        
        
     XSSFCell celdaDatIE = fila13.createCell(1);
     fila13.setHeight((short)0x190);
        celdaDatIE.setCellValue("DATOS DE LAS CAPACITACIONES REALIZADAS");
         celdaDatIE.setCellStyle(estiloTituloVerde);  
        hoja1.addMergedRegion(new CellRangeAddress(13,13,1,9)); //fila,fila,columna,columna       
            
          
          
        XSSFCell celdaB15= fila15.createCell(1);
        celdaB15.setCellValue("Fecha de la capacitación");
        celdaB15.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaC15= fila15.createCell(2);
        celdaC15.setCellValue("Lugar");
        celdaC15.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaD15= fila15.createCell(3);
        celdaD15.setCellValue("Responsable de INEGI que la impartió");
        celdaD15.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaE15= fila15.createCell(4);
        celdaE15.setCellValue("Cantidad de personas capacitadas");
        celdaE15.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaF15= fila15.createCell(5);
        celdaF15.setCellValue("Norma de Catastro");
        celdaF15.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaG15= fila15.createCell(6);
        celdaG15.setCellValue("Norma de la CURT");
        celdaG15.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaH15= fila15.createCell(7);
        celdaH15.setCellValue("Diccionarios de Datos Catastrales");
        celdaH15.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaI15= fila15.createCell(8);
        celdaI15.setCellValue("Lineamientos de Intercambio");
        celdaI15.setCellStyle(estiloCeldasBold);
        
       /*XSSFCell celdaF39= fila39.createCell(5);
        celdaF39.setCellValue("Medio Utilizado");
        celdaF39.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaG39= fila39.createCell(6);
        celdaG39.setCellValue("Unidad Administrativa quien recibe ");
        celdaG39.setCellStyle(estiloCeldasBold);  */
        
        
    }//if   
    else{
        j = 16; //j seguira valiendo 40 porque no hay variables arriba
    }
     
     conexion.rs.beforeFirst(); //ESTE REGRESA el cursor a la primera fila que devuelve el ResulsSet (lo resetea)..., pero
                                //pero para que este funcione se debe agregar esta línea despues de la conuslta: ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE   
   while(conexion.rs.next()){
       
       fecha_cap= conexion.rs.getString("fecha_cap");
         if(fecha_cap==null || fecha_cap.equals("01/01/0001") ){fecha_cap="";}
         
        lugar= conexion.rs.getString("lugar");
         if(lugar==null ){lugar="";}  
         
        resp_inegi= conexion.rs.getString("resp_inegi");
         if(resp_inegi==null ){resp_inegi="";}   
         
        cant_pers= conexion.rs.getString("cant_pers");
         if(cant_pers==null ){cant_pers="";}
         
        norma_cat= conexion.rs.getString("norma_cat");
         if(norma_cat==null || norma_cat==""){norma_cat="";}
         
        norma_curt= conexion.rs.getString("norma_curt");
         if(norma_curt==null || norma_curt==""){norma_curt="";}
        
        diccionario= conexion.rs.getString("diccionario");
         if(diccionario==null || diccionario==""){diccionario="";}
        
        lineamiento= conexion.rs.getString("lineamiento");
         if(lineamiento==null || lineamiento==""){lineamiento="";}  
               
        
  
     String[] datosP5 = {fecha_cap,lugar,resp_inegi,cant_pers,norma_cat,norma_curt,diccionario,lineamiento};
         
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
    
    //} //if
  }//try
                    catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
              //          conexion.closeConnection();
                    }
  
  //DESDE AQUI LAS FILAS COMIENZAN A SER VARIABLES

                 
           
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
        
        
       //-----------------------------creo las Filas de la Hoja 2---------------------------------------------
    
            
        
        
        
        
        
        
          
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
                    return;



        %>
