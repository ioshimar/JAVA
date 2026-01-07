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
           //  conexion.closeConnection();
         }  

%>
<html>
    <%
        
        
    String notificacion = "";    
      try{  
        PreparedStatement pst2 =(PreparedStatement) conexion.conn.prepareStatement("SELECT Count(*) as TOTAL  FROM \"seguim_CURT\".solicitud_soporte "
        + "WHERE estatus = 'PENDIENTE';",ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); //el Order BY ES MUY necesario 
        conexion.rs = pst2.executeQuery(); 
     
        int total = 0;
                while(conexion.rs.next()) {//se guarda cada resultado en la variable de opciones
                 total = conexion.rs.getInt("TOTAL");
       
                        if(total == 0){   //si es mayor a 0
                            notificacion = "";
                        }
                        else if(total == 1){   //si es mayor a 0
                            notificacion = "<br> Hay " +total+ " solicitud pendiente por atender <br>&nbsp;";
                        }
                        else if(total > 1){   //si es mayor a 0
                            notificacion = "<br> hay " +total+ " solicitudes pendientes por atender <br>&nbsp;";
                        }
                  }
                 } catch(SQLException e){out.print("exception"+e);}
              finally {
           // conexion.closeConnection();
         }  
     
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
                        //  postwith('captura.jsp',{ue:'< %=id_ue%>'}); //mandamos la URL
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
               
                });   
        </script>
        
        
        <!-------------------------------- SELECT con buscador ---------------------------------------->
          
         <link href="../css/select2/select2.css" rel="stylesheet" type="text/css"/>
         <script src="../js/select2/select2.min.js" type="text/javascript"></script>
         
         <script>
          // In your Javascript (external .js resource or <script> tag)
            $(document).ready(function() {
               $('.js-example-basic-single').select2({
                    placeholder: 'Selecciona una unidad del estado'
                   // theme: "classic"
                    //tags: true,
               });
            });
            
        </script>
      <!-- Termina SELECT con buscador-->
      
      
           <script>
