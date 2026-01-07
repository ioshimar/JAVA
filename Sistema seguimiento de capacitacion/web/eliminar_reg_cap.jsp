<%-- 
    Document   : eliminar_reg_cap
    Created on : 11/09/2019, 02:44:33 PM
    Author     : IOSHIMAR.RODRIGUEZ
--%>

<%@page import="BaseDatos.ConexionBD"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    HttpSession objsesion_enc =request.getSession(false);
    String sesion_cve_enc = (String)objsesion_enc.getAttribute("session_curt1"); //se crea la variable de Sesión
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
              var id_ue = document.getElementById("id_ue").value;  
             window.history.go(-1);
                // $("div#frame").hide();
                // $("#frame").close();
                
                 
            }
            
            function EliminaCapa(){
    
                var r = confirm("¿Estás realmente seguro que deseas ELIMINAR la capacitación? ");
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
     <% String id_cap = request.getParameter("id_cap"); 
        String id_ue = request.getParameter("id_ue"); 
     %>
    <body> 
    
        
        <div id="cont_form_center">
            <span class="text-eliminar"> Eliminar capacitación</span> <span class="capa-eliminar"></span> 
            
                <form action="operacion_elimina_cap.jsp" method="get" id="form-eliminar">
                    <input type="hidden" name="id_cap" id="id_cap" value="<%=id_cap%>">
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
