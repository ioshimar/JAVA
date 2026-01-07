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
     if(sesion_cve_enc!=null){  //SI NO ES NULLA
          
%>
<html>
    <%
        //conexiones a la base de datos
        ConexionBD conexion=new ConexionBD();
        ConexionDirecBD conexionDir =new ConexionDirecBD(); 
    %>
     
   
    <head>
        <!--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><!-- tipo de codificacion-->
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
        
      <!-------------------------------- SELECT con buscador ---------------------------------------->
          
         <link href="css/select2/select2.css" rel="stylesheet" type="text/css"/>
         <script src="js/select2/select2.min.js" type="text/javascript"></script>
         
         <script>
          // In your Javascript (external .js resource or <script> tag)
            $(document).ready(function() {
               $('.js-example-basic-single').select2({
                    placeholder: 'Selecciona una unidad del estado'
                   // theme: "classic"
                    //tags: true,
               });
            });
            
        </script>
      <!-- Termina SELECT con buscador-->
        

        
        
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
        <%! String claves_estado, entidad_encargado, claves_separadas ; %> <!--Variables Globales -->
        
        <%
            //CON ESTA CONSULTA SACAMOS TODOS LOS ESTADOS QUE LE PERTENECEN A LA REGIONAL: sesion_cve_enc
            
       try{     
         PreparedStatement pst23 =(PreparedStatement) conexion.conn.prepareStatement("select \"ENCESTATALES\", \"CVE_ENTIDAD\"  FROM seguimiento_cap.\"Encargados_CURT\" where \"CVE_ENTIDAD\"='"+sesion_cve_enc+"'");
            conexion.rs =pst23.executeQuery(); 
            while(conexion.rs.next()) {
            claves_estado = conexion.rs.getString("ENCESTATALES");
            }
         claves_separadas = claves_estado.replaceAll(",", "','");  
   } catch(SQLException e){out.print("exception"+e);}
              finally {
          // conexion.closeConnection();
       }
        %>
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
        
        
        <div id="cont_formulario">
            
         <form action="captura.jsp?nom_user=<%=nom_user%>" method="post" onsubmit="return valida()" >     
            <span class="TextTitulo subrayado">Capturar Unidad del Estado &nbsp;&nbsp;&nbsp;<%=nom_user%></span><br><br><br>
            
            <div id="cont_center2">
                <br><br>
           <div id="cont_left"> 
               <span class="lbl_slc">Nombre de la Unidad del Estado</span><br>
                   <!-- <input type="text" name="name_ue" id="name_ue" class="w50">-->
                   <select name="ue" id="ue" class="w100 js-example-basic-single" >
                        <option value=""> Selecciona una unidad del estado...</option>
                          <%
                     //nueva conslta para rellenar el listado
                String nombre_ue="";
                String nom_ent="";
                String folio_ue="";
                String ue_ID ="";
                String nom_mun ="";
              try{  
                
 PreparedStatement pst25 =(PreparedStatement) conexion.conn.prepareStatement( "select T1.\"Id\",T1.\"FOLIO\",T1.\"INSNOMBRE\",T1.\"CVE_ENTIDAD\", T1.\"CVE_MUN\", T1.\"INSNOMBRECIUDADMPIO\", T2.\"NOM_EDO\" "
                + "FROM  seguimiento_cap.ufg_directori_ufg as T1, seguimiento_cap.cat_edo as T2 "
                + "WHERE T1.\"CVE_ENTIDAD\"  =  T2.\"CVE_EDO\"  "
                + "AND   T1.\"CVE_ENTIDAD\" In('"+claves_separadas+"') "
                + "AND (T1.\"AMBITO\" LIKE 'E-C%' OR T1.\"AMBITO\" LIKE 'E-CR%' OR  T1.\"AMBITO\" LIKE 'F-RAN%' OR T1.\"AMBITO\" LIKE 'E-RPP%' OR T1.\"AMBITO\" LIKE 'E-O%' OR T1.\"AMBITO\" LIKE 'M-D%' OR T1.\"AMBITO\" = 'M' OR T1.\"AMBITO\" = 'E' OR T1.\"AMBITO\" = 'F' OR T1.\"AMBITO\" LIKE 'M-O%') "
                + "AND habilitado != FALSE"
                + " ORDER BY T1.\"CVE_ENTIDAD\", T1.\"INSNOMBRE\"");
                conexion.rs =pst25.executeQuery(); 
                while(conexion.rs.next()) {
                 nombre_ue= conexion.rs.getString("INSNOMBRE");
              // folio_ue=conexionDir.rs.getString("FOLIO"); 
                 ue_ID = conexion.rs.getString("Id");
                 nom_ent = conexion.rs.getString("NOM_EDO");
                 nom_mun = conexion.rs.getString("INSNOMBRECIUDADMPIO").toLowerCase();  //lo convertimos primero a minusculas
            
                String Nombre_mun2 = nom_mun.substring(0, 1).toUpperCase() + nom_mun.substring(1); // Solo convertimos la primera a mayuscula
                Nombre_mun2 = new String(Nombre_mun2.getBytes("UTF-8"),"ISO-8859-1");
               //Nombre_mun2 = Nombre_mun2.replaceAll("[^\\p{ASCII}]", "");
            
                      %> 
                        <OPTION value="<%=ue_ID%>"><%out.println(nombre_ue + "   " + "  (" +Nombre_mun2.toUpperCase() +", "+nom_ent.toUpperCase()+") " );%> </OPTION> 
                <% 
                 }
                 } catch(SQLException e){out.print("exception"+e);}
              finally {conexion.closeConnection(); }  
                %>  
                        
                    </select>
                    
               
                </div><br>
                <br>
                <div style="text-align: right;">
                    ¿No se encuentra la Unidad del Estado?<br>
                    <a href="alta_ue.jsp?nom_user=<%=nom_user%>">Registrar nueva UE</a></div>
         
                <br><br>
               
            </div>
                
                  <div id="btn_enviar">
                      <input type="button" value="&ll; Regresar" onclick="javascript:window.location.href='inicio_curt.jsp?nom_user=<%=nom_user%>'" class="bcancelar">    &nbsp;
                    <input type="submit" value="Capturar datos">
                 </div>
       </form>
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