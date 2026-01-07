<%-- 
    Document   : obten_ue_ugig
    Created on : 13/11/2018, 10:23:14 AM
    Author     : RICARDO.MACIAS
--%>

<%@page import="BaseDatos.ConexionDirecBD"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="BaseDatos.ConexionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    HttpSession objsesion_enc =request.getSession(false);
    String sesion_cve_enc = (String)objsesion_enc.getAttribute("session_curt"); //se crea la variable de Sesión
     if(sesion_cve_enc!=null){  //SI NO ES NULLA
%>


<!DOCTYPE html>
<%

String ent = request.getParameter("ent"); 
String tipo_ue = request.getParameter("tipo_ue");
ConexionBD conexion=new ConexionBD();
ConexionDirecBD conexionDir =new ConexionDirecBD(); 

//out.println(idCat);
//out.println(idCat1);
%>

 <!-- MODIFICACION 20/07/2017-->
        <%! String claves_estado, entidad_encargado, claves_separadas ; %> <!--Variables Globales -->
        
        <%
            //CON ESTA CONSULTA SACAMOS TODOS LOS ESTADOS QUE LE PERTENECEN A LA REGIONAL: sesion_cve_enc
            
       try{     
         PreparedStatement pst23 =(PreparedStatement) conexion.conn.prepareStatement("select \"ENCESTATALES\", \"CVE_ENTIDAD\"  FROM \"seguim_CURT\".\"Encargados_CURT\" where \"CVE_ENTIDAD\"='"+ent+"'");
            conexion.rs =pst23.executeQuery(); 
            while(conexion.rs.next()) {
            claves_estado = conexion.rs.getString("ENCESTATALES");
            }
         claves_separadas = claves_estado.replaceAll(",", "','");  
   } catch(SQLException e){out.print("exception"+e);}
              finally {conexion.closeConnection();}
        %>
        <!-- TERMINA MODIFICACION 20/07/2017 -->
        
        
        
                <select name="ue" id="ue" class="w100">
                        <option value=""> Selecciona una unidad del estado...</option>
                          <%
                     //nueva conslta para rellenar el listado
                String nombre_ue="";
                String nom_ent="";
                String folio_ue="";
                String ue_ID ="";
                String nom_mun ="";
                String Query_select="";
                String num_concat ="";
                
                
            if (tipo_ue.equals("ugig")){;
                
                Query_select ="select T1.\"Id\",T1.\"FOLIO\",T1.\"INSNOMBRE\",T1.\"CVE_ENTIDAD\", T1.\"CVE_MUN\", T1.\"INSNOMBRECIUDADMPIO\", T2.\"NOM_EDO\" "
                + "FROM  db_directorio.ufg_directori_ufg as T1,  db_directorio.cat_edo as T2 "
                + "WHERE T1.\"CVE_ENTIDAD\"  =  T2.\"CVE_EDO\"  "
                + "AND   T1.\"CVE_ENTIDAD\" In('"+claves_separadas+"') "
                + "AND (T1.\"AMBITO\" LIKE 'E-C%' OR T1.\"AMBITO\" LIKE 'E-CR%' OR T1.\"AMBITO\" LIKE 'M-D%' OR T1.\"AMBITO\" LIKE 'F-RAN%' OR T1.\"AMBITO\" LIKE 'M-C%' OR T1.\"AMBITO\" LIKE 'E-RPP%')"
                + " ORDER BY T1.\"CVE_ENTIDAD\", T1.\"INSNOMBRE\"";
                
              num_concat=""; //nada  
            }
            else if(tipo_ue.equals("ue")){
                
                Query_select = "select T1.\"Id\",T1.\"FOLIO\",T1.\"INSNOMBRE\",T1.\"CVE_ENTIDAD\", T1.\"CVE_MUN\", T1.\"INSNOMBRECIUDADMPIO\", T2.\"NOM_EDO\" "
                + "FROM  db_directorio.ufg_directori_ue as T1,  db_directorio.cat_edo as T2 "
                + "WHERE T1.\"CVE_ENTIDAD\"  =  T2.\"CVE_EDO\"  "
                + "AND   T1.\"CVE_ENTIDAD\" In('"+claves_separadas+"') ";
                
                num_concat="9";    
            }    
                
              try{  
                
 PreparedStatement pst25 =(PreparedStatement) conexionDir.conn.prepareStatement(Query_select);
                conexionDir.rs =pst25.executeQuery(); 
                while(conexionDir.rs.next()) {
                nombre_ue= conexionDir.rs.getString("INSNOMBRE");
              // folio_ue=conexionDir.rs.getString("FOLIO"); 
                 ue_ID = conexionDir.rs.getString("Id");
                 nom_ent = conexionDir.rs.getString("NOM_EDO");
                nom_mun = conexionDir.rs.getString("INSNOMBRECIUDADMPIO").toLowerCase();  //lo convertimos primero a minusculas
            
                String Nombre_mun2 = nom_mun.substring(0, 1).toUpperCase() + nom_mun.substring(1); // Solo convertimos la primera a mayuscula
            
                      %> 
                        <OPTION value="<%=ue_ID%>"><%out.println(nombre_ue + "   " + "  (" +Nombre_mun2 +", "+nom_ent+") " );%> </OPTION> 
                <% 
                 }
                 } catch(SQLException e){out.print("exception"+e);}
              finally {conexionDir.closeConnection(); }  

                %>  
                        
                    </select>
                
                
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