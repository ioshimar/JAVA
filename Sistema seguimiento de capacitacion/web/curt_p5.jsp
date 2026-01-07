<%-- 
    Document   : altas
    Created on : 29-abr-2014, 10:53:27
    Author     : est.cynthia.rivera
--%>
<%@page import="BaseDatos.ConexionProdCurt"%>
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
     if(sesion_cve_enc!=null){  //SI NO ES NULA
%>
<html>
    <%
        //conexiones a la base de datos
        ConexionBD conexion=new ConexionBD();
       //  ConexionDirecBD conexionDir=new ConexionDirecBD(); 
         ConexionProdCurt conexionCURT = new ConexionProdCurt();
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
          <!--<script src="js/Addinput.js" type="text/javascript"></script>-->
          <script src="js/agregar_ent_fisica.js" type="text/javascript"></script>
          <script src="js/actualiza_ent_fisP5.js" type="text/javascript"></script>
          
          <script src="js/jquery/recoge_datP13CURT.js" type="text/javascript"></script>
          <script src="js/jquery/carga_ConsCompCurt.js" type="text/javascript"></script>
          <script src="js/jquery/url_oculta.js" type="text/javascript"></script>
          
          <script src="js/verifica_permisos.js" type="text/javascript"></script>
          <script>
            function cancelar_activ(){
               var r = confirm("¿Deseas regresar?");
                  if (r === true) {
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
            function habilitap5(){
                  var entrega_web = document.getElementById("entrega_web");
                  var entrega_fis = document.getElementById("entrega_fis");
                  
                   if(entrega_web.checked){
                         $('#div_ent_fis').hide(700); 
                         $('#div_ent_fis').find('input, textarea, select').val(''); //resetamos el valor
                    }else if(entrega_fis.checked)  {
                         $('#div_ent_fis').show(700); 
                        
                    }
                
            }
        </script>
       
      
        <script>
            $(document).ready(function() {
                        carga(<%=id_ue%>);
                        $("#actualizar").css("display","none");  //que no este visible el botón actualizar
                        verifica_permisos(<%=id_ue%>);
                        habilitap5();
             });
        </script>
        
        <script>
            function ResetForm(){
            document.getElementById("form_entregaP5").reset();
              $("#actualizar").css("display","none");  //quitamos el boton actualizar
              //$("#nuevo_reg").css("display","none");  //quitamos el boton Nuevo Reg
              $("#agrega_reg").css("display","inline-block"); //Aparecemos el botón Nuevo Reg
              $("#nom_arch, #tamano, #no_reg, #pred_con_curt, #pred_sin_curt").attr('disabled', false); //lo habilitamos
          }
        </script>
        
        <script>
            
            
var peticion = false;//se crea la variable peticion
var  testPasado = false;//se crea la variable
try{    
    peticion = new XMLHttpRequest();//se inicia la peticion
} catch (trymicrosoft){
    try{
        peticion = new ActiveXObject("Msxml2.XMLHTTP");//se activa el objeto
    } catch (othermicrosoft){//si cae en este catch
        try{
            peticion = new ActiveXObject("Microsoft.XMLHTTP");//se activa el objeto nuevamente como elemento microsoft
        } catch (failed){//si entra en este catch 
            peticion = false;//se indica que la peticion fallo
        }
    }
}

if (!peticion)//si la peticion es falsa
alert("ERROR AL INICIALIZAR!");//muestra cuadro de dialogo con este mensaje

            function cargarCombo (url, comboAnterior, element_id){    
    var element =  document.getElementById(element_id);//recupera el elemento de acuerdo al id de entrada
    var valordepende = document.getElementById(comboAnterior);//seleccion del combo anterior
    var x = valordepende.value; //recupera el valor seleccionado del combo anterior   
    
    var fragment_url = url+"?id_ue="+x;//tomando el url se compone un nuevo fragmento  (toma el valor del Select de la opcion que escogimos en en el UES)
    peticion.open("GET", fragment_url);//se llama la peticion por metodo get 
    peticion.onreadystatechange = function(){//la peticion esta a la escucha de cambios para llamar la funcion
        if (peticion.readyState == 4){
            //escribimos la respuesta
            element.innerHTML = peticion.responseText;
        } 
    } 
   peticion.send(null); 
   
     // document.getElementById("Folio").value = "";   //RESETEAMOS EL FOLIO cada que cambiemos la unidad de Estado
        }
            
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
<script src="js/cerrar_notif.js" type="text/javascript"></script>

 
    </head>
    
    <body>
        <div id="notif"><div id="result">   </div><div id="cerrarDiv"><!--<img src="images/cerrar.png" width="30" height="30"/>--><a>Continuar</a></div> </div>
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
        
        
      
       <%! String claves_estado, entidad_encargado, claves_separadas , Nombre_mun2; %> <!--Variables Globales -->
        
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
                String Cpostal ="";
       try{              
         PreparedStatement pst25 =(PreparedStatement) conexion.conn.prepareStatement( "select T1.\"Id\",T1.\"FOLIO\", T1.\"CPOSTAL\", T1.\"INSNOMBRE\",T1.\"INSNOMBRECIUDADMPIO\",T1.\"CVE_ENTIDAD\", T1.\"CVE_MUN\",  T2.\"NOM_EDO\" "
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
                   Cpostal = conexion.rs.getString("CPOSTAL");
                } 
                 Nombre_mun2 = nom_mun.substring(0, 1).toUpperCase() + nom_mun.substring(1); // Solo convertimos la primera a mayuscula
                
        } catch(SQLException e){out.print("exception"+e);}
              finally {conexion.closeConnection(); }              
           
     %>  
        
        <div id="cont_formulario">
            
            <form id="form_entregaP5">
           
            <span class="TextTitulo subrayado">Datos de la entrega de información al INEGI </span><br><br>
            <div id="cont_center"><span class="text_smal15"> <%=nombre_ue+ " ("+Nombre_mun2+", "+name_edo+")"%></span></div><br>
            <div id="cont_center2">
                  <% String fecha=getFechaActual();%>
            <div id="div_fecha">Fecha: 
              <input type="text" id="fecha_llenado" name="fecha_llenado" value="<%out.print(fecha);%>" readonly style="border-width:0; background:none; font-weight: bold;" class="w15" >
              <input type="hidden" name="privilegio" id="privilegio" value="<%=privilegio%>" >
              <input type="hidden" name="usuario_resp" id="usuario_resp" value="<%=sesion_cve_enc%>" class="w5" readonly="">
            </div>
                 
                <input type="hidden" name="id_ue5" id="id_ue5" value="<%=id_ue%>">
                <input type="hidden" name="id_entrega" id="id_entrega" value="" >
                
                <div id="col_text"> Tipo de Enrtrega:</div>
                <div id="col_inp"> 
                    <input type="radio" name="tipo_entrega" id="entrega_web" value="app_web" onclick="javascript:habilitap5();"> <label for="entrega_web"> Por aplicativo Web</label><br>
                    <input type="radio" name="tipo_entrega" id="entrega_fis" value="ent_fis" onclick="javascript:habilitap5();"> <label for="entrega_fis"> Entrega Física</label>
                </div>
             <br><br>
             
             
                <div id="col_text">Fecha</div> 
                <div id="col_inp"><input type="text" id="fecha_dat" name="fecha_dat" placeholder="dd/mm/aaaa" class="fecha w15"> </div>
         
      
          
                <div id="col_text"> Nombre del responsable de la UE que entrega </div>
                <div id="col_inp">  <input type="text" name="nom_resp" id="nom_resp" class="w50"></div>
       
       <div id="div_ent_fis">      
            
            <fieldset>
                <legend>Estructura territorial de INEGI que recibe la información</legend>
                <div id="col_text">Unidad Administrativa</div>
                <div id="col_inp">  <input type="text" name="nom_ua" id="nom_ua" class="w50"></div>
              
                <div id="col_text">   Nombre del Responsable</div>
                <div id="col_inp">  <input type="text" name="resp_estr" id="resp_estr" class="w50"></div>
            </fieldset>
            
         
                <div id="col_text">Medio utilizado para la entrega</div>
                <div id="col_inp"> <input type="text" name="medio_udo" id="medio_udo" class="w20"></div>
       </div><!--div_ent_fis-->        
         
                <br><br>
            <fieldset>
                <legend>Información recibida</legend>
                
            <div id="slc_curt">
                Cargar Información desde la UE: <%=id_ue%><br>
                <select name="ue_curtprod" id="ue_curtprod" class="w100"  onchange="javascript:cargarCombo('obten_slc_archivos.jsp', 'ue_curtprod', 'div_subcategoria')" >
                    <option value=""> Selecciona una Opción</option>
                      <%
                     //nueva conslta para rellenar el listado
                String CURT_nombre_ue="";
                String CURT_idue ="";
                try{
                    PreparedStatement pst1 =(PreparedStatement) conexionCURT.conn.prepareStatement("SELECT nombre, idue FROM registrocurt.tr_ue WHERE codpostal = '"+Cpostal+"'");
                    conexionCURT.rs =pst1.executeQuery(); 
                     
                while(conexionCURT.rs.next()) {
                CURT_nombre_ue= conexionCURT.rs.getString("nombre");
                CURT_idue = conexionCURT.rs.getString("idue"); 
                %> 
                        <OPTION value="<%=CURT_idue%>"><%out.println(CURT_nombre_ue);%> </OPTION> 
                <% }
                 }
                catch(SQLException e){
                        out.print("exception"+e);
                    }finally{
                        conexionCURT.closeConnection();
                    } 
                
                %>  
                </select>
            </div>
                <br>
                
                <div id="slc_curt">
                    Archivos:<br>
                      <div id="div_subcategoria">     
                          <select  name="carga_archivos" id="carga_archivos" multiple="" ><!-- nuevo listado -->
                                 <option value="" selected="selected">- - -</option>    
                          </select><!-- fin de la lista --> 
                      </div> <!-- div_subcategoria--> 
                </div>
                <br><br>
                
         <div class="relative">
              <table> 
                   <tr> 
                       <th width="35%">Nombre del archivo</th>
                       <th width="18%">Tamaño de archivo (MB)</th>
                       <th width="18%">Número de registros</th>
                   </tr>
                   <tr>
                       <td><input type="text" name="nom_arch" id="nom_arch" class="w50" placeholder="Nombre archivo"></td> 
                       <td><input type="text" name="tamano" id="tamano" class="w10" placeholder="MB"></td> 
                       <td><input type="text" name="no_reg" id="no_reg" class="w10" placeholder="No. de registros"></td> 
                   </tr>
             </table>
             
           <!-- <div id="cols2">Predios con CURT-->
             <input type="hidden" name="pred_con_curt" id="pred_con_curt" value="0" class="w10">
            <!-- </div>-->
             
            <!--  <div id="cols2">Predios sin CURT-->
             <input type="hidden" name="pred_sin_curt" id="pred_sin_curt" value="0" class="w10">
             <!-- </div>-->
            
             
             <div id="loading_data" style="display:none;"   <br>
                 <img id="img_load" src="images/spinner-loading.gif" alt="" width="50px" height="50px"/>
                    <div id="text_load" class="CarroisGR16" style="text-align: center; color:#000; font-weight: bold;"> <!--aqui carga el texto--></div>
                    
                </div> 
         </div>   
                
                
            
            </fieldset>
                    <div id="btn_enviar">
                        <input type="button" value="Cancelar" name="nuevo_reg" id="nuevo_reg" class="bLimpiaFrom" onclick="javascript:ResetForm();" >&nbsp; &nbsp; &nbsp; &nbsp;
                        <input type="button" value="+ Agregar registro" name="agrega_reg" id="agrega_reg" onclick="javascript:Agrega_entfis();">&nbsp;
                        <input type="button" value="&circlearrowright; Actualizar" name="actualizar" id="actualizar" onclick="javascript:proceso_ActualizaP5();" class="bactualizar">
                    </div>
            </div>
                
                <div id="frame">
                    <iframe id="result_frame" name="result_frame">dd</iframe>
                </div>
                  
            
                <br>
                 <div id="btn_enviar">
                      <input type="button" value="&ll; Regresar" onclick="javascript:cancelar_activ();" class="bcancelar">    &nbsp;
                    <!-- <input type="button" value="Terminar" onclick="javascript:window.open('captura.jsp?ue=< %=id_ue%>','_self')"> -->
                 </div>
            </form>
        </div>
                
              
                
                
                <div id="cont_tablas">
                      <span class="TextTitulo subrayado">Archivos Agregados</span><br><br>
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