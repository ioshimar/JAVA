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
    //   ConexionDirecBD conexionDir=new ConexionDirecBD();
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
          <script src="js/jquery/url_oculta.js" type="text/javascript"></script>
          <script>
            function cancelar_activ(){
               var r = confirm("¿Deseas regresar?");
                  if (r === true) {
                       //location.href = "captura.jsp?ue="+< %=id_ue%>;
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
                buttonImageOnly: true,
              dateFormat: "dd/mm/yy"//formato de fecha año/mes/dia
            });
            });
        </script>
       
      
        <script src="js/jquery/recoge_datP5.js" type="text/javascript"></script>

        
        
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
<script src="js/ajx_agrega_gencurtP10.js" type="text/javascript"></script>
<script src="js/actualiza_gencurtP10.js" type="text/javascript"></script>
<script src="js/verifica_permisos.js" type="text/javascript"></script>

        <script>
     $(document).ready(function() {
                        carga_resultadosP10(<%=id_ue%>);
                        $("#actualizar").css("display","none");  //que no este visible el botón actualizar
                        $("#nuevo_reg").css("display","none");
                        verifica_permisos(<%=id_ue%>);
             });
        </script>

        <script>
            function CargaInput(valor){
                $("#total_motivo").val(valor); //cargamos en este input, el mismo valor que escribimos en Total de motivos
                
            }
        </script>
 


