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


<%--<%
    HttpSession objsesion_enc =request.getSession(false);
    String sesion_cve_enc = (String)objsesion_enc.getAttribute("session_curt"); //se crea la variable de Sesión
     if(sesion_cve_enc!=null){  //SI NO ES NULLA
%>--%>
<html>
 
     
   
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><!-- tipo de codificacion-->
          <link rel="icon" href="images/icono_png.ico" type="image/gif" sizes="16x16">
          <link rel="shortcut icon" href="images/favicon.ico"> 
 
          <script src="js/jquery/jquery-latest.min.js" type="text/javascript"></script>
          <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
          <link rel="stylesheet"  href="css/datepicker.css" />
          <script src="js/jquery/jquery-ui.js"></script> 
          <script type="text/javascript" src="js/jquery/datepicker-es.js"></script>
          
          <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes"> <!-- para que se ajuste a la pantalla del dispositivo-->
        <title>Consultar</title><!-- titulo de la pagina-->
        
        <link href="css/formularios_curt.css" rel="stylesheet" type="text/css"/>
     
    
          <script src="js/cancela_act.js" type="text/javascript"></script>
          <script type="text/javascript">
            //funcion anonima a la espera de la llamada para mostrar el objeto datepicker
            $(document).ready(function(){
            $(".fecha").datepicker({  //Clase fecha
                showOn: 'both',
                buttonImage: 'images/cal.gif',
                buttonImageOnly: true
              //dateFormat: "dd-mm-yy"//formato de fecha año/mes/dia
            });
            });
        </script>
    
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
                    placeholder: 'Selecciona una opción'
                   // theme: "classic"
                    //tags: true,
               });
               
               $(".div_por_ue").hide(700);
               $(".div_por_edo").hide(700);
               $(".div_por_mun").hide(700);
               $(".div_por_ue2").hide(700);
               $(".div_por_est").hide(700);
               $(".div_por_muni").hide(700);
               $(".div_por_reg").hide(700);
               $(".div_por_gen").hide(700);
               $(".div_por_gen_tot").hide(700);
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


