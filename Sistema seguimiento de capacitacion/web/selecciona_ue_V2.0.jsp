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
        <title>Registrar</title><!-- titulo de la pagina-->
        
        <link href="css/formularios_curt.css" rel="stylesheet" type="text/css"/>
     
    
          <script src="js/cancela_act.js" type="text/javascript"></script>
 
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

 //funcion de carga de lista desplegable al selceccionar un elemento de la lista anterior
function cargarCombo (url, comboAnterior, element_id){    
    var entidad = <%="'"+sesion_cve_enc+"'"%>   ;   // entre comillas para la entidad
    
    
    var element =  document.getElementById(element_id);//recupera el elemento de acuerdo al id de entrada
    var valordepende = document.getElementById(comboAnterior);//seleccion del combo anterior
    var x = valordepende.value; //recupera el valor seleccionado del combo anterior   

    
    var fragment_url = url+"?tipo_ue="+x+"&ent="+entidad;//tomando el url se compone un nuevo fragmento  (toma el valor del Select de la opcion que escogimos en en el UES)
    peticion.open("GET", fragment_url);//se llama la peticion por metodo get 
    peticion.onreadystatechange = function(){//la peticion esta a la escucha de cambios para llamar la funcion
        if (peticion.readyState == 4){
            //escribimos la respuesta
            element.innerHTML = peticion.responseText;
        } 
    } 
   peticion.send(null); 
   
  //    document.getElementById("Folio").value = "";   //RESETEAMOS EL FOLIO cada que cambiemos la unidad de Estado
}
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
           
          </ul>
           <ul class="text-right">
              <li><span class="negrita"><%=nom_usuario.toUpperCase()%> <span class="caret icon-chevron-down"> <!--boton --></span></span>
                    <!--<ul class="hijo">    
                       <li> <a href="logout_curt.jsp">  Cerrar Sesión</a></li>
                    </ul>-->
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
              finally {conexion.closeConnection();}
        %>
        <!-- TERMINA MODIFICACION 20/07/2017 -->
        <div id="margen-oculto">&nbsp;</div>
      
           <div id="Div_Titulo">
              
              <div id="img_logo"><img src="images/logoSegCurt.png" alt=""/></div>
              <div id="txt_titu">
              <span class="text_small">SISTEMA </span> <span class="text_small">DE SEGUIMIENTO DE LA
                  <br> </span> <span class="TextTitulo">CLAVE ÚNICA DEL REGISTRO DEL TERRITORIO</span>
                    </span><!-- parrafo de titulo-->
              </div>      
           </div>
        
        
        <div id="cont_formulario">
            
         <form action="captura.jsp" method="post" onsubmit="return valida()" >     
            <span class="TextTitulo subrayado">Unidad del Estado &nbsp;&nbsp;&nbsp;</span><br><br><br>
            
            <div id="cont_center2">
                
                <div id="cont_left">
                    <input type="radio" name="tipo_ue" id="t_ue" value="ue" onclick="javascript:cargarCombo('obten_ue_ugig.jsp', this.id, 'div_subcategoria')" > <label> UE (Gobiernos del Estado, Gobiernos municipales, SEDATU, INDAABIN)</label><br>
                    <input type="radio" name="tipo_ue" id="t_ugig" value="ugig"  onclick="javascript:cargarCombo('obten_ue_ugig.jsp', this.id, 'div_subcategoria')"> <label> UGIG (Catastros Estatales y municipales, RPP, RAN)</label>
                </div>      
                <br>
          
           <div id="cont_left"> 
                    <span>Nombre de la Unidad del Estado</span><br>
                   <!-- <input type="text" name="name_ue" id="name_ue" class="w50">-->
                    <div id="div_subcategoria">              
                              <select name="ue" id="ue" class="w100">
                                   <option value="">---</option>

                              </select>
                    </div>      
               
           </div><br>
                <br>
                <div style="text-align: right;">
                    ¿No se encuentra la Unidad del Estado?<br>
                    <a href="alta_ue.jsp">Registrar nueva UE</a></div>
         
                <br><br>
               
            </div>
                
                  <div id="btn_enviar">
                      <input type="button" value="&ll; Regresar" onclick="javascript:window.location.href='inicio_curt.jsp'" class="bcancelar">    &nbsp;
                    <input type="submit" value="Capturar datos">
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
     <script> alert("Inicia sesión para ver esta página");</script>
     <script>location.href = "index.jsp";</script>
    
    <% 
       }// Termina el ELSE 
    %>