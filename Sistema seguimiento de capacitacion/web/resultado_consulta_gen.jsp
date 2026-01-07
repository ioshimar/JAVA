<%-- 
    Document   : captura
    Created on : 27-jun-2018, 10:53:27
    Author     : ricardo.macias
--%>
<%@page import="BaseDatos.ConexionDirecBD"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="BaseDatos.Operaciones"%>
<%@page import="java.sql.*"%>
<%@page import="BaseDatos.ConexionBD"%>
<%@page import="java.text.DecimalFormat"%>

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



<html>
          
     
   
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><!-- tipo de codificacion-->
          <link rel="icon" href="images/icono_png.ico" type="image/gif" sizes="16x16">
          <link rel="shortcut icon" href="images/favicon.ico"> 
 
          <script src="js/jquery/jquery-latest.min.js" type="text/javascript"></script>
          <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes"> <!-- para que se ajuste a la pantalla del dispositivo-->
        <title>Registrar</title><!-- titulo de la pagina-->
        
        <link href="css/formularios_curt.css" rel="stylesheet" type="text/css"/>
     
    
          <script src="js/cancela_act.js" type="text/javascript"></script>
          
    
        <script>
            function valida(){
                 var ue = document.getElementById("ue").value;
                 
               if(!ue){
                     alert("Selecciona la Unidad del Estado");
                     setTimeout(function() { document.getElementById('ue').focus(); }, 10);
                     return false;
                    }
                return true;
           };
            
         
        </script>
      
        

        
        
<script type="text/javascript">
 //funcion de carga de lista desplegable al selceccionar un elemento de la lista anterior
<%!
        public static String getFechaActual() {//funcion para obtener la fecha actual
        
        SimpleDateFormat formateador = new SimpleDateFormat("dd 'de 'MMMM 'de 'yyyy", new Locale("ES", "MX"));//se define el formato de la fecha
        Date ahora = new Date();//se crea un objeto date
        return formateador.format(ahora);//regresa la fecha actual con el formato establecido
    }
%>
</script>  


<link href="header_menu/MenuIconos.css" rel="stylesheet" type="text/css"/>
<link href="header_menu/header.css" rel="stylesheet" type="text/css"/>
<script src="header_menu/menuResponsive.js" type="text/javascript"></script>
<link href="header_menu/menu_responsive.css" rel="stylesheet" type="text/css"/>
    </head>
    
    <body>
      
      <%
                
Class.forName("org.postgresql.Driver");
Connection  conexion = DriverManager.getConnection("jdbc:postgresql://10.152.11.61:5434/db_seguimientos", "us_seguimientos", "normAcAt");
Statement Estamento = conexion.createStatement();
String f_inicio_gen = request.getParameter("f_inicio_gen");
String f_fin_gen = request.getParameter("f_fin_gen");
//String f_inicio = "2014-06-01";
//String f_fin = "2018-12-31"; 



ResultSet rs1 = Estamento.executeQuery("SELECT count(DISTINCT id_ue) as tot_env FROM \"seguim_CURT\".generacion_curt WHERE fech_fin between '"+f_inicio_gen+"' AND '"+f_fin_gen+"';");
              
String tot_env = "";                             
					
