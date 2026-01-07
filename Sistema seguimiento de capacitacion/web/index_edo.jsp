<%-- 
    Document   : index
    Created on : 19/06/2018, 01:06:25 PM
    Author     : IOSHIMAR.RODRIGUEZ
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
    String nom_user = (String)objsesion_enc.getAttribute("session_curt"); //se crea la variable de Sesión
    
 
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Captura</title>
        <link href="css/estilos_login.css" rel="stylesheet" type="text/css"/>
             <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
          <link rel="shortcut icon" href="images/favicon.ico">  
        <link href="css/estilos_inicio.css" rel="stylesheet" type="text/css"/>
        <link href="css/icomoon/iconos.css" rel="stylesheet" type="text/css"/>  
        <script src="js/jquery/jquery-latest.min.js" type="text/javascript"></script>
        
        <script src="js/ajax_log.js" type="text/javascript"></script>
        
        <script>//Script para que se ejecute el ajax con el botón Enter del teclado
            $(document).keypress(function(e) { 
                    //mayor compatibilidad entre navegadores.
                    var code = (e.keyCode ? e.keyCode : e.which);
                    if(code==13){
                         ajax_sesion();
                    }else{}
                    
            });
        </script>
        
       
      
        
        <script>//Script para cerrar DIV
                $(document).ready(function() {
                       $("#cerrarDiv").click(function(){
                               $("section#R1").slideUp() ;
                       });
                });
        </script>
        <script>
            function removeClass(val_id){
                var elemento = document.getElementById(val_id);
                $(elemento).removeClass("error");  //removmeos la clase error del input password 
                 $("section#R1").slideUp("slow") ; //quitamos el mensaje de error
            }
        </script>
      
        
        <script>   
            /*------*OPCION 2 SIN USAR------------- */
      /*      function esMayuscula(letra){
                 return letra === letra.toUpperCase();
            }
            function esMinuscula(letra){
                return letra === letra.toLowerCase();
            }   

            function comprobar_mayus(){
                    var miPalabra = document.getElementById("pwd").value;
                                       
                    for(var index = 0; index < miPalabra.length; index++){
                        var letraActual = miPalabra.charAt(index);
                        if(esMayuscula(letraActual)) {
                            //alert("La letra " + letraActual + " es mayúscula");
                             document.getElementById("text_alert_psw").innerHTML = " Bloq. mayús activado";
                             $('.alert_psw').show(); //mostramos el div
                        }
                        if(esMinuscula(letraActual)){
                            //alert("La letra " + letraActual + " es minúscula");
                            $('.alert_psw').hide(); //OCULTAMOS el div
                        }  
                    }
            }
            
                  $( "#pwd" ).blur(function() { 
                     $('.alert_psw').hide(); //OCULTAMOS el div
                  }); 
                  
                  $( "#pwd" ).click(function() {
                     comprobar_mayus(); //mostramos el div
                  }); 
    */

        </script>
        

        
        
        
    </head>
    <% ConexionBD conexion=new ConexionBD(); %><!-- nueva conexion -->
    <body style="background-size: cover;"> <!---->
        <div id="cabecera">
        <div id="log"> <a href="index_edo.jsp?nom_user=<%=nom_user.toUpperCase()%>"> <!--<img src="images/icono_png.png" class="log_inegi" alt=""/>--><img src="images/logoSegCap.png" class="log_curt_ini" alt=""/></a></div>
                <div id="Text-Tit">
                    <span class="titulo2">SISTEMA PARA EL REGISTRO
                        <br><span class="text_small">DE CAPACITACIONES CATASTRALES</span>
                    </span><!-- parrafo de titulo-->
                </div>
   
        <div id="usuario"> 
            <li id="principal"><span class="icon-user"></span>&nbsp; <span class="nom_usu"> <%=nom_user.toUpperCase()%> <span class="caret icon-chevron-down"> <!--boton --></span> </span>
                    <ul class="hijo">    
                        <li class="psw1"> <a href="cambiar_psw.jsp?nom_user=<%=nom_user.toUpperCase()%>">  <span class="icon-engrane"> </span> Cambiar Contraseña</a></li>
                        <li > <a href="logout_curt.jsp"> <span class="icon-exit"> </span> Cerrar Sesión</a></li>
                    </ul>
            </li>
        </div>
    </div>
                    
        <div id="tit_inicio"><!--<a href="index.jsp">&laquo; Ir al Inicio</a>--></div>
        
        <div id="Cont-menu"> 
                    
         <section id="R1"><div id="result">   </div><div id="cerrarDiv"><img src="images/cerrar.png" width="30" height="30"/></div> </section>
         <div id="contenedor-login1">
             
                <!--<a href="index.jsp" title="Ir al Inicio"> <img  src="images/login4.png" alt="" id="size-personal"/></a><br><br>
             <h4 class="teclear">Iniciar sesión</h4><br>-->
       <form id="form_sesion">
           <!-- <div id="c1"><span>Estado:</span> </div>-->
            
            <div id="c2">
               
                <img src="images/us.png" id="imag_es"/><select name="estado" id="estado">
                    <option value="">Selecciona un estado...</option>    <!-- primera opcion todos-->        
                   <%
                String comboasen1="",clave1="";//se cara la variable que contendra cada opcion
                
             try{    
                PreparedStatement pst =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_EDO\",\"CVE_EDO\" from seguimiento_cap.cat_edo WHERE \"CVE_EDO\" not like '00' ORDER BY \"CVE_EDO\" ");
                conexion.rs =pst.executeQuery(); //ejecutamos la consulta
                        while(conexion.rs.next()) {//se guarda cada resultado en la variable de opciones
                        comboasen1 = conexion.rs.getString("NOM_EDO");
                        clave1=conexion.rs.getString("CVE_EDO");
                        int num_estado =conexion.rs.getInt("CVE_EDO");  //Solo para poner el numero antes del Nombre
                        if(comboasen1==null)comboasen1="";
                           %> 
                        <option value="<%=clave1%>"> <%out.println(num_estado +". " + comboasen1);%><!-- se agreaga la opcion --> </option>
                        <% }
            } catch(SQLException e){out.print("exception"+e);}
              finally {conexion.closeConnection(); }       
                        %>
             </select>
            </div>
             
             <br>
           <!--  <div id="c1">  <span>Clave de acceso</span></div>-->
           <div id="c2">
               <div class="div_relative">
                  <input type="hidden" name="pwd" id="pwd" placeholder="********" onkeypress="removeClass(this.id);" onkeyup=""  >
                     <div class="alert_psw"><span id="text_alert_psw"> </span></div>
               </div>
           </div>
             
             
           <div style="display: none;"><input type="hidden" name="nom_usuario" id="nom_usuario" value="<%=nom_user.toUpperCase()%>" >     </div> <!-- Solo para que al dar enter no se reseten los demas input-->
                    
          <div id="boton">
              <input type="button" value="Ingresar" id="enviar" onclick="javascript:ajax_sesion();"> <!-- boton de envio de formulario, llama a funcion valida-->
          </div>
            
        </form>
         </div>
        </div>
             <div id="foot"> </div>
    </body>
</html>
