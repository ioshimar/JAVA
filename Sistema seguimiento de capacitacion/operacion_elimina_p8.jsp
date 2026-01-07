<%-- 
    Document   : operacion_actua_capa
    Created on : 18/08/2017, 02:23:20 PM
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
        <title>JSP Page</title>
        <script>
             function goback(){
             
             window.history.go(-2);
             //location.reload(true);
       // window.location.reload(history.go(-3));
        
        //setTimeout('window.location.reload()',1); 
       // location.href = window.history.go(-3);
      
        //window.location.replace(history.go(-3));
 }
        </script>           
    </head>
    <body>
         <%! //variables estaticas para llamarlas desde cualquier parte de la pagina
         static String nom_capa, num_elem, id_eoc, nom_capa_A, num_elem_A;
         %>
         <%
         ConexionBD conexion=new ConexionBD(); 
    
            id_eoc = request.getParameter("id_eoc");
            
 
       conexion.stmt=conexion.conn.createStatement();      
       conexion.stmt.executeUpdate( "DELETE FROM \"seguim_CURT\".entrega_oc where id_eoc='"+id_eoc+"' ");
     
         %>
         
    
       
  <script>
	alert('Registro eliminado correctamente'); window.location.reload(history.go(-2));
</script>
       
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