while (rs1.next()) { 
tot_env = rs1.getString("tot_env");

 }


           %>
               
        
        <!--<div id="cont_consulta">-->
            <span class="CarroisGR16">Informe de la instrumentación  de la CURT por Unidad del Estado del <%=f_inicio_gen%> al <%=f_fin_gen%></span><br><br>
            <div class="r_tit"> UNIDADES DEL ESTADO REGISTRADAS QUE HAN GENERADO CURT: <%=tot_env%></div> 
            
         <%             


            ResultSet rs = Estamento.executeQuery("SELECT D.\"NOM_EDO\" as nom_ent, \"INSNOMBRECIUDADMPIO\" as municipio, \"INSNOMBRE\" as nom_ue, to_char(sum(pred_concurt),'999,999,999,999') as concurt, to_char(sum(pred_sincurt),'999,999,999,999') as sincurt FROM \"seguim_CURT\".generacion_curt O, \"seguim_CURT\".ufg_directori_ufg C, \"seguim_CURT\".cat_edo D WHERE C.\"Id\" = O.id_ue AND C.\"CVE_ENTIDAD\" = D.\"CVE_EDO\" AND O.fech_fin between '"+f_inicio_gen+"' and '"+f_fin_gen+"' GROUP BY id_ue, D.\"NOM_EDO\", \"INSNOMBRECIUDADMPIO\", \"INSNOMBRE\" ORDER BY D.\"NOM_EDO\" ASC;");
            
                             
            if(!rs.isBeforeFirst()){                  
  
         %>
           <table>
            <tr><td class="center" style="background:none; padding:8px 0; font-size:18px; border:none;">NO HAY REGISTROS</td></tr>
           </table>
           <%
               }
                else{ 

                
               out.println("<table>");
				out.println("<thead>");
					out.println("<tr class='backrep'><th><span class='Gotham-Book'>ENTIDAD</span></th><th><span class='Gotham-Book'>MUNICIPIO</span></th><th><span class='Gotham-Book'>UNIDAD DEL ESTADO</span></th><th><span class='Gotham-Book'>CON CURT</span></th><th><span class='Gotham-Book'>SIN CURT</span></th></tr>");
                                      
                                out.println("</thead>");
				out.println("<tbody>");
                                while(rs.next()) {
					out.println("<tr><td><span class='CarroisGR'>"+rs.getString("nom_ent")+"</span></td><td><span class='CarroisGR'>"+rs.getString("municipio")+"</span></td><td><span class='CarroisGR'>"+rs.getString("nom_ue")+"</span></td><td><span class='CarroisGR'>"+rs.getString("concurt")+"</span></td><td><span class='CarroisGR'>"+rs.getString("sincurt")+"</span></td></tr>");
                                        };
					
					
				out.println("</tbody>");
				out.println("<tfoot>");
				out.println("</tfoot>");
			out.println("</table>");
                 }  

      
                rs.close();
                
                //Estamento.close();
                //conexion.close();
                                 


           %>            
             
            <br><br>
                  <%
           ResultSet rs3 = Estamento.executeQuery("SELECT to_char(sum(pred_concurt),'999,999,999,999') as concurt, to_char(sum(pred_sincurt),'999,999,999,999') as sincurt FROM \"seguim_CURT\".generacion_curt WHERE fech_fin between '"+f_inicio_gen+"' and '"+f_fin_gen+"';");
               
           String concurt = "";
           String sincurt = "";
           String con = "";
                   while (rs3.next()) { 
                        concurt = rs3.getString("concurt");
                       
                        sincurt = rs3.getString("sincurt");
                   }
                   if(concurt==null){
                       
                       concurt="0";                   
                   
                   }
                   
                   if(sincurt==null){
                       
                       sincurt="0";                   
                   
                   }
                   //System.out.println("ey" + concurt);
                              
                  %> 
               <div class="r_tit"> TOTALES  &nbsp;&nbsp;&nbsp; PREDIOS CON CURT:<%=concurt%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PREDIOS SIN CURT: <%=sincurt%></div>
                
               <%
             rs3.close();
               %>
                <%             
            
            ResultSet rs2 = Estamento.executeQuery("SELECT D.\"NOM_EDO\" as nom_ent, count(DISTINCT id_ue) as total FROM \"seguim_CURT\".generacion_curt O, \"seguim_CURT\".ufg_directori_ufg C, \"seguim_CURT\".cat_edo D WHERE C.\"Id\" = O.id_ue AND C.\"CVE_ENTIDAD\" = D.\"CVE_EDO\" AND O.fech_fin between '"+f_inicio_gen+"' and '"+f_fin_gen+"' GROUP BY D.\"NOM_EDO\" ORDER BY D.\"NOM_EDO\" ASC;");
                
            if(!rs2.isBeforeFirst()){                  
  
         %>
           <table>
            <tr><td class="center" style="background:none; padding:8px 0; font-size:18px; border:none;">NO HAY REGISTROS</td></tr>
           </table>
           <%
               }
                else{ 
               out.println("<table>");
				out.println("<thead>");
					out.println("<tr class='backrep'><th><span class='Gotham-Book'>ENTIDAD</span></th><th><span class='Gotham-Book'>CANTIDAD</span></th></tr>");
                                      
                                out.println("</thead>");
				out.println("<tbody>");
                                while(rs2.next()) {
					out.println("<tr><td><span class='CarroisGR'>"+rs2.getString("nom_ent")+"</span></td><td><span class='CarroisGR'>"+rs2.getString("total")+"</span></td></tr>");
                                        };
					
					
				out.println("</tbody>");
				out.println("<tfoot>");
				out.println("</tfoot>");
			out.println("</table>");
                 }  

      
                rs2.close();
                
                Estamento.close();
                conexion.close();
                                 


           %> 
                   
           <div id="cur_notas"><a href="exportar_reporte_genera_curt.jsp?f_inicio_gen=<%=f_inicio_gen%>&f_fin_gen=<%=f_fin_gen%>" target="_new">Descargar archivo</a></div>
      
    </body>
</html>



    
  