<%-- 
    Document   : obten_ufg
    Created on : 29/06/2017, 08:59:30 AM
    Author     : RICARDO.MACIAS
--%>


<%@page import="BaseDatos.ConexionProdCurt"%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">


<%

String id_ue = request.getParameter("id_ue"); 
//String pEnt=(String)session.getAttribute("ent");
ConexionProdCurt conexionCURT = new ConexionProdCurt();

//out.println(idCat);
//out.println(idCat1);
%>
<select  name="carga_archivos" id="carga_archivos" onclick="javascript:carga_ConsCompCurt(this.value);" multiple size="6"><!-- nuevo listado -->
                      
            <%
                     //nueva conslta para rellenar el listado
                     
              try{       
                String idsolicitud="";
                String describe="";
              
                PreparedStatement pst26 =(PreparedStatement) conexionCURT.conn.prepareStatement( "SELECT idue, idsolicitud, idresponsable, fechasolicitud, id_status, \n" +
            "      estatus, describe, terminos, fechainsercion, tamano, intento, \n" +
            "       proceso, fechaproceso, checksum, tipo_solicitud, status, tamano_shp\n" +
            "  FROM registrocurt.tr_solicitudes_procesos WHERE idue = '"+id_ue+"' " ,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                 conexionCURT.rs =pst26.executeQuery(); //se ejecuta el listado
              if(conexionCURT.rs.next()){//SI encontró algo imprimimos lso encabezados...
                
                 conexionCURT.rs.beforeFirst(); //ESTE REGRESA el cursor a la primera fila que devuelve el ResulsSet (lo resetea)...,
                
                while(conexionCURT.rs.next()) {//se obtiene cada resultado de la consulta
                idsolicitud= conexionCURT.rs.getString("idsolicitud");
                describe=conexionCURT.rs.getString("describe");  
              
            %> <!-- se guarda el resultado en la variable -->
                    
                      <OPTION value="<%=idsolicitud%>"> <%out.println(describe);%>  </OPTION> 
               
            <%  }
            }else{
            %> 
                    <OPTION value="0"> No hay registros de archivos en esta UE  </OPTION> 
            <%
            }       
            }
                catch(SQLException e){
                        out.print("exception"+e);
                    }finally {
                        conexionCURT.closeConnection();
                    } 
            
            %>  
</select><!-- fin de la lista --> 