<link href="css/icomoon/iconos.css" rel="stylesheet" type="text/css"/>
<link href="header_menu/header.css" rel="stylesheet" type="text/css"/>
<script src="header_menu/menuResponsive.js" type="text/javascript"></script>
<link href="header_menu/menu_responsive.css" rel="stylesheet" type="text/css"/>
<script src="js/cerrar_notif.js" type="text/javascript"></script>
    </head>
    
    <body>
        <div id="notif"><div id="result">   </div><div id="cerrarDiv"><!--<img src="images/cerrar.png" width="30" height="30"/>--><a>Continuar</a></div> </div>
     <%
         String nom_usuario="";
         String cve_edo="";
         PreparedStatement pst41 =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_EDO\",\"CVE_EDO\" from \"seguim_CURT\".cat_edo where \"CVE_EDO\" = '"+sesion_cve_enc+"' ");
         conexion.rs =pst41.executeQuery(); //ejecutamos la consulta
         while(conexion.rs.next()) {//se guarda cada resultado en la variable de opciones
         nom_usuario = conexion.rs.getString("NOM_EDO");
         cve_edo = conexion.rs.getString("CVE_EDO");
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
                
              </div>      
           </div>
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
              finally {//conexion.closeConnection(); 
                    }      
    
  
        %>
     
     
     <%         //nueva conslta para sacar el nombre de la UE
                String nombre_ue="";
                String folio_ue="";
                String nom_mun ="";
                String name_edo ="";
                
    try{              
         PreparedStatement pst25 =(PreparedStatement) conexion.conn.prepareStatement( "select T1.\"Id\",T1.\"FOLIO\",T1.\"INSNOMBRE\",T1.\"INSNOMBRECIUDADMPIO\",T1.\"CVE_ENTIDAD\", T1.\"CVE_MUN\",  T2.\"NOM_EDO\" "
         + " FROM  \"seguim_CURT\".ufg_directori_ufg as T1, \"seguim_CURT\".cat_edo as T2 "
         + " WHERE T1.\"Id\" = '"+id_ue+"' "
         + " AND T1.\"CVE_ENTIDAD\"  =  T2.\"CVE_EDO\" "
         + " AND T1.\"CVE_ENTIDAD\" In('"+claves_separadas+"') ORDER BY T1.\"INSNOMBRE\" ");
                conexion.rs =pst25.executeQuery(); 
                while(conexion.rs.next()) {
                    nombre_ue= conexion.rs.getString("INSNOMBRE");
                    folio_ue=conexion.rs.getString("FOLIO"); 
                    nom_mun = conexion.rs.getString("INSNOMBRECIUDADMPIO").toLowerCase(); //lo convertimos a minusculas primero 
                   name_edo = conexion.rs.getString("NOM_EDO");
                }
     } catch(SQLException e){out.print("exception"+e);}
              finally {
                    // conexion.closeConnection(); 
                    }                   
                String Nombre_mun2 = nom_mun.substring(0, 1).toUpperCase() + nom_mun.substring(1); // Solo convertimos la primera a mayuscula
                
           
     %>  
        
        <div id="cont_formulario">
          <form id="curtp10" name="curtp10"> 
            <span class="TextTitulo subrayado">Generación de la CURT</span><br><br>
            <div id="cont_center"><span class="text_smal15"> <%=nombre_ue+ " ("+Nombre_mun2+", "+name_edo+")"%></span></div><br>
            <% String fecha=getFechaActual();%>
             <div id="div_fecha">Fecha: 
              <input type="text" id="fecha_llenado" name="fecha_llenado" value="<%out.print(fecha);%>" readonly style="border-width:0; background:none; font-weight: bold;" class="w15" >
              <input type="hidden" id="privilegio" name="privilegio" value="<%=privilegio%>">
              <input type="hidden" name="usuario_resp" id="usuario_resp" value="<%=sesion_cve_enc%>" class="w5" readonly="">
             </div>
            <input type="hidden" name="id_ue" id="id_ue" value="<%=id_ue%>">
            <input type="hidden" name="id_generacion" id="id_generacion" value="" > <!-- le agregaremos valor hasta que le demos en el botón editar o Actualizar-->
            <input type="hidden" name="cve_edo" id="cve_edo" value="<%=cve_edo%>"
            <div id="cont_center2">   
            <div id="col_text">Selecciona el archivo</div>
            <div id="col_inp">
                <select name="id_archivo" id="id_archivo" class="w30" onchange="javascript:carga_datp5(this.value)">
                     <option value=""> Selecciona un archivo...</option>
                          <%
                     //nueva conslta para rellenar el listado
                String nombre_archivo="";
                String ID_entrega ="";
            try{     
                
                PreparedStatement pst28 =(PreparedStatement) conexion.conn.prepareStatement( "SELECT id_entrega, nom_archivo FROM \"seguim_CURT\".datos_entrega_fis "
                        + "WHERE id_ue ='"+id_ue+"' ");
                conexion.rs =pst28.executeQuery(); 
                while(conexion.rs.next()) {
                nombre_archivo= conexion.rs.getString("nom_archivo");
                 ID_entrega = conexion.rs.getString("id_entrega"); 
                      %> 
                        <OPTION value="<%=ID_entrega%>"><%out.println(nombre_archivo);%> </OPTION> 
                <% }
                     }  catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
                      conexion.closeConnection();
                    }   
                %>  
                </select>
                
            </div>
                 <div id="col_text">Archivo seleccionado:</div>
                 <div id="col_inp"><input type="text" name="nom_archivo" id="nom_archivo" class="w15 read" readonly="readonly"></div><br>
                 
                 <div id="col_text"><span id="lbl_resp">Nombre del responsable</span></div>
            <div id="col_inp"><input type="text" name="nom_respgen" id="nom_respgen" class="w50"></div>
            <br><br>
            
            <fieldset>
                <legend>Fecha de procesamiento (dd/mm/aa)</legend>
                <div id="col_text"><!-- --></div>
                <div id="col_inp"> 
                    <div id="cont1">  Inicio <br><input type="text" name="fech_ini10" id="fech_ini10" class="fecha w15" placeholder="dd/mm/aaaa"></div>
                    <div id="cont2">  Término<br><input type="text" name="fech_ter10" id="fech_ter10" class="fecha w15" placeholder="dd/mm/aaaa"> </div>
                </div>
            </fieldset>
            <br><br>
            
            <fieldset>
                <legend>Resultados</legend>
                <div id="col_text"></div>
                <div id="col_inp">
                    <div id="cont1"> Predios con CURT<br> <input type="text" name="con_curt" id="con_curt" class="w15"></div>
                    <div id="cont2"> Predios sin CURT <br> <input type="text" name="sin_curt" id="sin_curt" class="w15" ></div>
                </div>
               <br><br><br>
                
             
                
               <!-- <fieldset>
                    <legend>Motivos por lo que no se generó la CURT</legend>
                    <table class="table table-bordered" id="dynamic_field2" style="max-width:600px; margin: 0 auto;"> 
                   <tr> 
                       <th width="30%" style="text-align: center;">Total</th>
                       <th width="45%" style="text-align: center;">Motivo(s)</th>
                    </tr>
                   <tr>
                       <td><input type="text" name="total_motivo" id="total_motivo" class="w10" placeholder="Total"></td> 
                       <td><input type="text" name="motivo" id="motivo" class="w30" placeholder="Motivo(s)"></td> 
                      
                      <!-- <td width="15%"><button type="button" name="add2" id="add2" class="btn btn-success">Agregar <br> renglones</button></td>//
                   </tr>
               
               </table>
                </fieldset>
                -->
                
            </fieldset>
           
        </div>
         
                
                  <div id="btn_enviar">
                    
                      <input type="button" value="Limpiar formulario" name="nuevo_reg" id="nuevo_reg" onclick="javascript:ResetForm10();" class="bLimpiaFrom" >&nbsp; &nbsp; &nbsp; &nbsp;
                        <input type="button" value="+ Agregar registro" name="agrega_reg" id="agrega_reg" onclick="agrega_gencurtP10();">&nbsp;
                        <input type="button" value="&circlearrowright; Actualizar" name="actualizar" id="actualizar" onclick="javascript:proceso_ActualizaP10();" class="bactualizar">
                 </div>
                
                <br>
                  <div id="btn_enviar">
                    <input type="button" value="&ll; Regresar" onclick="javascript:cancelar_activ();" class="bcancelar">    &nbsp;
                    <!-- <input type="button" value="Terminar" onclick="javascript:window.open('captura.jsp?ue=< %=id_ue%>','_self')"> -->
                 </div>
                
               </form>
        </div>
                
                
                <div id="cont_tablas">
                      <span class="TextTitulo subrayado">Registros agregados...</span><br><br>
                      <table id="lis_filas">
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