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
    String session_admin_curt = (String)objsesion_enc.getAttribute("session_admin_curt"); //se crea la variable de Sesión
     if(session_admin_curt!=null){  //SI NO ES NULLA
         
              ConexionBD conexion=new ConexionBD();
      String nom_usuario="";
         
      try{
         PreparedStatement pst41 =(PreparedStatement) conexion.conn.prepareStatement("SELECT  nombre, usuario, permisos FROM \"seguim_CURT\".tbl_admin where usuario = '"+session_admin_curt+"' ");
         conexion.rs =pst41.executeQuery(); //ejecutamos la consulta
         while(conexion.rs.next()) {//se guarda cada resultado en la variable de opciones
         nom_usuario = conexion.rs.getString("nombre");
         }
      } catch(SQLException e){out.print("exception"+e);}
              finally {
          conexion.closeConnection(); 
      }           


%>
<html>
    <%
   
       // ConexionDirecBD conexionDir=new ConexionDirecBD(); 
        String id_ue = request.getParameter("ue"); 
        String id_sol = request.getParameter("id_sol"); 
        String fecha_sol = request.getParameter("fecha_sol"); 
        String tipo_solicitud = request.getParameter("tipo");
        String mensaje = request.getParameter("mensaje");
        String nombre = request.getParameter("nom");
        String correo = request.getParameter("correo");

     /*   String privilegio ="";
        int sesionInt = Integer.parseInt(sesion_cve_enc); //convertimos el string (Sesion) en INT
        if(sesionInt >= 33){
             privilegio = "REGIONAL";
        }else if(sesionInt <= 32){
           privilegio = "ESTATAL";     
        }*/
    %>
     
   
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><!-- tipo de codificacion-->
          <link rel="icon" href="../images/icono_png.ico" type="image/gif" sizes="16x16">
          <link rel="shortcut icon" href="../images/favicon.ico"> 

          <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes"> <!-- para que se ajuste a la pantalla del dispositivo-->
        <title>Registrar</title><!-- titulo de la pagina-->
        
        <link href="../css/formularios_curt.css" rel="stylesheet" type="text/css"/>
        <script src="../header_menu/jquery-latest.min.js" type="text/javascript"></script>
         
          <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
          <link rel="stylesheet"  href="../css/datepicker.css" />
          <script src="../js/jquery/jquery-ui.js"></script> 
          <!-- <script type="text/javascript" src="js/jquery/datepicker.js"></script>-->
          <script type="text/javascript" src="../js/jquery/datepicker-es.js"></script>
         
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
                          postwith('solicitudes.jsp'); //mandamos la URL
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
                  //  carga_actualizaP2(< %=id_ue%>);  //AQUI También va el de verificar permisos privilegio
               
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

<script src="js/ajx_libera_solic.js" type="text/javascript"></script>

<link href="../css/icomoon/iconos.css" rel="stylesheet" type="text/css"/>

<link href="../header_menu/header.css" rel="stylesheet" type="text/css"/>
<script src="../header_menu/menuResponsive.js" type="text/javascript"></script>
<link href="../header_menu/menu_responsive.css" rel="stylesheet" type="text/css"/>
<script src="../js/cerrar_notif.js" type="text/javascript"></script>

    </head>
    
    <body>
        <div id="notif"><div id="result">  Datos ingresados correctamente </div><div id="cerrarDiv"><a href="javascript:postwith('captura.jsp',{ue:'<%=id_ue%>'})">Aceptar</a></div> </div>
     
         
     
       <div class="menu_bar">
            <a style="cursor:pointer;" class="bt-menu"> 
            <span class="icon-menu3"></span> <img src="../images/inegi_vertical.png" width="51" height="31"/></a>
        </div> 
     <header class="administrador">
        <div id="logo"> <a href="inicio_admin.jsp"><img id="log-inegi" src="../images/logo_blanco_comp.png" alt=""/></a></div>
        <div id="nav">
          <ul class="text-left">
             <a href="inicio_admin.jsp"> <li> Inicio</li></a>
             <a href="javascript:postwith('captura.jsp',{ue:'<%=id_ue%>'})"> <li>  Captura </li> </a>
             <a href="selecciona_ue.jsp"> <li> Cambiar UE</li></a>
          </ul>
           <ul class="text-right">
              <li><span class="icon-user"></span> <span class="negrita"><%=nom_usuario.toUpperCase()%> <span class="caret icon-chevron-down"> <!--boton --></span></span>
                    <ul class="children">    
                        <li> <a href="cambiar_psw_admin.jsp"> <span class="icon-engrane"></span> Cambiar contraseña</a></li>
                    </ul>
              </li><li class="cerrar_ses"> <a href="logout_admin.jsp">  Cerrar Sesión</a></li>
           </ul>
        </div>
   </header>
      
        <div id="margen-oculto">&nbsp;</div>
      <div id="Div_Titulo">
              <div id="img_logo"><img src="../images/logoSegCurt.png" alt=""/></div>
              <div id="txt_titu">
              <span class="text_small">SISTEMA </span> <span class="text_small">DE SEGUIMIENTO DE LA
                  <br> </span> <span class="TextTitulo">CLAVE ÚNICA DEL REGISTRO DEL TERRITORIO</span>
              </div>      
      </div>
          
   
  <div id="cont_formulario">
            
   <form id="soporte" name="soporte" >
        <span class="TextTitulo subrayado">Atender solicitud</span><br><br>
        
        
        <% String fecha=getFechaActual();%>
             <div id="div_fecha">Fecha: 
              <input type="text" id="fecha_llenado" name="fecha_llenado" value="<%out.print(fecha);%>" readonly style="border-width:0; background:none; font-weight: bold;" class="w15" >
             </div>
             <input type="hidden" name="id_ue" id="id_ue" value="<%=id_ue%>" >
             <input type="hidden" name="id_sol" id="id_sol" value="<%=id_sol%>" >
             <input type="hidden" name="fecha_sol" id="fecha_sol" value="<%=fecha_sol%>" >
             <input type="hidden" name="responsable_val" id="responsable_val" value="<%=session_admin_curt%>" readonly="">
            
         <div id="cont_center" >
             <div id="col_textCenter_2"> <span class="lbl_slc">Solicitante:</span></div> 
             <div id="col_inpCenter_2"> <input class="readtext" type="text" name="nom_solicita" id="nom_solicita" value="<%=nombre%>" readonly=""></div>
             
             <div id="col_textCenter_2"> <span class="lbl_slc">Tipo de solicitud: </span> </div> 
             <div id="col_inpCenter_2"><input class="readtext" type="text" name="tipo_solicitud" id="tipo_solicitud" value="<%=tipo_solicitud%>"  readonly=""></div>
             
             <div id="col_textCenter_2"> <span class="lbl_slc">Correo: </span> </div>  
             <div id="col_inpCenter_2"> <input class="readtext" type="text" name="correo" id="correo" value="<%=correo%>" readonly=""></div>
             
             <div id="col_textCenter_2"> <span class="lbl_slc">Mensaje:</span></div>  
             <div id="col_inpCenter_2"> <textarea class="readtext" name="mensaje" id="mensaje" readonly="" ><%=mensaje%></textarea></div>
            
         </div>    
         
                
                  <div id="btn_enviar">
                    <input type="button" value="&ll; Regresar" onclick="javascript:cancelar_activ();" class="bcancelar">    &nbsp;
                    <input type="button" value="Liberar" onclick="javascript:proceso_libera_solic();" id="guarda_reg" name="guarda_reg">
                 </div>
        
            </form>
 </div>
              
              
              <footer class="admin">
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
     <script>location.href = "index_admin.jsp";</script>
    
    <% 
       }// Termina el ELSE 
    %>