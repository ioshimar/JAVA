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

<%@page import="java.text.DateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.swing.DefaultComboBoxModel"%>
<%--<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="ie6 oldie"> <![endif]-->
<!--[if IE 7]>    <html class="ie7 oldie"> <![endif]-->
<!--[if IE 8]>    <html class="ie8 oldie"> <![endif]-->
<!--[if gt IE 8]><!-->

<%
    HttpSession objsesion_enc =request.getSession(false);
    String sesion_cve_enc = (String)objsesion_enc.getAttribute("session_curt1"); //se crea la variable de Sesión
    
    String nom_user = request.getParameter("nom_user");
    String cve_ent = request.getParameter("cve_ent");
    String nom_ent = request.getParameter("nom_ent");  
     if(sesion_cve_enc!=null){  //SI NO ES NULLA
          
%>
<html>
    <%
        //conexiones a la base de datos
        ConexionBD conexion=new ConexionBD();
        ConexionDirecBD conexionDir =new ConexionDirecBD(); 
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


<link href="css/icomoon/iconos.css" rel="stylesheet" type="text/css"/>
<link href="header_menu/header.css" rel="stylesheet" type="text/css"/>
<script src="header_menu/menuResponsive.js" type="text/javascript"></script>
<link href="header_menu/menu_responsive.css" rel="stylesheet" type="text/css"/>
    </head>
    
    <body>
      <%
         String nom_usuario="";
       try{
         PreparedStatement pst41 =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_EDO\",\"CVE_EDO\" from seguimiento_cap.cat_edo where \"CVE_EDO\" = '"+sesion_cve_enc+"' ");
         conexion.rs =pst41.executeQuery(); //ejecutamos la consulta
         while(conexion.rs.next()) {//se guarda cada resultado en la variable de opciones
         nom_usuario = conexion.rs.getString("NOM_EDO");
         }
       } catch(SQLException e){out.print("exception"+e);}
              finally {//conexion.closeConnection();
       }  
     %> 
         
     
       <div class="menu_bar">
            <a style="cursor:pointer;" class="bt-menu"> 
            <span class="icon-menu3"></span> <img src="images/inegi_vertical.png" width="51" height="31"/></a>
        </div> 
   <header>
        <div id="logo"> <a href="inicio_curt.jsp?nom_user=<%=nom_user%>"><img id="log-inegi" src="images/logo_blanco_comp.png" alt=""/></a></div>
        <div id="nav">
            <ul class="text-left">
              <!--<li><a href="javascript:window.history.back();">&laquo; Regresa una página</a></li>-->
            <a href="inicio_curt.jsp?nom_user=<%=nom_user%>"> <li> Inicio</li></a>
             <a href="selecciona_ue.jsp?nom_user=<%=nom_user%>"> <li> Capturar</li></a>
            <a href="resultado_consulta_gen_tot.jsp?nom_user=<%=nom_user%>"> <li> Consultar reporte</li></a>
            <!--<a href="modulo_exportacion.jsp"> <li> Exportar</li></a>-->
           
          </ul>
           <ul class="text-right">
              <li><span class="negrita"><%=nom_usuario.toUpperCase()%> <span class="caret icon-chevron-down"> <!--boton --></span></span>
                    <ul class="children">    
                        <li> <a href="cambiar_psw.jsp?nom_user=<%=nom_user%>"> <span class="icon-settings2"></span> Cambiar contraseña</a></li>
                    </ul>
             </li>
             <li class="cerrar_ses"> <a href="logout_curt.jsp">  Cerrar Sesión</a></li>
           </ul>
        </div>
    </header>
        
        <!-- MODIFICACION 20/07/2017-->
        
        <!-- TERMINA MODIFICACION 20/07/2017 -->
        <div id="margen-oculto">&nbsp;</div>
      
           <div id="Div_Titulo">
              
              <div id="img_logo"><img src="images/logoSegCap.png" alt=""/></div>
              <div id="txt_titu">
              <span class="text_small">SISTEMA </span> <span class="text_small">PARA EL REGISTRO
                  <br> </span> <span class="TextTitulo">DE CAPACITACIONES CATASTRALES</span>
                   <!-- parrafo de titulo-->
              </div>      
           </div>
      
     
               
           <br>
           <br>
        <!--<div id="cont_consulta">-->
           <!--
           <span class="CarroisGR16">Informe de la instrumentación  de la CURT por Unidad del Estado total</span><br><br>
            <div class="r_tit"> UNIDADES DEL ESTADO REGISTRADAS QUE HAN GENERADO CURT: </div> 
            -->
         
             
            <br><br>
                   
               <div class="r_tit"> CAPACITACIONES DE <%= nom_ent.toUpperCase() %></div>
                
              
                <%             
            
            PreparedStatement pst25 =(PreparedStatement) conexion.conn.prepareStatement("SELECT T1.fecha_cap,count(*) as num_institu, sum(T1.cant_pers) as personas, string_agg(T2.\"INSNOMBRE\"::text, ', ' order by T2.\"INSNOMBRE\") as instituciones, ((case when T1.norma_cat = '' then '' else 'Norma de Catastro' end ) || ' - ' || (case when T1.norma_curt = '' then '' else 'Norma de la CURT' end ) || ' - ' || (case when T1.lineamiento = '' then '' else 'Lineamientos para el intercambio de información' end )|| ' - ' || (case when T1.diccionario = '' then '' else 'Diccionarios 1:1,000 y 1:10,000' end )) as doc "
                    + "FROM seguimiento_cap.capacitacion AS T1, seguimiento_cap.ufg_directori_ufg as T2 WHERE T2.\"Id\"  =  T1.id_ue AND T2.\"CVE_ENTIDAD\"='"+cve_ent+"' GROUP BY T1.fecha_cap,doc;");
            conexion.rs =pst25.executeQuery();
            
            if(!conexion.rs.isBeforeFirst()){                  
  
         %>
           <table>
            <tr><td class="center" style="background:none; padding:8px 0; font-size:18px; border:none;">NO HAY REGISTROS</td></tr>
           </table>
           <%
               }
                else{ 
               out.println("<table>");
				out.println("<thead>");
					out.println("<tr class='backrep'><th width='8%'><span class='Gotham-Book'>FECHA</span></th><th><span class='Gotham-Book'>NUMERO DE INSTITUCIONES</span></th><th><span class='Gotham-Book'>INSTITUCIONES</span></th><th><span class='Gotham-Book'>NUMERO DE PERSONAS CAPACITADAS</span></th><th><span class='Gotham-Book'>DOCUMENTOS</span></th></tr>");
                                      
                                out.println("</thead>");
				out.println("<tbody>");
                                while(conexion.rs.next()) {
                                String docu = conexion.rs.getString("doc");
                                       //docu = docu.replace("- ", " ");
					out.println("<tr><td><span class='CarroisGR'>"+conexion.rs.getString("fecha_cap")+"</span></td><td><span class='CarroisGR'>"+conexion.rs.getString("num_institu")+"</span></td><td><span class='CarroisGR'>"+conexion.rs.getString("instituciones")+"</span></td><td><span class='CarroisGR'>"+conexion.rs.getString("personas")+"</span></td><td><span class='CarroisGR'>"+docu+"</span></td></tr>");
                                        };
					
					
				out.println("</tbody>");
				out.println("<tfoot>");
				out.println("</tfoot>");
			out.println("</table>");
                 }  

      
                conexion.rs.close();
                
                conexion.closeRsStmt();
                conexion.closeConnection();
                                 


           %> 
                   
           <div id="cur_notas"><a href="exportar_reporte_capa_edo.jsp?cve_ent=<%=cve_ent%>&nom_ent=<%=nom_ent%>" target="_new">Descargar archivo</a></div>
      
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

    
  