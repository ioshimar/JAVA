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
         <script src="header_menu/jquery-latest.min.js" type="text/javascript"></script>
        
        <script src="js/ajx_proceso_DeleteFile.js" type="text/javascript"></script>
        <title>Eliminar Archivo</title>
        <style>  </style>
        
        <script>
            function Cancelar(){ window.history.back();}
            
           /* function ActualizarCobert(){
               var r = confirm("¿Estás seguro que deseas ACTUALIZAR el archivo?");
               if (r == true) {
                   document.getElementById("form-actualizar").submit();
               } 
               else{
                      window.history.back();
                   }
            }*/
        </script>
        
         <script>
              function postwith (to,p) { /*OCULTAR URL*/
                    var myForm = document.createElement("form");
                    myForm.method="post" ;
                    myForm.action = to ;
                    for (var k in p) {
                      var myInput = document.createElement("input") ;
                      myInput.setAttribute("name", k) ;
                      myInput.setAttribute("value", p[k]);
                      myForm.appendChild(myInput) ;
                    }
                    document.body.appendChild(myForm) ;
                    myForm.submit() ;
                    document.body.removeChild(myForm) ;
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
     <% 
        String id_ue = request.getParameter("id_ue"); 
        String colum =request.getParameter("colum");
        String nom_arch = request.getParameter("nom_arch");
        String tipo_oficio = "";
        if(colum.equals("ruta_ofi_env1")){tipo_oficio="1er oficio enviado";}
        if(colum.equals("ruta_ofi_recib1")){tipo_oficio="1er oficio recibido";}
        if(colum.equals("ruta_ofi_env2")){tipo_oficio="2do oficio enviado";}
        if(colum.equals("ruta_ofi_recib2")){tipo_oficio="2do oficio recibido";}
        if(colum.equals("ruta_ofi_env3")){tipo_oficio="3er oficio enviado";}
        if(colum.equals("ruta_ofi_recib3")){tipo_oficio="3er oficio recibido";}

     %>
     
     
    <body background="img_codigo4a_roja.jpg"> 
      
        
        <div id="cont_form_center">
            <span class="text-eliminar"> Eliminar documento del <%=tipo_oficio%></span> <span class="capa-eliminar"> </span> 
            <form id="form_delete" > <!-- action="SubirArchivo" enctype="MULTIPART/FORM-DATA" method="post"-->
                <input type="hidden" name="id_ue" id="id_ue" value="<%=id_ue%>">
                <input type="hidden" name="colum" id="colum" value="<%=colum%>">
                <input type="hidden" name="nom_arch" id="nom_arch" value="<%=nom_arch%>">
                <br><br>


                <div id="boton">
                    <input type="button" onclick="javascript:Cancelar();" value="&ll; Regresar" class="bcancelar" style="max-width: 100px;"/> &nbsp; &nbsp; &nbsp; &nbsp;    
                    <input type="button" value="Eliminar" onclick="proceso_DeleteFile();" />
                </div>
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