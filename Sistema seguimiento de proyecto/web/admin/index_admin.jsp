<%-- 
    Document   : index
    Created on : 19/06/2018, 01:06:25 PM
    Author     : RICARDO.MACIAS
--%>


<%@page import="java.sql.SQLException"%>
<%@page import="BaseDatos.ConexionBD"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirmando autorización</title>
        <link href="../css/estilos_login.css" rel="stylesheet" type="text/css"/>
             <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
          <link rel="shortcut icon" href="../images/favicon.ico">  
  
        <script src="../js/jquery/jquery-latest.min.js" type="text/javascript"></script>
    
        <script src="js/ajax_log_admin.js" type="text/javascript"></script>
        
        <script>//Script para que se ejecute el ajax con el botón Enter del teclado
            $(document).keypress(function(e) { 
                    //mayor compatibilidad entre navegadores.
                    var code = (e.keyCode ? e.keyCode : e.which);
                    if(code==13){
                         ajax_sesion_admin();
                    }else{}
                    
            });
        </script>
        
       
      
        
        <script>//Script para cerrar DIV
                $(document).ready(function() {
                       $("#cerrarDiv").click(function(){
                               $("section#R1").slideUp() ;
                       });
                });
        </script>
        <script>
            function removeClass(val_id){
                var elemento = document.getElementById(val_id);
                $(elemento).removeClass("error");  //removmeos la clase error del input password 
                 $("section#R1").slideUp("slow") ; //quitamos el mensaje de error
            }
        </script>
      
        
        <script>   
        

        </script>
        
  <script type="text/javascript">
        $(function () { //funcion comprobar mayusculas
            var isShiftPressed = false;
            var isCapsOn = null;
            $("#pwd").bind("keydown", function (e) {
                var keyCode = e.keyCode ? e.keyCode : e.which;
                if (keyCode == 16) {
                    isShiftPressed = true;
                }
            });
            
            $("#pwd").bind("keyup", function (e) {
                var keyCode = e.keyCode ? e.keyCode : e.which;
                if (keyCode == 16) {
                    isShiftPressed = false;
                }
                
                if (keyCode == 20) {
                    if (isCapsOn == true) {
                        isCapsOn = false;
                        $('.alert_psw').hide();
                    } else if (isCapsOn == false) {
                        isCapsOn = true;
                         document.getElementById("text_alert_psw").innerHTML = " Bloq. mayús activado";
                         $('.alert_psw').show(); //mostramos el div
                    }
                }
            });
            
            
            $("#pwd").bind("keypress", function (e) {
                var keyCode = e.keyCode ? e.keyCode : e.which;
                if (keyCode >= 65 && keyCode <= 90 || isShiftPressed) {
                    isCapsOn = true;
                            document.getElementById("text_alert_psw").innerHTML = " Bloq. mayús activado";
                             $('.alert_psw').show(); //mostramos el div
                } else {
                    $('.alert_psw').hide();
                }
            });
            
             /*$( "#pwd" ).blur(function() { 
                     $('.alert_psw').hide(); //OCULTAMOS el div
                  }); */
        });
    </script>
        
        
        
    </head>
    <% ConexionBD conexion=new ConexionBD(); %><!-- nueva conexion -->
    <body background="../images/backBinar3.jpg"  style="background-size: cover;"> <!---->
         <section id="R1"><div id="result">   </div><div id="cerrarDiv"><img src="../images/cerrar.png" width="30" height="30"/></div> </section>
         <div id="contenedor-login">
             
                <a href="index.jsp" title="Ir al Inicio"> <img  src="../images/admin_log.png" alt="" id="size-personal"/></a><br><br>
             <h4 class="teclear">Administrador</h4><br>
       <form id="form_sesion">
           <!-- <div id="c1"><span>Estado:</span> </div>-->
           <div id="c2">
               <img src="../images/us.png" id="imag_es"/><input type="text" name="usuario" id="usuario" placeholder="administrador">
            </div>
             
             <br>
           <!--  <div id="c1">  <span>Clave de acceso</span></div>-->
           <div id="c2">
               <div class="div_relative">
                   <img src="../images/key.png" id="imag_es" alt=""/><input type="password" name="pwd" id="pwd" placeholder="********" onkeypress="removeClass(this.id);" onkeyup=""  >
                     <div class="alert_psw"><span id="text_alert_psw"> </span></div>
               </div>
           </div>
             
             
                    <div style="display: none;">   <input type="text" name="" id="">  </div> <!-- Solo para que al dar enter no se reseten los demas input-->
                    
          <div id="boton">
              <input type="button" value="Ingresar" id="enviar" onclick="javascript:ajax_sesion_admin();"> <!-- boton de envio de formulario, llama a funcion valida-->
          </div>
            
        </form>
         </div>
    </body>
</html>
