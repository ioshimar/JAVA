<%-- 
    Document   : obtenloc
    Created on : 22-may-2014, 12:02:47
    Author     : est.cynthia.rivera
--%>

<%@page import="BaseDatos.ConexionDirecBD"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<%
//String idCat = new  String(request.getParameter("NOM_MUN").getBytes("ISO-8859-1"),"UTF-8"); 
String idCat = request.getParameter("CVE_MUNICIPIO"); 

HttpSession objsesion_enc =request.getSession(false);
String sesion_cve_enc = (String)objsesion_enc.getAttribute("session_curt1"); //se crea la variable de Sesi

ConexionDirecBD conexion=new ConexionDirecBD();
//out.print(val);
//out.println(idCat);
//out.println(idCat1);
%>
<select name="lista_subcategoria"  id="lista_subcategoria" class="w30">
      <option value="" selected="selected">Seleccione una opción</option>
       
<%
   String loc="";
   String nomloc = "";
try{   
   //PreparedStatement pst =(PreparedStatement) conexion.conn.prepareStatement("select nomloc from db_directorio.cat_loc where cve_mun IN(select \"CVE_MUN\" from db_directorio.cat_mun where \"NOM_MUN\"='"+idCat+"') AND  cve_edo IN(SELECT \"CVE_ENTIDAD\" from db_directorio.encargados where \"ENCPWD\"='"+val+"') ") ;
   //PreparedStatement pst =(PreparedStatement) conexion.conn.prepareStatement("select nomloc from db_directorio.cat_loc where cve_mun IN(select \"CVE_MUN\" from db_directorio.cat_mun where \"NOM_MUN\"='"+idCat+"') AND  cve_edo ='"+val+"' ") ;
   PreparedStatement pst =(PreparedStatement) conexion.conn.prepareStatement("select nomloc, cve_loc from db_directorio.cat_loc where cve_mun ='"+idCat+"' AND  cve_edo ='"+sesion_cve_enc +"' ORDER BY \"nomloc\"");
   conexion.rs =pst.executeQuery(); 
   while(conexion.rs.next()) {
   loc = conexion.rs.getString("cve_loc");
   nomloc = conexion.rs.getString("nomloc");
%>
  <OPTION value="<%=loc%>"><%out.println(nomloc.toUpperCase());%></OPTION>
   <% }
    } catch(SQLException e){out.print("exception"+e);}
              finally {conexion.closeConnection();
                    }     
   %>
</select>