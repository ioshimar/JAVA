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
            function Cancelar(){ window.history.back();}
            
            function EliminaCapa(){
    
                var r = confirm("¿Estás seguro que deseas ELIMINAR el archivo?");
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
     <% String id_cob = request.getParameter("cob"); 
        String id_ue = request.getParameter("ue"); 
        String id_entrega = request.getParameter("entrega"); 
     %>
    <body background="img_codigo4a_roja.jpg"> 
        <%! String municipio ,  no_reg  ; %>
        <%ConexionBD conexion = new ConexionBD();%>
        
       <% PreparedStatement pst25 =(PreparedStatement) conexion.conn.prepareStatement( "SELECT * FROM \"seguim_CURT\".cobertura WHERE id_cob = '"+id_cob+"'");
                conexion.rs =pst25.executeQuery(); 
                while(conexion.rs.next()) {
                municipio = conexion.rs.getString("municipio");
                no_reg = conexion.rs.getString("num_reg");
                } 
        %>
        
        <div id="cont_form_center">
            <span class="text-eliminar"> Eliminar registro</span> <span class="capa-eliminar"> <%=municipio%> </span> 
            
            <form action="EliminaCobert" method="post" id="form-eliminar">
                    <input type="hidden" name="cobertura" id="cobertura" value="<%=id_cob%>">
                    <input type="hidden" name="ue" id="ue" value="<%=id_ue%>">
                    <input type="hidden" name="entrega" id="entrega" value="<%=id_entrega%>">
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