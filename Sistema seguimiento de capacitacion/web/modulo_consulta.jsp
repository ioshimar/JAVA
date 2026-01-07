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
    %>
     
   
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><!-- tipo de codificacion-->
          <link rel="icon" href="images/icono_png.ico" type="image/gif" sizes="16x16">
          <link rel="shortcut icon" href="images/favicon.ico"> 
 
          <script src="js/jquery/jquery-latest.min.js" type="text/javascript"></script>
          <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes"> <!-- para que se ajuste a la pantalla del dispositivo-->
        <title>Consultar</title><!-- titulo de la pagina-->
        
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
                    placeholder: 'Selecciona una opción'
                   // theme: "classic"
                    //tags: true,
               });
               
               $(".div_por_ue").hide(700);
               $(".div_por_edo").hide(700);
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
                     
                     if(select_por_ue.checked){
                         $(".div_por_ue").show(700);
                          $(".div_por_edo").hide(700);
                     }else if(select_por_edo.checked){
                         $(".div_por_edo").show(700);
                         $(".div_por_ue").hide(700);
                     }
                }
        </script>
        
        
        <script>
      function llama_consulta(){
          
         
            var ue = document.getElementById("ue").value;
            var cve_estado = document.getElementById("cve_estado").value;
            var select_por_ue = document.getElementById("select_por_ue");
            var select_por_edo = document.getElementById("select_por_edo");
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
              url="resultado_consulta.jsp";
                if(!ue){ /*si esta vacio campo nombre...*/
                     alert("Selecciona la Unidad del estado");
                     setTimeout(function() { document.getElementById('ue').focus(); }, 10);
                     return false;
                     //verifica_envio = false;
                }
             document.getElementById("text_load").innerHTML = "P r o c e s a n d o . . .";   
             $('#loading_cons').show(); //mostramos el gif
          }
          else if(select_por_edo.checked){
              url="result_consulta_todos.jsp";
              if(!cve_estado){ /*si esta vacio campo nombre...*/
                    alert("Selecciona un estado");
                    setTimeout(function() { document.getElementById('cve_estado').focus(); }, 10);
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
                        document.getElementById("text_load").innerHTML = ""
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
       <!-- MODIFICACION 20/07/2017-->
        <%! String claves_estado, entidad_encargado, claves_separadas ; %> <!--Variables Globales -->
        
        <%
            //CON ESTA CONSULTA SACAMOS TODOS LOS ESTADOS QUE LE PERTENECEN A LA REGIONAL: sesion_cve_enc
            
       try{     
         PreparedStatement pst23 =(PreparedStatement) conexion.conn.prepareStatement("select \"ENCESTATALES\", \"CVE_ENTIDAD\"  FROM \"seguim_CURT\".\"Encargados_CURT\" where \"CVE_ENTIDAD\"='"+sesion_cve_enc+"'");
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
              
              <div id="img_logo"><img src="images/logoSegCurt.png" alt=""/></div>
              <div id="txt_titu">
              <span class="text_small">SISTEMA </span> <span class="text_small">DE SEGUIMIENTO DE LA
                  <br> </span> <span class="TextTitulo">CLAVE ÚNICA DEL REGISTRO DEL TERRITORIO</span>
                   <!-- parrafo de titulo-->
              </div>      
           </div>
        
        
        <div id="cont_consulta">
            
            <form id="form_consulta">     
            <span class="TextTitulo subrayado">Consultas &nbsp;&nbsp;&nbsp;</span><br><br><br>
         <div id="cont_center2">    
          <div id="cont_left">  
              <span class="lbl_slc">Selecciona el tipo de consulta:</span><br>
              <input type="radio" name="select_por" id="select_por_ue" value="por_ue" onclick="javascript:habilita_slc();"> <label for="select_por_ue" class="Gotham-Book"> Por UE</label><br>
              <input type="radio" name="select_por" id="select_por_edo" value="por_edo" onclick="javascript:habilita_slc();"> <label for="select_por_edo" class="Gotham-Book"> Por Estado</label>
           </div> 
         </div> 
            
            <div id="cont_center2" class="div_por_ue">
          
           <div id="cont_left"> 
               <span class="lbl_slc">Nombre de la Unidad del Estado</span>
                   <!-- <input type="text" name="name_ue" id="name_ue" class="w50">-->
                   <select name="ue" id="ue" class="w100 js-example-basic-single">
                        <option value=""> Selecciona una unidad del estado...</option>
                          <%
                     //nueva conslta para rellenar el listado
                String nombre_ue="";
                String nom_ent="";
                String folio_ue="";
                String ue_ID ="";
                String nom_mun ="";
              try{  
                
 PreparedStatement pst25 =(PreparedStatement) conexion.conn.prepareStatement( "SELECT  id_ue, nom_ent, cve_ent, nom_ue, "
         + "municipio FROM \"seguim_CURT\".concertacion WHERE cve_ent In('"+claves_separadas+"') ORDER BY cve_ent, nom_ue");
                conexion.rs =pst25.executeQuery(); 
                while(conexion.rs.next()) {
                nombre_ue= conexion.rs.getString("nom_ue");
              // folio_ue=conexionDir.rs.getString("FOLIO"); 
                 ue_ID = conexion.rs.getString("id_ue");
                 nom_ent = conexion.rs.getString("nom_ent");
                nom_mun = conexion.rs.getString("municipio").toLowerCase();  //lo convertimos primero a minusculas
            
                String Nombre_mun2 = nom_mun.substring(0, 1).toUpperCase() + nom_mun.substring(1); // Solo convertimos la primera a mayuscula
            
                      %> 
                        <OPTION value="<%=ue_ID%>"><%out.println(nombre_ue + "   " + "  (" +Nombre_mun2 +", "+nom_ent+") " );%> </OPTION> 
                <% 
                 }
                 } catch(SQLException e){out.print("exception"+e);}
              finally {
                    //conexion.closeConnection();
                        }  
                %>  
                        
                    </select>
                </div>
           </div>
                
                <br><br>
                
                <div id="cont_center2" class="div_por_edo"> 
                    
            
           <div id="cont_left">         
                <span class="lbl_slc">Estado:</span>
                
                 <select name="cve_estado" id="cve_estado" class="w100 js-example-basic-single">
                        <option value=""> Selecciona una unidad del estado...</option>
                          <%
                     //nueva conslta para rellenar el listado
            String comboasen1="",clave1="";
               try{    
                PreparedStatement pst =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_EDO\",\"CVE_EDO\" from \"seguim_CURT\".cat_edo"
                        + " WHERE \"CVE_EDO\" In('"+claves_separadas+"') AND \"CVE_EDO\" not in ('33','34','35','36','37','38','39','40','41','42','43') ORDER BY \"CVE_EDO\" ");
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