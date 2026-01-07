<%-- 
    Document   : actualiza_capa
    Created on : 18/08/2017, 01:05:18 PM
    Author     : RICARDO.MACIAS
--%>


<%@page import="BaseDatos.ConexionBD"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    HttpSession objsesion_enc =request.getSession(false);
    String sesion_cve_enc = (String)objsesion_enc.getAttribute("session_curt1"); //se crea la variable de Sesión
    String nom_user = request.getParameter("nom_user");
     if(sesion_cve_enc!=null){  //SI NO ES NULLA
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link href="css/formularios_curt.css" rel="stylesheet" type="text/css"/>
        <title>Eliminar capa</title>
     
        
        <script>
            function Cancelar(){ window.history.back();}
            
            function EliminaRegistro(){
    
             //   var r = confirm("¿Estás seguro que deseas ELIMINAR el registro?");
             //  if (r == true) {
                   document.getElementById("form-eliminar").submit();
            //  } 
             //      else {
                //      window.history.back();
               //    }
            }
        </script>
        
        <style>
            body{
                background: #000;
            background-size: cover;
             background-repeat: no-repeat;
            }
            
        </style>
    </head>
     <% 
         String tabla = request.getParameter("tab");
         String id_ue = request.getParameter("ue");
         
         String nom_tab ="";
         if(tabla.equals("concertacion")){nom_tab="Concertacion";}
         if(tabla.equals("capacitacion")){nom_tab="Capacitacion";}
         if(tabla.equals("registro_ue")){nom_tab="Unidad del Estado";}
         if(tabla.equals("asesoria")){nom_tab="Asesoría de la UE";}
         if(tabla.equals("entrega_oc")){nom_tab="Datos de entrega de información a Oficinas Centrales";}
         if(tabla.equals("entrega_ssg")){nom_tab="Datos de entrega a la Subdirección de Soluciones Geomáticas";}
         if(tabla.equals("datos_entrega")){nom_tab="Datos de entrega de información a la Unidad del Estado";}
         if(tabla.equals("constancia")){nom_tab="Constancia de cobertura";}

     %>
    <body background="img_codigo4a_roja.jpg"> 
        <%! String nombre_arch ,  tamano  ; %>
        
      <!-- < % PreparedStatement pst25 =(PreparedStatement) conexion.conn.prepareStatement( "SELECT *  FROM \"seguim_CURT\".'"+tabla+"' WHERE id_ue = '"+id_ue+"'");
                conexion.rs =pst25.executeQuery(); 
                while(conexion.rs.next()) {
                nombre_arch = conexion.rs.getString("nom_archivo");
               // tamano = conexion.rs.getString("tamano");
                } 
        %>-->
        
        <div id="cont_form_center">
            <span class="text-eliminar"> Eliminar registro de </span> <span class="capa-eliminar"> <%=nom_tab%></span> 
            
            <form action="operacion_elimina_regis.jsp" method="post" id="form-eliminar">
                    <input type="hidden" name="tab" id="tab" value="<%=tabla%>">
                    <input type="hidden" name="id_ue" id="id_ue" value="<%=id_ue%>">
                    <br><br>
                    <div id="boton"> <input type="button" onclick="javascript:Cancelar();" value="Cancelar" class="bcancelar" style="max-width: 100px;"/> 
             &nbsp; &nbsp; &nbsp; &nbsp;<input type="button" onClick="javascript:EliminaRegistro();" value="Eliminar" style="max-width: 100px;"/></div>
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