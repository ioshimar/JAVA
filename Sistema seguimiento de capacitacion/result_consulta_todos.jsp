<%-- 
    Document   : captura
    Created on : 27-jun-2018, 10:53:27
    Author     : ricardo.macias
--%>
<%@page import="BaseDatos.ConexionDirecBD"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="BaseDatos.Operaciones"%>
<%@page import="java.sql.*"%>
<%@page import="BaseDatos.ConexionBD"%>
<%@page import="BaseDatos.ConexionBDB"%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.swing.DefaultComboBoxModel"%>
<%--<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="ie6 oldie"> <![endif]-->
<!--[if IE 7]>    <html class="ie7 oldie"> <![endif]-->
<!--[if IE 8]>    <html class="ie8 oldie"> <![endif]-->
<!--[if gt IE 8]><!-->


<%
    HttpSession objsesion_enc =request.getSession(false);
    String sesion_cve_enc = (String)objsesion_enc.getAttribute("session_curt"); //se crea la variable de Sesión
     if(sesion_cve_enc!=null){  //SI NO ES NULLA
%>
<html>
    <%
        //conexiones a la base de datos
        ConexionBD conexion=new ConexionBD();
        ConexionBD conexion2=new ConexionBD();
        ConexionBD conexion3=new ConexionBD();
        ConexionBDB conexion4=new ConexionBDB();
        ConexionDirecBD conexionDir =new ConexionDirecBD(); 
       String cve_estado = request.getParameter("cve_estado");
     
    %>
     
   
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><!-- tipo de codificacion-->
          <link rel="icon" href="images/icono_png.ico" type="image/gif" sizes="16x16">
          <link rel="shortcut icon" href="images/favicon.ico"> 
 
          <script src="js/jquery/jquery-latest.min.js" type="text/javascript"></script>
          <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes"> <!-- para que se ajuste a la pantalla del dispositivo-->
        <title>Registrar</title><!-- titulo de la pagina-->
        
        <link href="css/formularios_curt.css" rel="stylesheet" type="text/css"/>
     
    
          <script src="js/cancela_act.js" type="text/javascript"></script>
          
    
        <script>
            function valida(){
                 var ue = document.getElementById("ue").value;
                 
               if(!ue){
                     alert("Selecciona la Unidad del Estado");
                     setTimeout(function() { document.getElementById('ue').focus(); }, 10);
                     return false;
                    }
                return true;
           };
            
         
        </script>
      
        

        
        
<script type="text/javascript">
 //funcion de carga de lista desplegable al selceccionar un elemento de la lista anterior
<%!
        public static String getFechaActual() {//funcion para obtener la fecha actual
        
        SimpleDateFormat formateador = new SimpleDateFormat("dd 'de 'MMMM 'de 'yyyy", new Locale("ES", "MX"));//se define el formato de la fecha
        Date ahora = new Date();//se crea un objeto date
        return formateador.format(ahora);//regresa la fecha actual con el formato establecido
    }
%>
</script>  


<link href="header_menu/MenuIconos.css" rel="stylesheet" type="text/css"/>
<link href="header_menu/header.css" rel="stylesheet" type="text/css"/>
<script src="header_menu/menuResponsive.js" type="text/javascript"></script>
<link href="header_menu/menu_responsive.css" rel="stylesheet" type="text/css"/>
    </head>
    
    <body>
      
     
       
       
      
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
    tipo_entrega,fecha_entrega12,fec_ue,nom_arch12,arch_ue,cant_reg12,cant_ue, nom_resp_ocent, nom_resp_rec12, nom_resp_ent12, nom_resp_uerec,
    //Constancia
    fec_sol, fec_emi, folio_cons, idue
    
    ; 
     int total_con_curt;
     int total_sin_curt;
     %>  
      
       
        <%
         
          try{       
    PreparedStatement pstn2=(PreparedStatement)conexion3.conn.prepareStatement("SELECT id_ue FROM \"seguim_CURT\".concertacion WHERE cve_ent = '"+cve_estado+"'" ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion3.rs=pstn2.executeQuery();
conexion3.rs.beforeFirst();
  
while(conexion3.rs.next()){
        idue= conexion3.rs.getString("id_ue");
      
     %>
    
   <div id="cont_consulta">   
        
        
      
            <span class="CarroisGR16">Informe de la instrumentación  de la CURT por Unidad del Estado</span><br><br>
            <div class="r_tit"> DATOS DE LA UNIDAD DEL ESTADO </div> 
            
         
            
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
        if(fec_pri_env==null || fec_pri_env.equals("01/01/0001")) {fec_pri_env="--/--/--";}
        
        fec_pri_res = conexion.rs.getString("fec_pri_res");
        if(fec_pri_res==null || fec_pri_res.equals("01/01/0001")){fec_pri_res="--/--/--";}
        
        fec_seg_env = conexion.rs.getString("fec_seg_env");
        if(fec_seg_env==null || fec_seg_env.equals("01/01/0001")){fec_seg_env="--/--/--";}
        
        fec_seg_res = conexion.rs.getString("fec_seg_res");
        if(fec_seg_res==null || fec_seg_res.equals("01/01/0001")){fec_seg_res="--/--/--";}
        
         fec_ter_env = conexion.rs.getString("fec_ter_env");
        if(fec_ter_env==null || fec_ter_env.equals("01/01/0001") ){fec_ter_env="--/--/--";}
        
        fec_ter_res = conexion.rs.getString("fec_ter_res");
        if(fec_ter_res==null || fec_ter_res.equals("01/01/0001")){fec_ter_res="--/--/--";}
        
        
        nombre_destin1 = conexion.rs.getString("nombre_destin1");
        if(nombre_destin1==null || nombre_destin1.equals("") ){nombre_destin1="_ _ _";}
        
        nombre_remi1= conexion.rs.getString("nombre_remi1");
        if(nombre_remi1==null ||nombre_remi1.equals("")){nombre_remi1="_ _ _";}
        
        
        nombre_destin2 = conexion.rs.getString("nombre_destin2");
        if(nombre_destin2==null || nombre_destin2.equals("") ){nombre_destin2="_ _ _";}
        
        nombre_remi2= conexion.rs.getString("nombre_remi2");
        if(nombre_remi2==null || nombre_remi2.equals("")){nombre_remi2="_ _ _";}
        
         nombre_destin3 = conexion.rs.getString("nombre_destin3");
        if(nombre_destin3==null || nombre_destin3.equals("") ){nombre_destin3="_ _ _";}
        
        nombre_remi3= conexion.rs.getString("nombre_remi3");
        if(nombre_remi3==null || nombre_remi3.equals("")){nombre_remi3="_ _ _";}
        
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
        if(acepto==null || acepto.equals("")){acepto="__";}
        
        que_acepto = conexion.rs.getString("que_acepto");
        if(que_acepto==null ||que_acepto.equals("")){que_acepto="__";}
        
        motivo = conexion.rs.getString("motivo");
        if(motivo==null || motivo.equals("")){motivo="__";}
        
        observacionesp1 = conexion.rs.getString("observaciones");
        if(observacionesp1==null){observacionesp1="";}
        
%>
         <div style="font-size:13px;">  <span class="Gotham-Book fbold" >Nombre de la UE:</span>  <span class="CarroisGR"><%=nom_ue%> </span></div><br>
            <div id="rcols2">  <span class="Gotham-Book fbold" >Entidad: </span>         <span class="CarroisGR"><%=nom_ent%> </span> </div>
            <div id="rcols2">  <span class="Gotham-Book fbold" >Municipio:</span>        <span class="CarroisGR" > <%=municipio%>  </span></div>
            
            <br><br>
            
            <div id="rcols5"> </div>
            <div id="rcols5"><span class="Gotham-Book fbold"> Fecha de envío del oficio </span></div>
            <div id="rcols5"><span class="Gotham-Book fbold"> Fecha de respuesta</span> </div>
            <div id="rcols5"><span class="Gotham-Book fbold"> Nombre del Remitente</span></div>
            <div id="rcols5"><span class="Gotham-Book fbold"> Nombre del Destinatario</span></div>
            
             <div id="rcols5"><span class="Gotham-Book fbold">1° Oficio </span></div>
            <div id="rcols5"><span class="CarroisGR"><%=fec_pri_env%> </span></div>
            <div id="rcols5"><span class="CarroisGR"><%=fec_pri_res%>  </span></div>
            <div id="rcols5"><span class="CarroisGR"><%=nombre_remi1%></span></div>
            <div id="rcols5"><span class="CarroisGR"><%=nombre_destin1%></span></div>
            
            <div id="rcols5"><span class="Gotham-Book fbold">2° Oficio</span> </div>
            <div id="rcols5"><span class="CarroisGR"><%=fec_seg_env%> </span></div>
            <div id="rcols5"><span class="CarroisGR"><%=fec_seg_res%>  </span></div>
            <div id="rcols5"><span class="CarroisGR"><%=nombre_remi2%></span></div>
            <div id="rcols5"><span class="CarroisGR"><%=nombre_destin2%></span></div>
            
            <div id="rcols5"><span class="Gotham-Book fbold">3° Oficio</span> </div>
            <div id="rcols5"><span class="CarroisGR"><%=fec_ter_env%> </span></div>
            <div id="rcols5"><span class="CarroisGR"><%=fec_ter_res%> </span></div>
            <div id="rcols5"><span class="CarroisGR"><%=nombre_remi3%></span></div>
            <div id="rcols5"><span class="CarroisGR"><%=nombre_destin3%></span></div>
            <br><br><br>
            
            <div id="rc1"><span class="Gotham-Book fbold"> ¿Aceptó?</span></div>
            <div id="rc2"><span class="Gotham-Book fbold"> ¿Qué aceptó?</span></div>
            <div id="rc3"><span class="Gotham-Book fbold"> ¿Motivos por las que la UE no Aceptó?</span></div>
            
            <div id="rc1"><span class="CarroisGR"><%=acepto%></span></div>
            <div id="rc2">
                <span class="CarroisGR"> 
                    <%=que_acepto%>
                </span>
            </div>
            <div id="rc3"><span class="CarroisGR"> <%=motivo%></span></div>
            <br><br>
            <div id="rcols2">
                <span class="Gotham-Book fbold" >Observaciones </span> 
                <span class="CarroisGR"><%=observacionesp1%> </span>
            </div>
            <br><br>
                   

 <%
 }else{
%>
    <table><tr><td class="center" style="background:none; padding:8px 0; font-size:18px; border:none;">NO HAY REGISTROS</td> </tr></table>
<%
   } 
 }  catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
                       //conexion.closeConnection();
                    }  
%>
            
    <div class="r_tit"> CAPACITACIÓN </div>         
            
            
      <%
      try{       
    PreparedStatement pst3=(PreparedStatement)conexion.conn.prepareStatement("SELECT id_cap, id_ue, TO_CHAR(fecha_cap, 'dd/MM/yyyy') as fecha_cap, lugar, resp_inegi, cant_pers, TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado, TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as  fecha_actualizacion\n" +
"  FROM \"seguim_CURT\".capacitacion  WHERE id_ue = '"+idue+"'"  ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst3.executeQuery();
    
    if(conexion.rs.next()){//SI encontró algo imprimimos lso encabezados...
        
         fecha_cap= conexion.rs.getString("fecha_cap");
         if(fecha_cap==null){fecha_cap="";}
         
         resp_inegi= conexion.rs.getString("resp_inegi");
         if(resp_inegi==null){resp_inegi="";}
         
        cant_pers= conexion.rs.getString("cant_pers");
         if(cant_pers==null){cant_pers="";} 
         
         resp_inegi = conexion.rs.getString("resp_inegi");
         if(resp_inegi==null){resp_inegi="";} 
    %>
        
           
            <div id="rcols2">  <span class="Gotham-Book fbold" >Fecha de capacitación:</span>  <span class="CarroisGR"><%=fecha_cap%> </span></div>
            <div id="rcols2">  <span class="Gotham-Book fbold" >Cantidad de Personas:</span>  <span class="CarroisGR"><%=cant_pers%></span></div><br>
            <div id="rcols2">  <span class="Gotham-Book fbold" >Nombre del responsable que lo impartió:</span>  <span class="CarroisGR"><%=resp_inegi%> </span></div>
            <br><br>
    <%  
    } else{
    %>
       <table><tr><td class="center" style="background:none; padding:8px 0; font-size:18px; border:none;">NO HAY REGISTROS</td> </tr></table>
    <%
    } 
 } catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
              //          conexion.closeConnection();
                    }
      %>      
            
 <div class="r_tit"> REGISTRO DE LAS UNIDADES DE ESTADO </div>      
     <%
     try{       
    PreparedStatement pst4=(PreparedStatement)conexion.conn.prepareStatement("SELECT  TO_CHAR(fec_sol_reg, 'dd/MM/yyyy') as fec_sol_reg, TO_CHAR(fec_env_doc, 'dd/MM/yyyy') as fec_env_doc,  TO_CHAR(fec_val_doc, 'dd/MM/yyyy') as fec_val_doc, "
                + "TO_CHAR(fec_env_firm, 'dd/MM/yyyy') as fec_env_firm, TO_CHAR(fec_regus, 'dd/MM/yyyy') as  fec_regus, TO_CHAR(fec_rec_doc, 'dd/MM/yyyy') as  fec_rec_doc" +
                "  FROM \"seguim_CURT\".registro_ue WHERE id_ue = '"+idue+"'"  ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst4.executeQuery();
    
        if(conexion.rs.next()){//SI encontró algo imprimimos lso encabezados...
             fec_sol_reg= conexion.rs.getString("fec_sol_reg");
             if(fec_sol_reg == null || fec_sol_reg.equals("01/01/0001") ){fec_sol_reg="";}

             fec_env_doc= conexion.rs.getString("fec_env_doc");
             if(fec_env_doc==null || fec_env_doc.equals("01/01/0001")){fec_env_doc="";}

             fec_rec_doc= conexion.rs.getString("fec_rec_doc");
             if(fec_rec_doc==null || fec_rec_doc.equals("01/01/0001")){fec_rec_doc="";}

     %>
         
            <div id="rcols3">  <span class="Gotham-Book fbold" >Fecha de solicitud de registro:</span> </div>
            <div id="rcols3">  <span class="Gotham-Book fbold" >Fecha de envío de los documentos escaneados:</span>  </div>
            <div id="rcols3">  <span class="Gotham-Book fbold" >Fecha de recepción de  documentos originales:</span>  </div>
            
            <div id="rcols3"><span class="CarroisGR"><%=fec_sol_reg%> </span></div>
            <div id="rcols3"><span class="CarroisGR"><%=fec_env_doc%> </span></div>
            <div id="rcols3"><span class="CarroisGR"><%=fec_rec_doc%> </span></div>
     <%        
        }else{
    %>
            <table><tr><td class="center" style="background:none; padding:8px 0; font-size:18px; border:none;">NO HAY REGISTROS</td> </tr></table>
     <% }
     }  catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
              //          conexion.closeConnection();
                    }   
     %>       
            
            
        
            <br><br>
            
            <div class="r_tit"> DATOS DE LA INFORMACIÓN ENTREGADA AL INEGI </div> 
            
         <table>
<%
try{       
    PreparedStatement pst5=(PreparedStatement)conexion.conn.prepareStatement("SELECT id_entrega, id_ue, TO_CHAR(fecha, 'dd/MM/yyyy') as fecha, nom_resp_ent, unidad_admin, nom_resp_rec, medio, nom_archivo, tamano, total_reg FROM \"seguim_CURT\".datos_entrega_fis WHERE id_ue = '"+idue+"'"  ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst5.executeQuery();
    
    if(conexion.rs.next()){//SI encontró algo imprimimos lso encabezados...
%>
                <tr class="backrep">
                     <td><span class="Gotham-Book">Fecha de entrega física</span></td>
                     <td><span class="Gotham-Book">Nombre del archivo</span></span></td>
                     <td><span class="Gotham-Book">Número de registros</span></td>
                     <td><span class="Gotham-Book">Nombre del responsable del INEGI que recibió</span></td>
                     <td><span class="Gotham-Book">Medio Utilizado</span></td>
                     <td><span class="Gotham-Book">Unidad Administrativa quien recibe</span></td>
                </tr>
 <%
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
         
   
      %>             
                 <tr>
                     <td><span class="CarroisGR"> <%out.print(fecha_entfis); %></span></td>
                     <td><span class="CarroisGR"> <%out.print(nom_archivo); %></span></td>
                     <td><span class="CarroisGR"> <%out.print(total_reg); %></span></td>
                     <td><span class="CarroisGR"> <%out.print(nom_resp_rec); %></span></td>
                     <td><span class="CarroisGR"> <%out.print(medio); %></span></td>
                     <td><span class="CarroisGR"> <%out.print(unidad_admin); %></span></td>
                 </tr>
     <%
      }//while
 }//if   
    else{
%>
        <tr><td class="center" style="background:none; padding:8px 0; font-size:18px; border:none;">NO HAY REGISTROS</td></tr>
<%      
    }
 }//try
    catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
              //          conexion.closeConnection();
                    } 
     %>            
             </table>
            
            <br><br>
            <div class="r_tit"> DATOS DE DEVOLUCIÓN DE INFORMACIÓN</div> 
            
            
            <table>  
            
 <%
       try{       
    PreparedStatement pst6=(PreparedStatement)conexion.conn.prepareStatement("SELECT  TO_CHAR(fecha_dev, 'dd/MM/yyyy') as fecha_dev, nom_resp_dev, nom_rec_dev, arch_dev, \n" +
" total_regdev, fecha_llenado, fecha_actualizacion, motivos_dev,  id_entrega, nom_archivo \n" +
"  FROM \"seguim_CURT\".devolucion WHERE id_ue = '"+idue+"'"  ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst6.executeQuery();
  
    if(conexion.rs.next()){
   %>
   
            <tr class="backrep">
                     <td><span class="Gotham-Book">Fecha de devolución</span></td>
                     <td><span class="Gotham-Book">Motivo de devolución</span></span></td>
                     <td><span class="Gotham-Book">Nombre del archivo que se devolvió</span></td>
                     <td><span class="Gotham-Book">Total de registros en el archivo devuelto</span></td>
                     <td><span class="Gotham-Book">Nombre del responsable de INEGI que devolvió</span></td>
                     <td><span class="Gotham-Book">Nombre de quien recibió en la UE</span></td>
                </tr>
   
   <%
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
    %>
                 <tr>
                     <td><span class="CarroisGR"> <%out.print(fecha_dev); %></span></td>
                     <td><span class="CarroisGR"> <%out.print(motivos_dev); %></span></td>
                     <td><span class="CarroisGR"> <%out.print(arch_dev); %></span></td>
                     <td><span class="CarroisGR"> <%out.print(total_regdev); %></span></td>
                     <td><span class="CarroisGR"> <%out.print(nom_resp_dev); %></span></td>
                     <td><span class="CarroisGR"> <%out.print(nom_rec_dev); %></span></td>
                 </tr>
    <%
    }//while
   }//if
    else{
    %>
             <tr><td class="center" style="background:none; padding:8px 0; font-size:18px; border:none;">NO HAY REGISTROS</td></tr>
    <%
    }
 }//try
  catch(SQLException e){out.print("exception"+e);
                    }finally {
              //          conexion.closeConnection();
                    }
 %>
            
            </table>
            
 <br><br>
  <div class="r_tit">ASESORÍA A LA UNIDAD DEL ESTADO</div> 
  
 <!-- <table style="max-width: 600px; margin: 0 auto;">-->
  <%
   try{       
    PreparedStatement pst3=(PreparedStatement)conexion.conn.prepareStatement("SELECT tipo_asesoria  FROM \"seguim_CURT\".asesoria"
            + "  WHERE id_ue = '"+idue+"'",ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst3.executeQuery();
    
    if(conexion.rs.next()){//SI encontró algo imprimimos los encabezados...
        tipo_asesoria= conexion.rs.getString("tipo_asesoria");
         if(tipo_asesoria==null ){tipo_asesoria="";}
         
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
     %>
     
     <script>
         
       $(document).ready(function(){
           //Se ponen las variables entre comillas, para que las detecte como String "< % T_regUE % >"
         if("<%=T_regUE%>" ==="X"){ document.getElementById("Creg_ue").checked = true;}
         if("<%=T_uso%>" ==="X"){  document.getElementById("Cuso").checked=true; }
         if("<%=T_estructura%>" ==="X"){  document.getElementById("CEstInfo").checked=true; }
         if("<%=T_coord%>" ==="X"){  document.getElementById("Ccoord").checked=true; }
         if("<%=T_infoS%>" ==="X"){  document.getElementById("Cinfos").checked=true; }
         if("<%=T_interp%>" ==="X"){  document.getElementById("Cinterp").checked=true; }
       });
     </script>
     
     <span class="Gotham-Book fbold" style="font-size: 16px;"> Tipo de Asesorías:</span><br>
     <div id="cols2"> 
         <input type="checkbox" disabled="" id="Creg_ue"> <span class="Gotham-Book"> Registro de la Unidad del Estado</span> <br>
         <input type="checkbox" disabled="" id="Cuso"> <span class="Gotham-Book"> Uso y manejo del aplicativo</span><br>
         <input type="checkbox" disabled="" id="CEstInfo"> <span class="Gotham-Book"> Estructuración de la información</span><br>
     </div>
     <div id="cols2"> 
         <input type="checkbox" disabled="" id="Ccoord"> <span class="Gotham-Book"> Convertir coordenadas cartesianas a geográficas</span><br>
         <input type="checkbox" disabled="" id="Cinfos"> <span class="Gotham-Book"> Convertir información de un sistema de referencia geodésico a otro</span><br>
        <input type="checkbox" disabled="" id="Cinterp"> <span class="Gotham-Book"> Interpretación de los resultados de generación/actualización de la CURT</span><br>
     </div>
     
  
     <%
         
    }
    
    else{
    %>
    <table><tr><td class="center" style="background:none; padding:8px 0; font-size:18px; border:none;">NO HAY REGISTROS</td> </tr></table>
    <%
        
    }
  }catch(SQLException e){out.print("exception"+e);
                    }finally {
              //          conexion.closeConnection();
                    }
  %>
  
 <!-- </table> -->
 
 
 <div class="r_tit">GENERACIÓN Y/O ACTUALIZACIÓN DE LA CURT</div>
 <table>
 <%
 try{       
    PreparedStatement pst7=(PreparedStatement)conexion4.conn.prepareStatement("SELECT id_gen, id_ue, nom_resp, TO_CHAR(fech_ini, 'dd/MM/yyyy') as fech_ini,  TO_CHAR(fech_fin, 'dd/MM/yyyy') as fech_fin, pred_concurt, pred_sincurt, \n" +
"       TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado,  TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as fecha_actualizacion, total_motgen, mot_gen, id_entrega, \n" +
"       nom_archivo\n" +
"  FROM \"seguim_CURT\".generacion_curt WHERE id_ue = '"+idue+"' ORDER BY id_gen" ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion4.rs=pst7.executeQuery();
    
    System.out.print("");
    
 if(conexion4.rs.next()){
    %>
    
   <!--Aqui pueden ir los encabezados-->
    <% 
     
     
  total_con_curt = 0; //esto es clave para que se reinicie a 0 antes de hacer el while
  total_sin_curt = 0;
 
  conexion4.rs.beforeFirst(); //ESTE REGRESA el cursor a la primera fila que devuelve el ResulsSet (lo resetea)...,
  while (conexion4.rs.next()){
     
         fech_ini10= conexion4.rs.getString("fech_ini");
         if(fech_ini10==null || fech_ini10.equals("01/01/0001") ){fech_ini10="";}
       
        fech_fin10= conexion4.rs.getString("fech_fin");
         if(fech_fin10==null || fech_fin10.equals("01/01/0001") ){fech_fin10="";}
         
    
         
         pred_concurt= conexion4.rs.getString("pred_concurt");
         if(pred_concurt==null ){pred_concurt="";}
         
         pred_sincurt= conexion4.rs.getString("pred_sincurt");
         if(pred_sincurt==null ){pred_sincurt="";}
         
         nom_archivo10= conexion4.rs.getString("nom_archivo");
         if(nom_archivo10==null ){nom_archivo10="";}
         
         id_gen10= conexion4.rs.getString("id_gen");
         if(id_gen10==null ){id_gen10="";}
         
  
    %>
    
    <tr class="backrep">
        <td><span class="Gotham-Book fbold">Proceso Realizado</span></td>
        <td><span class="Gotham-Book fbold">Nombre del archivo</span></td>
        <td><span class="Gotham-Book fbold">Nombre original del archivo</span></td>
        <td><span class="Gotham-Book fbold">Inicio de procesamiento</span></td>
        <td><span class="Gotham-Book fbold">Término de procesamiento</span></td>
        <td><span class="Gotham-Book fbold">Predios con CURT</span></td>
        <td><span class="Gotham-Book fbold">Predios sin CURT</span></td>
        <td colspan="2"><span class="Gotham-Book fbold">Motivos por los que no se les genero la CURT</span></td>
    </tr>
  
  <!--<tr style="height: 10px;"></tr> <!-- Espaciado -->
  <tr>
        <td>Generación</td>
        <td><span class="CarroisGR"><%=nom_archivo10%></span></td>
        <td><span class="CarroisGR"><%=nom_archivo10%></span></td>
        <td><span class="CarroisGR"><%=fech_ini10%></span></td>
        <td><span class="CarroisGR"><%=fech_fin10%></span></td>
        <td><span class="CarroisGR"><%=pred_concurt%></span></td>
        <td><span class="CarroisGR"><%=pred_sincurt%></span></td>
        <td style="text-align: center; color: #0a5e51;">Código de motivo</td>
        <td style="text-align: center; color: #0a5e51;">Total</td>
    </tr>
    
    
  <!--  <tr>
        <td style="background: #fff; border: none;"></td>
        <td style="background: #fff; border: none;"></td>
        <td style="background: #fff; border: none;"></td>
        <td style="background: #fff; border: none;"></td>
        <td style="background: #fff; border: none;"></td>
        <td style="background: #fff; border: none;"></td>
        <td style="background: #fff; border: none;"></td>
        <td>Motivos</td>
        <td>Total</td>
    </tr>
    -->
   
    
     <%     
       
       int int_cc =  Integer.parseInt(pred_concurt);//lo pasamos a entero
         total_con_curt = total_con_curt + int_cc;
         
         int int_sc = Integer.parseInt(pred_sincurt);
         total_sin_curt = total_sin_curt + int_sc;
         
         
  PreparedStatement pst9 = (PreparedStatement)conexion2.conn.prepareStatement("SELECT mot_gen as motg,  total_motgen as totg FROM \"seguim_CURT\".motivos_gen WHERE id_gen = '"+id_gen10+"'" ); 
    conexion2.rs=pst9.executeQuery();
    
     int tot_mot_gen = 0;
            while(conexion2.rs.next()){   
              mot_gen= conexion2.rs.getString("motg");
                 if(mot_gen==null ){mot_gen="";}

              tot_gen= conexion2.rs.getString("totg");
                 if(tot_gen==null ){tot_gen="";}
                 
      tot_mot_gen = tot_mot_gen +Integer.parseInt(tot_gen);            
%>
     <tr>
        <td style="background: #fff; border: none;"></td>
        <td style="background: #fff; border: none;"></td>
        <td style="background: #fff; border: none;"></td>
        <td style="background: #fff; border: none;"></td>
        <td style="background: #fff; border: none;"></td>
        <td style="background: #fff; border: none;"></td>
        <td style="background: #fff; border: none;"></td>
        <td style="text-align: center; color:#0c51b7;">  <span class="Gotham-Book fbold"><%=mot_gen%></span></td>
        <td style="text-align: center; color: #0c51b7"><span class="Gotham-Book fbold"><%=tot_gen%></span></td>
     </tr>
    
      
     
<%
                  
            }  //while    
    %>
     <tr>
         <td colspan="7"></td>
         <td style="font-weight: bold; text-align: right;">TOTAL:</td>
         <td style="font-weight: bold; text-align: center;"><%=tot_mot_gen%></td>
     </tr>
    <%
    //  m++;
   }//while principal   
  %>
  <div id="cur_notas"><a href="curtnotas.pdf" target="_new">Descargar archivo de notas  &Downarrow;</a></div><!--Ponemos el link para descargar el archivo de los códigos-->
  <tr class="backrep">
     <td colspan="5" ></td>
     <td style="font-weight: bold;">Total con CURT</td>
     <td style="font-weight: bold;">Total sin CURT</td>
 </tr>
  <tr>
     <td colspan="5" style="text-align: right; font-weight: bold;"></td>
     <td style="font-weight: bold;"><%=total_con_curt%></td>
     <td style="font-weight: bold;"><%=total_sin_curt%></td>
 </tr>
  
  <%  

}//if 
 else{
   %>
   <tr><td class="center" style="background:none; padding:8px 0; font-size:18px; border:none;">NO HAY REGISTROS</td> </tr>
   <%
}
             
  }//try
  catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
                      conexion2.closeConnection();
                      // conexion.closeConnection();
                    }
     
 
 %>
 
 </table>
 
 <div class="r_tit"> DATOS DE LA ENTREGA </div>  
 <table>
 
 <%
 try{       
    PreparedStatement pst10=(PreparedStatement)conexion.conn.prepareStatement("SELECT id_dae, id_ue, TO_CHAR(fecha_entrega, 'dd/MM/yyyy') as fecha_entrega, nom_resp_ent, nom_resp_rec, id_entrega, "
            + "nom_arch, cant_reg, fecha_llenado, fecha_actualizacion, tipo_entrega"
            + " FROM \"seguim_CURT\".datos_entrega_p12 WHERE id_ue = '"+idue+"'" ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); 
    conexion.rs=pst10.executeQuery();        
 
    if(conexion.rs.next()){
 %>
 <tr class="backrep">   
     <td><span class="Gotham-Book">Entrega:</span></td>
     <td><span class="Gotham-Book">Fecha de entrega:</span></td>
     <td><span class="Gotham-Book">Nombre del archivo:</span></td>
     <td><span class="Gotham-Book">Cantidad de registros:</span></td>
     <td><span class="Gotham-Book">Nombre del responsable del INEGI que entrega la información:</span></td>
     <td><span class="Gotham-Book">Nombre del responsable que recibe la información:</span></td>
 </tr>
 <%     
        
   conexion.rs.beforeFirst(); //ESTE REGRESA el cursor a la primera fila que devuelve el ResulsSet (lo resetea)..., pero   //pero para que este funcione se debe agregar esta línea despues de la conuslta: ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE   
    while(conexion.rs.next()){     
        
        tipo_entrega= conexion.rs.getString("tipo_entrega");
                 if(tipo_entrega==null ){tipo_entrega="";}  
                 
        fecha_entrega12= conexion.rs.getString("fecha_entrega");
                 if(fecha_entrega12==null ){fecha_entrega12="";}     
                 
        nom_arch12= conexion.rs.getString("nom_arch");
                 if(nom_arch12==null ){nom_arch12="";}  
                 
        
                 
        cant_reg12= conexion.rs.getString("cant_reg");
                 if(cant_reg12==null ){cant_reg12="";} 
                 
       
                 
        nom_resp_ent12= conexion.rs.getString("nom_resp_ent");
                 if(nom_resp_ent12==null ){nom_resp_ent12="";}   
      
                 
        nom_resp_rec12= conexion.rs.getString("nom_resp_rec");
                 if(nom_resp_rec12==null ){nom_resp_rec12="";}     
           
       
           //  datosP12 = {tipo_entrega, fecha_entrega12, nom_arch12, cant_reg12};
        
   %>          
             <tr>
                 <td><span class="CarroisGR"> <%=tipo_entrega%> </span></td>
                 <td><span class="CarroisGR"> <%=fecha_entrega12%> </span></td>
                 <td><span class="CarroisGR"> <%=nom_arch12%> </span></td>
                 <td><span class="CarroisGR"> <%=cant_reg12%> </span></td>
                 <td><span class="CarroisGR"> <%=nom_resp_ent12%> </span></td>
                 <td><span class="CarroisGR"><%=nom_resp_rec12%> </span></td>        
             </tr>
   <%            
         
 %>
    
 
 <%    
    }//while     
 }//if
 else{
 %>
   <tr><td class="center" style="background:none; padding:8px 0; font-size:18px; border:none;">NO HAY REGISTROS</td> </tr>
 <%   
    }
  }//try
  catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
              //          conexion.closeConnection();
                    } 
 %>
 </table>
 <br><br>
  <div class="r_tit"> CONSTANCIA DE COBERTURA </div>  
  
  <%
  
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
   
  %>
            <div id="rcols2">  <span class="Gotham-Book fbold" >Fecha de solicitud:</span>  <span class="CarroisGR"><%=fec_sol%> </span></div>
            <div id="rcols2">  <span class="Gotham-Book fbold" >Fecha de emisión:</span>  <span class="CarroisGR"><%=fec_emi%></span></div><br>
            <div id="rcols2">  <span class="Gotham-Book fbold" >No. de folio constancia:</span>  <span class="CarroisGR"><%=folio_cons%> </span></div>
            <br><br>
  
  <%               
    }//if
    else{
%>
    <table><tr><td class="center" style="background:none; padding:8px 0; font-size:18px; border:none;">NO HAY REGISTROS</td> </tr></table>
 <% 
    }
  }//try
  catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
                      // conexion.closeConnection();
                    }    
  %>
 
       
      
  
     
 </div>   
  <br><br>
        
      <%
      }//while 
          } catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
                        conexion.closeConnection();
                       conexion3.closeConnection();
                    }  %>
      
    </body>
</html>


<%
    } //termina el if

      else{  
        // out.print("Debes Iniciar Sesión"); 
    %>
     <script> alert("Inicia sesión para ver esta página"); </script>
     <script> location.href = "index.jsp"; </script>
    
    <% 
       }// Termina el ELSE 
    %>