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


    <%ConexionBD conexion=new ConexionBD();
     ConexionBD conexion2=new ConexionBD();

    String idue = request.getParameter("ue");
    String f_inicio_reg = request.getParameter("f_inicio_reg");
    String f_fin_reg = request.getParameter("f_fin_reg");
    //String f_inicio = "2014-06-01";
    //String f_fin = "2018-12-31"; 
 
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
        XSSFSheet hoja1 = objLibro.createSheet("Informe CURT");// Creo la hoja
       // XSSFSheet hoja2 = objLibro.createSheet("Códigos notas");// Creo la hoja 2
          
      
  
        XSSFRow Encabezado = hoja1.createRow((short)1); 
        XSSFRow FilaSubtitulo = hoja1.createRow((short)4); 
        
        XSSFRow fila = hoja1.createRow((short)8); // creo la fila.
        XSSFRow fila1 = hoja1.createRow((short)9);
         fila1.setHeight((short)0x100);
         
         XSSFRow fila6 = hoja1.createRow((short)6);
         XSSFRow fila7 = hoja1.createRow((short)7);
         XSSFRow fila8 = hoja1.createRow((short)8);
         XSSFRow fila9 = hoja1.createRow((short)9);
         XSSFRow fila10 = hoja1.createRow((short)10);
         XSSFRow fila11 = hoja1.createRow((short)11);
         XSSFRow fila12 = hoja1.createRow((short)12);
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
       ruta_ofi_env2, ruta_ofi_recib2, ruta_ofi_env3, ruta_ofi_recib3, municipio,total,
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
    //Datos Entrega 12
    tipo_entrega,fecha_entrega12,fec_ue,nom_arch12,arch_ue,cant_reg12,cant_ue, nom_resp_ocent, nom_resp_rec12, nom_resp_ent12, nom_resp_uerec,
   
    //Constancia
    fec_sol, fec_emi, folio_cons
    
    ; 
     
     %>  
    <%
     
  
  int j=11;
  
  try{       
    PreparedStatement pst5=(PreparedStatement)conexion.conn.prepareStatement("SELECT c.\"NOM_EDO\" as nom_ent,\"INSNOMBRECIUDADMPIO\" as municipio, \"INSNOMBRE\" as nom_ue FROM \"seguim_CURT\".registro_ue a, \"seguim_CURT\".ufg_directori_ufg b, \"seguim_CURT\".cat_edo c WHERE b.\"Id\" = a.id_ue AND b.\"CVE_ENTIDAD\" = c.\"CVE_EDO\" AND a.fec_sol_reg between '"+f_inicio_reg+"' and '"+f_fin_reg+"' ORDER BY c.\"NOM_EDO\" ASC;"  ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst5.executeQuery();
    
    /*ENCABEZADOS CAMPOS */
        
         XSSFCell celdaEncabezado = Encabezado.createCell(1);
    celdaEncabezado.setCellValue("SISTEMA DE SEGUIMIENTO DE LA CLAVE ÚNICA DEL REGISTRO DEL TERRITORIO");
    celdaEncabezado.setCellStyle(estiloCeldaEncabezado); 
    hoja1.addMergedRegion(new CellRangeAddress(1,3,1,9)); //fila,fila,columna,columna
    
    XSSFCell celdaSubtitulo = FilaSubtitulo.createCell(1);
        celdaSubtitulo.setCellValue("Informe de Unidades del Estado registradas en el aplicativo de la CURT "+f_inicio_reg+" al "+f_fin_reg+"");
        celdaSubtitulo.setCellStyle(estiloCeldaSubtitulo); 
        hoja1.addMergedRegion(new CellRangeAddress(4,5,1,9)); //fila,fila,columna,columna
    
    
    if(conexion.rs.next()){//SI encontró algo imprimimos lso encabezados...
        fila6.setHeight((short)0x220);
        XSSFCell celdaEntrega = fila6.createCell(1);
        celdaEntrega.setCellValue("APLICATIVO DE LA CURT");
        celdaEntrega.setCellStyle(estiloCeldaAzul);  
        hoja1.addMergedRegion(new CellRangeAddress(6,6,1,9)); //fila,fila,columna,columna   
        
        
     XSSFCell celdaDatIE = fila8.createCell(1);
     fila8.setHeight((short)0x190);
        celdaDatIE.setCellValue("REGISTRO DE UNIDADES DEL ESTADO");
         celdaDatIE.setCellStyle(estiloTituloVerde);  
        hoja1.addMergedRegion(new CellRangeAddress(8,8,1,9)); //fila,fila,columna,columna       
            
          
          
        XSSFCell celdaB10= fila10.createCell(1);
        celdaB10.setCellValue("ENTIDAD");
        celdaB10.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaC10= fila10.createCell(2);
        celdaC10.setCellValue("MUNICIPIO");
        celdaC10.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaD10= fila10.createCell(3);
        celdaD10.setCellValue("UNIDAD DEL ESTADO");
        celdaD10.setCellStyle(estiloCeldasBold);
        
       
        
        
    }//if   
    else{
        j = 11; //j seguira valiendo 40 porque no hay variables arriba
    }
     
     conexion.rs.beforeFirst(); //ESTE REGRESA el cursor a la primera fila que devuelve el ResulsSet (lo resetea)..., pero
                                //pero para que este funcione se debe agregar esta línea despues de la conuslta: ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE   
   while(conexion.rs.next()){
       
       /*nom_ent= conexion.rs.getString("nom_ent");
         if(nom_ent==null || nom_ent.equals("01/01/0001") ){nom_ent="";}*/
       
       nom_ent= conexion.rs.getString("nom_ent");
         if(nom_ent==null){nom_ent="";}
         
        municipio= conexion.rs.getString("municipio");
         if(municipio==null ){municipio="";}  
         
        nom_ue= conexion.rs.getString("nom_ue");
         if(nom_ue==null ){nom_ue="";}   
         
                 
  
     String[] datosP5 = {nom_ent,municipio,nom_ue};
         
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
  
   int k =0;
  int fv = 0; //modif 16_nov_18
  try{       
    PreparedStatement pst6=(PreparedStatement)conexion.conn.prepareStatement("SELECT c.\"NOM_EDO\" as nom_ent,count(id_ue) as total FROM \"seguim_CURT\".registro_ue a, \"seguim_CURT\".ufg_directori_ufg b, \"seguim_CURT\".cat_edo c WHERE b.\"Id\" = a.id_ue AND b.\"CVE_ENTIDAD\" = c.\"CVE_EDO\" AND a.fec_sol_reg between '"+f_inicio_reg+"' and '"+f_fin_reg+"' GROUP BY nom_ent ORDER BY nom_ent ASC;"  ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst6.executeQuery();
  
     fv = j+1; //desde aqui comienzan a ser variables las filas fv:fila variable
     
    if(conexion.rs.next()){       
  
  /* XSSFRow filaX = hoja1.createRow((short)fv); 
      filaX.setHeight((short)0x220);
        XSSFCell celdaDevolucion = filaX.createCell(1);
        celdaDevolucion.setCellValue("DEVOLUCIÓN DE INFORMACIÓN POR VALIDACIÓN PREVIA A LA GENERACIÓN");
        celdaDevolucion.setCellStyle(estiloCeldaAzul);  
        hoja1.addMergedRegion(new CellRangeAddress(fv,fv,1,9)); //fila,fila,columna,columna
     */
   //int fv2 = j+3;     
    XSSFRow filaX = hoja1.createRow((short)fv);
       XSSFCell celdaDatDevo = filaX.createCell(1);
       filaX.setHeight((short)0x190);
        celdaDatDevo.setCellValue("TOTALES");
         celdaDatDevo.setCellStyle(estiloTituloVerde);  
         hoja1.addMergedRegion(new CellRangeAddress(fv,fv,1,9)); //fila,fila,columna,columna        
        
         
  //int fv3 = j+5;
  int fv2 = j+3;   
  XSSFRow filaX3 = hoja1.createRow((short)fv2);
        XSSFCell celdaBX3= filaX3.createCell(1);
            celdaBX3.setCellValue("ENTIDAD");
        celdaBX3.setCellStyle(estiloCeldasBold);
        
        XSSFCell celdaCX3= filaX3.createCell(2);
        celdaCX3.setCellValue("CANTIDAD");
        celdaCX3.setCellStyle(estiloCeldasBold);     
     
        
     k = fv2+1;   //le asigno nuevo valor a k
    }//if
    else{
        k = j+2; //si no hay nada a k le damos el valor de j que es en el que se quedo
    }
    
   conexion.rs.beforeFirst(); //ESTE REGRESA el cursor a la primera fila que devuelve el ResulsSet (lo resetea)..., pero
                               //pero para que este funcione se debe agregar esta línea despues de la conuslta: ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE   
   while(conexion.rs.next()){
   
       
         /*fecha_dev= conexion.rs.getString("fecha_dev");
         if(fecha_dev==null || fecha_dev.equals("01/01/0001") ){fecha_dev="";}
         */
        nom_ent= conexion.rs.getString("nom_ent");
         if(nom_ent==null ){nom_ent="";}
         
         total= conexion.rs.getString("total");
         if(total==null ){total="";}
   
          String[] datosP6 = {nom_ent,total};
         
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
                 
           
   //Creo la celda A0
    XSSFCell CeldaA0 = fila.createCell(0);
             CeldaA0.setCellValue("");        
             
        // Volcamos la información a un archivo.
        //obtener cadena para descarga en carpeta de descargas del ususario
        String nombre="reporte de Unidades del Estado registradas en el aplicativo de la CURT.xlsx";
       
        
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
  /*       
         XSSFRow h2fila1 = hoja2.createRow((short)1); 
        
       h2fila1.setHeight((short)0x220);
        XSSFCell H2Celda0 = h2fila1.createCell(1);
        H2Celda0.setCellValue("Código");
        H2Celda0.setCellStyle(estiloCeldasBold);
        
      XSSFCell H2Celda1 = h2fila1.createCell(2);
        H2Celda1.setCellValue("Descripción");
        H2Celda1.setCellStyle(estiloCeldasBold);
        
        
        
        
        String[] codigos= {"1", "2", "3", "4", "5", "6", "7","8", "9","10","11a","11b","12a","12b","13","14","15","16","17","18","19"};
        String[] descripcion_c = {"La clave de la entidad federativa no debe ser nula.", "El número de dígitos de la clave de la entidad federativa es incorrecto.",
            "La clave del municipio o demarcación territorial no debe ser nula.", "El número de dígitos de la clave del municipio o demarcación territorial es incorrecto.",
            "La clave de localidad no debe ser nula.", "El número de dígitos de la clave de localidad es incorrecto.", "El identificador catastral no debe ser nulo.","El registro tabular contiene más de una geometría.",
            "Tipo de geometría no válida, debe ser polígono o multipolígono.","Geometría inválida (la geometría no está correctamente formada o cerrada en todos sus vértices; o bien, los vértices no intersecten entre sí con ellos mismos).",
            "El polígono está traslapado con alguno o algunos polígonos de la solicitud.","El polígono está traslapado con alguno o algunos polígonos de la información almacenada.","El polígono está duplicado con alguno o algunos polígonos de la solicitud.",
            "El polígono está duplicado con alguno o algunos polígonos de la información almacenada.","El polígono se encuentra fuera del rango establecido del territorio nacional.", "El identificador catastral está duplicado.",
        "El área que conforma el polígono debe ser mayor o igual a 1 metro cuadrado.","La Clave Única del Registro del Territorio esta duplicada.","La Clave Única del Registro del Territorio no debe ser nula.",
        "Las CURT´s ingresadas de los polígonos a fusionar deben de corresponder a su geometría.","Las CURT´s ingresadas de cada división, no corresponden al valor original de la clave."};
        
        
        for (int nz = 0; nz < codigos.length; nz++){
            //se agreaga el estilo y los valores del vector a la nueva fila
         XSSFRow h2filaX = hoja2.createRow((short)nz+2);
                 h2filaX.setHeight((short)0x220);
              XSSFCell H2celdaX = h2filaX.createCell(1); // creo la celdas en la columna 1
                        H2celdaX.setCellValue(codigos[nz]); //le doy el valor del vector
                     
                        
                        
                XSSFCell H2celdaY = h2filaX.createCell(2);  // creo la celdas en la columna 2        
                         H2celdaY.setCellValue(descripcion_c[nz]);
                          hoja1.autoSizeColumn(nz);
    
         }//for  
        
         hoja2.autoSizeColumn(0);
        hoja2.autoSizeColumn(1);
        hoja2.autoSizeColumn(2);
       
            
        */   
              
        
        
          
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
                    



        %>
