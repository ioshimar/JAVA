<%-- 
    Document   : actualiza_capa
    Created on : 18/08/2017, 01:05:18 PM
    Author     : RICARDO.MACIAS
--%>


<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
            
            function ActualizarCobert(){
    
                var r = confirm("¿Estás seguro que deseas ACTUALIZAR el archivo?");
               if (r == true) {
                   document.getElementById("form-actualizar").submit();
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
        <script type="text/javascript">
 //funcion de carga de lista desplegable al selceccionar un elemento de la lista anterior
<%!
        public static String getFechaActual() {//funcion para obtener la fecha actual
        
        SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy", new Locale("ES", "MX"));//se define el formato de la fecha
        Date ahora = new Date();//se crea un objeto date
        return formateador.format(ahora);//regresa la fecha actual con el formato establecido
    }
%>
</script>  
        
        
    </head>
     <% String id_cob = request.getParameter("cob"); 
        String id_ue = request.getParameter("ue"); 
        String id_entrega = request.getParameter("entrega"); 
     %>
    <body background="img_codigo4a_roja.jpg"> 
        <%! String municipio ,  no_reg, nom_shape  ; %>
        <%ConexionBD conexion = new ConexionBD();%>
        
       <% PreparedStatement pst25 =(PreparedStatement) conexion.conn.prepareStatement( "SELECT * FROM \"seguim_CURT\".cobertura WHERE id_cob = '"+id_cob+"'");
                conexion.rs =pst25.executeQuery(); 
                while(conexion.rs.next()) {
                municipio = conexion.rs.getString("municipio");
                no_reg = conexion.rs.getString("num_reg");
                nom_shape = conexion.rs.getString("nom_shape");
                } 
        %>
        
        <div id="cont_form_center">
            <span class="text-eliminar"> Actualizar registro</span> <span class="capa-eliminar"> <%=municipio%> </span> 
            
            <form action="ActualizaCobert" method="post" id="form-actualizar">
                <% String fecha=getFechaActual();%>
             <div id="div_fecha">Fecha: 
              <input type="text" id="fecha_llenado" name="fecha_llenado" value="<%out.print(fecha);%>" readonly style="border-width:0; background:none; font-weight: bold;" class="w15" >
             </div>
                
                    <input type="hidden" name="cobertura" id="cobertura" value="<%=id_cob%>">
                    <input type="hidden" name="ue" id="ue" value="<%=id_ue%>">
                    <input type="hidden" name="entrega" id="entrega" value="<%=id_entrega%>">
                    <br>
                    <div id="col_text"><span class="text_act"> Municipio:</span></div>
                    <div id="col_inp"><input type="text" name="muni" id="muni" value="<%=municipio%>" class="w30"></div>
                    <br><br>
                    <div id="col_text"><span class="text_act">  Número de Registros:</span></div>
                    <div id="col_inp"><input type="text" name="no_reg" id="no_reg" value="<%=no_reg%>" class="w30"></div>
                     <br><br>
                     <div id="col_text"> <span class="text_act"> Nombre del shape:</span></div>
                    <div id="col_inp"><input type="text" name="nom_shape" id="nom_shape" value="<%=nom_shape%>" class="w30" ></div>
                    <br><br>
                    <div id="boton"> <input type="button" onclick="javascript:Cancelar();" value="Cancelar" class="bcancelar" style="max-width: 100px;"/> 
             &nbsp; &nbsp; &nbsp; &nbsp;<input type="button" onClick="javascript:ActualizarCobert();" value="Actualizar" style="max-width: 100px;"/></div>
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