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
         static String nom_capa, num_elem, id_entrega, nom_capa_A, num_elem_A,id_ue;
         %>
         <%
         ConexionBD conexion=new ConexionBD(); 
    
            id_entrega = request.getParameter("id_entrega");
            id_ue = request.getParameter("id_ue");
 
       conexion.stmt=conexion.conn.createStatement();      
       conexion.stmt.executeUpdate( "DELETE FROM \"seguim_CURT\".datos_entrega_fis where id_entrega='"+id_entrega+"' and id_ue='"+id_ue+"' ");
       //Eliminar tambien en la tabla COBERTURA
        conexion.stmt.executeUpdate( "DELETE FROM \"seguim_CURT\".cobertura WHERE id_entrega='"+id_entrega+"' and id_ue='"+id_ue+"' ");
        //Eliminar tambien en la tabla criterios_validacion
       conexion.stmt.executeUpdate( "DELETE FROM \"seguim_CURT\".criterios_validacion WHERE id_entrega='"+id_entrega+"' and id_ue='"+id_ue+"' ");
        //Eliminar tambien en la tabla generacion_curt
       conexion.stmt.executeUpdate( "DELETE FROM \"seguim_CURT\".generacion_curt WHERE id_entrega='"+id_entrega+"' and id_ue='"+id_ue+"' ");
         //Eliminar tambien en la tabla motivos_gen
       conexion.stmt.executeUpdate( "DELETE FROM \"seguim_CURT\".motivos_gen WHERE id_entrega='"+id_entrega+"' and id_ue='"+id_ue+"' ");
       //Eliminar tambien en la tabla datos_entrega_p12
       conexion.stmt.executeUpdate( "DELETE FROM \"seguim_CURT\".datos_entrega_p12 WHERE id_entrega='"+id_entrega+"' and id_ue='"+id_ue+"' ");
       
        conexion.closeConnection();//termina la conexion
 
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

