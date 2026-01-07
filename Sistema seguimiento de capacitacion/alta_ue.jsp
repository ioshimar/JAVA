<%-- 
    Document   : captura
    Created on : 27-jun-2018, 10:53:27
    Author     : ioshimar.rodriguez
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
    String nom_user = request.getParameter("nom_user");
    System.out.print("aqui" + sesion_cve_enc);
    
     if(sesion_cve_enc!=null){  //SI NO ES NULLA
         
         int sesion_int =  Integer.parseInt(sesion_cve_enc);
        if(sesion_int <= 33){
%>
<html>
    <%
        ConexionBD conexion=new ConexionBD();
        ConexionDirecBD conexionDir =new ConexionDirecBD(); 
    %>
     
   
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><!-- tipo de codificacion-->
          <link rel="icon" href="images/icono_png.ico" type="image/gif" sizes="16x16">
          <link rel="shortcut icon" href="images/favicon.ico"> 
 
          <script src="js/jquery/jquery-latest.min.js" type="text/javascript"></script>
          <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes"> <!-- para que se ajuste a la pantalla del dispositivo-->
        <title>Registrar</title><!-- titulo de la pagina-->
        
        <link href="css/formularios_curt.css" rel="stylesheet" type="text/css"/>
     
        <script src="js/valida_altasUE.js" type="text/javascript"></script>
          <script src="js/cancela_act.js" type="text/javascript"></script>
         
          <script>
          
             
          </script>
          
    
       
 
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
      
<script>
    
    $(document).ready(function(){
        cargarCombo('obtenloc.jsp', 'lista_categoria', 'div_subcategoria');  //cargo el combo al cargar la página
    });
    
    function val_numeros(val_id){
    var numeros =/^([0-9])*$/;
    var elemento = document.getElementById(val_id);
    
    if(!elemento.value.match(numeros)){
           $(elemento).addClass("redinput");
    }
    else{
          $(elemento).removeClass("redinput");
    }
    
}


function val_letras(val_id){
       var nombre=/^[a-zA-ZñÑáéíóúÁÉÍÓÚüÜñÑ\s\(\).,]*$/;
       var elemento_input = document.getElementById(val_id);
   
    if(!elemento_input.value.match(nombre)){
        $(elemento_input).addClass("redinput");             // JQuery    (le ponemos la clase)
         // elemento_input.style.backgroundColor = "#FAD8F4";  // JavaScript
    }else{
       // document.getElementById(val_id).style.borderColor = "#e6e6e6"; 
        $(elemento_input).removeClass("redinput");         // JQuery     (quitamos la clase)
          //elemento_input.style.backgroundColor = "#FFF";    // JavaScript
    }
}


</script>    

        
        
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


<link href="header_menu/MenuIconos.css" rel="stylesheet" type="text/css"/>
<link href="header_menu/header.css" rel="stylesheet" type="text/css"/>
<script src="header_menu/menuResponsive.js" type="text/javascript"></script>
<link href="header_menu/menu_responsive.css" rel="stylesheet" type="text/css"/>
<script src="js/CambiaTipoAmbito.js" type="text/javascript"></script>
    </head>
    
    <body>
        <%
         String nom_usuario="";
       try{
         PreparedStatement pst41 =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_EDO\",\"CVE_EDO\" from \"seguim_CURT\".cat_edo where \"CVE_EDO\" = '"+sesion_cve_enc+"' ");
         conexion.rs =pst41.executeQuery(); //ejecutamos la consulta
         while(conexion.rs.next()) {//se guarda cada resultado en la variable de opciones
         nom_usuario = conexion.rs.getString("NOM_EDO");
         }
       } catch(SQLException e){out.print("exception"+e);}
              finally {conexion.closeConnection();
       }  
     %> 
         
     
        <div class="menu_bar">
            <a style="cursor:pointer;" class="bt-menu"> 
            <span class="icon-menu3"></span> <img src="images/inegi_vertical.png" width="51" height="31"/></a>
        </div> 
    <header>
        <div id="logo"> <a href="inicio_curt.jsp?nom_user=<%=nom_user%>"><img id="log-inegi" src="images/logo_blanco_comp.png" alt=""/></a></div>
        <div id="nav">
            <ul class="text-left">
              <!--<li><a href="javascript:window.history.back();">&laquo; Regresa una página</a></li>-->
            <a href="inicio_curt.jsp?nom_user=<%=nom_user%>"> <li> Inicio</li></a>
             <a href="selecciona_ue.jsp?nom_user=<%=nom_user%>"> <li> Capturar</li></a>
            <a href="resultado_consulta_gen_tot.jsp?nom_user=<%=nom_user%>"> <li> Consultar reporte</li></a>
            <!--<a href="modulo_exportacion.jsp"> <li> Exportar</li></a>-->
           
          </ul>
           <ul class="text-right">
              <li><span class="negrita"><%=nom_usuario.toUpperCase()%> <span class="caret icon-chevron-down"> <!--boton --></span></span>
                    <ul class="children">    
                        <li> <a href="cambiar_psw.jsp?nom_user=<%=nom_user%>"> <span class="icon-settings2"></span> Cambiar contraseña</a></li>
                    </ul>
             </li>
             <li class="cerrar_ses"> <a href="logout_curt.jsp">  Cerrar Sesión</a></li>
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
              finally {}
        %>
        <!-- TERMINA MODIFICACION 20/07/2017 -->
        <div id="margen-oculto">&nbsp;</div>
      
           <div id="Div_Titulo">
              
              <div id="img_logo"><img src="images/logoSegCap.png" alt=""/></div>
              <div id="txt_titu">
              <span class="text_small">SISTEMA </span> <span class="text_small">DE SEGUIMIENTO DE LA
                  <br> </span> <span class="TextTitulo">CLAVE ÚNICA DEL REGISTRO DEL TERRITORIO</span>
                    </span><!-- parrafo de titulo-->
              </div>      
           </div>
        
        
        <div id="cont_formulario">
            
         <form action="operaciones_ugig.jsp?nom_user=<%=nom_user%>" method="post" onsubmit="return valida_altasue()" >     
            <span class="TextTitulo subrayado">Registrar Unidad del Estado y/o Institución &nbsp;&nbsp;&nbsp;</span><br><br><br>
            
              <% String fecha=getFechaActual();%>
             <div id="div_fecha">Fecha: 
              <input type="text" id="fecha_llenado" name="fecha_llenado" value="<%out.print(fecha);%>" readonly style="border-width:0; background:none; font-weight: bold;" class="w20" >
             </div>
            
          <div id="f1">  
            <!--   Folio:<input type="text" name="folio" id="folio"  maxlength="3" class="w10">  -->
            <span style="color: red">*</span> Ambito UGIG:<br>
                 <select name="ambito_ins" id="ambito_ins" class="w20"  onchange="CambiaTipoAmbito(this.id, 'tipo_ambito');">
                          <option value="" selected="selected">Seleccione una opción</option>
                          <option value="E">ESTATAL</option>
                          <option value="M">MUNICIPAL</option>
                          <option value="F">FEDERAL</option>
                </select>
          </div>
            
          <div id="f2">  
              <span style="color: red">*</span> Tipo de Ambito: <!--<a>?</a> -->  <br>
                <select name="tipo_ambito" id="tipo_ambito" class="w30 read" disabled="">
                          <option value="" selected="selected">- - - </option>
                   
                </select>
              <div id="def_ambito">
                  El Tipo de Registro se refiere a bla bla bla bla bla bla bla bla bla bla bla bla ...
              </div>
              
          </div>  
             <br>
             
      <div id="f1" class="text-derecha"><span style="color: red">*</span> Unidad de Estado a la que pertenece:<br> 
        
            <SELECT  name="nombre_ues" id="nombre_ues" class=""><!-- nuevo listado -->
                       <option value="" selected="selected">Seleccione una opción</option>    
                       <option value="no_aplica">No Aplica</option>   
                      <%
                     //nueva conslta para rellenar el listado
                String nombre_ue="";
                String ue_Id="";
                 String ambito="";
            try{     
                PreparedStatement pst25 =(PreparedStatement) conexionDir.conn.prepareStatement( "select \"Id\",\"INSNOMBRE\",\"CVE_ENTIDAD\",\"AMBITO\" from db_directorio.ufg_directori_ue where \"CVE_ENTIDAD\"='"+sesion_cve_enc+"'  ORDER BY \"INSNOMBRE\" ");
                conexionDir.rs =pst25.executeQuery(); //se ejecuta el listado
                while(conexionDir.rs.next()) {//se obtiene cada resultado de la consulta
                nombre_ue= conexionDir.rs.getString("INSNOMBRE");
                ue_Id=conexionDir.rs.getString("Id"); 
                ambito = conexionDir.rs.getString("AMBITO");  
                      %> <!-- se guarda el resultado en la variable -->
                       <!--  <OPTION value="< %=ue_clave%>">< %out.println(nombre_ue + "  " + "(" +nombre_loc + ")");%> </OPTION> -->
                        <OPTION value="<%=ue_Id%>"><%out.println(nombre_ue + " " + " &nbsp;("+ambito+")");%> </OPTION> 
                <% }
            } catch(SQLException e){out.print("exception"+e);}
              finally {//conexionDir.closeConnection();
                        }
                %>  
            </select><!-- fin de la lista -->      
                           
     </div>  
                       
                       
          <div id="f2" class="text-derecha"><span style="color: red">*</span> Nombre oficial de la UE y/o Institución:<br>
            <input onKeyUp="this.value=this.value.toUpperCase(); val_letras(this.id);" name="nomoficial" type="text" class="" maxlength="255" id="nomoficial">
          
          </div>
            
           
             <br>
             
                
    <div id="f1" class="text-derecha"><span style="color: red">*</span> Entidad Federativa:<br>
                    <span class="tipo11"></span>
                    <SELECT  NAME="cve_entidad" id="cve_entidad" class="w50" ><!-- nuevo listado -->
                      <%
                     //nueva conslta para rellenar el listado
                String entidad="";
                String entidad_clave="";
            try{    
                //PreparedStatement pst1 =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_EDO\" from db_directorio.cat_edo where \"CVE_EDO\" IN(SELECT \"CVE_ENTIDAD\" from db_directorio.encargados  where \"ENCPWD\"='"+val+"') ");
                PreparedStatement pst1 =(PreparedStatement) conexionDir.conn.prepareStatement("select \"CVE_EDO\",\"NOM_EDO\" from db_directorio.cat_edo where \"CVE_EDO\"='"+sesion_cve_enc+"' ");
                conexionDir.rs =pst1.executeQuery(); //se ejecuta el listado
                while(conexionDir.rs.next()) {//se obtiene cada resultado de la consulta
                entidad = conexionDir.rs.getString("NOM_EDO");
                entidad_clave=conexionDir.rs.getString("CVE_EDO");      
                      %> <!-- se guarda el resultado en la variable -->
                         <OPTION value="<%=entidad_clave%>"><%out.println(entidad);%><!-- se obtiene como opcion-->  </OPTION>

                <% }
                  } catch(SQLException e){out.print("exception"+e);}
              finally {//conexionDir.closeConnection();
                        }  
                %>  
                       </select><!-- fin de la lista -->
    
    </div>  
                       
 <div id="f2">                     
  <div id="f_c2"><span style="color: red">*</span> Municipio:<br>
            <span class="tipo11"></span>
                <!-- nueva lista , llama a funcion cargar combo si hay algun cambio en la seleccion -->
             <select name="lista_categoria" class="w30" onchange="javascript:cargarCombo('obtenloc.jsp', 'lista_categoria', 'div_subcategoria')" id="lista_categoria" ><%----%>
                  <option value="" selected="selected">Seleccione un municipio</option>
         <%//nueva consulta 
         String mun="",mun_clave=""; 
         
      try{   
         //PreparedStatement pst2 =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_MUN\" from db_directorio.cat_mun where \"CVE_EDO\" IN(SELECT \"CVE_ENTIDAD\" from db_directorio.encargados  where \"ENCPWD\"='"+val+"') ");
         PreparedStatement pst2 =(PreparedStatement) conexionDir.conn.prepareStatement( "select \"NOM_MUN\", \"CVE_MUN\" from db_directorio.cat_mun where \"CVE_EDO\" ='"+sesion_cve_enc+"' ORDER BY \"NOM_MUN\" ");
         conexionDir.rs =pst2.executeQuery();//ejecucion de la consulta
         while(conexionDir.rs.next()) {//se obtiene cada elemento de la consulta
             //se guardan los resultados en las varables
         mun = conexionDir.rs.getString("NOM_MUN");
         mun_clave=conexionDir.rs.getString("CVE_MUN");%>
         <OPTION value="<%=mun_clave%>"><%out.println(mun);%><!-- se rellena el listado y se asigna un valor -->
         </OPTION>
         <% } 
      } catch(SQLException e){out.print("exception"+e);}
              finally {conexionDir.closeConnection();
                        }   
         %> </select> 
   </div>   
   
   <div id="f_c2" ><span style="color: red">*</span> Localidad:<br>
     <span class="tipo11"></span>
       <div id="div_subcategoria">    
            <select name="lista_subcategoria" class="w30" id="lista_subcategoria">
                <option value="" selected="selected">- - -</option>
           
            </select>
       </div><!-- div_subcategoria -->
     </div>
 </div>  
      
      <br>
      
<div id="f1">      
   <div id="f_c3">   
      <span class="tipo11">Código Postal: </span><br>
      <input onKeyUp="this.value=this.value.toUpperCase();  val_numeros(this.id);" name="codigopostal" class="w5" id="codigopostal" maxlength="5">
   </div>
</div>
 
<div id="f2">       
    <div id="f_c3"> Teléfono: <br> 
             <input name="telefono"  id="telefono" onkeyup="val_numeros(this.id)" class="w10" >
    </div>
         
   <div id="f_c3">Extensión:<br>
          <input name="extension" class="w5" id="extension" onkeyup="val_numeros(this.id)" >
    </div>
</div>
      
            
            
            
                
                  <div id="btn_enviar">
                      <input type="button" value="&ll; Regresar" onclick="javascript:window.location.href='selecciona_ue.jsp?nom_user=<%=nom_user%>'" class="bcancelar">    &nbsp;
                     <input type="submit" value="Capturar datos">
                 </div>
       </form>
        </div>
       
      
    </body>
</html>


<%
    }//if int
    
    else{  

%>
<script> alert("No cuentas con permisos para inscribir una UE");</script>
<script>location.href = "selecciona_ue.jsp";</script>

<%
    }  //else      
} //termina el if principal 
else{  
        // out.print("Debes Iniciar Sesión"); 
%>    
     <script> alert("Inicia sesión para ver esta página");</script>
     <script>location.href = "index.jsp";</script>
    <% 
}// Termina el ELSE 
    %>