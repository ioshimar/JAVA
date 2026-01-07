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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="ie6 oldie"> <![endif]-->
<!--[if IE 7]>    <html class="ie7 oldie"> <![endif]-->
<!--[if IE 8]>    <html class="ie8 oldie"> <![endif]-->
<!--[if gt IE 8]><!-->


<%
    HttpSession objsesion_enc =request.getSession(false);
    String sesion_cve_enc = (String)objsesion_enc.getAttribute("session_curt1"); //se crea la variable de Sesión
    String nom_user = request.getParameter("nom_user");
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
        <title>Cambiar contraseña</title><!-- titulo de la pagina-->
        
        <link href="css/formularios_curt.css" rel="stylesheet" type="text/css"/>
        <script src="js/ajax_ps.js" type="text/javascript"></script>
    
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
        
      
        
      <script>
        function ver_psw(){
               if($('#show_password').is(':checked')){// Convertimos el input de contraseña a texto.
                   $('#old_psw').get(0).type='text';
               } else {// En caso contrario..
                 $('#old_psw').get(0).type='password';// Lo convertimos a contraseña.
              }
              
              if($('#show_password2').is(':checked')){
                  $('#new_psw').get(0).type='text';
              }else{
                  $('#new_psw').get(0).type='password';
              }
              
              if($('#show_password3').is(':checked')){
                  $('#repeat_psw').get(0).type='text';
              }else{
                  $('#repeat_psw').get(0).type='password';
              }
          
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
            <!--<a href="modulo_consulta.jsp"> <li> Consultar</li></a>
            <a href="modulo_exportacion.jsp"> <li> Exportar</li></a>-->
           
          </ul>
           <ul class="text-right">
              <li><span class="negrita"><%=nom_usuario.toUpperCase()%> <span class="caret icon-chevron-down"> <!--boton --></span></span>
                     <ul class="children">    
                        <li> <a href="cambiar_psw.jsp?nom_user=<%=nom_user%>"> <span class="icon-engrane"></span> Cambiar contraseña</a></li>
                    </ul>
             </li>
             <li class="cerrar_ses"> <a href="logout_curt.jsp"><span class="icon-exit"></span>  Cerrar Sesión</a></li>
           </ul>
        </div>
    </header>
       
        <div id="margen-oculto">&nbsp;</div>
      
           <div id="Div_Titulo">
              
              <div id="img_logo"><img src="images/logoSegCap.png" alt=""/></div>
              <div id="txt_titu">
              <span class="text_small">SISTEMA </span> <span class="text_small">PARA EL REGISTRO
                  <br> </span> <span class="TextTitulo">DE CAPACITACIONES CATASTRALES</span>
                   <!-- parrafo de titulo-->
              </div>      
           </div>
        
        
        <div id="cont_formulario" style="max-width: 500px;">
            <br>
            <div id="cont_center">  
            <span class="TextTitulo subrayado"> <span class="icon-settings2"></span>Cambiar Contraseña</span>
            <br><br><br>
       <form name="formu_pass" id="formu_pass">
                <input type="hidden" name="usuario" id="usuario" value="<%=sesion_cve_enc%>">
                <input type="hidden" name="nom_user" id="nom_user" value="<%=nom_user%>">
                   <div class="relative">        
                          <span class="lbl_psw">Contraseña actual</span><br>
                          <input type="password" name="old_psw" id="old_psw" class="w20">
                        
                        <div id="cont_psw2">
                            <label><input id="show_password" type="checkbox"  onclick="javascript:ver_psw();"/> Ver contraseña </label>
                        </div>
                   </div>
                      <br>
                      
                    <div class="relative">   
                       <span class="lbl_psw">Nueva contraseña</span> <br>
                       <input type="password" name="new_psw" id="new_psw" class="w20">
                       
                       <div id="cont_psw2">
                             <label><input id="show_password2" type="checkbox" onclick="javascript:ver_psw();" /> Ver contraseña</label>
                        </div>
                    </div>
                      <br>
                    <div class="relative">    
                      <span class="lbl_psw">Confirma la nueva contraseña</span><br>
                      <input type="password" name="repeat_psw" id="repeat_psw" class="w20">
                      
                       <div id="cont_psw2">
                             <label><input id="show_password3" type="checkbox" onclick="javascript:ver_psw();" /> Ver contraseña</label>
                        </div>
                    </div>
                      <br> <br>
                      
                      
                      <input type="button"  value="Aceptar" onclick="javascript:ajax_ps();">
                      
                  </form>
                      <br>
            </div>
        </div>
       
      
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