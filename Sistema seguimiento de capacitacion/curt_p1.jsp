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
     if(sesion_cve_enc!=null){  //SI NO ES NULLA
%>
<html>
    <%
        //conexiones a la base de datos
        ConexionBD conexion=new ConexionBD();
      //  ConexionDirecBD conexionDir =new ConexionDirecBD(); 
        String id_ue = request.getParameter("ue");
        
        
        String privilegio ="";
        int sesionInt = Integer.parseInt(sesion_cve_enc); //convertimos el string (Sesion) en INT
        if(sesionInt >= 33){
             privilegio = "REGIONAL";
        }
       
        else if(sesionInt <= 32){
           privilegio = "ESTATAL";     
        }
        
     /*   else if(sesionInt == 33){
           privilegio = "REGIONAL, ESTATAL";     
        }
*/

        
    %>
     
   
    <head>
          <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"><!-- tipo de codificacion-->
          <link rel="icon" href="images/icono_png.ico" type="image/gif" sizes="16x16">
          <link rel="shortcut icon" href="images/favicon.ico"> 

          <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes"> <!-- para que se ajuste a la pantalla del dispositivo-->
        <title>Registrar</title><!-- titulo de la pagina-->
        
        <link href="css/formularios_curt.css" rel="stylesheet" type="text/css"/>
        <script src="header_menu/jquery-latest.min.js" type="text/javascript"></script>
         
          <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
          <link rel="stylesheet"  href="css/datepicker.css" />
          <script src="js/jquery/jquery-ui.js"></script> 
          <!-- <script type="text/javascript" src="js/jquery/datepicker.js"></script>-->
          <script type="text/javascript" src="js/jquery/datepicker-es.js"></script>
          <script src="js/cancela_act.js" type="text/javascript"></script>
          <script src="js/funCargaP1.js" type="text/javascript"></script>
          <script src="js/CargaTablaP1.js" type="text/javascript"></script>
          <script src="js/cerrar_notif.js" type="text/javascript"></script>
          <script>
              function postwith (to,p) { /*OCULTAR URL*/
                    var myForm = document.createElement("form");
                    myForm.method="post" ;
                    myForm.action = to ;
                    for (var k in p) {
                      var myInput = document.createElement("input") ;
                      myInput.setAttribute("name", k) ;
                      myInput.setAttribute("value", p[k]);
                      myForm.appendChild(myInput) ;
                    }
                    document.body.appendChild(myForm) ;
                    myForm.submit() ;
                    document.body.removeChild(myForm) ;
             }
          </script>
          <script>
              function cancelar_activ(){
                var r = confirm("¿Deseas regresar?");
                if (r === true) {
                   // document.getElementById("formul2").reset();
                   // window.history.back();
                 // location.href = "captura.jsp?ue="+< %=id_ue%>;
                  postwith('captura.jsp',{ue:'<%=id_ue%>'}); //mandamos la URL
                } 
                };
          </script>
          
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
            function habilita(){
                 var acepto_si = document.getElementById("acepto_si");
                 var acepto_no = document.getElementById("acepto_no");
                 var acept_sinresp = document.getElementById("acept_sinresp");
                 
               if(acepto_si.checked){
                   
                         $('#condicionSi').show(700); 
                       // $('#condicionSi').css("display","block");
                         $('#condicionNo').hide(700); 
                         $('#condicionNo').find('input, textarea, select').val(''); //resetamos el valor
                    }else if(acepto_no.checked)  {
                         $('#condicionNo').show(700); 
                         $('#condicionSi').hide(700); 
                         $('#condicionSi').find("input[type='checkbox'],input[type='radio']").removeAttr('checked');//quitamos los checked
                    }
                    /*else if(acept_sinresp.checked)  {
                         $('#condicionNo').hide(700); 
                         $('#condicionSi').hide(700); 
                         $('#condicionSi,#condicionNo ').find("input[type='checkbox'],input[type='radio']").removeAttr('checked');//quitamos los checked
                    }*/
               
            };
            
            
    function habilita2(){
        
        var concerta = document.getElementById("concerta");
        
        if(concerta.checked){
            $("#fld_concert").hide(500);
            $('#fld_concert').find('input, textarea, select').val(""); //todos los valores en null
            $('#fld_concert').find('input[type="radio"], input[type="checkbox"]').removeAttr('checked'); //removemos los cheched a todos los input radio y checkbox
             
        }else{
            $("#fld_concert").show(500);
        }
                
          var sin_fechas1 = document.getElementById("sin_fechas1");
          var first_resp = document.getElementById("first_resp");
          var activa_2doOf = document.getElementById("activa_2doOf");
          
          var sin_fechas2 = document.getElementById("sin_fechas2"); 
          var second_resp = document.getElementById("second_resp"); 
          var activa_3erOf = document.getElementById("activa_3erOf");
          
          var sin_fechas3 = document.getElementById("sin_fechas3");  
          var third_resp = document.getElementById("third_resp"); 
          
             if(sin_fechas1.checked){
                   $('#cont_fechas').find('input, textarea, select').attr("disabled",true);  //todos los input dentro de #cont_fechas se deshabiltaran
                   $('#cont_fechas').find('input, textarea, select').val(""); //todos los valores en null
                   $("#cont_fechas").hide(700);  //ocultamos el div 
                   $("#div_acepto").hide(700);
                   
                   $("#first_resp, #sin_fechas2, #second_resp, #sin_fechas3, #third_resp, #activa_2doOf, #activa_3erOf").attr("disabled",true); // deshabilito los checkbox
                   $("#first_resp, #sin_fechas2, #second_resp, #sin_fechas3, #third_resp, #activa_2doOf, #activa_3erOf").removeAttr('checked');
             }else{
                 $('#cont_fechas').find('input, textarea, select').attr("disabled",false); //todos los input dentro de #cont_fechas se Habiltaran
                 $("#first_resp, #sin_fechas2, #second_resp, #sin_fechas3, #third_resp, #activa_2doOf, #activa_3erOf").attr("disabled",false);  // Habilito los checkbox
                 $("#cont_fechas").show(700);
                 $("#div_acepto").show(700);
             }    
             
           
        //var first_resp = document.getElementById("first_resp");  
        if(first_resp.checked){
                  $("#fecha_ofic, #fecha_resp, #nom_destinatario, #nom_remitente, #file_oficio1, #file_resp1").attr("disabled",true);  //deshabilito todos estos input
                  $("#fecha_resp, #file_resp1").val("");  //solo reseteo el input de fecha de respuesta en caso que lo hayan llenado
                   
                   $("#div_fechas2").show(700);
                   
                  }else{    //Esto se puede omitir...
                     
                    $("#div_fechas2").hide(700); 
                   // $("#sin_fechas2, #second_resp, #sin_fechas3, #third_resp").removeAttr('checked');  //deshabilito los check
                  //$('#div_fechas2').find('input[type="text"],input[type="file"], textarea, select').val(""); //todos los valores que estan en el div_fechas2 lo ponemos en nulo
                  }
                  
                  
                  if(activa_2doOf.checked){ //modif 09/11_2018
                      $("#div_fechas2").show(700);
                  }
                  
       //  var sin_fechas2 = document.getElementById("sin_fechas2");  
       if(sin_fechas2.checked){
               $("#fecha_ofic2, #fecha_resp2, #nom_destinatario2, #nom_remitente2, #file_oficio2, #file_resp2").attr("disabled", true); //deshabilito todos los input fecha
               $("#fecha_ofic2, #fecha_resp2, #nom_destinatario2, #nom_remitente2, #file_oficio2, #file_resp2").val("");
               $(".backdiv2").hide(700); 
               $("#div_acepto").hide(700);
               
                  $("#second_resp").attr("disabled",true); // deshabilito los checkbox
                  $("#second_resp").removeAttr('checked');
            }else if(!sin_fechas2.checked){
                $(".backdiv2").show(700); 
            }else{}
                  
      //   var second_resp = document.getElementById("second_resp");     
          if(second_resp.checked){
               $("#fecha_ofic2, #fecha_resp2, #nom_destinatario2, #nom_remitente2, #file_oficio2, #file_resp2").attr("disabled", true); 
               $("#fecha_resp2, #file_resp2").val(""); //quito el valor a la fecha de respuesta2 y su respectivo archivo
                 
               $("#div_fechas3").show(700);
            }else{
                $("#div_fechas3").hide(700);
               // $("#sin_fechas3, #third_resp").removeAttr('checked');
            }
            
            if(activa_3erOf.checked){
                $("#div_fechas3").show(700);
            }
            
             
         //  var sin_fechas3 = document.getElementById("sin_fechas3");  
       if(sin_fechas3.checked){
               $("#fecha_ofic3, #fecha_resp3, #nom_destinatario3, #nom_remitente3, #file_oficio3, #file_resp3").attr("disabled", true); //deshabilito todos los input fecha
               $("#fecha_ofic3, #fecha_resp3, #nom_destinatario3, #nom_remitente3, #file_oficio3, #file_resp3").val("");
               $(".backdiv3").hide(700); 
               $("#div_acepto").hide(700);
               
                  $("#third_resp").attr("disabled",true); // deshabilito los checkbox
                  $("#third_resp").removeAttr('checked');
            }else if(!sin_fechas3.checked){
                $(".backdiv3").show(700); 
            } else{}
            
         //   var third_resp = document.getElementById("third_resp");     
          if(third_resp.checked){
               $("#fecha_ofic3, #fecha_resp3, #nom_destinatario3, #nom_remitente3, #file_oficio3, #file_resp3").attr("disabled", true); 
               $("#fecha_resp3, #file_resp3").val(""); //deshabilito todos los input fecha
            }else{}    
            
    
    };
            
            
            
           $(document).ready(function(){
                    carga_actualizaP1(<%=id_ue%>);
                     habilita();
                     habilita2();
                     cargaTablaP1(<%=id_ue%>);
                    $("#actualizar").css("display","none");
                    $(".boton_delete").css("display","none");
                     
                });   
        </script>
      
        <script src="js/ajx_guarda_concerP1.js" type="text/javascript"></script>
      
        <script src="js/actualiza_concerP1.js" type="text/javascript"></script>
        
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
        
        <div id="notif"><div id="result">   </div><div id="cerrarDiv"><!--<img src="images/cerrar.png" width="30" height="30"/>--> <a>Continuar</a></div> </div>
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
            <a href="javascript:postwith('captura.jsp',{ue:'<%=id_ue%>'})">  <li>  Captura </li> </a>
            <a href="selecciona_ue.jsp"> <li> Cambiar UE</li></a>
          </ul>
           <ul class="text-right">
              <li><span class="negrita"><%=nom_usuario.toUpperCase()%> <span class="caret icon-chevron-down"> <!--boton --></span></span>
                    <ul class="children">    
                        <li> <a href="cambiar_psw.jsp"> <span class="icon-engrane"></span> Cambiar contraseña</a></li>
                    </ul>
             </li> 
             <li class="cerrar_ses"> <a href="logout_curt.jsp">  <span class="icon-exit"></span> Cerrar Sesión</a></li>
           </ul>
        </div>
    </header>
                  
        <div id="margen-oculto">&nbsp;</div>
       <div id="Div_Titulo">
              <div id="img_logo"><img src="images/logoSegCurt.png" alt=""/></div>
              <div id="txt_titu">
              <span class="text_small">SISTEMA </span> <span class="text_small">DE SEGUIMIENTO DE LA
                  <br> </span> <span class="TextTitulo">CLAVE ÚNICA DEL REGISTRO DEL TERRITORIO</span>
                  
              </div>      
           </div>
        
        <div id="cont_formulario">
            
            <form id="curtp1" name="curtp1">
            <span class="TextTitulo subrayado">Concertación &nbsp;&nbsp;&nbsp;</span><br><br><br>
             <% String fecha=getFechaActual();%>
             <div id="div_fecha">Fecha: 
              <input type="text" id="fecha_llenado" name="fecha_llenado" value="<%out.print(fecha);%>" readonly style="border-width:0; background:none; font-weight: bold;" class="w15" >
              <input type="hidden" name="privilegio" id="privilegio" value="<%=privilegio%>" >
              <input type="hidden" name="usuario_resp" id="usuario_resp" value="<%=sesion_cve_enc%>" class="w5" readonly="">
             </div>
            
            <div id="cont_center2">
           <!-- <div id="cont1">
                <span>Entidad federativa</span><br>
                <select name="ent" id="ent" class="w50">
                    <option value=""> Selecciona un estado...</option>
                      < %
                String comboasen1="",clave1="";//se cara la variable que contendra cada opcion
                PreparedStatement pst =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_EDO\",\"CVE_EDO\" from \"seguim_CURT\".cat_edo WHERE \"CVE_EDO\" not like '00' ORDER BY \"CVE_EDO\" ");
                conexion.rs =pst.executeQuery(); //ejecutamos la consulta
                while(conexion.rs.next()) {//se guarda cada resultado en la variable de opciones
                comboasen1 = conexion.rs.getString("NOM_EDO");
                clave1=conexion.rs.getString("CVE_EDO");
                int num_estado =conexion.rs.getInt("CVE_EDO");  //Solo para poner el numero antes del Nombre
                if(comboasen1==null)comboasen1="";
                   %> 
                <option value="< %=clave1%>"> < %out.println(num_estado +". " + comboasen1);%> </option>
                 < % } %>
                    
                </select>
            </div>-->
                
           <div id="cont_left"> 
                    <span>Nombre de la Unidad del Estado</span><br>
                   <!-- <input type="text" name="name_ue" id="name_ue" class="w50">-->
                
                 
              
       <%! String claves_estado, entidad_encargado, claves_separadas, Nombre_mun2 ; %> <!--Variables Globales -->
        
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
              finally {//conexion.closeConnection(); 
                    }     
  
        %>
     
     
     <%         //nueva conslta para rellenar el listado
                String nombre_ue="";
                String folio_ue="";
                String nom_mun ="";
                String name_edo ="";
                String cve_edo ="";
                
     try{            
         PreparedStatement pst25 =(PreparedStatement) conexion.conn.prepareStatement( "select T1.\"Id\",T1.\"FOLIO\",T1.\"INSNOMBRE\",T1.\"INSNOMBRECIUDADMPIO\",T1.\"CVE_ENTIDAD\", T1.\"CVE_MUN\",  T2.\"NOM_EDO\" "
         + " FROM  \"seguim_CURT\".ufg_directori_ufg as T1, \"seguim_CURT\".cat_edo as T2  "
         + " WHERE T1.\"Id\" = '"+id_ue+"' "
         + " AND T1.\"CVE_ENTIDAD\"  =  T2.\"CVE_EDO\" "
         + " AND T1.\"CVE_ENTIDAD\" In('"+claves_separadas+"') ORDER BY T1.\"INSNOMBRE\" ");
                conexion.rs =pst25.executeQuery(); 
                while(conexion.rs.next()) {
                    nombre_ue= conexion.rs.getString("INSNOMBRE");
                    folio_ue=conexion.rs.getString("FOLIO"); 
                    nom_mun = conexion.rs.getString("INSNOMBRECIUDADMPIO").toLowerCase(); //lo convertimos a minusculas primero 
                   name_edo = conexion.rs.getString("NOM_EDO");
                   cve_edo = conexion.rs.getString("CVE_ENTIDAD");
                } 
                 Nombre_mun2 = nom_mun.substring(0, 1).toUpperCase() + nom_mun.substring(1); // Solo convertimos la primera a mayuscula
      } catch(SQLException e){out.print("exception"+e);}
              finally {conexion.closeConnection(); }            
         
     %>  
                        
                   
                          <input type="text" name="name_ue" id="name_ue" class="w100 read" value="<%=nombre_ue%>" readonly="readonly"> 
                          <input type="hidden" name="id_ue" id="id_ue" value="<%=id_ue%>" readonly="readonly" class="read w5">
                          <input type="text" name="nom_edo" id="nom_edo" value="<%=name_edo%>" class="w15 read"readonly="readonly">
                          <input type="text" name="nombre_muni" id="nombre_muni" value="<%=Nombre_mun2%>" class="w15 read" readonly="readonly" >
                          <input type="hidden" name="cve_edo" id="cve_edo" value="<%=cve_edo%>" class="w5 read" readonly="readonly">
                    
                </div><br>
                <br><br>
                <div id="cont_left">
                    <input type="checkbox" name="concerta" id="concerta" value="NO" onclick="javascript:habilita2();"> <label for="concerta" > Sin Concertación </label>
                </div>
                <br><br>
                
                <fieldset id="fld_concert">
                    <legend>Concertación</legend>
                
                    <div id="cont_left"> 
                        <input type="checkbox" name="sin_fechas1" id="sin_fechas1" value="sin fechas" onclick="javascript:habilita2();"> <label for="sin_fechas1"> No se requirió oficio para concertar </label>
                    </div><br>
              <div id="cont_fechas">    
                    <div class="backdiv">   
                        <div id="div_fechas"> 
                                <div id="cols_31">
                                    <span>Nombre del destinatario </span><br>
                                    <input type="text" name="nom_destinatario" id="nom_destinatario">
                                </div>

                                <div id="cols_32">
                                    <span>Nombre del remitente </span><br>
                                    <input type="text" name="nom_remitente" id="nom_remitente">
                                </div>

                                <div id="cols_33"> </div>

                                <div id="cols_31"> 
                                    <span>Fecha del 1er. oficio enviado </span><br>
                                    <input type="text" id="fecha_ofic" name="fecha_ofic" placeholder="dd/mm/aaaa" class="fecha w20"> <br>
                                    <!--<input type="file" name="file_oficio1" id="file_oficio1" />-->
                                </div>
                                
                                
                                <div id="cols_32">
                                    <span>Fecha de respuesta  del 1er. oficio enviado  </span><br>
                                    <input type="text" id="fecha_resp" name="fecha_resp" placeholder="dd/mm/aaaa" class="fecha w20"> <br>
                                  <!--  <input type="file" name="file_resp1" id="file_resp1" />-->
                                </div>

                                <div id="cols_33" style="">
                                    <input type="checkbox" name="first_resp" id="first_resp" value="NO" onclick="javascript:habilita2();"><label for="first_resp">Sin 1er respuesta</label> <br> 
                                    <input type="checkbox" name="activa_2doOf" id="activa_2doOf" value="true" onclick="javascript:habilita2();" ><label for="activa_2doOf">Activar 2do Oficio</label>
                                </div>
                        </div> <!--div_fechas-->
                    </div><!--backdiv-->
                    
                    <br><br>
            <DIV id="div_fechas2">   
                    <div id="cont_left"> 
                        <input type="checkbox" name="sin_fechas2" id="sin_fechas2" value="sin fechas" onclick="javascript:habilita2();"><label for="sin_fechas2"> Sin fechas en 2do ofcio. </label>
                    </div>

                <div class="backdiv2">   
                        <div id="cols_31">
                           <span>Nombre del destinatario </span><br>
                           <input type="text" name="nom_destinatario2" id="nom_destinatario2">
                       </div>

                       <div id="cols_32">
                           <span>Nombre del remitente </span><br>
                           <input type="text" name="nom_remitente2" id="nom_remitente2">
                       </div>

                       <div id="cols_33"> </div>


                       <div id="cols_31">
                           <span>Fecha<br>  de  2do. oficio enviado  </span><br>
                           <input type="text" id="fecha_ofic2" name="fecha_ofic2" placeholder="dd/mm/aaaa" class="fecha w20"> <br>
                          <!-- <input type="file" name="file_oficio2" id="file_oficio2" />-->
                       </div>

                       <div id="cols_32">
                           <span>Fecha de respuesta <br> del 2do. oficio enviado </span><br>
                           <input type="text" id="fecha_resp2" name="fecha_resp2" placeholder="dd/mm/aaaa" class="fecha w20"><br>
                           <!--<input type="file" name="file_resp2" id="file_resp2" />-->
                       </div>

                       <div id="cols_33">
                           <input type="checkbox" name="second_resp" id="second_resp" value="NO" onclick="javascript:habilita2();"><label for="second_resp">Sin 2da respuesta</label><br>
                           <input type="checkbox" name="activa_3erOf" id="activa_3erOf" value="true" onclick="javascript:habilita2();" ><label for="activa_3erOf">Activar 3er Oficio</label>
                       </div>
                </div> 
            </DIV>
                    <br>
                    
                    
            <DIV id="div_fechas3">         
                <div id="cont_left"> 
                  <input type="checkbox" name="sin_fechas3" id="sin_fechas3" value="sin fechas" onclick="javascript:habilita2();"><label for="sin_fechas3"> Sin fechas en 3er ofcio. </label>
                </div>
                    
                <div class="backdiv3"> 
                        <div id="cols_31">
                            <span>Nombre del destinatario </span><br>
                            <input type="text" name="nom_destinatario3" id="nom_destinatario3">
                        </div>

                        <div id="cols_32">
                            <span>Nombre del remitente </span><br>
                            <input type="text" name="nom_remitente3" id="nom_remitente3">
                        </div>

                        <div id="cols_33"> </div>

                        <div id="cols_31">
                            <span>Fecha<br>  de  3er. oficio enviado  </span><br>
                            <input type="text" id="fecha_ofic3" name="fecha_ofic3" placeholder="dd/mm/aaaa" class="fecha w20"> <br>
                          <!--  <input type="file" name="file_oficio3" id="file_oficio3" />-->
                        </div>

                        <div id="cols_32">
                            <span>Fecha de respuesta <br> del 3er. oficio enviado </span><br>
                            <input type="text" id="fecha_resp3" name="fecha_resp3" placeholder="dd/mm/aaaa" class="fecha w20"><br>
                         <!--   <input type="file" name="file_resp3" id="file_resp3" />-->
                        </div>

                        <div id="cols_33">
                            <input type="checkbox" name="third_resp" id="third_resp" value="NO" onclick="javascript:habilita2();">   <label for="third_resp">Sin 3er respuesta</label> 
                        </div>
                </div>  
            </DIV>      
                    
             
              </div>      
                    
                    <br> <br>
                    
                  <div id="div_acepto">   
                    <div id="cont_left">
                        <span>¿Aceptó?</span><br>&nbsp;
                        <input type="radio" name="acepto" id="acepto_si" value="SI" onclick="javascript:habilita();"><label for="acepto_si">SI</label>  &nbsp; &nbsp;
                        <input type="radio" name="acepto" id="acepto_no" value="NO" onclick="javascript:habilita();"><label for="acepto_no">NO</label>  &nbsp; &nbsp;
                     <!--   <input type="radio" name="acepto" id="acept_sinresp" value="SR" onclick="javascript:habilita();"><label for="acept_sinresp">Sin respuesta</label>-->
                    </div>
                 </div>
                    
                    <div id="condicionSi">
                        <span> ¿Qué aceptó?</span><br>&nbsp; &nbsp; &nbsp; &nbsp;
                        <input type="checkbox" name="que_acepto" id="cap_curt" value="Recibir capacitación sobre la Norma Técnica de la CURT" > <label for="cap_curt">Recibir capacitación sobre la Norma Técnica de la CURT</label><br>&nbsp; &nbsp; &nbsp; &nbsp;
                        <input type="checkbox" name="que_acepto" id="gen_curt" value="Generar y/o actualizar la CURT" > <label for="gen_curt">Generar y/o actualizar la CURT</label>  
                       
                    <!--<br>&nbsp; &nbsp; &nbsp; &nbsp;<input type="checkbox" name="que_acepto" id="otro" value="Otro"> Otro-->
                    </div>
                    
                    
                    <div id="condicionNo">
                        <span>Motivo:</span><br><br>
                        <textarea name="motivo" id="motivo" rows="3"></textarea>
                    </div>
                    <br><br>
                    <div id="div_obs">
                        <span>Observaciones:</span><br>
                        <textarea name="observaciones" id="observaciones" rows="5"></textarea>
                    </div>
                    
                </fieldset>
            </div>
                <input type="hidden" name="todo" value="upload">
                  <div id="btn_enviar">
                      <!-- href="elimina_registro.jsp?ue=< %=id_ue%>&tab=concertacion"-->
                      <input type="button" value="&ll; Regresar" onclick="javascript:cancelar_activ();" class="bcancelar">    &nbsp;
                      <input type="button" value="+ Guardar" id="guarda_reg" name="guarda_reg" onclick="javascript:proceso_guardap1();" >
                      <input type="button" value="&circlearrowright; Actualizar" name="actualizar" id="actualizar" onclick="javascript:proceso_ActualizaP1();" class="bactualizar">
                    <!--  <input type="submit" value="submit">-->

                 </div>   
                    <!--
                                Server Version: < %= application.getServerInfo() %><br>
                                Servlet Version: < %= application.getMajorVersion() %>.< %= application.getMinorVersion() %>
                                JSP Version: < %= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %>
                    -->
  <div id="div_delete">                
    <a class="boton_delete" href="javascript:postwith('elimina_registro.jsp',{ue:'<%=id_ue%>', tab:'concertacion'})"> 
        <span class="icon-trashcan" style="font-size:18px;"></span> <span style="font-size:10px;">Eliminar registro</span>
    </a> &nbsp;  &nbsp;   &nbsp; 
  </div>            
            </form>   
        </div>
                 <br>
             <div id="cont_tablas">
                      <span class="TextTitulo subrayado">Agregar Documentos</span><br><br>
                      <table id="lis_filas_curtp1">
                          <!--Aqui van agregandose las filas dinamicamente -->
                      </table> 
             </div>     
                 
       
        <footer>
                    <div id="foot1">
                        Términos de uso | Contacto<br>
                    <span class="text_f_sm"> Derechos Reservados © INEGI</span>
                    </div>
       </footer>
    </body>
</html>


<%
    } //termina el if

      else{  
        // out.print("Debes Iniciar Sesión"); 
    %>
     <script> alert("Inicia sesión para ver esta página");</script>
     <script>location.href = "index.jsp";</script>
    
    <% 
       }// Termina el ELSE 
    %>