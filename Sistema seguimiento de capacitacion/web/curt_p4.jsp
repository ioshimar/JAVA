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
       //ConexionDirecBD conexionDir=new ConexionDirecBD(); 
        String id_ue = request.getParameter("ue");
        
        String privilegio ="";
            int sesionInt = Integer.parseInt(sesion_cve_enc); //convertimos el string (Sesion) en INT
            if(sesionInt >= 33){
                 privilegio = "REGIONAL";
            }else if(sesionInt <= 32){
               privilegio = "ESTATAL";     
        }
    %>
     
   
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><!-- tipo de codificacion-->
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
          
          <script src="js/ajx_guarda_asesorP4.js" type="text/javascript"></script>
          <script src="js/actualiza_asesorP4.js" type="text/javascript"></script>
          <script src="js/funCargaAsesorP4.js" type="text/javascript"></script>
          <script src="js/jquery/url_oculta.js" type="text/javascript"></script>
          
         <script>
            function cancelar_activ(){
               var r = confirm("¿Deseas regresar?");
                  if (r == true) {
                                //  location.href = "captura.jsp?ue="+< %=id_ue%>;
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
                 var chk_reg_ue = document.getElementById("chk_reg_ue");
                    if(chk_reg_ue.checked){
                         $('#div_reg_ue').show(700); 
                    }else{
                         $('#div_reg_ue').hide(700); 
                         $('#div_reg_ue').find('input, textarea, select').val(''); //resetamos el valor
                    }
                    
                var chk_usoapp = document.getElementById("chk_usoapp");   
                 if(chk_usoapp.checked){
                         $('#div_usoapp').show(700); 
                    }else{
                         $('#div_usoapp').hide(700); 
                         $('#div_usoapp').find('input, textarea, select').val(''); //resetamos el valor
                    }
                    
                var chk_coord = document.getElementById("chk_coord");   
                 if(chk_coord.checked){
                         $('#div_coord').show(700); 
                    }else{
                         $('#div_coord').hide(700); 
                         $('#div_coord').find('input, textarea, select').val(''); //resetamos el valor
                    } 
                    
                var chk_estr = document.getElementById("chk_estr");   
                 if(chk_estr.checked){
                         $('#div_estr').show(700); 
                    }else{
                         $('#div_estr').hide(700); 
                         $('#div_estr').find('input, textarea, select').val(''); //resetamos el valor
                    } 
                    
                 var chk_convert = document.getElementById("chk_convert");   
                 if(chk_convert.checked){
                         $('#div_convert').show(700); 
                    }else{
                         $('#div_convert').hide(700); 
                         $('#div_convert').find('input, textarea, select').val(''); //resetamos el valor
                    }   
                    
                 var chk_interp = document.getElementById("chk_interp");   
                 if(chk_interp.checked){
                         $('#div_interp').show(700); 
                    }else{
                         $('#div_interp').hide(700); 
                         $('#div_interp').find('input, textarea, select').val(''); //resetamos el valor
                    }       
                
        
                    
                    
            }
        </script>
        
          <script>
              $(document).ready(function(){
                    carga_actualizaP4(<%=id_ue%>);
                    habilita();
                    $("#actualizar").css("display","none");
                    $(".boton_delete").css("display","none");
               });   
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
         PreparedStatement pst41 =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_EDO\",\"CVE_EDO\" from \"seguim_CURT\".cat_edo where \"CVE_EDO\" = '"+sesion_cve_enc+"' ");
         conexion.rs =pst41.executeQuery(); //ejecutamos la consulta
         while(conexion.rs.next()) {//se guarda cada resultado en la variable de opciones
         nom_usuario = conexion.rs.getString("NOM_EDO");
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
            <a href="inicio_curt.jsp"> <li> Inicio</li></a>
            <a href="javascript:postwith('captura.jsp',{ue:'<%=id_ue%>'})"> <li>  Captura </li> </a>
            <a href="selecciona_ue.jsp"> <li> Cambiar UE</li></a>
          </ul>
           <ul class="text-right">
              <li><span class="negrita"><%=nom_usuario.toUpperCase()%> <span class="caret icon-chevron-down"> <!--boton --></span></span>
                   <ul class="children">    
                        <li> <a href="cambiar_psw.jsp"> <span class="icon-engrane"></span> Cambiar contraseña</a></li>
                    </ul>
              </li>
              <li class="cerrar_ses"> <a href="logout_curt.jsp"> <span class="icon-exit"></span> Cerrar Sesión</a></li>
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
              finally {
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
        <div id="cont_formulario">
            <form id="curtp4" name="curtp4" > 
            <span class="TextTitulo subrayado">Asesoría a las Unidades del Estado</span><br><br>
            <div id="cont_center"><span class="text_smal15">  <%=nombre_ue+ " ("+Nombre_mun2+", "+name_edo+")"%></span></div><br>
            
             <% String fecha=getFechaActual();%>
             <div id="div_fecha">Fecha: 
              <input type="text" id="fecha_llenado" name="fecha_llenado" value="<%out.print(fecha);%>" readonly style="border-width:0; background:none; font-weight: bold;" class="w15" >
              <input type="hidden" name="privilegio" id="privilegio" value="<%=privilegio%>" >
              <input type="hidden" name="usuario_resp" id="usuario_resp" value="<%=sesion_cve_enc%>" class="w5" readonly="">
             </div>
            
            <div id=""> 
                <input type="hidden" name="id_ue" id="id_ue" value="<%=id_ue%>">
                <span class="Text_tit">Selecciona el tipo de Asesoría:</span><br>
                <input type="checkbox" name="tipo_asesoria" id="chk_reg_ue" onclick="javascript:habilita();" value="Registro de la UE en el aplicativo"> <label for="chk_reg_ue">Registro de la UE en el aplicativo</label>
                <fieldset id="div_reg_ue">
                    <legend>Registro de la UE en el aplicativo</legend>
                    <div id="cont1">
                        Fecha de Inicio<br>
                        <input type="text" id="fecha_ini" name="fecha_ini" placeholder="dd/mm/aaaa" class="fecha w15"> 
                   </div>
                    
                    <div id="cont2">
                        Fecha de Término<br>
                        <input type="text" id="fecha_fin" name="fecha_fin" placeholder="dd/mm/aaaa" class="fecha w15"> 
                   </div>
                    <br><br>
                    
                    <div id="cont1">
                        Nombre del asesor<br>
                        <input type="text" name="name_resp" id="name_resp" class="w50">
                    </div>
                    
                     <div id="cont2">
                        Nombre de la persona que recibío asesoría<br>
                        <input type="text" name="name_ase" id="name_ase" class="w50">
                    </div>
                </fieldset>
                <br><br>
                <input type="checkbox" name="tipo_asesoria" id="chk_usoapp" onclick="javascript:habilita();" value="Uso y manejo del aplicativo"> <label for="chk_usoapp">Uso y manejo del aplicativo</label>
                <fieldset id="div_usoapp">
                    <legend>Uso y manejo del aplicativo</legend>
                     <div id="cont1">
                        Fecha de Inicio<br>
                        <input type="text" id="fecha_ini_ap" name="fecha_ini_ap" placeholder="dd/mm/aaaa" class="fecha w15"> 
                   </div>
                    
                    <div id="cont2">
                        Fecha de Término<br>
                        <input type="text" id="fecha_fin_ap" name="fecha_fin_ap" placeholder="dd/mm/aaaa" class="fecha w15"> 
                   </div>
                    <br><br>
                    
                    <div id="cont1">
                        Nombre del asesor<br>
                        <input type="text" name="name_resp_ap" id="name_resp_ap" class="w50">
                    </div>
                    
                     <div id="cont2">
                        Nombre de la persona que recibío asesoría<br>
                        <input type="text" name="name_ase_ap" id="name_ase_ap" class="w50">
                    </div>
                </fieldset>
                <br><br>
                
                 <input type="checkbox" name="tipo_asesoria" id="chk_estr" onclick="javascript:habilita();" value="Estructuración de la información"> <label for="chk_estr">Estructuración de la información</label>
                <fieldset id="div_estr">
                    <legend>Estructuración de la información</legend>
                     <div id="cont1">
                        Fecha de Inicio<br>
                        <input type="text" id="fecha_ini_est" name="fecha_ini_est" placeholder="dd/mm/aaaa" class="fecha w15"> 
                     </div>
                    
                    <div id="cont2">
                        Fecha de Término<br>
                        <input type="text" id="fecha_fin_est" name="fecha_fin_est" placeholder="dd/mm/aaaa" class="fecha w15"> 
                    </div>
                    <br><br>
                    
                    <div id="cont1">
                        Nombre del asesor<br>
                        <input type="text" name="name_resp_est" id="name_resp_est" class="w50">
                    </div>
                    
                    <div id="cont2">
                        Nombre de la persona que recibío asesoría<br>
                        <input type="text" name="name_ase_est" id="name_ase_est" class="w50">
                    </div>
                </fieldset>
                 <br><br>
                
                <input type="checkbox" name="tipo_asesoria" id="chk_coord" onclick="javascript:habilita();" value="Convertir coordenadas cartesianas a geográficas"> <label for="chk_coord">Convertir coordenadas cartesianas a geográficas</label>
                <fieldset id="div_coord">
                    <legend>Convertir coordenadas cartesianas a geográficas</legend>
                   <div id="cont1">
                        Fecha de Inicio<br>
                        <input type="text" id="fecha_ini_conv" name="fecha_ini_conv" placeholder="dd/mm/aaaa" class="fecha w15"> 
                   </div>
                    
                   <div id="cont2">
                        Fecha de Término<br>
                        <input type="text" id="fecha_fin_conv" name="fecha_fin_conv" placeholder="dd/mm/aaaa" class="fecha w15"> 
                   </div>
                    <br><br>
                    
                    <div id="cont1">
                        Nombre del asesor<br>
                        <input type="text" name="name_resp_conv" id="name_resp_conv" class="w50">
                    </div>
                    
                    <div id="cont2">
                        Nombre de la persona que recibío asesoría<br>
                        <input type="text" name="name_ase_conv" id="name_ase_conv" class="w50">
                    </div>
                </fieldset>
                <br><br>
                
               
                
                 <input type="checkbox" name="tipo_asesoria" id="chk_convert" onclick="javascript:habilita();" value="Convertir información de un sistema de referencia geodésico a otro"> <label for="chk_convert">Convertir información de un sistema de referencia geodésico a otro</label>
                 <fieldset id="div_convert">
                    <legend>Convertir información de un sistema de referencia geodésico a otro</legend>
                    <div id="cont1">
                         Fecha de Inicio<br>
                         <input type="text" id="fecha_ini_ref" name="fecha_ini_ref" placeholder="dd/mm/aaaa" class="fecha w15"> 
                    </div>
                    
                    <div id="cont2">
                        Fecha de Término<br>
                        <input type="text" id="fecha_fin_ref" name="fecha_fin_ref" placeholder="dd/mm/aaaa" class="fecha w15"> 
                    </div>
                    <br><br>
                    
                    <div id="cont1">
                        Nombre del asesor<br>
                        <input type="text" name="name_resp_ref" id="name_resp_ref" class="w50">
                    </div>
                    
                    <div id="cont2">
                        Nombre de la persona que recibío asesoría<br>
                        <input type="text" name="name_ase_ref" id="name_ase_ref" class="w50">
                    </div>
                </fieldset>
                 <br><br>
                
                 <input type="checkbox" name="tipo_asesoria" id="chk_interp" onclick="javascript:habilita();" value="Interpretación de los resultados de generación/actualización de la CURT"> <label for="chk_interp">Interpretación de los resultados de generación/actualización de la CURT</label>
                 <fieldset id="div_interp">
                    <legend>Interpretación de los resultados de generación/actualización de la CURT</legend>
                   <div id="cont1">
                        Fecha de Inicio<br>
                        <input type="text" id="fecha_ini_int" name="fecha_ini_int" placeholder="dd/mm/aaaa" class="fecha w15"> 
                   </div>
                    
                    <div id="cont2">
                        Fecha de Término<br>
                        <input type="text" id="fecha_fin_int" name="fecha_fin_int" placeholder="dd/mm/aaaa" class="fecha w15"> 
                   </div>
                    <br><br>
                    
                    <div id="cont1">
                        Nombre del asesor<br>
                        <input type="text" name="name_resp_int" id="name_resp_int" class="w50">
                    </div>
                    
                     <div id="cont2">
                        Nombre de la persona que recibío asesoría<br>
                        <input type="text" name="name_ase_int" id="name_ase_int" class="w50">
                    </div>
                </fieldset>
                
            
            
            </div>
           
            
                
                  <div id="btn_enviar">
                    <input type="button" value="&ll;  Regresar" onclick="javascript:cancelar_activ();" class="bcancelar">    &nbsp;
                     <input type="button" value="+ Guardar" id="guarda_reg" name="guarda_reg" onclick="javascript:proceso_guardaP4();">
                     <input type="button" value="&circlearrowright; Actualizar" name="actualizar" id="actualizar" onclick="javascript:proceso_ActualizaP4();" class="bactualizar">
                 </div>
                
                <div id="div_delete">
                     <a class="boton_delete" href="javascript:postwith('elimina_registro.jsp',{ue:'<%=id_ue%>', tab:'asesoria'})">
                       <span class="icon-trashcan" style="font-size:18px;"></span> <span style="font-size:10px;">Eliminar registro</span>
                     </a> 
                </div>
            </form>
        </div>
        <br><br><br><br>
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