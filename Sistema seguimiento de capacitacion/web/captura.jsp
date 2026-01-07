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


<%
    HttpSession objsesion_enc =request.getSession(false);
    String sesion_cve_enc = (String)objsesion_enc.getAttribute("session_curt1"); //se crea la variable de Sesión
    String nom_user = request.getParameter("nom_user");
     if(sesion_cve_enc!=null){  //SI NO ES NULLA
%>
<html>
    <%
        //conexiones a la base de datos
        ConexionBD conexion=new ConexionBD();
      //  ConexionDirecBD conexionDir=new ConexionDirecBD(); 
        String id_ue = request.getParameter("ue"); 
String priv ="";
    %>
     
   
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><!-- tipo de codificacion-->
          <link rel="icon" href="images/icono_png.ico" type="image/gif" sizes="16x16">
          <link rel="shortcut icon" href="images/favicon.ico"> 

          <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes"> <!-- para que se ajuste a la pantalla del dispositivo-->
        <title>Registrar</title><!-- titulo de la pagina-->
        
        <link href="css/formularios_curt.css" rel="stylesheet" type="text/css"/>
        <link href="css/estilos_inicio.css" rel="stylesheet" type="text/css"/>
         <script src="header_menu/jquery-latest.min.js" type="text/javascript"></script>
      
         
       
        

        
        
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


<link href="css/icomoon/iconos.css" rel="stylesheet" type="text/css"/>
<link href="header_menu/header.css" rel="stylesheet" type="text/css"/>
<script src="header_menu/menuResponsive.js" type="text/javascript"></script>
<link href="header_menu/menu_responsive.css" rel="stylesheet" type="text/css"/>
    
         
     
     
       <script>
             /*ocultar URL*/
             
             
function postwith (to,p) {
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

//javascript:postwith('curt_p4.jsp',{ue:'< %=id_ue%>'})

         </script>
         
         <script>
             function carga_informacion_check(){
                  //deshabilitamos los link con clase cri_valid, desde el inicio...
                  
                  
            $('.cri_valid').click(function () {return false;});
            $('.cri_valid').addClass("a_disabled"); //le agregamos la clase deshabilitado
            
            $(".txt_gray61").css("color","#d5d5d5");
            $(".backgray61").css("background","#d5d5d5");  
            
           // var privilegio;
               /*Validación Checkbox Inicial*/
                  var part1 = document.getElementById("p_inicial");
                    
                   var param = new Object();
                   param["id_ue"] = <%=id_ue%>;
                   var url="CargaP1";  
                   $.post(url,param,function(listaIdent){
                       var elementoP1 = listaIdent[0];
                       
                       if(listaIdent.length > 0){  //Si encuentra Algún registro
                           part1.checked=true;
                            $('.aP1').click (function () { return true;}); //habilitamos los link
                        //  privilegio = elementoP1.privilegio;  //Est o Reg
                        
                              var acepto_q = elementoP1.acepto;            
                    
                                if(acepto_q ==="NO"){
                                        $('.lnk_acept').click (function () { //deshabilitamos los link
                                           return false;                       //deshabilitamos los link
                                        });
                                       $('.lnk_acept').addClass("a_disabled"); //le agregamos la clase deshabilitado

                                  }else if(acepto_q ==="SI"){
                                       $('.lnk_acept').click (function () {
                                           return true;           //habilitamos los link
                                        });
                                     // $('.lnk_acept').removeClass("a_disabled");  
                                  }
                       }
                       
                      else{ //Si no encontro nada
                          part1.checked=false; 
                           $('.aP1').click (function () {return false; }); //deshabilitamos los link
                           $('.aP1').addClass("a_disabled"); //le agregamos la clase deshabilitado
                      };
                       
                     
                    }
                   
                  );
          
          
          /*------------------ Capac P2 ------------------*/
          
           var part2 = document.getElementById("part2");
                 var param2 = new Object();
                     param2["id_ue"] = <%=id_ue%>;
                     var url2="CargaCapacP2"; 
                     $.post(url2,param2,function(listaIdent2){
                           if(listaIdent2.length > 0){  //Si encuentra Algún registro
                           part2.checked=true;
                           }
                      else if(listaIdent2.length === 0){ // Si No encuentra algun registro  deshabilita los INGERESAR
                           $('.aP2').click (function () { //deshabilitamos los link
                                return false;                       //deshabilitamos los link
                            });
                            $('.aP2').addClass("a_disabled");
                             //$('.links_acepto').css('color','#d0d0d0');
                       }
                      
                      else{ part2.checked=false; };
                         
                     });
                    
           
          /*------------------ RegUE P3 ------------------*/
          
           var part3 = document.getElementById("part3");
                 var param3 = new Object();
                     param3["id_ue"] = <%=id_ue%>;
                     var url3="CargaP3"; 
                     $.post(url3,param3,function(listaIdent3){
                           if(listaIdent3.length > 0){  //Si encuentra Algún registro
                           part3.checked=true;
                       }
                         else if(listaIdent3.length === 0){ // Si No encuentra algun registro  deshabilita los INGERESAR //deshabilitamos los link
                           $('.aP3').click (function () { return false;  }); //deshabilitamos los link 
                           $('.aP3').addClass("a_disabled");   //agregamos la clase deshabilitado
                         }
        
                        else{ part3.checked=false; };
                         
                     });          
                     
                     
             /*------------------ RegUE P3 ------------------*/
          
           var part4 = document.getElementById("part4");
                 var param4 = new Object();
                     param4["id_ue"] = <%=id_ue%>;
                     var url4="CargaP4"; 
                     $.post(url4,param4,function(listaIdent4){
                           if(listaIdent4.length > 0){  //Si encuentra Algún registro
                                 part4.checked=true;
                           }
                           else if(listaIdent4.length === 0){ // Si No encuentra algun registro  deshabilita los INGERESAR  //deshabilitamos los link
                              //  $('.aP4').click (function () { return false; });//deshabilitamos los link 
                               // $('.aP4').addClass("a_disabled"); //agregamos la clase deshabilitado
                           }
                       else{ part4.checked=false; };
                         
                     });          
                              
          
          /*----------------Cons P5-----------------------*/
              
                var part5 = document.getElementById("part5");
                 var param5 = new Object();
                     param5["id_ue"] = <%=id_ue%>;
                     var url5="CargaFilasP5"; 
                     $.post(url5,param5,function(listaIdent5){
                        if(listaIdent5.length > 0){  //Si encuentra Algún registro
                            part5.checked=true;
                        }
                        else if(listaIdent5.length === 0){ // Si No encuentra algun registro  deshabilita los INGERESAR  //deshabilitamos los link
                                $('.aP5').click (function () { return false; });//deshabilitamos los link 
                                $('.aP5').addClass("a_disabled"); //agregamos la clase deshabilitado
                           }
                        else{ part5.checked=false; };
                         
                     });
                     
                     
          /*----------------cri vali P6-----------------------*/
              var array2 = []; 
                var part6 = document.getElementById("part6");
                 var param6 = new Object();
                     param6["id_ue"] = <%=id_ue%>;
                     var url6="CargaP6"; 
                     
                     $.post(url6,param6,function(listaIdent6){
                        if(listaIdent6.length > 0){  //Si encuentra Algún registro
                           part6.checked=true;// HASTA Aqui es para marcar como checked el checkbox 6
                               // var elementoP6 = listaIdent6[0];   
                                
                                 var Filas = listaIdent6.length; //Sacamos el Total de Filas 
                              for (var i=0; i<Filas; i++){  // recorremos el array segun el número de filas
                                      var elementoP6 = listaIdent6[i];      
                                 
                                var for_shape =elementoP6.for_shape;
                                var ext_min =elementoP6.ext_min;
                                var est_cor =elementoP6.est_cor;
                                var atrib =elementoP6.atrib;
                                var info_cord =elementoP6.info_cord;
                                var code_total =elementoP6.code_total;
                                
                               if(for_shape==="NO" || ext_min==="NO" || est_cor==="NO" || atrib==="NO" || info_cord==="NO" || code_total==="NO" ){//si cualquiera es un NO...
                                        $('.cri_valid').unbind('click'); //volvemos a habilitar el LINk 
                                        $('.cri_valid').removeClass("a_disabled"); //le agregamos la clase deshabilitado
                                        $(".txt_gray61").css("color","#000");     //ponemos en color negro el texto
                                        $(".backgray61").css("background","#1e63ab");  // ponemos en color azul el fondo del circulo 
                                 }else{}
                              
                                    
                                      
                                     
                                     
             /***************************************************** OPCIÓN 1************************************************/
                              //Object.values(elementoP6);//Sacar los valores del array
                         /*         var  array = Object.values(elementoP6);  //CREO el array con los valores de la lista de objetos de arrriba
                                    var indices = [];     //creo otro array
                                     
                                        var idx = array.indexOf("NO");  // creo una variable que buscara en el array los que tengan un "NO"
                                        while (idx != -1) {      //mientras sea diferente de -1 (o sea que si encuentre algun "NO")...
                                          indices.push(idx);       //le agregamos el elemento encontrado a nuestro nuevo array
                                          idx = array.indexOf("NO", idx + 1);
                                        }
                                       // alert(indices);    */
                                       
         /**************************************************************** OPCIÓN 2*************************************************/   
                                      
                               if(for_shape==="NO"){ array2.push(" El archivo no esta en formato shape");}        
                               if(ext_min==="NO"){ array2.push(" El archivo no contiene las 4 extenciones minimas");}
                               if(est_cor==="NO"){ array2.push(" La estructura del archivo no es correcta");}
                               if(atrib==="NO"){ array2.push(" Atributos sin valores nulos o vacíos");}
                               if(info_cord==="NO"){ array2.push(" La información no esta en coordenadas geográficas");}
                               if(code_total==="NO"){ array2.push(" No coincide con el total de registros entregados");}
                            //alert(array2);
                            document.getElementById("motivos").innerHTML = array2;
                        }
                    }
                        
                        else{ part6.checked=false; };//SI no esncontro ningun registro NO marca el checkbox6
                         
                     });   
                     
                     
                        
          /*----------------devolucion P7-----------------------*/
              
                var part7 = document.getElementById("part7");
                 var param7 = new Object();
                     param7["id_ue"] = <%=id_ue%>;
                     var url7="CargaP7"; 
                     $.post(url7,param7,function(listaIdent7){
                       if(listaIdent7.length > 0){  //Si encuentra Algún registro
                           part7.checked=true;
                       }else{ part7.checked=false; };
                         
                     }); 
                     
                     
          /*----------------enrega OC P8-----------------------*/
              
                var part8 = document.getElementById("part8");
                 var param8 = new Object();
                     param8["id_ue"] = <%=id_ue%>;
                     var url8="CargaP8"; 
                     $.post(url8,param8,function(listaIdent8){
                           if(listaIdent8.length > 0){  //Si encuentra Algún registro
                           part8.checked=true;
                       }else{ part8.checked=false; };
                         
                     });
                     
                     
            /*----------------enrega SSg P9-----------------------*/
              
          /*      var part9 = document.getElementById("part9");
                 var param9 = new Object();
                     param9["id_ue"] = < %=id_ue%>;
                     var url9="CargaP9"; 
                     $.post(url9,param9,function(listaIdent9){
                           if(listaIdent9.length > 0){  //Si encuentra Algún registro
                           part9.checked=true;
                       }else{ part9.checked=false; };
                         
                     });      
                     */
             /*----------------Generacion Curt P10-----------------------*/
              
                var part10 = document.getElementById("part10");
                 var param10 = new Object();
                     param10["id_ue"] = <%=id_ue%>;
                     var url10="CargaFilasP10"; 
                     $.post(url10,param10,function(listaIdent10){
                           if(listaIdent10.length > 0){  //Si encuentra Algún registro
                           part10.checked=true;
                       }else{ part10.checked=false; };
                         
                     });     
                     
                     
                        
             /*----------------Generacion Curt P11-----------------------*/
              
                var part11 = document.getElementById("part11");
                 var param11 = new Object();
                     param11["id_ue"] = <%=id_ue%>;
                     var url11="CargaFilasP11"; 
                     $.post(url11,param11,function(listaIdent11){
                           if(listaIdent11.length > 0){  //Si encuentra Algún registro
                           part11.checked=true;
                       }else{ part11.checked=false; };
                         
                     });           
                     
                     
             /*----------------Dat entrega P12-----------------------*/
              
                var part12 = document.getElementById("part12");
                 var param12 = new Object();
                     param12["id_ue"] = <%=id_ue%>;
                     var url12="CargaFilasP12"; 
                     $.post(url12,param12,function(listaIdent12){
                           if(listaIdent12.length > 0){  //Si encuentra Algún registro
                           part12.checked=true;
                       }else{ part12.checked=false; };
                         
                     });     
                     
                     
              /*----------------Constancia P13-----------------------*/
              
                var part13 = document.getElementById("part13");
                 var param13 = new Object();
                     param13["id_ue"] = <%=id_ue%>;
                     var url13="CargaP13"; 
                     $.post(url13,param13,function(listaIdent13){
                           if(listaIdent13.length > 0){  //Si encuentra Algún registro
                           part13.checked=true;
                       }else{ part13.checked=false; };
                         
                     });             
                
                
           
                         /*  var part1 = document.getElementById("p_inicial");
                           if(< %=Concertacion%>){ part1.checked=true;}   //If concertacion es igual a true
                           else{ part1.checked=false; }; */
                     /*---------PARTE 5--------------*/       
                         /*  var part5 = document.getElementById("part5");
                           if(< %=Entrega_Fis%>){ part5.checked=true;}
                           else{ part5.checked=false; };
                           */
                           
                          /* 
                           var acepto_q = "< %=acepto%>";
                           if(acepto_q ==="NO"){
                                 $('.links_acepto').click (function () { //deshabilitamos los link
                                    return false;                       //deshabilitamos los link
                                 });
                                 
                                 $('.links_acepto').css('background','#f7f7f7');
                                 $('.links_acepto').css('color','#d0d0d0');
                           }else if(acepto_q ==="SI"){
                                $('.links_acepto').click (function () {
                                    return true;           //habilitamos los link
                                 });
                           }*/
             }
             
         </script>
   
     
     <script>   
       $(document).ready(function(){
            carga_informacion_check();
            
            
                         
       });
     </script>
     
     
     
     
       
     </head>
    
    <body>
        
         <%
         String nom_usuario="";
      try{    
         PreparedStatement pst41 =(PreparedStatement) conexion.conn.prepareStatement("select \"NOM_EDO\",\"CVE_EDO\" from seguimiento_cap.cat_edo where \"CVE_EDO\" = '"+sesion_cve_enc+"' ");
         conexion.rs =pst41.executeQuery(); //ejecutamos la consulta
         while(conexion.rs.next()) {//se guarda cada resultado en la variable de opciones
         nom_usuario = conexion.rs.getString("NOM_EDO");
         }
      } catch(SQLException e){out.print("exception"+e);}
              finally {//conexion.closeConnection();
                    }          
     %> 
         
    <div class="menu_bar">
            <a style="cursor:pointer;" class="bt-menu"> 
            <span class="icon-menu3"></span> <img src="images/inegi_vertical.png" width="51" height="31"/></a>
        </div> 
    <header>
        <div id="logo"> <a href="inicio_curt.jsp?nom_user=<%=nom_user%>">  <img id="log-inegi" src="images/logo_blanco_comp.png" alt=""/></a>   </div>
        <div id="nav">
            <ul class="text-left">
                <!--<li><a href="javascript:window.history.back();">&laquo; Regresa una página</a></li>-->
             <a href="inicio_curt.jsp?nom_user=<%=nom_user%>"> <li> Inicio</li></a>
             <a href="javascript:postwith('captura.jsp',{ue:'<%=id_ue%>',nom_user:'<%=nom_user%>'})"> <li>  Captura </li> </a>
             <a href="selecciona_ue.jsp?nom_user=<%=nom_user%>"> <li> Cambiar UE</li></a>
         </ul>
           <ul class="text-right">
              <li><span class="negrita"><%=nom_usuario.toUpperCase()%> <span class="caret icon-chevron-down"> <!--boton --></span></span>
                    <ul class="hijo">    
                        <li class="psw"> <a href="cambiar_psw.jsp?nom_user=<%=nom_user%>"> <span class="icon-engrane"></span> Cambiar contraseña</a></li>
                    </ul>
              </li>
              <li class="cerrar_ses"> <a href="logout_curt.jsp">  <span class="icon-exit"></span> Cerrar Sesión</a></li>
           </ul>
        </div>
    </header>
                    
        <div id="margen-oculto">&nbsp;</div>
        
        
          <div id="Div_Titulo">
              <div id="img_logo"><img src="images/logoSegCap.png" alt=""/></div>
              <div id="txt_titu">
              <span class="text_small">SISTEMA </span> <span class="text_small">PARA EL REGISTRO
                  <br> </span> <span class="TextTitulo">DE CAPACITACIONES CATASTRALES</span>
                    </span><!-- parrafo de titulo-->
              </div>      
           </div>
        
        
        <%! String claves_estado, entidad_encargado, claves_separadas ; %> <!--Variables Globales -->
        
        <%
            //CON ESTA CONSULTA SACAMOS TODOS LOS ESTADOS QUE LE PERTENECEN A LA REGIONAL: sesion_cve_enc
     try{         
            
         PreparedStatement pst23 =(PreparedStatement) conexion.conn.prepareStatement("select \"ENCESTATALES\", \"CVE_ENTIDAD\"  FROM seguimiento_cap.\"Encargados_CURT\" where \"CVE_ENTIDAD\"='"+sesion_cve_enc+"'");
            conexion.rs =pst23.executeQuery(); 
            while(conexion.rs.next()) {
            claves_estado = conexion.rs.getString("ENCESTATALES");
            }
         claves_separadas = claves_estado.replaceAll(",", "','");  
 } catch(SQLException e){out.print("exception"+e);}
              finally {
          // conexion.closeConnection();
       }
  
        %>
     
     
     <%         //nueva conslta para rellenar el listado
                String nombre_ue="";
                String folio_ue="";
                String nom_mun ="";
                String name_edo ="";
                
    try{             
         PreparedStatement pst25 =(PreparedStatement) conexion.conn.prepareStatement( "select T1.\"Id\",T1.\"FOLIO\",T1.\"INSNOMBRE\",T1.\"INSNOMBRECIUDADMPIO\",T1.\"CVE_ENTIDAD\", T1.\"CVE_MUN\",  T2.\"NOM_EDO\" "
         + " FROM  seguimiento_cap.ufg_directori_ufg as T1, seguimiento_cap.cat_edo as T2 "
         + " WHERE T1.\"Id\" = '"+id_ue+"' "
         + " AND T1.\"CVE_ENTIDAD\"  =  T2.\"CVE_EDO\" "
         + " AND T1.\"CVE_ENTIDAD\" In('"+claves_separadas+"') ORDER BY T1.\"INSNOMBRE\" ");
                conexion.rs =pst25.executeQuery(); 
                while(conexion.rs.next()) {
                    nombre_ue= conexion.rs.getString("INSNOMBRE");
                    folio_ue=conexion.rs.getString("FOLIO"); 
                    nom_mun = conexion.rs.getString("INSNOMBRECIUDADMPIO").toLowerCase(); //lo convertimos a minusculas primero 
                   name_edo = conexion.rs.getString("NOM_EDO");
                }
    } catch(SQLException e){out.print("exception"+e);}
    finally {conexion.closeConnection(); } 
                String Nombre_mun2 = nom_mun.substring(0, 1).toUpperCase() + nom_mun.substring(1); // Solo convertimos la primera a mayuscula
                
            
     %>  
       
        <div id="Contenedor_marcoIndice">  
              
            
    <!-- se crea un formulario que se enviara por medio de post y llamara a la funcion validacion antes de enviarse a la pagina indicada en accion-->

    <span class="text_small">  <%=nombre_ue+ " ("+Nombre_mun2+", "+name_edo+")"%><%=id_ue%></span><br><br><br>
        
      <!--<div id="num_ind">1</div>   
      <div id="col3a">Concertación</div>
      <div id="col3b"><input type="checkbox" name="p_inicial" id="p_inicial" disabled="" >     </div>
      <div id="col3c">  <a href="javascript:postwith('curt_p1.jsp',{ue:'<%=id_ue%>'})"> Ingresar </a></div>  <br>  
      -->
  
      
      <div id="num_ind">&#10003;</div>  
      <div id="col3a">Capacitación</div>
      <div id="col3b"><input type="checkbox" name="p_inicial" id="p_inicial" disabled="" >     </div>
      <div id="col3c">  <a href="javascript:postwith('curt_p2.jsp',{ue:'<%=id_ue%>',nom_user:'<%=nom_user%>'})"> Ingresar </a></div> <br> 
      
      <!--<div id="num_ind">3</div> 
      <div id="col3a"> Registro de la Unidad del Estado</div>
      <div id="col3b"><input type="checkbox" name="part3" id="part3" disabled="" >     </div>
      <div id="col3c"> <a href="javascript:postwith('curt_p3.jsp',{ue:'<%=id_ue%>'})" class="lnk_acept aP1"> Ingresar </a> </div> <br> -->
      
      <!--<div id="num_ind">4</div> 
      <div id="col3a"> Asesoría a las Unidades del Estado</div>
      <div id="col3b"><input type="checkbox" name="part4" id="part4" disabled="" >     </div>
      <div id="col3c">  <a href="javascript:postwith('curt_p4.jsp',{ue:'<%=id_ue%>'})" class="lnk_acept aP1" > Ingresar </a>               </div> <br>  --> 
      
      <!--<div id="num_ind">5</div> 
      <div id="col3a"> Datos de la entrega de información al INEGI</div>
      <div id="col3b"><input type="checkbox" name="part5" id="part5" disabled="" >     </div>
      <div id="col3c">  <a href="javascript:postwith('curt_p5.jsp',{ue:'<%=id_ue%>'})" class="lnk_acept aP1 aP2 aP4"> Ingresar </a>                </div> <br> --> 
      
      <!--<div id="num_ind">6</div> 
      <div id="col3a"> Criterios de validación previos a la generación de la CURT</div>
      <div id="col3b"><input type="checkbox" name="part6" id="part6" disabled="" >     </div>
      <div id="col3c">  <a href="javascript:postwith('curt_p6.jsp',{ue:'<%=id_ue%>'})" class="lnk_acept aP1 aP2 aP5"> Ingresar </a>                 </div> <br>--> 
      
  <!-- <div class="div6_1">-->
       <!--<div id="num_ind" >7</div> --><!--class="backgray61"-->
       <!--<div id="col3a" > Datos de devolución a la UE <p id="motivos">--><!--aqui irán los motivos--><!--</p></div> --><!--class="txt_gray61"-->
      <!--<div id="col3b"><input type="checkbox" name="part7" id="part7" disabled="" >     </div>
      <div id="col3c">  <a href="javascript:postwith('curt_p7.jsp',{ue:'<%=id_ue%>'})" class="lnk_acept aP1 aP2 aP6 cri_valid"> Ingresar </a> </div> <br>--> 
<!--   </div>-->
     <!--<div id="num_ind">8</div> 
      <div id="col3a"> Datos de entrega de información a Oficinas Centrales </div>
      <div id="col3b"><input type="checkbox" name="part8" id="part8" disabled="" >     </div>
      <div id="col3c">  <a href="javascript:postwith('curt_p8.jsp',{ue:'<%=id_ue%>'})" class="lnk_acept aP1 aP2 aP7"> Ingresar </a> </div> <br> -->
      
      <!--<div id="num_ind">9</div> 
      <div id="col3a">Datos de entrega a la Subdirección de Soluciones Geomáticas</div>
      <div id="col3b"><input type="checkbox" name="part9" id="part9" disabled="" >     </div>
      <div id="col3c">  <a href="javascript:postwith('curt_p9.jsp',{ue:'< %=id_ue%>'})" class="lnk_acept aP1 aP2"> Ingresar </a> </div> <br> 
      -->
      <!--<div id="num_ind">9</div> 
      <div id="col3a">Generación de la CURT</div>
      <div id="col3b"><input type="checkbox" name="part10" id="part10" disabled="" >     </div>
      <div id="col3c">  <a href="javascript:postwith('curt_p10.jsp',{ue:'<%=id_ue%>'})" class="lnk_acept aP1 aP2 aP5"> Ingresar </a>                 </div> <br> 
      -->
      <!--<div id="num_ind">10</div> 
      <div id="col3a">Actualización de la CURT </div>
      <div id="col3b"><input type="checkbox" name="part11" id="part11" disabled="" >     </div>
      <div id="col3c">  <a href="javascript:postwith('curt_p11.jsp',{ue:'<%=id_ue%>'})" class="lnk_acept aP1 aP2 aP5"> Ingresar </a>                 </div> <br> 
      -->
      <!--<div id="num_ind">11</div> 
      <div id="col3a">Datos de Entrega a la Unidad del Estado </div>
      <div id="col3b"><input type="checkbox" name="part12" id="part12" disabled="" >     </div>
      <div id="col3c">  <a href="javascript:postwith('curt_p12.jsp',{ue:'<%=id_ue%>'})" class="lnk_acept aP1 aP2"> Ingresar </a>                 </div> <br> 
     -->
      <!--<div id="num_ind">12</div> 
      <div id="col3a">Constancia de cobertura </div>
      <div id="col3b"><input type="checkbox" name="part13" id="part13" disabled="" >     </div>
      <div id="col3c">  <a href="javascript:postwith('curt_p13.jsp',{ue:'<%=id_ue%>'})" class="lnk_acept aP1 aP2"> Ingresar </a>                 </div> <br> 
      -->
   

      </div><!-- Contenedor--> 
      
      
      <script src="js/proceso_expReport.js" type="text/javascript"></script>
      
        <div id="loading" style="display: none;" > <img src="images/spinner-loading.gif" alt="" width="50px" height="50px"/> </div> 
        <div id="resultado"> </div>
        <br><br>
      <div id="div_exp">
         <a onclick="javascript:realizaProceso_expR(<%=id_ue%>);">  <img src="images/xls.png" alt="" width="16px" height="16px"/> Exportar reporte</a> 
          
      </div>
      
    
     
      
       <footer>
                    <div id="foot1">
                        Términos de uso | Contacto<br>
                    <span class="text_f_sm"> Derechos Reservados © INEGI</span>
                    </div>
       </footer>
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