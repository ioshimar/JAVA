<%-- 
    Document   : llama_sistema_ins
    Created on : 7/06/2017, 10:21:13 AM
    Author     : RICARDO.MACIAS
--%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="BaseDatos.ConexionBD"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<%
    HttpSession objsesion_enc =request.getSession(false);
    String sesion_cve_enc = (String)objsesion_enc.getAttribute("session_curt1"); //se crea la variable de Sesión
    
    String nom_user = request.getParameter("nom_user");
    
 if(sesion_cve_enc!=null){  //SI NO ES NULLA
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><!-- indica el tipo de codificacion de la pagina-->
        <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes"> <!-- para que se ajuste a la pantalla del dispositivo-->
        <title>Seguimiento CURT </title>
        <script src="js/jquery/jquery-latest.min.js" type="text/javascript"></script>
        <link href="css/estilos_inicio.css" rel="stylesheet" type="text/css"/>
        <link href="css/icomoon/iconos.css" rel="stylesheet" type="text/css"/>
         <link rel="shortcut icon" href="images/favicon.ico"> 
      <script>
      /*  $(document).ready(function() {  
            var estado = < %=sesion_cve_enc%>;
            
                if(estado>33){  //Si es Mayor (33, 34, 35 ...)
                      $('#navbar li#n1').hide();    //Ocultamos el modulo Inscripción
                      $('#navbar li#n3 ul a#uest').addClass('no_disponible');      //ocultamos el modulo (actualizar unidad de estado)
                 }
          
                         //ESTE Código es para el efecto del submenú (cerrar sesión)
                            $('#principal').click(function(){
                                 $(this).children('.hijo').slideToggle();
                             });           
         });
        */
  
      </script>   
         
      <script type="text/javascript">
       
    </script>
         
    </head>   

<body>

    <% ConexionBD conexion = new ConexionBD();  
    
    %>
      
    <%
        
         String nom_usuario="";
         try{
         PreparedStatement pst41 =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_EDO\",\"CVE_EDO\" from seguimiento_cap.cat_edo where \"CVE_EDO\" = '"+sesion_cve_enc+"' ");
         conexion.rs =pst41.executeQuery(); //ejecutamos la consulta
         while(conexion.rs.next()) {//se guarda cada resultado en la variable de opciones
         nom_usuario = conexion.rs.getString("NOM_EDO");
         }
         } catch(SQLException e){out.print("exception"+e);}
              finally {conexion.closeConnection(); }  
     %> 
    
    <div id="cabecera">
        <div id="log"> <a href="inicio_curt.jsp?nom_user=<%=nom_user%>"> <!--<img src="images/icono_png.png" class="log_inegi" alt=""/>--><img src="images/logoSegCap.png" class="log_curt_ini" alt=""/></a></div>
                <div id="Text-Tit">
                    <span class="titulo2">SISTEMA PARA EL REGISTRO
                        <br><span class="text_small">DE CAPACITACIONES CATASTRALES</span>
                    </span><!-- parrafo de titulo-->
                </div>
   
        <div id="usuario"> 
            <li id="principal"><span class="icon-user"></span>&nbsp; <span class="nom_usu"> <%=nom_user%> <span class="caret icon-chevron-down"> <!--boton --></span> </span>
                    <ul class="hijo">    
                        <!--<li class="psw"> <a href="cambiar_psw.jsp">  <span class="icon-engrane"> </span> Cambiar Contraseña</a></li>-->
                        <li class="psw"> <a href="index_edo.jsp?nom_user=<%=nom_user%>">  <span class="icon-menu3"> </span> Capturar otra Entidad</a></li>
                        <li > <a href="logout_curt.jsp"> <span class="icon-exit"> </span> Cerrar Sesión</a></li>
                    </ul>
            </li>
        </div>
    </div>

    <div id="tit_inicio"><!--<a href="index.jsp">&laquo; Ir al Inicio</a>--></div>
  
<div id="Cont-menu"> 
    
    

  
            <ul id="navbar">
                <a href="selecciona_ue.jsp?nom_user=<%=nom_user%>"> 
                    <li id="n1"><!-- primer elemento de la lista-->
                    <img src="images/cap2W.png" alt=""/>
                    <div id="li_txt">Capturar</div>
                    <ul><!--lista dentro de lista -->
                        
                    </ul><!--fin de la sublista -->
                    </li><!--fin del primer elemento-->
                </a>
                <!--
                <li id="n2">
                    <img src="images/actualizarW.png" alt=""/>
                    <div id="li_txt">Actualizar</div>
                    
                    <ul>
                        <a href="#">  <li>---</li></a>
                        <a href="#"> <li>---</li></a>   
                    </ul>
                </li>
                -->
                <!--<a href="modulo_consulta.jsp"> 
                <li id="n2">
                    <img src="images/consultar.png" alt=""/>
                    <div id="li_txt">Consultar</div>
                </li>
                </a>-->
                
                
                
                <!--<a href="modulo_exportacion.jsp">
                <li id="n3">
                    <img src="images/exportarW.png" alt=""/>
                    <div id="li_txt">Exportar</div>
                   
                </li>
                </a>-->
               <!-- <a href="Manual_CURT.PDF" target="_new" >
                <li id="n4">
                    <img src="images/manual.png" alt=""/>
                    <div id="li_txt">Manual</div>
                </li>
               </a>-->
               <!-- <li id="n6"><img src="images/icono_png.png"/><br><br><a href='#'>Resumen</a>
                    <ul>
                        <a href="#">   <li>---</li></a>
                        <a href="#">  <li>---</li></a>
                    </ul>
                </li>
                
                 <li id="n7"><img src="images/icono_png.png"/><br><br><a href='#'>Producto</a>
                    <ul>
                        <a href="#">  <li>---</li> </a> 
                     <!--   <a href="#">  <li>Panel de Administrador</li> </a> 
                    </ul>
                     -->
                <!-- </li>-->
                 
                 <li id="oculto">
                     
                 </li>
                 
               <!--<li id="n8"><img src="images/marco_jur.png"/><br><br><a href='#'>Marco Jurídico</a>
                    <ul>
                       <a href="alta_marco_jur.jsp">  <li>Inscribir</li> </a>                  
                    </ul>
               </li>-->
          
             </ul>

</div>
    
     <div id="foot"> </div>
    
    </body>
</html>


<%
    } //termina el if

      else{  
        // out.print("Debes Iniciar Sesión"); 
    %>
     <script> alert("Inicia Sesión");</script>
     <script>location.href = "index.jsp";</script>
    
    <% 
       }// Termina el ELSE 
    %>