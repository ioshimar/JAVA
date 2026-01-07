
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
        ConexionBD conexion1=new ConexionBD(); 
 //String id_cob = "valor_cob";
 String id_gen = request.getParameter("gencurt");
 String id_ue = request.getParameter("ue");
 String id_entrega = request.getParameter("id_entrega");
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
          <script src="js/ajax_addMotivosGencurt.js" type="text/javascript"></script>
          
          
          <script>
                $(document).ready(function(){  
                    var i=1;  
                    $('#add_mot_GenCurt').click(function(){  
                         i++;  
                         $('#dynamic_field_cob').append('<tr id="row'+i+'">\n\
                                                      <td><input type="text" name="total_motivos" class="w15" placeholder="Total"></td>\n\
                                                      <td><input type="text" name="motivo" id="motivo" class="w50" placeholder="Motivo(s)"></td>\n\
                                                      <td><button type="button" name="remove" id="'+i+'" class="btn btn-danger btn_remove">X</button></td></tr>');  
                    });  
                    $(document).on('click', '.btn_remove', function(){  
                         var button_id = $(this).attr("id");   
                         $('#row'+button_id+'').remove();  
                    });  

               });
          </script>
       
          <script>
            function cancelar_activ(){
               var r = confirm("¿Deseas regresar?");
                  if (r === true) {
                                  location.href = "curt_p10.jsp?ue="+<%=id_ue%>;
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
                function enviar_formulario(){ 
                   document.getElementById("elimina_cob").submit();
                }; 
                
              function enviar_form_actualiza(){
                  document.getElementById("actualiza_cob").submit();
               };
                
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
         

  String Nombre_carpeta="";
   try{
       PreparedStatement pst1 =(PreparedStatement) conexion.conn.prepareStatement( "SELECT nom_archivo FROM \"seguim_CURT\".generacion_curt WHERE id_gen= '"+id_gen+"' AND id_ue = '"+id_ue+"' ");
       conexion.rs =pst1.executeQuery(); 
           
                   while(conexion.rs.next()){ 
                   Nombre_carpeta =conexion.rs.getString("nom_archivo");
                   }
    }
      catch(SQLException e){
               out.print("exception"+e);
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
             <a onclick="window.open('captura.jsp?ue=<%=id_ue%>','_self')"> <li>  Captura </li> </a>
          </ul>
           <ul class="text-right">
              <li><span class="negrita"><%=nom_usuario.toUpperCase()%> <span class="caret icon-chevron-down"> <!--boton --></span></span>
                 <ul class="children">    
                        <li> <a href="cambiar_psw.jsp"> <span class="icon-engrane"></span> Cambiar contraseña</a></li>
                    </ul>
              </li>
              <li class="cerrar_ses"> <a href="logout_curt.jsp">  Cerrar Sesión</a></li>
           </ul>
        </div>
   </header>
      
        <div id="margen-oculto">&nbsp;</div>
        <div id="Div_Titulo">
              <span class="text_small">SISTEMA </span> <span class="text_small">DE SEGUIMIENTO DE LA
                  <br> </span> <span class="TextTitulo">CLAVE ÚNICA DEL REGISTRO DEL TERRITORIO</span><br>
                 
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
                String Cpostal ="";
     try{            
         PreparedStatement pst25 =(PreparedStatement) conexion.conn.prepareStatement( "select T1.\"Id\",T1.\"FOLIO\",T1.\"CPOSTAL\",T1.\"INSNOMBRE\",T1.\"INSNOMBRECIUDADMPIO\",T1.\"CVE_ENTIDAD\", T1.\"CVE_MUN\",  T2.\"NOM_EDO\" "
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
      } catch(SQLException e){out.print("exception"+e);}
              finally {
                    // conexion.closeConnection(); 
                    }                        
               // String Nombre_mun2 = nom_mun.substring(0, 1).toUpperCase() + nom_mun.substring(1); // Solo convertimos la primera a mayuscula
                
           
     %>  
     
     <div id="cont_mot">
         <div id="cont_codigos">
                   <br>
                   <span class="Gotham-Book">Guía para la interpretación de códigos en la generación y actualización de la CURT</span>
                   <br>
                   <!-- <img src="images/codigos_motivos.JPG" alt=""/>-->
                   <table id="tbl_codigos">
                        <tr>
                            <th width="10%">Código</td>
                            <th width="90%">Descripción</td>
                        </tr>
                        <tr> <td class="cel_cod">1</td> <td>La clave de la entidad federativa no debe ser nula.</td></tr>
                        <tr> <td class="cel_cod">2</td> <td>El número de dígitos de la clave de la entidad federativa es incorrecto.</td> </tr>
                        <tr> <td class="cel_cod">3</td> <td>La clave del municipio o demarcación territorial no debe ser nula.</td></tr>
                        <tr> <td class="cel_cod">4</td> <td>El número de dígitos de la clave del municipio o demarcación territorial es incorrecto.</td></tr>
                        <tr> <td class="cel_cod">5</td> <td>La clave de localidad no debe ser nula.</td> </tr>
                        <tr> <td class="cel_cod">6</td> <td>El número de dígitos de la clave de localidad es incorrecto.</td></tr>
                        <tr> <td class="cel_cod">7</td> <td>El identificador catastral no debe ser nulo.</td> </tr>
                        <tr> <td class="cel_cod">8</td> <td>El registro tabular contiene más de una geometría.</td></tr>
                        <tr> <td class="cel_cod">9</td> <td>Tipo de geometría no válida, debe ser polígono o multipolígono.</td></tr>
                        <tr> <td class="cel_cod">10</td> <td>Geometría inválida (la geometría no está correctamente formada o cerrada en todos sus vértices; o bien, los vértices no intersecten entre sí con ellos mismos).</td> </tr>
                        <tr> <td class="cel_cod">11a</td> <td>El polígono está traslapado con alguno o algunos polígonos de la solicitud.</td> </tr>
                        <tr> <td class="cel_cod">11b</td> <td>El polígono está traslapado con alguno o algunos polígonos de la información almacenada.</td> </tr>
                        <tr> <td class="cel_cod">12a</td> <td>El polígono está duplicado con alguno o algunos polígonos de la solicitud.</td></tr>
                        <tr> <td class="cel_cod">12b</td> <td>El polígono está duplicado con alguno o algunos polígonos de la información almacenada.</td> </tr>
                        <tr> <td class="cel_cod">13</td> <td>El polígono se encuentra fuera del rango establecido del territorio nacional.</td></tr>
                        <tr> <td class="cel_cod">14</td> <td>El identificador catastral está duplicado.</td> </tr>
                        <tr> <td class="cel_cod">15</td> <td>El área que conforma el polígono debe ser mayor o igual a 1 metro cuadrado.</td> </tr>
                        <tr> <td class="cel_cod">16</td> <td>La Clave Única del Registro del Territorio esta duplicada.</td></tr>
                        <tr> <td class="cel_cod">17</td> <td>La Clave Única del Registro del Territorio no debe ser nula.</td> </tr>
                        <tr> <td class="cel_cod">18</td> <td>Las CURT´s ingresadas de los polígonos a fusionar deben de corresponder a su geometría.</td> </tr>
                        <tr> <td class="cel_cod">19</td> <td>Las CURT´s ingresadas de cada división, no corresponden al valor original de la clave.</td> </tr>
                    </table>
               </div>
         
         
        <div id="cont_formulario_motiv">
            <form id="form_motivos_gen">
            <span class="TextTitulo subrayado">Agregar motivos por los que no se generó la curt en  <%=Nombre_carpeta%></span><br><br>
            <% String fecha=getFechaActual();%>
             <div id="div_fecha">Fecha: 
              <input type="text" id="fecha_llenado" name="fecha_llenado" value="<%out.print(fecha);%>" readonly style="border-width:0; background:none; font-weight: bold;" class="w15" >
             </div>
            
            
             <div id="cont_center"><span class="text_smal15">  <%=nombre_ue%></span></div><br>
             <div id="cont_center2">
                 <div class="relative">
          
               <input type="hidden" name="id_gen" id="id_gen" value="<%=id_gen%>" >
               <input type="hidden" name="id_ue" id="id_ue"  value="<%=id_ue%>">
               <input type="hidden" name="id_entrega" id="id_entrega"  value="<%=id_entrega%>">
               
               
              <table class="table table-bordered" id="dynamic_field_cob"> 
                   <tr> 
                     
                       <th width="20%">Total motivos</th>
                       <th width="50%">Código(s) de Motivo(s) &nbsp;
                           <span class="ayuda" id="ayuda_motivos">
                               ? 
                               <div class="div_oculto">
                                   Agregue los <a href="curtnotas.pdf" target="_new">códigos</a> 
                                   de los  motivos separándolos por una coma (, ) <br>ejemplo: 1, 2, 11a, 12b, etc...
                               </div>
                           </span>
                       </th>
                   
                   </tr>
                   <tr>
                  
                       <td><input type="text" name="total_motivos" class="w15" placeholder="Total"></td> 
                       <td><input type="text" name="motivo" id="motivo" class="w50" placeholder="Motivo(s)"></td> 
                        
                        <td><button type="button" name="add_mot_GenCurt" id="add_mot_GenCurt" class="btn btn-success"> Agregar + <br>renglones</button></td>
                   </tr>
               </table>
               
               
              
                 </div>
               
               
            </div>
               
               
            
                
                  <div id="btn_enviar">
                    <input type="button" value="&ll; Regresar" onclick="javascript:cancelar_activ();" class="bcancelar">    &nbsp;
                    <input type="button" value="Guardar" onclick="javascript:proceso_motivos_gencurt();">
                 </div>
            </form>
        </div>
               
             
               
     </div>      
                       
                       <%
    try{
       PreparedStatement pst2 =(PreparedStatement) conexion.conn.prepareStatement( "SELECT * FROM \"seguim_CURT\".motivos_gen"
               + " WHERE id_gen= '"+id_gen+"' AND id_ue = '"+id_ue+"'" ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
       conexion.rs =pst2.executeQuery(); 
      
                       %>
                       
      <div id="cont_tablas" >
          <span class="text-eliminar">Motivos por los que no se generó la CURT en: </span> <span class="capa-eliminar"> <%=Nombre_carpeta%> </span><br><br>
        <table id="lis_filas" style="max-width:600px; margin: 0 auto;" > 
            
           <%if(conexion.rs.next()){ //SI ENCUENTRA REGISTROS...%> 
             <tr>
               <td class="cabeReg" style="font-weight: bold;">Total</td>
               <td class="cabeReg" style="font-weight: bold;"> Motivo(s) </td>
               <td class="cabeReg" style="font-weight: bold;" colspan="2">Acción </td>
             </tr>
            <%
                              conexion.rs.beforeFirst(); //ESTE REGRESA el cursor a la primera fila que devuelve el ResulsSet (lo resetea)..., pero
                                //pero para que este funcione se debe agregar esta línea despues de la conuslta: ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE
                                while(conexion.rs.next()){
                                        int id_motgen = conexion.rs.getInt("id_motgen");
                                        String total_motgen =conexion.rs.getString("total_motgen");
                                        if(total_motgen==null)
                                            total_motgen="";
                                        String mot_gen=conexion.rs.getString("mot_gen");
                                        if(mot_gen==null)
                                            mot_gen="";
                                        
                            
            %>
                            <tr class="hov">
                                <td class="ambito center" align="center"><%out.print(total_motgen); %></td>
                                <td class="ambito center" align="center"><%out.print(mot_gen); %></td>
                                <td class="center"> 
                                    <a href="actualiza_mot_gencurt.jsp?idmotivo=<%=id_motgen%>&ue=<%=id_ue%>&id_gen=<%=id_gen%>&id_entrega=<%=id_entrega%>"> <span class="icon-edit"></span><span class="text-e">Editar </span></a>
                                </td>
                               
                                <td class="center"> 
                                    <a href="elimina_mot_gencurt.jsp?idmotivo=<%=id_motgen%>&ue=<%=id_ue%>&id_gen=<%=id_gen%>"><span class="icon-trashcan"></span><span class="text-e">  Eliminar</span></a>
                                       
                                 <!--   </a>-->
                                </td>
                            </tr>
                        <%   }
              }else{%> 
                    <tr><td class="center" style="background:none; padding:8px 0; font-size:18px; border:none;">NO HAY REGISTROS</td></tr>
            <%}
    }
      catch(SQLException e){
               out.print("exception"+e);
              }  
            finally {conexion.closeConnection(); }  
            %>
                           
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
     <script> alert("Inicia sesión para ver esta página");
              location.href = "index.jsp";
     </script>
    
    <% 
       }// Termina el ELSE 
    %>