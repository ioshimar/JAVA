<%-- 
    Document   : llama_sistema_ins
    Created on : 7/06/2017, 10:21:13 AM
    Author     : RICARDO.MACIAS
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="BaseDatos.ConexionBD"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<%
    HttpSession objsesion_enc =request.getSession(false);
    String session_admin_curt = (String)objsesion_enc.getAttribute("session_admin_curt"); //se crea la variable de Sesión
    
 if(session_admin_curt!=null){  //SI NO ES NULLA
     
 ConexionBD conexion = new ConexionBD();  
  String nom_usuario="";
  boolean masterboolean = false;
         try{
         PreparedStatement pst41 =(PreparedStatement) conexion.conn.prepareStatement("SELECT  nombre, usuario, permisos, master FROM \"seguim_CURT\".tbl_admin where usuario = '"+session_admin_curt+"' ");
         conexion.rs =pst41.executeQuery(); //ejecutamos la consulta
        
         while(conexion.rs.next()) {//se guarda cada resultado en la variable de opciones
            nom_usuario = conexion.rs.getString("nombre");
            masterboolean = conexion.rs.getBoolean("master");
         }
         } catch(SQLException e){out.print("exception"+e);}
              finally {conexion.closeConnection(); } 
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><!-- indica el tipo de codificacion de la pagina-->
        <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes"> <!-- para que se ajuste a la pantalla del dispositivo-->
        <title>Seguimiento CURT </title>
       
        
      
        <script src="../js/jquery/jquery-latest.min.js" type="text/javascript"></script>
        <link href="../css/estilos_inicio.css" rel="stylesheet" type="text/css"/>
        <link href="../css/icomoon/iconos.css" rel="stylesheet" type="text/css"/>
         <link rel="shortcut icon" href="../images/favicon.ico"> 
         
     
      <script>
      function cargaNotif(){
   
                 var param2 = new Object();
                     param2["estatus"] = 'PENDIENTE';
                     var url2="../ConsSoliSop"; 
                     $.post(url2,param2,function(listaIdent2){
                         var elementoP2 = listaIdent2[0];
                           if(listaIdent2.length > 0){  //Si encuentra Algún registro
                               var total = elementoP2.total;
                             // alert(elementoP2.total);
                            document.getElementById("num_notif").innerHTML = total;
                            document.getElementById("text_notif").innerHTML = "<br> Hay "+total+" solicitud pendiente por atender <br>&nbsp;";
                         
                            setTimeout(cargaNotif, 1000 ); //carga la notificacion cada segundo
                           }
                         else{  
                              
                            };
                         
                     });
            
      }
  
      </script>   
      
      <script>
             
           $(document).ready(function(){
                    cargaNotif();
                   if(<%=masterboolean%>){
                       $("li.alta_us").show();
                   }else{
                       $("li.alta_us").hide();
                   }
                });   
        
      </script>
         
     
   
         
    </head>   

<body>

    <% 
       
       
      /*  PreparedStatement pst2 =(PreparedStatement) conexion.conn.prepareStatement("SELECT Count(*) as TOTAL  FROM \"seguim_CURT\".solicitud_soporte "
        + "WHERE estatus = 'PENDIENTE';",ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); //el Order BY ES MUY necesario 
        conexion.rs = pst2.executeQuery(); 
       
        String notificacion = ""; 
        int total = 0;
                while(conexion.rs.next()) {//se guarda cada resultado en la variable de opciones
                 total = conexion.rs.getInt("TOTAL");
       
                        if(total == 0){   //si es mayor a 0
                            notificacion = "";
                        }
                        else if(total == 1){   //si es mayor a 0
                            notificacion = "<br> Hay " +total+ " solicitud pendiente por atender <br>&nbsp;";
                        }
                        else if(total > 1){   //si es mayor a 0
                            notificacion = "<br> hay " +total+ " solicitudes pendientes por atender <br>&nbsp;";
                        }
                  }*/
    
    %>
      
   
    
     <div id="cabecera_admin" >
        <div id="log"> <a href="inicio_admin.jsp"> <!--<img src="images/icono_png.png" class="log_inegi" alt=""/>--><img src="../images/logoSegCurt.png" class="log_curt_ini" alt=""/></a></div>
                <div id="Text-Tit">
                    <span class="titulo2">PANEL DE ADMINISTRADOR 
                        <br><span class="text_small">DEL SISTEMA DE SEGUIMIENTO DE LA CURT</span>
                    </span><!-- parrafo de titulo-->
                </div>
   
        <div id="usuario"> 
            <li id="principal"><span class="icon-user"></span> <span class="nom_usu"> <%=nom_usuario.toUpperCase()%> <span class="caret icon-chevron-down"> <!--boton --></span> </span>
                    <ul class="hijo admin_sbmnu">    
                        <li class="psw"> <a href="cambiar_psw_admin.jsp">  <span class="icon-engrane"> </span>Cambiar Contraseña</a></li>
                        <li class="psw alta_us"> <a href="alta_admin.jsp">  <span class="icon-contactos"> </span>Usuario nuevo</a></li>
                        <li class="psw alta_us"> <a href="recupera_psw.jsp">  <span class="icon-unlocked"> </span>Recuperar Contraseña</a></li>
                        <li > <a href="logout_admin.jsp">  <span class="icon-exit"></span> Cerrar Sesión</a></li>
                    </ul>
            </li>
              <li class="submenu">
                <!-- < %if(notificacion.equals("")  ){%>   <!-- SI no hay notificaciones ...-->
               <!--   <span ><img src="../images/notif.png" alt="" title="No tienes notificaciones "/> </span>-->
                <!-- < %} else{%> -->
                       <span><img src="../images/notif.png"  title="" alt=""/> </span>
                       <div id="num_notif"> <!--< %out.println(total);%>--> </div>
                 
                         <ul class="children">
                            <a href="solicitudes.jsp"> 
                                <li id="text_notif"> <!--< %out.println(notificacion);%> --> </li>
                            </a>
                         </ul>
               <!-- < %}%> -->
                </li>
          
        </div>
    </div>

    <div id="tit_inicio"><!--<a href="index.jsp">&laquo; Ir al Inicio</a>--></div>
  
<div id="Cont-menu"> 
    
    

  
            <ul id="navbar">
                <a href="mod_capt_admin.jsp"> 
                    <li id="n1"><!-- primer elemento de la lista-->
                    <img src="../images/cap_ad.png" alt=""/>
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
                <a href="consulta_admin.jsp"> 
                <li id="n2">
                    <img src="../images/cons_ad.png" alt=""/>
                    <div id="li_txt">Consultar</div>
                </li>
                </a>
                
                
                
                <a href="mod_export_admin.jsp">
                <li id="n3">
                    <img src="../images/exp_ad.png" alt=""/>
                    <div id="li_txt">Exportar</div>
                   
                </li>
                </a>
              <a href="solicitudes.jsp">   
               <li id="n4">
                    <img src="../images/soporte1.png" alt=""/>
                    <div id="li_txt">Soporte</div>
                   
                </li>
              </a>  
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
     <script>location.href = "index_admin.jsp";</script>
    
    <% 
       }// Termina el ELSE 
    %>