<script>    
          function resizeIframe(obj) {
                obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
          }
        </script>
        
        <script>    
       /*         function gen_repo(pforma) {
                    var ue = document.getElementById("ue").value;
                         if(!ue){//si el segundo select esta vacio
                                 alert("Selecciona la Unidad del estado"); 
                                 setTimeout(function() { document.getElementById('ue').focus(); }, 10); 
                            }
                            else{ //opcion 1 (la opción cero es el que no tiene nada)
                              var memURL = "resultado_consulta.jsp?ue="+ue;
                              window.open( memURL, 'result_frame');
                                        //document.location.href = memURL;   
                           }  
                }*/
        </script>
        
        <script>    
                function habilita_slc(){
                     var select_por_ue = document.getElementById("select_por_ue");
                     var select_por_edo = document.getElementById("select_por_edo");
                     var select_por_mun = document.getElementById("select_por_mun");
                     var select_por_ue2 = document.getElementById("select_por_ue2");
                     var select_por_est = document.getElementById("select_por_est");
                     var select_por_muni = document.getElementById("select_por_muni");
                     var select_por_reg = document.getElementById("select_por_reg");
                     var select_por_gen = document.getElementById("select_por_gen");
                     var select_por_gen_tot = document.getElementById("select_por_gen_tot");
                     
                     if(select_por_ue.checked){
                         $(".div_por_ue").show(700);
                         $(".div_por_edo").hide(700);
                         $(".div_por_mun").hide(700);
                         $(".div_por_ue2").hide(700);
                         $(".div_por_est").hide(700);
                         $(".div_por_muni").hide(700);
                         $(".div_por_reg").hide(700);
                         $(".div_por_gen").hide(700);
                         $(".div_por_gen_tot").hide(700);
                     }else if(select_por_edo.checked){
                         $(".div_por_edo").show(700);
                         $(".div_por_ue").hide(700);
                         $(".div_por_mun").hide(700);
                         $(".div_por_ue2").hide(700);
                         $(".div_por_est").hide(700);
                         $(".div_por_muni").hide(700);
                         $(".div_por_reg").hide(700);
                         $(".div_por_gen").hide(700);
                         $(".div_por_gen_tot").hide(700);
                     }else if(select_por_mun.checked){
                         $(".div_por_mun").show(700);
                         $(".div_por_edo").hide(700);
                         $(".div_por_ue").hide(700);
                         $(".div_por_ue2").hide(700);
                         $(".div_por_est").hide(700);
                         $(".div_por_muni").hide(700);
                         $(".div_por_reg").hide(700);
                         $(".div_por_gen").hide(700);
                         $(".div_por_gen_tot").hide(700);
                     }else if(select_por_ue2.checked){
                         $(".div_por_ue2").show(700);
                         $(".div_por_mun").hide(700);
                         $(".div_por_edo").hide(700);
                         $(".div_por_ue").hide(700);
                         $(".div_por_est").hide(700);
                         $(".div_por_muni").hide(700);
                         $(".div_por_reg").hide(700);
                         $(".div_por_gen").hide(700);
                         $(".div_por_gen_tot").hide(700);
                     }else if(select_por_est.checked){
                         $(".div_por_est").show(700);
                         $(".div_por_ue2").hide(700);
                         $(".div_por_mun").hide(700);
                         $(".div_por_edo").hide(700);
                         $(".div_por_ue").hide(700);
                         $(".div_por_muni").hide(700);
                         $(".div_por_reg").hide(700);
                         $(".div_por_gen").hide(700);
                         $(".div_por_gen_tot").hide(700);
                     }else if(select_por_muni.checked){
                         $(".div_por_muni").show(700);
                         $(".div_por_est").hide(700);
                         $(".div_por_ue2").hide(700);
                         $(".div_por_mun").hide(700);
                         $(".div_por_edo").hide(700);
                         $(".div_por_ue").hide(700);
                         $(".div_por_reg").hide(700);
                         $(".div_por_gen").hide(700);
                         $(".div_por_gen_tot").hide(700);
                     }else if(select_por_reg.checked){
                         $(".div_por_reg").show(700);
                         $(".div_por_muni").hide(700);
                         $(".div_por_est").hide(700);
                         $(".div_por_ue2").hide(700);
                         $(".div_por_mun").hide(700);
                         $(".div_por_edo").hide(700);
                         $(".div_por_ue").hide(700);
                         $(".div_por_gen").hide(700);
                         $(".div_por_gen_tot").hide(700);
                     }else if(select_por_gen.checked){
                         $(".div_por_gen").show(700);
                         $(".div_por_reg").hide(700);
                         $(".div_por_muni").hide(700);
                         $(".div_por_est").hide(700);
                         $(".div_por_ue2").hide(700);
                         $(".div_por_mun").hide(700);
                         $(".div_por_edo").hide(700);
                         $(".div_por_ue").hide(700);
                         $(".div_por_gen_tot").hide(700);
                     }else if(select_por_gen_tot.checked){
                         $(".div_por_gen_tot").show(700);
                         $(".div_por_gen").hide(700);
                         $(".div_por_reg").hide(700);
                         $(".div_por_muni").hide(700);
                         $(".div_por_est").hide(700);
                         $(".div_por_ue2").hide(700);
                         $(".div_por_mun").hide(700);
                         $(".div_por_edo").hide(700);
                         $(".div_por_ue").hide(700);
                         
                     }
                }
        </script>
        
        
        <script>
      function llama_consulta(){
          
         
            
            var f_inicio = document.getElementById("f_inicio").value;
            var f_fin = document.getElementById("f_fin").value;
            var f_inicio_e = document.getElementById("f_inicio_e").value;
            var f_fin_e = document.getElementById("f_fin_e").value;
            var f_inicio_m = document.getElementById("f_inicio_m").value;
            var f_fin_m = document.getElementById("f_fin_m").value;
            var f_inicio_ue2 = document.getElementById("f_inicio_ue2").value;
            var f_fin_ue2 = document.getElementById("f_fin_ue2").value;
            var f_inicio_est = document.getElementById("f_inicio_est").value;
            var f_fin_est = document.getElementById("f_fin_est").value;
            var f_inicio_cap_mun = document.getElementById("f_inicio_cap_mun").value;
            var f_fin_cap_mun = document.getElementById("f_fin_cap_mun").value;
            var f_inicio_reg = document.getElementById("f_inicio_reg").value;
            var f_fin_reg = document.getElementById("f_fin_reg").value;
            var f_inicio_gen = document.getElementById("f_inicio_gen").value;
            var f_fin_gen = document.getElementById("f_fin_gen").value;
            //var tipo_oficio = document.getElementById("tipo_oficio").value;
            var select_por_ue = document.getElementById("select_por_ue");
            var select_por_edo = document.getElementById("select_por_edo");
            var select_por_mun = document.getElementById("select_por_mun");
            var select_por_ue2 = document.getElementById("select_por_ue2");
            var select_por_est = document.getElementById("select_por_est");
            var select_por_muni = document.getElementById("select_por_muni");
            var select_por_reg = document.getElementById("select_por_reg");
            var select_por_gen_tot = document.getElementById("select_por_gen_tot");
            var select_por = document.getElementsByName("select_por");
            
             var seleccionado = false;    // Para validar los Radio Button
            for(var i=0; i < select_por.length; i++) {    
                   var valor_opcion = select_por[i].value;  //obtener el valor
                if(select_por[i].checked) {  //validar que se seleccione al menos una
                   seleccionado = true;
                    break;
                }
             }
             
             if(!seleccionado){ /*si esta vacio campo nombre...*/
                     alert("Selecciona una opción");
                     setTimeout(function() { document.getElementById('select_por_ue').focus(); }, 10);
                     return false;
                     //verifica_envio = false;
                }
            
            
           
          var url;
          if(select_por_ue.checked){
              url="resultado_consulta_oficios_est.jsp";
                if(!f_inicio_e||!f_fin_e){ /*si esta vacio campo nombre...*/
                     alert("Selecciona una fecha");
                     setTimeout(function() { 
                        document.getElementById('f_inicio_e').focus();
                        document.getElementById('f_fin_e').focus();
                        
                     }, 10);
                     return false;
                     //verifica_envio = false;
                }
             document.getElementById("text_load").innerHTML = "P r o c e s a n d o . . .";   
             $('#loading_cons').show(); //mostramos el gif
          }
          else if(select_por_edo.checked){
              url="resultado_consulta_oficios.jsp";
              if(!f_inicio||!f_fin){ /*si esta vacio campo nombre...*/
                    alert("Selecciona una fecha");
                    setTimeout(function() { 
                        document.getElementById('f_inicio').focus();
                        document.getElementById('f_fin').focus();
                        
                    }, 10);
                    return false;
                    //verifica_envio = false;
               }
            document.getElementById("text_load").innerHTML = "P r o c e s a n d o . . .";   
            $('#loading_cons').show(); //mostramos el gif
            
          }
          else if(select_por_mun.checked){
              url="resultado_consulta_oficios_mun.jsp";
              if(!f_inicio_m||!f_fin_m){ /*si esta vacio campo nombre...*/
                    alert("Selecciona una fecha");
                    setTimeout(function() { 
                        document.getElementById('f_inicio_m').focus();
                        document.getElementById('f_fin_m').focus();
                        
                    }, 10);
                    return false;
                    //verifica_envio = false;
               }
            document.getElementById("text_load").innerHTML = "P r o c e s a n d o . . .";   
            $('#loading_cons').show(); //mostramos el gif 
            
          }
          else if(select_por_ue2.checked){
              url="resultado_consulta_respuestas.jsp";
              if(!f_inicio_ue2||!f_fin_ue2){ /*si esta vacio campo nombre...*/
                    alert("Selecciona una fecha");
                    setTimeout(function() { 
                        document.getElementById('f_inicio_ue2').focus();
                        document.getElementById('f_fin_ue2').focus();
                        
                    }, 10);
                    return false;
                    //verifica_envio = false;
               }
            document.getElementById("text_load").innerHTML = "P r o c e s a n d o . . .";   
            $('#loading_cons').show(); //mostramos el gif 
            
          }
          else if(select_por_est.checked){
              url="resultado_consulta_cap_est.jsp";
              if(!f_inicio_est||!f_fin_est){ /*si esta vacio campo nombre...*/
                    alert("Selecciona una fecha");
                    setTimeout(function() { 
                        document.getElementById('f_inicio_est').focus();
                        document.getElementById('f_fin_est').focus();
                        
                    }, 10);
                    return false;
                    //verifica_envio = false;
               }
            document.getElementById("text_load").innerHTML = "P r o c e s a n d o . . .";   
            $('#loading_cons').show(); //mostramos el gif 
            
          }
          else if(select_por_muni.checked){
              url="resultado_consulta_cap_mun.jsp";
              if(!f_inicio_cap_mun||!f_fin_cap_mun){ /*si esta vacio campo nombre...*/
                    alert("Selecciona una fecha");
                    setTimeout(function() { 
                        document.getElementById('f_inicio_cap_mun').focus();
                        document.getElementById('f_fin_cap_mun').focus();
                        
                    }, 10);
                    return false;
                    //verifica_envio = false;
               }
            document.getElementById("text_load").innerHTML = "P r o c e s a n d o . . .";   
            $('#loading_cons').show(); //mostramos el gif 
            
          }
          else if(select_por_reg.checked){
              url="resultado_consulta_reg.jsp";
              if(!f_inicio_reg||!f_fin_reg){ /*si esta vacio campo nombre...*/
                    alert("Selecciona una fecha");
                    setTimeout(function() { 
                        document.getElementById('f_inicio_reg').focus();
                        document.getElementById('f_fin_reg').focus();
                        
                    }, 10);
                    return false;
                    //verifica_envio = false;
               }
            document.getElementById("text_load").innerHTML = "P r o c e s a n d o . . .";   
            $('#loading_cons').show(); //mostramos el gif 
            
          }
          else if(select_por_gen_tot.checked){
              url="resultado_consulta_gen_tot.jsp";
              //if(!f_inicio_gen||!f_fin_gen){ /*si esta vacio campo nombre...*/
                //    alert("Selecciona una fecha");
                  //  setTimeout(function() { 
                    //    document.getElementById('f_inicio_gen').focus();
                      //  document.getElementById('f_fin_gen').focus();
                        
                    //}, 10);
                    //return false;
                    //verifica_envio = false;
               //}
            document.getElementById("text_load").innerHTML = "P r o c e s a n d o . . .";   
            $('#loading_cons').show(); //mostramos el gif 
            
          }
          else if(select_por_gen.checked){
              url="resultado_consulta_gen.jsp";
              if(!f_inicio_gen||!f_fin_gen){ /*si esta vacio campo nombre...*/
                    alert("Selecciona una fecha");
                    setTimeout(function() { 
                        document.getElementById('f_inicio_gen').focus();
                        document.getElementById('f_fin_gen').focus();
                        
                    }, 10);
                    return false;
                    //verifica_envio = false;
               }
            document.getElementById("text_load").innerHTML = "P r o c e s a n d o . . .";   
            $('#loading_cons').show(); //mostramos el gif 
            
          } 
            
          
             var dataString = $('#form_consulta').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)
                // alert('Datos serializados: '+dataString);
          
                $.ajax({
                    type: "POST",
                    url: url,
                    data: dataString,
                    success: function(data) {
                          //document.getElementById("result_consulta").innerHTML = data;
                        $('#result_consulta').html(data);
                        $('#loading_cons').hide(); // Ocultamos el GIF
                        document.getElementById("text_load").innerHTML = "";
                     }
                });
          return false;
   
           
           
      }
        </script>
        