function realizaProceso(){
    var ue = document.getElementById("ue").value;

 
    
     var xhttp = new XMLHttpRequest();
     //var url = '../exp_rep_mensual?fecha_inicio='+fecha_ini+"&fecha_fin="+fecha_fin;
     var url = '../exportar_reporte.jsp?ue='+ue;
     var verificar = true; //declaro la variable verificar
     
     document.getElementById("resultado").innerHTML = "Descargando archivo espere...";
     $('#loading').show();  // Mostramos el GIF
    //Validación
                if(!ue){
                   alert("Selecciona la Unidad del Estado");
                     setTimeout(function() { document.getElementById('ue').focus(); }, 10);
                    verificar = false;
                    
                }
                
     //TERMINA validación            
               
    
    xhttp.open("POST", url, true);
    xhttp.setRequestHeader("Content-Type", "application/json");
    xhttp.onreadystatechange = function() {
                var a;
            if (xhttp.readyState === 4 && xhttp.status === 200) {

               var archivo_blob = new Blob([xhttp.response], { type: 'text/csv;charset=utf-8' });  
               //alert(archivo_blob.size);
               if (archivo_blob.size < 5500){   //si el archivo equivale a menos de 5500 bytes (1KB) no Descargar nada de documento (es porque no contiene nada)
                   //alert("No hay regsitros en estas fechas"); 
                   $('#loading').hide(); // Ocultamos el GIF
                   document.getElementById("resultado").innerHTML = "El archivo que intentas descargar está vacío";
               }
               

               else {   //SI NO... si el archivo pesa mas de 1000 bytes (1KB) si imprimirá el documento
                            
                            var nombre_archivo = "Reporte"+ue+".xlsx"; //nombre del archivo con extension


                        if (navigator.appVersion.toString().indexOf('.NET') > 0){  //PARA QUE FUNCIONE EN EL IExplorer
                              window.navigator.msSaveBlob(archivo_blob, nombre_archivo);
                               $('#loading').hide(); // Ocultamos el GIF
                               document.getElementById("resultado").innerHTML = "";
                        }
                        else
                        {

                           // Truco para hacer un enlace descargable
                            a = document.createElement('a');
                            a.href = window.URL.createObjectURL(archivo_blob);
                            // Dar el nombre de archivo que deseas descargar
                            a.download = nombre_archivo;
                            a.style.display = 'none';
                            document.body.appendChild(a);
                            a.click();

                            $('#loading').hide(); // Ocultamos el GIF
                            document.getElementById("resultado").innerHTML = "";
                        }
                  }        
            }
    };
  
 // Debes configurar responseType como blob para respuestas binarias.
          xhttp.responseType = 'blob';

  
   if(verificar===false){
      $('#loading').hide(); // lo mantenemos oculto
      document.getElementById("resultado").innerHTML = ""; // quitamos el texto
   }
  
    if(verificar===true){   //Enviar los archivos
        //xhttp.send();
        xhttp.send(JSON.stringify(url));
   }

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



<link href="../css/icomoon/iconos.css" rel="stylesheet" type="text/css"/>

<link href="../header_menu/header.css" rel="stylesheet" type="text/css"/>
<script src="../header_menu/menuResponsive.js" type="text/javascript"></script>
<link href="../header_menu/menu_responsive.css" rel="stylesheet" type="text/css"/>
<script src="../js/cerrar_notif.js" type="text/javascript"></script>

    </head>
    
    <body>
        <div id="notif"><div id="result"> </div><div id="cerrarDiv"><a href="javascript:postwith('captura.jsp',{ue:'< %=id_ue%>'})">Aceptar</a></div> </div>
   
         
     
       <div class="menu_bar">
            <a style="cursor:pointer;" class="bt-menu"> 
            <span class="icon-menu3"></span> <img src="../images/inegi_vertical.png" width="51" height="31"/></a>
        </div> 
   <header class="administrador">
        <div id="logo"> <a href="inicio_admin.jsp"><img id="log-inegi" src="../images/logo_blanco_comp.png" alt=""/></a></div>
        <div id="nav">
          <ul class="text-left">
             <a href="inicio_admin.jsp"> <li> Inicio</li></a>
             <a href="javascript:postwith('captura.jsp',{ue:'< %=id_ue%>'})"> <li>  Captura </li> </a>
             <a href="selecciona_ue.jsp"> <li> Cambiar UE</li></a>
          </ul>
           <ul class="text-right">
              <li><span class="icon-user"></span> <span class="negrita"><%=nom_usuario%> <span class="caret icon-chevron-down"> <!--boton --></span></span>
                    <ul class="children">    
                        <li> <a href="cambiar_psw_admin.jsp"> <span class="icon-engrane"></span> Cambiar contraseña</a></li>
                        <li class="cerrar_sesion" > <a href="logout_admin.jsp">  <span class="icon-exit"></span> Cerrar Sesión</a></li>
                    </ul>
              </li>
             
                
              <li class="padre_notif"> 
                <%if( notificacion.equals("")){%>   
                    <img id="notific_f" src="../images/notif.png" alt="" title="No tienes notificaciones "/>
                <%}else{%>  
                       <img id="notific_t" src="../images/alerta_notif.png"  title="" alt=""/>
                        <ul class="hijo_notif">
                           <a href="solicitudes.jsp">  <li><%out.println(notificacion);%></li></a>
                          
                        </ul>
                <%}%>  
                </li>
              
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
     <img src="../images/xls.png" alt="" style="vertical-align:middle;"/>  <span class="TextTitulo subrayado">EXPORTAR REPORTE</span><br><br> 
   
                
              <form name="exportacion">     
             
            
            <div id="cont_center2">
          
           <div id="cont_left"> 
               <span class="lbl_slc">Nombre de la Unidad del Estado</span><br>
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
         + "municipio FROM \"seguim_CURT\".concertacion ORDER BY cve_ent, nom_ue");
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
              finally {conexion.closeConnection(); }  
                %>  
                        
                    </select>
                    
              <!--  <input type="text" name="inp_nom_ue" id="inp_nom_ue" value="">-->
                </div><br>
                <br><br>
              
            </div>
                
                  <div id="btn_enviar">
                      <input type="button" value="Regresar" onclick="javascript:window.location.href='inicio_curt.jsp'" class="bcancelar">    &nbsp;
                      <input type="button" value="Exportar Excel" onclick="javascript:realizaProceso();">
                 </div>
                <div id="loading" style="display: none;" > <img src="../images/spinner-loading.gif" alt="" width="100px" height="100px"/> </div> 
                  <div id="resultado"> </div>
                
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