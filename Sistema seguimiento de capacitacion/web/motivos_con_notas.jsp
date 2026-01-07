
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
            function cancelar_activ(){
               var r = confirm("¿Deseas regresar?");
                  if (r === true) {
                                  location.href = "curt_p10.jsp?ue="+<%=id_ue%>;
                  } 
             };
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
       }
      catch(SQLException e){
               out.print("exception"+e);
              }       
                   while(conexion.rs.next()){ 
                   Nombre_carpeta =conexion.rs.getString("nom_archivo");
                   }          
     %> 
      
     
       <div class="menu_bar">
            <a style="cursor:pointer;" class="bt-menu"> 
            <span class="icon-menu3"></span> <img src="images/inegi_vertical.png" width="51" height="31"/></a>
        </div> 
    <header>
        <div id="logo"> <a href="inicio_curt.jsp"><img id="log-inegi" src="images/inegi_letras.png" alt=""/></a></div>
        <div id="nav">
          <ul class="text-left">
             <a href="inicio_curt.jsp"> <li> Inicio</li></a>
             <a onclick="window.open('captura.jsp?ue=<%=id_ue%>','_self')"> <li>  Captura </li> </a>
          </ul>
           <ul class="text-right">
              <li><span class="negrita"><%=nom_usuario.toUpperCase()%> <span class="caret icon-chevron-down"> <!--boton --></span></span>
                 <!--   <ul class="hijo">    
                       <li> <a href="logout_curt.jsp">  Cerrar Sesión</a></li>
                    </ul>-->
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
          <%
             //   ConexionDirecBD conexionDir=new ConexionDirecBD(); 
                     //nueva conslta para rellenar el listado
                String nombre_ue="";
                String folio_ue="";
           
                PreparedStatement pst25 =(PreparedStatement) conexion.conn.prepareStatement( "select \"Id\",\"FOLIO\",\"INSNOMBRE\",\"CVE_ENTIDAD\", \"CVE_MUN\" "
                        + " FROM  \"seguim_CURT\".ufg_directori_ufg WHERE \"Id\" = '"+id_ue+"' AND \"CVE_ENTIDAD\" = '"+sesion_cve_enc+"'    ORDER BY \"INSNOMBRE\" ");
                conexion.rs =pst25.executeQuery(); 
                while(conexion.rs.next()) {
                    nombre_ue= conexion.rs.getString("INSNOMBRE");
                    folio_ue=conexion.rs.getString("FOLIO"); 
                } 
       %>  
        <div id="cont_formulario">
            <form id="form_motivos_gen">
            <span class="TextTitulo subrayado">Agregar cobertura de <%=Nombre_carpeta%></span><br><br>
            <% String fecha=getFechaActual();%>
             <div id="div_fecha">Fecha: 
              <input type="text" id="fecha_llenado" name="fecha_llenado" value="<%out.print(fecha);%>" readonly style="border-width:0; background:none; font-weight: bold;" class="w15" >
             </div>
            
            
             <div id="cont_center"><span class="text_smal15">  <%=nombre_ue%></span></div><br>
             <div id="cont_center2">
          
               <input type="hidden" name="id_gen" id="id_gen" value="<%=id_gen%>" >
               <input type="hidden" name="id_ue" id="id_ue"  value="<%=id_ue%>">
              <table> 
                   <tr> 
                     
                       <th width="50%">Motivo</th>
                       <th width="20%">Total </th>
                   </tr>
                   <tr>
                       <td>1. La clave de la entidad federativa no debe ser nula.</td> 
                       <td><input type="text" name="mot_cod1" id="mot_cod1" class="w15" placeholder="total"></td> 
                   </tr>
                    <tr>
                       <td>2. El número de dígitos de la clave de la entidad federativa es incorrecto.</td> 
                       <td><input type="text" name="mot_cod2" id="mot_cod2" class="w15" placeholder="total"></td> 
                   </tr>
                   <tr>
                       <td>3. La clave del municipio o demarcación territorial no debe ser nula.</td> 
                       <td><input type="text" name="mot_cod3" id="mot_cod3" class="w15" placeholder="total"></td> 
                   </tr>
                   <tr>
                       <td>4. El número de dígitos de la clave del municipio o demarcación territorial es incorrecto.</td> 
                       <td><input type="text" name="mot_cod4" id="mot_cod4" class="w15" placeholder="total"></td> 
                   </tr>
                   <tr>
                       <td>5. La clave de localidad no debe ser nula.</td> 
                       <td><input type="text" name="mot_cod5" id="mot_cod5" class="w15" placeholder="total"></td> 
                   </tr>
                    <tr>
                       <td>6. El número de dígitos de la clave de localidad es incorrecto.</td> 
                       <td><input type="text" name="mot_cod6" id="mot_cod6" class="w15" placeholder="total"></td> 
                   </tr>
                    <tr>
                       <td>7. El identificador catastral no debe ser nulo.</td> 
                       <td><input type="text" name="mot_cod7" id="mot_cod7" class="w15" placeholder="total"></td> 
                   </tr>
                   <tr>
                       <td>8. El registro tabular contiene más de una geometría.</td> 
                       <td><input type="text" name="mot_cod8" id="mot_cod8" class="w15" placeholder="total"></td> 
                   </tr>
                   <tr>
                       <td>9. Tipo de geometría no válida, debe ser polígono o multipolígono.</td> 
                       <td><input type="text" name="mot_cod9" id="mot_cod9" class="w15" placeholder="total"></td> 
                   </tr>
                   <tr>
                       <td>10. Geometría inválida (la geometría no está correctamente formada o cerrada en todos sus vértices; o bien, los vértices no intersecten entre sí con ellos mismos).</td> 
                       <td><input type="text" name="mot_cod10" id="mot_cod10" class="w15" placeholder="total"></td> 
                   </tr>
                    <tr>
                       <td>11a. El polígono está traslapado con alguno o algunos polígonos de la solicitud.</td> 
                       <td><input type="text" name="mot_cod11a" id="mot_cod11a" class="w15" placeholder="total"></td> 
                   </tr>
                   <tr>
                       <td>11b. El polígono está traslapado con alguno o algunos polígonos de la información almacenada.</td> 
                       <td><input type="text" name="mot_cod11b" id="mot_cod11b" class="w15" placeholder="total"></td> 
                   </tr>
                   <tr>
                       <td>12a. El polígono está duplicado con alguno o algunos polígonos de la solicitud.</td> 
                       <td><input type="text" name="mot_cod12a" id="mot_cod12a" class="w15" placeholder="total"></td> 
                   </tr>
                   <tr>
                       <td>12b. El polígono está duplicado con alguno o algunos polígonos de la información almacenada.</td> 
                       <td><input type="text" name="mot_cod12b" id="mot_cod12b" class="w15" placeholder="total"></td> 
                   </tr>
                   <tr>
                       <td>13. El polígono se encuentra fuera del rango establecido del territorio nacional.</td> 
                       <td><input type="text" name="mot_cod13" id="mot_cod13" class="w15" placeholder="total"></td> 
                   </tr>
                   <tr>
                       <td>14. El identificador catastral está duplicado.</td> 
                       <td><input type="text" name="mot_cod14" id="mot_cod14" class="w15" placeholder="total"></td> 
                   </tr>
                   <tr>
                       <td>15. El área que conforma el polígono debe ser mayor o igual a 1 metro cuadrado.</td> 
                       <td><input type="text" name="mot_cod15" id="mot_cod15" class="w15" placeholder="total"></td> 
                   </tr>
                   <tr>
                       <td>16. La Clave Única del Registro del Territorio esta duplicada.</td> 
                       <td><input type="text" name="mot_cod16" id="mot_cod16" class="w15" placeholder="total"></td> 
                   </tr>
                    <tr>
                       <td>17. La Clave Única del Registro del Territorio no debe ser nula.</td> 
                       <td><input type="text" name="mot_cod17" id="mot_cod17" class="w15" placeholder="total"></td> 
                   </tr>
                   <tr>
                       <td>18. Las CURT´s ingresadas de los polígonos a fusionar deben de corresponder a su geometría.</td> 
                       <td><input type="text" name="mot_cod18" id="mot_cod18" class="w15" placeholder="total"></td> 
                   </tr>
                    <tr>
                       <td>19. Las CURT´s ingresadas de cada división, no corresponden al valor original de la clave.</td> 
                       <td><input type="text" name="mot_cod19" id="mot_cod19" class="w15" placeholder="total"></td> 
                   </tr>
                   
               </table>
             
            </div>
            
                
                  <div id="btn_enviar">
                    <input type="button" value="&ll; Regresar" onclick="javascript:cancelar_activ();" class="bcancelar">    &nbsp;
                    <input type="button" value="Guardar" onclick="javascript:proceso_motivos_gencurt();">
                 </div>
            </form>
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
                                    <a href="actualiza_mot_gencurt.jsp?idmotivo=<%=id_motgen%>&ue=<%=id_ue%>&id_gen=<%=id_gen%>"> <span class="icon-edit"></span><span class="text-e">Editar </span></a>
                                </td>
                               
                                <td class="center"> 
                                    <a href="elimina_mot_gencurt.jsp?idmotivo=<%=id_motgen%>&ue=<%=id_ue%>&id_gen=<%=id_gen%>"><span class="icon-trashcan"></span><span class="text-e">  Eliminar</span></a>
                                       
                                 <!--   </a>-->
                                </td>
                            </tr>
                            <%}
                            
                            }else{%> 
            <tr><td class="center" style="background:none; padding:8px 0; font-size:18px; border:none;">NO HAY REGISTROS</td></tr>
            <%}
            }
      catch(SQLException e){
               out.print("exception"+e);
              }  finally {conexion.closeConnection(); } 
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