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
        ConexionBD conexion=new ConexionBD();
       // ConexionDirecBD conexionDir=new ConexionDirecBD(); 
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
          <script src="js/funCargaCapacP2.js" type="text/javascript"></script>
          <script src="js/verifica_libera_capacita.js" type="text/javascript"></script>
          
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
                buttonImageOnly: true
              //dateFormat: "dd-mm-yy"//formato de fecha año/mes/dia
            });
            });
        </script>
        
        <script>
              $(document).ready(function(){
                    carga_actualizaP2(<%=id_ue%>);  //AQUI También va el de verificar permisos privilegio
                 
                 $("#actualizar").css("display","none");
                 $(".boton_delete").css("display","none");
                // verifica_lib_cap(< %=id_ue%>);
                    
                  
                     
                });   
        </script>
       
      
        <script src="js/ajx_guarda_capacP2.js" type="text/javascript"></script>
        <script src="js/actualiza_capacP2.js" type="text/javascript"></script>
        
        
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
        <div id="notif"><div id="result">  Datos ingresados correctamente </div><div id="cerrarDiv"><a href="javascript:postwith('captura.jsp',{ue:'<%=id_ue%>'})">Aceptar</a></div> </div>
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
              </li><li class="cerrar_ses"> <a href="logout_curt.jsp">  Cerrar Sesión</a></li>
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
            
   <form id="curtp2" name="curtp2" >
        <span class="TextTitulo subrayado">Capacitación</span><br><br>
        <div id="cont_center"><span class="text_smal15">  <%=nombre_ue+ " ("+Nombre_mun2+", "+name_edo+")"%></span></div><br>
        
        <% String fecha=getFechaActual();%>
             <div id="div_fecha">Fecha: 
              <input type="text" id="fecha_llenado" name="fecha_llenado" value="<%out.print(fecha);%>" readonly style="border-width:0; background:none; font-weight: bold;" class="w15" >
              <input type="hidden" name="privilegio" id="privilegio" value="<%=privilegio%>" >
             </div>
        
            
         <div id="cont_center" >
             <input type="hidden" name="id_ue" id="id_ue" value="<%=id_ue%>">
           <fieldset>  
             <legend>Impartición</legend>
                
                     <div id="col_text">Fecha</div>
                     <div id="col_inp"><input type="text" id="fecha_impart" name="fecha_impart" placeholder="dd/mm/aaaa" class="fecha w20"> </div>
                
             <br><br>
             
             <div>
                 <div id="col_text">Lugar</div>
                 <div id="col_inp"><input type="text" name="lugar" id="lugar" class="w50"></div>
                </div>
            </fieldset>
            <br><br>
           
               <div id="col_text">Responsable de INEGI que la impartió</div>
               <div id="col_inp"> <input type="text" name="responsable" id="responsable" class="w50"></div>
           
            <br><br>
            
           
            <div id="col_text">Cantidad de personas capacitadas</div>
            <div id="col_inp">  <input type="text" name="cantidad_p" id="cantidad_p" class="w15" ></div>
         </div>    
         
                
                  <div id="btn_enviar">
                    <input type="button" value="&ll; Regresar" onclick="javascript:cancelar_activ();" class="bcancelar">    &nbsp;
                    <input type="button" value="+ Guardar" onclick="javascript:proceso_guardaP2();" id="guarda_reg" name="guarda_reg">
                    <input type="button" value="&circlearrowright; Actualizar" name="actualizar" id="actualizar" onclick="javascript:proceso_ActualizaP2();" class="bactualizar">
                 </div>
           <div id="div_delete">
                <a class="boton_delete" href="javascript:postwith('elimina_registro.jsp',{ue:'<%=id_ue%>', tab:'capacitacion'})"> 
                    <span class="icon-trashcan" style="font-size:18px;"></span> <span style="font-size:10px;">Eliminar registro</span>
                </a> &nbsp;  &nbsp;   &nbsp; 
            </div>
           
            </form>
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