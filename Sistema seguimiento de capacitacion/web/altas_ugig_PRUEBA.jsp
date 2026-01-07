<%-- 
    Document   : altas_ufg
    Created on : 12-may-2014, 9:27:23
    Author     : est.cynthia.rivera
--%>

<%@page import="java.util.Locale"%>
<%@page import="BaseDatos.ConexionBD"%>
<%@page import="java.text.DateFormat"%>
<%@page import="Modelo.TipoVia"%>
<%@page import="Modelo.TipoViaConsulta"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.swing.DefaultComboBoxModel"%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    HttpSession objsesion_enc =request.getSession(false);
    String sesion_cve_enc = (String)objsesion_enc.getAttribute("session_dir"); //se crea la variable de Sesión
     if(sesion_cve_enc!=null){  //SI NO ES NULLA
%>

<html>
    <!-- Localidad  --> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><!-- codificacion de la pagina -->
        <title>Directorio de Instituciones Catastrales y Registrales</title><!-- titulo de la pagina -->
        <meta name="viewport" content="width=divice-width,initial-scale=1"/>
        <link rel="icon" href="images/icono_png.ico" type="image/gif" sizes="16x16">
        <!-- ligas a jquery -->
        
        
         <script src="header_menu/jquery-latest.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="css/style.css">
       
   
        <link href="css/estilos_formularios_ugig.css" rel="stylesheet" type="text/css"/>


  <script src="js/validaciones_ugig.js" type="text/javascript"></script>
  <script src="js/validaciones_ontime_ugig.js" type="text/javascript"></script>
  <script src="js/limpia_formulario.js" type="text/javascript"></script>
<script type="text/javascript">
var peticion = false;//nueva variable de peticion
var  testPasado = false;
try{    
    peticion = new XMLHttpRequest();
} catch (trymicrosoft){
    try{
        peticion = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (othermicrosoft){//si cae en este caso 
        try{//probamos
            peticion = new ActiveXObject("Microsoft.XMLHTTP");//activamos el objeto de esta forma
        } catch (failed){//si cae en este catch la peticion fallo
            peticion = false;//peticion falsa
        }
    }
}

if (!peticion)//si la peticion es falsa
alert("ERROR AL INICIALIZAR!");//cuadro de dialogo con mensaje
//funcion para cargar combo, 
//seo obtiene el valor del combo anterior y se envia a la url armada en esta funcion
//el resultado se escribe en el siguiente combo
function cargarCombo (url, comboAnterior, element_id){    
    var element =  document.getElementById(element_id);
    var valordepende = document.getElementById(comboAnterior);
    var x = valordepende.value;    
    var fragment_url = url+"?CVE_MUNICIPIO="+x+"&sw=0";
    peticion.open("GET", fragment_url); 
    peticion.onreadystatechange = function(){
        if (peticion.readyState == 4){
            //escribimos la respuesta
            element.innerHTML = peticion.responseText;
        } 
    } 
   peticion.send(null); //se envia la peticion
}
</script>  

 <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
 <link rel="stylesheet"  href="css/datepicker.css" />
 <script src="js/jquery/jquery-ui.js"></script> 
<!-- <script type="text/javascript" src="js/jquery/datepicker.js"></script>-->
<script type="text/javascript" src="js/jquery/datepicker-es.js"></script>

<script type="text/javascript">
//funcion anonima a la espera de la llamada para mostrar el objeto datepicker
$(document).ready(function(){
$("#fecha").datepicker({
        showOn: 'both',
        buttonImage: 'cal.gif',
        buttonImageOnly: true,
      
     
});
});
$(document).ready(function(){
$("#fecha2").datepicker({
    showOn: 'both',
    buttonImage: 'cal.gif',
    buttonImageOnly: true,
//    dateFormat: "yy-m-d"//formato de fecha año/mes/dia
});
});
$(document).ready(function(){
$("#fecha3").datepicker({
    showOn: 'both',
    buttonImage: 'cal.gif',
    buttonImageOnly: true,
  //dateFormat: "dd-mm-yy"//formato de fecha año/mes/dia
});
});
</script>

<script>
    function habilita(){
        var otro_gda = document.getElementById("otro_gd");
        var especifica_otro = document.getElementById("otro_esp");
     
     if(otro_gda.checked){
         especifica_otro.readOnly = false;           // quitamos el solo lectura
         especifica_otro.classList.remove("read");  //quitamos la clase
     }else{
        especifica_otro.readOnly = true;        //agregamos el solo lectura 
        especifica_otro.classList.add("read");  // agregamos la clase
        especifica_otro.value="";               // regresamos el valor a vacio
     }
        
    };
</script>


<script src="js/cambia_select.js" type="text/javascript"></script>

<link href="header_menu/MenuIconos.css" rel="stylesheet" type="text/css"/>
<link href="header_menu/header.css" rel="stylesheet" type="text/css"/>
<script src="header_menu/menuResponsive.js" type="text/javascript"></script>
<link href="header_menu/menu_responsive.css" rel="stylesheet" type="text/css"/>

 </head>
    <% ConexionBD conexion= new ConexionBD(); %><!-- nueva conexion a la base de datos -->
    <body><!-- imagen de fondo del cuerpo de la pagina -->
           <%
         String nom_usuario="";
         PreparedStatement pst41 =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_EDO\",\"CVE_EDO\" from db_directorio.cat_edo where \"CVE_EDO\" = '"+sesion_cve_enc+"' ");
         conexion.rs =pst41.executeQuery(); //ejecutamos la consulta
         while(conexion.rs.next()) {//se guarda cada resultado en la variable de opciones
         nom_usuario = conexion.rs.getString("NOM_EDO");
         }
     %> 
        
           <%
               String clave=""; 
               String val1= sesion_cve_enc;
       
       %>

 <div class="menu_bar">
            <a style="cursor:pointer;" class="bt-menu"> 
            <span class="icon-menu3"></span> <img src="images/inegi_vertical.png" width="51" height="31"/></a>
        </div> 
    <header>
        <div id="logo"> <a href="index.jsp"><img id="log-inegi" src="images/inegi_letras.png" alt=""/></a></div>
        <div id="nav">
          <ul>  
              <li><a href="javascript:window.history.back();">&laquo; Volver atrás</a></li>
              <li> &nbsp; &nbsp; &nbsp;</li>
              <li><a href="index.jsp">  Inicio</a></li>
              <li><a href="sis_dir.jsp"> Sistema Directorio</a> </li>
              <li><span class="negrita"><%=nom_usuario.toUpperCase()%></span> &nbsp; (UGIG)</li>
              <li class="cerrar_ses"><a href="logout_directorio.jsp"> <span class="caret icon-cross"></span> Cerrar Sesión</a> </li>
         </ul>
        </div>
    </header>       
       <div id="margen-oculto">&nbsp;</div>
        
        
<div id="Contenedor">
    <form method="post" id="formul2" name="fomul2" onsubmit="return validavacio();" action="operaciones_ugig.jsp"><!--nuevo formulario de envio a operaciones_ugig que llama a la funcion de validacion antes de enviarse -->
           <!-- nueva tabla -->
           <div id="Tit">   
           CEDULA DE IDENTIFICACIÓN DE UNIDADES DEL ESTADO (UE) Y UNIDADES GENERADORAS DE INFORMACIÓN GEOGRÁFICA (UGIG)
           </div>
           
           <div id="cont-r">  
            <!--   Folio:<input type="text" name="folio" id="folio"  maxlength="3" class="w10">  -->
                    Ambito UGIG:
                 <select name="ambito_ins" id="ambito_ins" class="captura"  onchange="CambiaSelect(this.id, 'tipo_ambito')">
                          <option value="" selected="selected">---</option>
                          <option value="E">ESTATAL</option>
                          <option value="M">MUNICIPAL</option>
                          <option value="F">FEDERAL</option>
                </select>
          </div>
           
           
            <div id="cont-r">  
                    Tipo de Ambito:
                 <select name="tipo_ambito" id="tipo_ambito" class="captura">
                          <option value="" selected="selected">---</option>
                   
                </select>
          </div>
           
           
           
           
           
                <!-- nueva fila y columna , se crea un objeto de fecha y establece el formato, se obtiene la fecha actual con el formato establecido-->
              <div id="cont-r"> Fecha de llenado: <% Date date = new Date ();
                    DateFormat df = new SimpleDateFormat ("dd' de 'MMMM' de 'yyyy", new Locale("ES", "MX"));%>
                    <input type="text" id="fecha_llenado" name="fecha_llenado" class="w20" value="<%=df. format ( date) %>" readonly style="border-width:0; background:none; font-weight: bold;">
              </div>
               
              
              <div id="encabezado">7. IDENTIFICACIÓN DE LA UNIDAD GENERADORA DE INFORMACIÓN GEOGRÁFICA (UGIG)</div>
    
   <!-- nueva fila si color -->
              <div id="f1" class="text-derecha">Unidad de Estado a la que pertenece:</div>
              
              <div id="f2">
                      <SELECT  name="nombre_ues" id="nombre_ues" class="captura"><!-- nuevo listado -->
                       <option value="" selected="selected">- - -</option>    
                      <%
                     //nueva conslta para rellenar el listado
                String nombre_ue="";
                String ue_Id="";
                 String ambito="";
                PreparedStatement pst25 =(PreparedStatement) conexion.conn.prepareStatement( "select \"Id\",\"INSNOMBRE\",\"CVE_ENTIDAD\",\"AMBITO\" from db_directorio.ufg_directori_ue where \"CVE_ENTIDAD\"='"+val1+"' ORDER BY \"INSNOMBRE\" ");
                conexion.rs =pst25.executeQuery(); //se ejecuta el listado
                while(conexion.rs.next()) {//se obtiene cada resultado de la consulta
                nombre_ue= conexion.rs.getString("INSNOMBRE");
                ue_Id=conexion.rs.getString("Id"); 
                ambito = conexion.rs.getString("AMBITO");  
                      %> <!-- se guarda el resultado en la variable -->
                       <!--  <OPTION value="< %=ue_clave%>">< %out.println(nombre_ue + "  " + "(" +nombre_loc + ")");%> </OPTION> -->
                        <OPTION value="<%=ue_Id%>"><%out.println(nombre_ue + " " + " &nbsp;("+ambito+")");%> </OPTION> 
                <% } %>  
                       </select><!-- fin de la lista -->      
                           
              </div>
                       
                       
   
   
   
   <div id="f1" class="text-derecha">7.1.Nombre Oficial:</div>
   <div id="f2"> <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="nomoficial" type="text" class="w100" maxlength="255" id="nomoficial"></div>
    
    <!-- nueva fila -->
    <div id="f1" class="text-derecha">Siglas o Acrónimo:</div>
    <div id="f2"><input onKeyUp="this.value=this.value.toUpperCase()" name="siglas" type="text" class="w20" maxlength="255" id="siglas"></div>
    <fieldset> 
        <legend> 8. Domicilio Oficial:</legend>
 
    <div id="f1">Vialidad:</div>
        <div id="f2"> 
            <div id="f2A"><span class="tipo11">Tipo: </span></div> <!-- linea de texto -->
            <div id="f2B"> 
                <SELECT NAME="tipovia" id="tipovia" class="captura" ><!-- lista seleccionable  -->
                    <option value="" selected="selected">- - -</option>
 <%
          String combo=""; 
          //consulta de tipo de via 
          PreparedStatement pst98=(PreparedStatement) conexion.conn.prepareStatement("SELECT tipoviadescripcion FROM db_directorio.cat_tipovia order by tipovia");
          conexion.rs=pst98.executeQuery();//ejecucion de consulta
          while(conexion.rs.next()){  //se obtiene un cada elemento de la consulta
          combo=conexion.rs.getString("tipoviadescripcion"); %><!--se guarda el resultado en la variable -->
          <OPTION> <%out.println(combo);%><!-- se agrega la opcion al listado -->
 </OPTION>
 <%}
 //termina la consulta
 %>
          </select>
          </div>
          <br>
          
    
          <div id="f2A"> <span class="tipo11">Nombre:</span></div>
          <div id="f2B"><input onKeyUp="this.value=this.value.toUpperCase()" name="nomvial" size="40" id="nomvial"></div>
    
      
          <div id="cols3-1">  
              <span class="tipo11">Número exterior: <br>
                  <input name="numexterior" id="numexterior" class="w5" onkeyup="val_num_exte(this.id);"></span>
         </div>
        
          <div id="cols3-2">
              <span class="tipo11">Número exterior alfanumérico:<br> 
              <input name="numexterioralfa" id="numexterioralfa" class="w20"></span>
          </div>
       
         <div id="cols3-3">
              <span class="tipo11">Número exterior anterior: <br>
                  <input name="numexteriorant" id="numexteriorant" class="w10" onkeyup="val_num_exte(this.id);"></span>
         </div>
          
          <br>
      
        <div id="cols3-1">  
            <span class="tipo11">Número interior: <br>
                <input name="numinterior" id="numinterior" class="w5" onkeyup="val_num_exte(this.id);"></span>
        </div>
       
       <div id="cols3-2">
            <span class="tipo11">Número interior alfanumérico:  <br>
            <input name="numinterioralfa" id="numinterioralfa" class="w20"></span>
       </div>
          
          <div id="cols3-1"></div><!--falso -->
 
 <br><br>
          
          
 
        
        <div id="f2A"><span class="tipo11">Edificio:</span> </div>
        <div id="f2B"> <input onKeyUp="this.value=this.value.toUpperCase()" name="edificio" id="edificio" size="90"></div>
         <br>
        <div id="f2A"> <span class="tipo11">Nivel: </span></div>
        <div id="f2B"> <input onKeyUp="this.value=this.value.toUpperCase()" name="nivel" id="nivel" class="w10"></div>
    
   
   <br> <br>
 <fieldset>
     <legend><span class="tipo11">Entre vialidades: </span> </legend><br>
    
  <div id="cols2-1">   
      <span class="tipo11">Tipo: </span> <br>
           <!-- listado de tipo de via -->
          <SELECT NAME="tipovia1" id="tipovia1" class="captura">
               <option value="NINGUNO" selected="selected">NINGUNO</option>
 <%       String combo1=""; 
            //consulta de tipos de via
          PreparedStatement pst99=(PreparedStatement) conexion.conn.prepareStatement("SELECT tipoviadescripcion FROM db_directorio.cat_tipovia order by tipovia");
          conexion.rs=pst99.executeQuery();//ejecucion de consulta
          while(conexion.rs.next()){  //se obtiene cada elemento de la consulta
          combo1=conexion.rs.getString("tipoviadescripcion"); %><!-- se guarda el resultado en la variable -->
          <OPTION><%out.println(combo1);%><!-- se agrega la variable como opcion del listado -->
 </OPTION>
 <%}%><!-- termina la consulta -->
          </select><!-- termina el listado -->
          
  </div>       
          
         <div id="cols2-2">  
             <span class="tipo11">Nombre: </span> <br>
            <input onKeyUp="this.value=this.value.toUpperCase()" name="nomvial1" id="nomvial1" size="60"> 
         </div>
          
    <div id="letra-centro">
        <span class="tipo11">y</span>
    </div>
 
 <div id="cols2-1">
     <span class="tipo11">Tipo: </span> <br>
          <SELECT NAME="tipovia2" id="tipovia2" class="captura">
               <option value="NINGUNO" selected="selected">NINGUNO</option>
<%        String combo4=""; 
            //nueva consulta de tipos de via
          PreparedStatement pst100=(PreparedStatement) conexion.conn.prepareStatement("SELECT tipoviadescripcion FROM db_directorio.cat_tipovia order by tipovia");
          conexion.rs=pst100.executeQuery();//se ejecuta la consulta
          while(conexion.rs.next()){  //se obtiene cada elemento de la 
          combo4=conexion.rs.getString("tipoviadescripcion"); %><!-- se guarda el resultado de la consulta en la variable -->
          <OPTION><%out.println(combo4);%><!-- se agrega la opcion a el listado -->
 </OPTION>
 <%}%>
          </select>
          
 </div> 
          
         <div id="cols2-2">
             <span class="tipo11">Nombre: </span><br>
            <input onKeyUp="this.value=this.value.toUpperCase()" name="nomvial2" id="nomvial2" size="60">
         </div>
          
 <br><br><br>
 <span class="tipo11">Vialidad Posterior: </span>
    <br>
   
    <div id="cols2-1">
        <span class="tipo11">Tipo: </span> <br>
          <SELECT NAME="tipovia3" id="tipovia3" class="captura">
            <option value="NINGUNO" selected="selected">NINGUNO</option> 
       <% String combo3=""; 
          //nueva consulta
          PreparedStatement pst101=(PreparedStatement) conexion.conn.prepareStatement("SELECT tipoviadescripcion FROM db_directorio.cat_tipovia order by tipovia");
          conexion.rs=pst101.executeQuery();//ejecucion de la consulta
          while(conexion.rs.next()){  //se obtiene cada elemento de la consulta
          combo3=conexion.rs.getString("tipoviadescripcion"); %><!-- se guarda el resultado de la consulta en la variable -->
          <OPTION><%out.println(combo3);%><!-- se agrega la variable como opcion del listado -->
 </OPTION>
 <%}%><!-- final de la consulta -->
          </select>
          
    </div>
          
          <div id="cols2-2">
       <span class="tipo11">Nombre: </span> <br>
       <input onKeyUp="this.value=this.value.toUpperCase()" name="nomvial3" id="nomvial3" size="60">   
          </div>
       
        </fieldset> <!-- Entre vialidades-->
          <br>
       
 </div>  <!--div f2 vialidad-->       
       
       
    
 <div id="f1">Asentamiento Humano:</div>
 
<div id="f2">
    
    <div id="cols3-1">
        <span class="tipo11">Tipo: </span><br>
           <SELECT NAME="tipoasent" id="tipoasent" class="captura">
                <option value="" selected="selected">- - -</option>
       <%//nueva consulta 
        String comboasen="";
        PreparedStatement pst =(PreparedStatement) conexion.conn.prepareStatement("select tipoasen from db_directorio.cat_asen");
        conexion.rs =pst.executeQuery(); //ejecucion de la consulta
        while(conexion.rs.next()) {//se obtiene cada resultado
        comboasen = conexion.rs.getString("tipoasen");%> <!-- se guarda el resuktado -->
 <OPTION><%out.println(comboasen);%><!-- se agrega como opcion del listado-->
 </OPTION>
 <% } %><!-- fin de la consulta -->
       
          </select><!-- fin del listadoo -->
          
    </div>
 
          <div id="cols3-2">
              <span class="tipo11">Nombre: </span><br>
                <input onKeyUp="this.value=this.value.toUpperCase();" name="nomasentamiento"  size="40" id="nomasentamiento">
          </div>
     
     
          <div id="cols3-3">   
              <span class="tipo11">Código Postal: </span><br>
             <input onKeyUp="this.value=this.value.toUpperCase();  val_numeros(this.id);" name="codigopostal" class="w5" id="codigopostal" maxlength="5">
          </div>
    
 
</div> <!--DIV f2 --> 
 
 
 
    <!-- nueva fila con dos columnas, span hace lineas de texto e input agrega cuadro de texto -->
     
       
       <div id="f1" class="text-derecha">Entidad Federativa:</div>
     
        <div id="f2">
       <span class="tipo11"></span>
                        <SELECT  NAME="cve_entidad" id="cve_entidad" class="captura"><!-- nuevo listado -->
                      <%
                     //nueva conslta para rellenar el listado
                String entidad="";
                String entidad_clave="";
                //PreparedStatement pst1 =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_EDO\" from db_directorio.cat_edo where \"CVE_EDO\" IN(SELECT \"CVE_ENTIDAD\" from db_directorio.encargados  where \"ENCPWD\"='"+val+"') ");
                PreparedStatement pst1 =(PreparedStatement) conexion.conn.prepareStatement( "select \"CVE_EDO\",\"NOM_EDO\" from db_directorio.cat_estados where \"CVE_EDO\"='"+val1+"' ");
                conexion.rs =pst1.executeQuery(); //se ejecuta el listado
                while(conexion.rs.next()) {//se obtiene cada resultado de la consulta
                entidad = conexion.rs.getString("NOM_EDO");
                entidad_clave=conexion.rs.getString("CVE_EDO");      
                      %> <!-- se guarda el resultado en la variable -->
                         <OPTION value="<%=entidad_clave%>"><%out.println(entidad);%><!-- se obtiene como opcion-->  </OPTION>

                <% } %>  
                       </select><!-- fin de la lista -->
    
        </div>
          <br>
          
          <div id="f1" class="text-derecha">Municipio:</div>
          
          <div id="f2">
      <span class="tipo11"></span>
          <!-- nueva lista , llama a funcion cargar combo si hay algun cambio en la seleccion -->
       <select name="lista_categoria" class="captura" onchange="javascript:cargarCombo('obtenloc.jsp', 'lista_categoria', 'div_subcategoria')" id="lista_categoria" ><%----%>
            <option value="" selected="selected">- - -</option>
   <%//nueva consulta 
   String mun="",mun_clave="";  
   //PreparedStatement pst2 =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_MUN\" from db_directorio.cat_mun where \"CVE_EDO\" IN(SELECT \"CVE_ENTIDAD\" from db_directorio.encargados  where \"ENCPWD\"='"+val+"') ");
   PreparedStatement pst2 =(PreparedStatement) conexion.conn.prepareStatement( "select \"NOM_MUN\", \"CVE_MUN\" from db_directorio.cat_mun where \"CVE_EDO\" ='"+val1+"' ORDER BY \"NOM_MUN\" ");
   conexion.rs =pst2.executeQuery();//ejecucion de la consulta
   while(conexion.rs.next()) {//se obtiene cada elemento de la consulta
       //se guardan los resultados en las varables
   mun = conexion.rs.getString("NOM_MUN");
   mun_clave=conexion.rs.getString("CVE_MUN");%>
   <OPTION value="<%=mun_clave%>"><%out.println(mun);%><!-- se rellena el listado y se asigna un valor -->
   </OPTION>
   <% } %> </select> 
   
          </div>
  
   
   <div id="f1" class="text-derecha">Localidad:</div>
   
     <div id="f2">
     <span class="tipo11"></span>
       <div id="div_subcategoria">    
            <select name="lista_subcategoria" class="captura" id="lista_subcategoria">
                <option value="" selected="selected">- - -</option>
            <!--  < %
               //nueva consulta para rellenar el listado de localidades
                    String mun1="";
                    //mun1=request.getParameter("y[x].text");
                    //PreparedStatement pst3 =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_MUN\" from db_directorio.cat_mun where \"CVE_EDO\" IN(SELECT \"CVE_ENTIDAD\" from db_directorio.encargados  where \"ENCPWD\"='"+val+"') ");
                    //nueva consulta de municipios
                    PreparedStatement pst3 =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_MUN\",\"CVE_MUN\" from db_directorio.cat_mun where \"CVE_EDO\"='"+val1+"'  ORDER BY \"NOM_MUN\"");
                    conexion.rs =pst3.executeQuery();//ejecucion de la consulta
                    while(conexion.rs.next()) {//se obtiene cada elemento de la consulta
                    // mun1 = conexion.rs.getString("NOM_MUN");
                    mun1 = conexion.rs.getString("CVE_MUN");//se obtiene la clave del municipio apara siguiente consulta
                    String loc="",loc_clave="";
                    //PreparedStatement pst4 =(PreparedStatement) conexion.conn.prepareStatement("select nomloc from db_directorio.cat_loc where cve_mun IN(select \"CVE_MUN\" from db_directorio.cat_mun where \"NOM_MUN\"='"+mun1+"') AND  cve_edo IN(SELECT \"CVE_ENTIDAD\" from db_directorio.encargados where \"ENCPWD\"='"+val+"') ") ;
                    //PreparedStatement pst4 =(PreparedStatement) conexion.conn.prepareStatement("select nomloc from db_directorio.cat_loc where cve_mun IN(select \"CVE_MUN\" from db_directorio.cat_mun where \"NOM_MUN\"='"+mun1+"') AND  cve_edo ='"+val1+"' ") ;
                    //se obtiene una subconsulta con el valor obtenido de la consulta anterior, para obtener las localidades
                    PreparedStatement pst4 =(PreparedStatement) conexion.conn.prepareStatement("select \"NOMLOC\" , cve_loc from db_directorio.cat_loc_copy where cve_mun ='"+mun1+"' AND  cve_edo ='"+val1+"'  ORDER BY \"NOMLOC\"") ;
                    conexion.rs =pst4.executeQuery(); //ejecucion de la consulta
                    while(conexion.rs.next()) {//se obtiene cada elemento de la consulta
                    loc = conexion.rs.getString("nomloc");//se guarda el resultado de la consulta en la variable
                    loc_clave = conexion.rs.getString("cve_loc");%>
               <OPTION>< %out.println(loc);%>
               </OPTION>
               < % } }%>
             -->
            </select>
       </div><!-- div_subcategoria -->
     </div>
   

                <div id="f1" class="text-derecha">Descripción de Ubicación:   </div>  
                <div id="f2">     <input onKeyUp="this.value=this.value.toUpperCase()" name="descripcion" id="descripcion" size="80"></div>
           
  </fieldset>   <!-- fieldset  F2 DOMICILIO-->  
 
 <br>
       
         
    <!-- nueva fila con dos columnas, span hace lineas de texto e input agrega cuadro de texto -->
   <div id="f1" class="text-derecha">   9.Página de Internet: </div>
   <div id="f2"> http://<input name="paginternet" size="100" type="text" id="paginternet" placeholder="www.ejemplo.com" onkeyup="vali_url(this.id);"></div>
 
    <!-- nueva fila con dos columnas, span hace lineas de texto e input agrega cuadro de texto -->
    <div id="f1" class="text-derecha"> 10.Teléfono: </div>
  
     <div id="f2">
         <div id="cols2-1"> <br>
             <input name="telefono" size="30" id="telefono" onkeyup="val_numeros(this.id)" >
         </div>
         
           <div id="cols2-2">Extensión:<br>
          <input name="extension" class="w15" id="extension" onkeyup="val_numeros(this.id)" >
           </div>
     </div>
    <br>
             

     <div id="encabezado">  11.TITULAR</div>
    
      <div id="cols3-1">
          Primer Apellido:  <br>   
    <span class="tipo11">
        <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="apepattitular" size="40" id="apepattitular" ></span>
      </div>     
            
        <div id="cols3-2">    
             <span class="tipo11">
                 Segundo Apellido:<br>
            <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="apemattitular" size="40" id="apemattitular"></span>
        </div>
       
     <div id="cols3-3">
        Nombre(s):    <br>
            <span class="tipo11">
            <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="nomtitular" size="40" id="nomtitular"></span>
     </div>  
     
      <div id="cols3-1">
          Puesto: <br>    
            <span class="tipo11">
            <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="puestotitular" size="100" id="puestotitular"></span>
      </div>
     
     
     <div id="cols3-2">Profesión:   
            <span class="tipo11">
            <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="titularprofesion" size="100" id="titularprofesion"></span>
     </div>
     <br>
           
     <div id="f1" class="text-derecha" >Teléfono:  </div>
     
     
    <div id="f2" class="text-derecha">
        <div id="cols2-1"> <br>
            <input name="teltitular" size="15" id="teltitular" onkeyup="val_numeros(this.id);">
           </div>   
        
        <div id="cols2-1">  Extensión:<br>
              <input name="exttitular" class="w15" id="exttitular" onkeyup="val_numeros(this.id);">
            </div>
    </div>    
          
          
          

     <div id="f1" class="text-derecha" >Correo electrónico:  </div>   
    
        <div id="f2">
            <span class="tipo11">      
            <input onKeyUp="this.value=this.value.toUpperCase()" name="mailtitular" class="w100" id="mailtitular" type="text"></span>
        </div> 
     
     <div id="encabezado"> 12. GRUPOS DE DATOS QUE PRODUCE LA UNIDAD CON FUNCIONES GEOGRÁFICAS (UGIG)</div>
      
     <div id="colum1">
         <input type="checkbox" name="grupodatos" id="marco" value="Marco de referencia geodésico"> <label for="marco">Marco de referencia geodésico</label><br>
         <input type="checkbox" name="grupodatos" id="limites" value="Límites costeros, internacionales, estatales y municipales"> <label for="limites">Límites costeros, internacionales, estatales y municipales</label><br>
         <input type="checkbox" name="grupodatos" id="relieve" value="Datos de relieve continental, insular y submarino"><label for="relieve"> Datos de relieve continental, insular y submarino </label><br>
         <input type="checkbox" name="grupodatos" id="catastrales" value="Datos catastrales"><label for="catastrales"> Datos catastrales </label> <br>
         <input type="checkbox" name="grupodatos" id="topograficos" value="Datos topográficos"> <label for="topograficos">Datos topográficos </label><br>
    </div>
     
     

        <div id="colum2">
            <input type="checkbox" name="grupodatos" id="recursos" value="Datos de recursos naturales y clima"><label for="recursos"> Datos de recursos naturales y clima</label> <br>
            <input type="checkbox" name="grupodatos" id="geograficos" value="Nombres geogr&aacute;ficos"><label for="geograficos"> Nombres geográficos</label><br>
            <input type="checkbox" name="grupodatos" id="ambiente" value="Medio ambiente"><label for="ambiente"> Medio ambiente </label><br>
         <input type="checkbox" name="grupodatos" id="otro_gd" value="Otro" onclick="javascript:habilita();"><label for="otro_gd"> Otro (específica) </label><br>
            <input type="text" name="otro_esp" id="otro_esp" readonly="readonly" class="read">
        </div>   
    
    <!-- nueva fila con color de fondo -->
    <div id="encabezado"> 13.¿LA UGIG REALIZA FUNCIONES ESTADÍSTICAS?</div>
        <!-- nueva fila con dos columnas, span hace lineas de texto e input agrega cuadro de texto -->
        <div id="colum1"><input type="radio" id="op1" name="fun_esta" value="Si"><label for="op1"> Sí</label></div>
        <div id="colum1"> <input type="radio" id="op2" name="fun_esta" value="No"><label for="op2"> No</label>  </div>
    
     
        <div id="encabezado">  14. PERSONA DE ENLACE</div>
    
  
        <div id="cols3-1">
         <span class="tipo11">Primer Apellido: </span>  <br> 
            <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="apepatenlace" size="40" id="apepatenlace">
        </div> 
            
        
        <div id="cols3-2">
            <span class="tipo11">Segundo Apellido:</span><br>
            <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="apematenlace" size="40" id="apematenlace">
        </div>
  
          <div id="cols3-3">
              <span class="tipo11"> Nombre(s):  </span><br>
            <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="nomenlace" size="70" id="nomenlace">
          </div><br>
  
           <div id="cols3-1"> 
                  <span class="tipo11">Puesto:  </span>  <br>
            <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="puestoenlace" size="70" id="puestoenlace">
           </div>
       
    
        <div id="cols3-2"> 
                <span class="tipo11">Área de Adscripción: </span> <br>
            <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="areads" size="70" id="areads">
        </div>
          
          <br>
          <div id="f1" class="text-derecha"> Teléfono:   </div>
 
                <div id="f2">
                    <div id="cols2-1">
                            <span class="tipo11"></span><br>
                            <input name="telenlace" size="15" id="telenlace" onkeyup="val_numeros(this.id);">
                    </div>
                    <div id="cols2-2">
                        <span class="tipo11">Extensión: </span><br>
                        <input name="extenlace" class="w15" id="extenlace" onkeyup="val_numeros(this.id);">
                    </div>  
                </div>
          
          
          <div id="f1" class="text-derecha">Correo electrónico:  </div>  
          <div id="f2"> <span class="tipo11"><input name="mailenlace" size="70" type="text" id="mailenlace"> </span></div>
       
            
          <div id="encabezado"> 15.RESPONSABLE DEL LLENADO Y/O ACTUALIZACIÓN DE LA CÉDULA </div>
  
       
         
          15.1 NOMBRE DEL RESPONSABLE DE PROPORCIONAR LA INFORMACIÓN<br>
         
          <div id="contenedor-nombre">
        <div id="cols3-1">
              <span class="tipo11">  Primer Apellido:    </span>
              <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="apepatresp" id="apepatresp" size="40">
        </div>
            
          <div id="cols3-2">
              <span class="tipo11">Segundo Apellido:</span><br>
             <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="apematresp" id="apematresp" size="40">
          </div>
   
          <div id="cols3-3">
                <span class="tipo11">   Nombre(s):    </span> 
               <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="nomresp" id="nomresp" size="40">
          </div>
         
          <br>
    
          <div id="cols3-1">
             <span class="tipo11">Adscripción:    </span><br>
             <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="adsresp" id="adsresp"  class="w40"><br>
          </div>
             
             <div id="cols3-2">Fecha: <br>
                <input type="text" id="fecha" name="fecha" class="fecha w20"> 
             </div>
          
          
             
            <div id="cols3-3" class="w10">
                <input type="checkbox" id="firma" name="firma" value="Si" align="center">
                Firma:    <!-- imput type=checkbox agrega cuadro check--> 
            </div>
          
          </div><!--contenedor nombre -->
             <br><br>
          
             15.2 NOMBRE DEL RESPONSABLE DEL LLENADO<br>
       <div id="contenedor-nombre">
             <div id="cols3-1">   
                 <span class="tipo11">Primer Apellido: </span><br>
                 <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="apepatllenado" id="apepatllenado" size="40">
             </div>
            
             <div id="cols3-2">  
                  <span class="tipo11">Segundo Apellido:</span><br>
                  <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="apematllenado" id="apematllenado" size="40">
             </div>
    
               <div id="cols3-3"> 
             <span class="tipo11">Nombre(s): </span><br>
            <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="nomllenado" id="nomllenado" size="40">
               </div>
             <br>
             
          
           <div id="cols3-1"> 
            <!-- <span class="tipo11">Adscripción:  </span>
            <input onKeyUp="this.value=this.value.toUpperCase()" name="adsllenado" id="adsllenado" size="40">
             -->
           </div>
              
          <div id="cols3-2"> 
              Fecha: <br>
             <input type="text" id="fecha2" name="fecha2" class="fecha2 w20" >
         </div>
             
            <div id="cols3-3"> 
                   <input type="checkbox" name="firma2" id="firma2"  value="Si">Firma:    
            </div>
             <BR>
       </div><!--contenedor nombre -->
       
       
             15.3 NOMBRE DEL RESPONSABLE DE LA VERIFICACIÓN<BR>
   
             <div id="contenedor-nombre">
        <div id="cols3-1">  
            <span class="tipo11">Primer Apellido: </span><br>
            <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="apepatver" id="apepatver" size="40">
        </div>
             
              <div id="cols3-2"> 
        <span class="tipo11">Segundo Apellido:</span><br>
        <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="apematver" id="apematver" size="40">
              </div>
             
        <div id="cols3-3">       
            <span class="tipo11">Nombre(s):  </span>
            <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="nomver" id="nomver" size="40">
        </div>
             <br>
  
             
        <div id="cols3-1">       
            <!-- 
            <span class="tipo11"> Adscripción:</span><br>
           <input onKeyUp="this.value=this.value.toUpperCase()" name="adsver" id="adsver" size="40">
             -->
         </div>
    
             <div id="cols3-2"> 
                 Fecha: <br>
                 <input type="text" id="fecha3" name="fecha3" class="fecha3 w20" >
            </div>
             
            <div id="cols3-3"> 
             <input type="checkbox" name="firma3" id="firma3" value="Si" disabled title="Esta opción no está Disponible">Firma:    
            </div>
             <br>
             
    </div>  <!-- contenedor nombre -->
  
    Observaciones<br>
    <div id="observ">
    <textarea name="mytextarea" id="mytextarea" cols="35" rows="3" maxlength="245"></textarea>
    </div>
   <!-- fin de la tabla -->
         <!-- nueva tabla de 960 de ancho -->

         <div id="Btn"> 
         <input name="limpiar_btn" type="button"  id="limpiar-ubicacion" value="Cancelar" onClick="javascript:limpiarForm2();"> &nbsp;&nbsp;&nbsp;
             <input type="submit" value="Grabar"><!-- nueva fila con columna y boton de envio-->
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
     <script> 
         alert("Primero debes loguearte para ver esta pagina");
         location.href = "llama_sistema_dir.jsp";
    </script>
    
    <% 
       }// Termina el ELSE 
    %>