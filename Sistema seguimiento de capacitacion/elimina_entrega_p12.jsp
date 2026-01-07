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
    String sesion_cve_enc = (String)objsesion_enc.getAttribute("session_curt"); //se crea la variable de Sesión
     if(sesion_cve_enc!=null){  //SI NO ES NULLA
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link href="css/formularios_curt.css" rel="stylesheet" type="text/css"/>
        <title>Eliminar capa</title>
        <style>
   
   


        </style>
        
        <script>
            function Cancelar(){ 
              window.history.back();
                // $("div#frame").hide();
                // $("#frame").close();
                 
            }
            
            function EliminaCapa(){
    
                var r = confirm("¿Estás seguro que deseas ELIMINAR el registro?");
               if (r == true) {
                   document.getElementById("form-eliminar").submit();
              } 
                   else {
                      window.history.back();
                   }
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
     <% String id_dae = request.getParameter("id_dae"); 
        String id_ue = request.getParameter("id_ue"); 
     %>
    <body> 
        <%! String nom_arch   ; %>
        <%ConexionBD conexion = new ConexionBD();%>
        
       <% PreparedStatement pst25 =(PreparedStatement) conexion.conn.prepareStatement( "SELECT * FROM \"seguim_CURT\".datos_entrega_p12 WHERE id_dae = '"+id_dae+"'");
                conexion.rs =pst25.executeQuery(); 
                while(conexion.rs.next()) {
                nom_arch = conexion.rs.getString("nom_arch");
               
                } 
        %>
        
        <div id="cont_form_center">
            <span class="text-eliminar"> Eliminar carpeta</span> <span class="capa-eliminar"> <%=nom_arch%> </span> 
            
                <form action="operacion_elimina_dat_entp12.jsp" method="get" id="form-eliminar">
                    <input type="hidden" name="id_dae" id="id_dae" value="<%=id_dae%>">
                    <input type="hidden" name="id_ue" id="id_ue" value="<%=id_ue%>">
                    <br><br>
                    <div id="boton"> <input type="button" onclick="javascript:Cancelar();" value="Cancelar" class="bcancelar" style="max-width: 100px;"/> 
             &nbsp; &nbsp; &nbsp; &nbsp;<input type="button" onClick="javascript:EliminaCapa();" value="Eliminar" style="max-width: 100px;"/></div>
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