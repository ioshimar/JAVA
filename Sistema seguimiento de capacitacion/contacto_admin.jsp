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
    String sesion_cve_enc = (String)objsesion_enc.getAttribute("session_curt"); //se crea la variable de Sesión
     if(sesion_cve_enc!=null){  //SI NO ES NULLA
%>
<html>
    <%
        //conexiones a la base de datos
        ConexionBD conexion=new ConexionBD();
        ConexionDirecBD conexionDir =new ConexionDirecBD(); 
        String id_ue = request.getParameter("ue"); 
        String tipo_solicitud = request.getParameter("tipo_solicitud"); 
    %>
     
   
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><!-- tipo de codificacion-->
          <link rel="icon" href="images/icono_png.ico" type="image/gif" sizes="16x16">
          <link rel="shortcut icon" href="images/favicon.ico"> 
 
        
          <script src="js/jquery/jquery-latest.min.js" type="text/javascript"></script>
          <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes"> <!-- para que se ajuste a la pantalla del dispositivo-->
        <title>Solicitud liberación</title><!-- titulo de la pagina-->
        
        <link href="css/formularios_curt.css" rel="stylesheet" type="text/css"/>
       
        <script src="js/ajx_guarda_soli_soporte.js" type="text/javascript"></script>
    
         <script>
              function cancelar_activ(){
                var r = confirm("¿Deseas regresar?");
                if (r === true) {
                         //location.href = "captura.jsp?ue="+< %=id_ue%>;
                      //    postwith('captura.jsp',{ue:'< %=id_ue%>'}); //mandamos la URL
                      window.history.back(-1);
                } 
                };
          </script>
          
    
     
        
      
        
     
        
<script type="text/javascript">
 //funcion de carga de lista desplegable al selceccionar un elemento de la lista anterior
<%!
        public static String getFechaActual() {//funcion para obtener la fecha actual
        
        SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy", new Locale("ES", "MX"));//se define el formato de la fecha
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
         PreparedStatement pst41 =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_EDO\",\"CVE_EDO\" from \"seguim_CURT\".cat_edo where \"CVE_EDO\" = '"+sesion_cve_enc+"' ");
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
        <div id="logo"> <a href="inicio_curt.jsp"><img id="log-inegi" src="images/logo_blanco_comp.png" alt=""/></a></div>
        <div id="nav">
            <ul class="text-left">
              <!--<li><a href="javascript:window.history.back();">&laquo; Regresa una página</a></li>-->
            <a href="inicio_curt.jsp"> <li> Inicio</li></a>
             <a href="selecciona_ue.jsp"> <li> Capturar</li></a>
            <a href="modulo_consulta.jsp"> <li> Consultar</li></a>
            <a href="modulo_exportacion.jsp"> <li> Exportar</li></a>
           
          </ul>
           <ul class="text-right">
              <li><span class="negrita"><%=nom_usuario.toUpperCase()%> <span class="caret icon-chevron-down"> <!--boton --></span></span>
                     <ul class="children">    
                        <li> <a href="cambiar_psw.jsp"> <span class="icon-engrane"></span> Cambiar contraseña</a></li>
                    </ul>
             </li>
             <li class="cerrar_ses"> <a href="logout_curt.jsp"><span class="icon-exit"></span>  Cerrar Sesión</a></li>
           </ul>
        </div>
    </header>
       
        <div id="margen-oculto">&nbsp;</div>
      
           <div id="Div_Titulo">
              
              <div id="img_logo"><img src="images/logoSegCurt.png" alt=""/></div>
              <div id="txt_titu">
              <span class="text_small">SISTEMA </span> <span class="text_small">DE SEGUIMIENTO DE LA
                  <br> </span> <span class="TextTitulo">CLAVE ÚNICA DEL REGISTRO DEL TERRITORIO</span>
                   <!-- parrafo de titulo-->
              </div>      
           </div>
        
        
        <div id="cont_formulario" style="max-width: 800px;">
            <br>
            <div id="cont_center">  
            <span class="TextTitulo subrayado"> <span class="icon-mail"></span> Solicitar liberación</span>
            <br><br><br>
       <form name="form_contacto" id="form_contacto">
           <br>
           
            <% String fecha=getFechaActual();%>
             <div id="div_fecha">Fecha: 
              <input type="text" id="fecha_hoy" name="fecha_hoy" value="<%out.print(fecha);%>" readonly style="border-width:0; background:none; font-weight: bold;" class="w15" >
             </div>
           
              <input type="hidden" name="id_ue" id="id_ue" value="<%=id_ue%>" class="w10">
              <input type="hidden" name="tipo_solicitud" id="tipo_solicitud" value="<%=tipo_solicitud%>" class="w15"><br>
           
           <div id="col_textCenter_2"><span class="lbl_slc">Nombre completo</span></div>
           <div id="col_inpCenter_2"> <input type="text" name="nombre_soli" id="nombre_soli" class="w30" >  </div>
           
           <br><br>
           
           
           <div id="col_textCenter_2"><span class="lbl_slc">Correo</span> </div>
            <div id="col_inpCenter_2"> <input type="text" name="correo" id="correo" class="w30" >  </div>
            <br><br>
            
            <div id="col_textCenter_2"><span class="lbl_slc">Mensaje:</span> </div>
            <div id="col_inpCenter_2"> <textarea name="mensaje" id="mensaje" rows="4"></textarea></div>
                      
            <br><br>
            <div id="btn_enviar">
                <input type="button" value="&ll; Regresar" onclick="javascript:cancelar_activ();" class="bcancelar"> &nbsp; &nbsp; &nbsp;
                <input type="button" value="+ Guardar" onclick="javascript:proceso_guarda_solicitud();" id="guarda_reg" name="guarda_reg">
            </div>
                      
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