<link href="css/icomoon/iconos.css" rel="stylesheet" type="text/css"/>
<link href="header_menu/header.css" rel="stylesheet" type="text/css"/>
<script src="header_menu/menuResponsive.js" type="text/javascript"></script>
<link href="header_menu/menu_responsive.css" rel="stylesheet" type="text/css"/>
    </head>
    
    <body bgcolor="#efefef">
      
         
     
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
              <li><span class="negrita"> <span class="caret icon-chevron-down"> <!--boton --></span></span>
                    <ul class="children">    
                        <li> <a href="cambiar_psw.jsp"> <span class="icon-engrane"></span> Cambiar contraseña</a></li>
                    </ul>
             </li>
             <li class="cerrar_ses"> <a href="logout_curt.jsp"><span class="icon-exit"></span>  Cerrar Sesión</a></li>
           </ul>
        </div>
    </header>
       <!-- MODIFICACION 20/07/2017-->
        
        <!-- TERMINA MODIFICACION 20/07/2017 -->
        <div id="margen-oculto">&nbsp;</div>
      
           <div id="Div_Titulo">
              
              <div id="img_logo"><img src="images/logoSegCurt.png" alt=""/></div>
              <div id="txt_titu">
              <span class="text_small">SISTEMA </span> <span class="text_small">DE SEGUIMIENTO DE LA
                  <br> </span> <span class="TextTitulo">CLAVE ÚNICA DEL REGISTRO DEL TERRITORIO</span>
                   <!-- parrafo de titulo-->
              </div>      
           </div>
        
        
        <div id="cont_consulta">
            
            <form id="form_consulta">     
            <span class="TextTitulo subrayado">Consultas de información &nbsp;&nbsp;&nbsp;</span><br><br><br>
         <div id="cont_center2_inf">
             
          <table width="100%" border="0">
                 <tr>
                     <td><span class="lbl_slc">Oficios enviados:</span></td>
                     <td><span class="lbl_slc">Respuestas recibidas:</span></td>
                     <td><span class="lbl_slc">Capacitaciones:</span></td>
                     <td><span class="lbl_slc">Aplicativo web:</span></td>
                 </tr>
                 <tr>
                     <td><input type="radio" name="select_por" id="select_por_edo" value="por_edo" onclick="javascript:habilita_slc();"> <label for="select_por_edo" class="Gotham-Book"> Federal</label><br></td>
                     <td><input type="radio" name="select_por" id="select_por_ue2" value="por_ue" onclick="javascript:habilita_slc();"> <label for="select_por_ue2" class="Gotham-Book"> Por parte de las Unidades del Estado</label><br></td>
                     <td><input type="radio" name="select_por" id="select_por_est" value="por_est" onclick="javascript:habilita_slc();"> <label for="select_por_est" class="Gotham-Book"> Estatal</label><br></td>
                     <td><input type="radio" name="select_por" id="select_por_reg" value="por_reg" onclick="javascript:habilita_slc();"> <label for="select_por_reg" class="Gotham-Book"> Unidades del Estado registradas</label><br></td>
                 </tr>
                 <tr>
                     <td><input type="radio" name="select_por" id="select_por_ue" value="por_ue" onclick="javascript:habilita_slc();"> <label for="select_por_ue" class="Gotham-Book"> Estatal</label><br></td>
                     <td>&nbsp;</td>
                     <td><input type="radio" name="select_por" id="select_por_muni" value="por_muni" onclick="javascript:habilita_slc();"> <label for="select_por_muni" class="Gotham-Book"> Municipal</label></td>
                     <td><input type="radio" name="select_por" id="select_por_gen" value="por_gen" onclick="javascript:habilita_slc();"> <label for="select_por_gen" class="Gotham-Book"> Unidades del Estado que han generado CURT (por fecha)</label></td>
                 </tr>
                 <tr>
                     <td><input type="radio" name="select_por" id="select_por_mun" value="por_mun" onclick="javascript:habilita_slc();"> <label for="select_por_mun" class="Gotham-Book"> Municipal</label></td>
                     <td>&nbsp;</td>
                     <td>&nbsp;</td>
                     <td><input type="radio" name="select_por" id="select_por_gen_tot" value="por_gen_total" onclick="javascript:habilita_slc();"> <label for="select_por_gen_tot" class="Gotham-Book"> Unidades del Estado que han generado CURT (total)</label></td>
                 </tr>
             </table>

             
         </div> 
            
            <br><br>
            
            <div id="cont_center2" class="div_por_ue">          
                <div id="cont_left">             
                    <span class="lbl_slc">De:</span>                
                    <input type="text" id="f_inicio_e" name="f_inicio_e" placeholder="dd/mm/aaaa" class="fecha w20">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="lbl_slc">Hasta:</span>   <input type="text" id="f_fin_e" name="f_fin_e" placeholder="dd/mm/aaaa" class="fecha w20">
                    
                </div>
            </div>            
                
            <div id="cont_center2" class="div_por_edo"> 
                <div id="cont_left">         
                    <span class="lbl_slc">De:</span>                
                    <input type="text" id="f_inicio" name="f_inicio" placeholder="dd/mm/aaaa" class="fecha w20">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="lbl_slc">Hasta:</span>   <input type="text" id="f_fin" name="f_fin" placeholder="dd/mm/aaaa" class="fecha w20">
                    
                </div> 
            </div>
            
            <div id="cont_center2" class="div_por_mun">          
                <div id="cont_left">             
                    <span class="lbl_slc">De:</span>                
                    <input type="text" id="f_inicio_m" name="f_inicio_m" placeholder="dd/mm/aaaa" class="fecha w20">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="lbl_slc">Hasta:</span>   <input type="text" id="f_fin_m" name="f_fin_m" placeholder="dd/mm/aaaa" class="fecha w20">
                  
                </div>
            </div>
            
            <div id="cont_center2" class="div_por_ue2">          
                <div id="cont_left">             
                    <span class="lbl_slc">De:</span>                
                    <input type="text" id="f_inicio_ue2" name="f_inicio_ue2" placeholder="dd/mm/aaaa" class="fecha w20">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="lbl_slc">Hasta:</span>   <input type="text" id="f_fin_ue2" name="f_fin_ue2" placeholder="dd/mm/aaaa" class="fecha w20">
                  
                </div>
            </div>
            
            <div id="cont_center2" class="div_por_est">          
                <div id="cont_left">             
                    <span class="lbl_slc">De:</span>                
                    <input type="text" id="f_inicio_est" name="f_inicio_est" placeholder="dd/mm/aaaa" class="fecha w20">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="lbl_slc">Hasta:</span>   <input type="text" id="f_fin_est" name="f_fin_est" placeholder="dd/mm/aaaa" class="fecha w20">
                  
                </div>
            </div>
            
            <div id="cont_center2" class="div_por_muni">          
                <div id="cont_left">             
                    <span class="lbl_slc">De:</span>                
                    <input type="text" id="f_inicio_cap_mun" name="f_inicio_cap_mun" placeholder="dd/mm/aaaa" class="fecha w20">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="lbl_slc">Hasta:</span>   <input type="text" id="f_fin_cap_mun" name="f_fin_cap_mun" placeholder="dd/mm/aaaa" class="fecha w20">
                  
                </div>
            </div>
            
            <div id="cont_center2" class="div_por_reg">          
                <div id="cont_left">             
                    <span class="lbl_slc">De:</span>                
                    <input type="text" id="f_inicio_reg" name="f_inicio_reg" placeholder="dd/mm/aaaa" class="fecha w20">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="lbl_slc">Hasta:</span>   <input type="text" id="f_fin_reg" name="f_fin_reg" placeholder="dd/mm/aaaa" class="fecha w20">
                  
                </div>
            </div>
            
            <div id="cont_center2" class="div_por_gen">          
                <div id="cont_left">             
                    <span class="lbl_slc">De:</span>                
                    <input type="text" id="f_inicio_gen" name="f_inicio_gen" placeholder="dd/mm/aaaa" class="fecha w20">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="lbl_slc">Hasta:</span>   <input type="text" id="f_fin_gen" name="f_fin_gen" placeholder="dd/mm/aaaa" class="fecha w20">
                  
                </div>
            </div>
            
            <div id="cont_center2" class="div_por_gen_tot">          
                <div id="cont_left">             
                                    
                    
                  
                </div>
            </div>
                
                  <div id="btn_enviar">
                      <input type="button" value="&ll; Regresar" onclick="javascript:window.location.href='inicio_curt.jsp'" class="bcancelar">    &nbsp;
                     <!-- <input type="button" name="Cons_tipo" id="Cons_tipo" value="Consultar" onclick="gen_repo(this.form)" />-->
                      <input type="button" name="btn_ajx" id="btn_ajx" value="Consultar" onclick="javascript:llama_consulta();"> 
                 </div>
       </form>
                
                <div id="loading_cons"  style="display: none;"  >
                     <img src="images/spinner-loading.gif" alt=""/>
                     <div id="text_load" class="CarroisGR22" style="text-align: center; color: #000; font-weight: bold;"><!-- Aqui va el texto--></div>
                </div> 
                
                <div name="result_consulta" id="result_consulta" ></div>
                
                
                 <!-- <iframe id="result_frame" name="result_frame" > </iframe>  -->
        </div>
       <br><br>
      
    </body>
</html>



    
    
