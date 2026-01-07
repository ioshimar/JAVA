/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_guardap1(){
  
  var id_ue = document.getElementById("id_ue").value;    
  var name_ue = document.getElementById("name_ue").value;
  var fecha_ofic =document.getElementById("fecha_ofic").value;
  var fecha_resp = document.getElementById("fecha_resp").value;  
  var fecha_ofic2 = document.getElementById("fecha_ofic2").value;
  var fecha_resp2 = document.getElementById("fecha_resp2").value;
  var fecha_ofic3 = document.getElementById("fecha_ofic3").value;
  var fecha_resp3 = document.getElementById("fecha_resp3").value;
  var acepto = document.getElementsByName("acepto");
  var que_acepto = document.getElementsByName("que_acepto");
  var motivo = document.getElementById("motivo").value;
  var first_resp = document.getElementById("first_resp");
  var second_resp = document.getElementById("second_resp");
  var third_resp = document.getElementById("third_resp");
  
   var sin_fechas1 = document.getElementById("sin_fechas1");  
   var sin_fechas2 = document.getElementById("sin_fechas2");  //modificado 19 julio 2018
   var sin_fechas3 = document.getElementById("sin_fechas3");  //modificado 19 julio 2018
   
   
   var nom_destinatario = document.getElementById("nom_destinatario").value;
   var nom_remitente = document.getElementById("nom_remitente").value;
   
   var nom_destinatario2 = document.getElementById("nom_destinatario2").value;
   var nom_remitente2 = document.getElementById("nom_remitente2").value;
   
   var nom_destinatario3 = document.getElementById("nom_destinatario3").value;
   var nom_remitente3 = document.getElementById("nom_remitente3").value;
   
   var concerta = document.getElementById("concerta");
   var observaciones = document.getElementById("observaciones").value;
   
   //alert(observaciones.length);
   
 /*  var file_oficio1 = document.getElementById("file_oficio1").value;
   var file_resp1 = document.getElementById("file_resp1").value;
   var file_oficio2 = document.getElementById("file_oficio2").value;
   var file_resp2 = document.getElementById("file_resp2").value;
   var file_oficio3 = document.getElementById("file_oficio3").value;
   var file_resp3 = document.getElementById("file_resp3").value;*/
      
             
         var seleccionado = false;    // Para validar los Radio Button
            for(var i=0; i < acepto.length; i++) {    
                   var valor_opcion = acepto[i].value;  //obtener el valor
                if(acepto[i].checked) {  //validar que se seleccione al menos una
                   seleccionado = true;
                    break;
                }
             }
             
        var selectQueAcepto = false;    // Para validar los Radio Button
            for(var i=0; i < que_acepto.length; i++) {    
                   var valor_que_acepto= que_acepto[i].value;  //obtener el valor
                if(que_acepto[i].checked) {  //validar que se seleccione al menos una
                   selectQueAcepto = true;
                    break;
                }
             }     
             
              //Split de las fechas recibidas para separarlas
                    var x  = fecha_ofic.split("/");
                    var z = fecha_resp.split("/");  
                    
            //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fecha_ofic_compare = x[1] + "/" + x[0] + "/" + x[2];
            var fecha_resp_compare = z[1] + "/"  + z[0] + "/"  + z[2];      
            
            //Split de las fechas recibidas para separarlas
                    var m  = fecha_ofic2.split("/");
                    var n = fecha_resp2.split("/");  
                    
            //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fecha_ofic_compare2 = m[1] + "/" + m[0] + "/" + m[2];
            var fecha_resp_compare2 = n[1] + "/"  + n[0] + "/"  + n[2];     
            
            
            //Split de las fechas recibidas para separarlas
                    var r  = fecha_ofic3.split("/");
                    var q = fecha_resp3.split("/");  
                    
            //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fecha_ofic_compare3 = r[1] + "/" + r[0] + "/" + r[2];
            var fecha_resp_compare3 = q[1] + "/"  + q[0] + "/"  + q[2];     
  
  //VALIDACIONES
  
  
    if(concerta.checked){} //Si esta marcado este check no valida nada
        else{ //Si NO esta marcado valida...
  
                 if(!name_ue){
                    alert("Ingresa el nombre de la Unidad del Estado");
                     setTimeout(function() { document.getElementById('name_ue').focus(); }, 10);
                    return false;
                 }
               
              if(!sin_fechas1.checked){
                        if(!nom_destinatario){
                            alert("Ingresa El nombre del destinatario (1er oficio)");
                            setTimeout(function() { document.getElementById('nom_destinatario').focus(); }, 10);
                            return false;
                        }
                        else if(!nom_remitente){
                            alert("Ingresa El nombre del remitente (1er oficio)");
                            setTimeout(function() { document.getElementById('nom_remitente').focus(); }, 10);
                            return false;
                        }

                        else if(!fecha_ofic){
                            alert("Ingresa la fecha del primer oficio enviado");
                            setTimeout(function() { document.getElementById('fecha_ofic').focus(); }, 10);
                            return false;
                        }
                     /*   else if(!file_oficio1){
                            alert("Selecciona el archivo del 1er oficio enviado");
                            setTimeout(function() { document.getElementById('file_oficio1').focus(); }, 10);
                            return false;
                        }*/
                        
                        else{}

                         if(!first_resp.checked){ //Si no esta marcado el check de la primer Sin respuesta
                                if(!fecha_resp){
                                    alert("Ingresa la fecha de Respuesta  del 1er oficio");
                                   setTimeout(function() { document.getElementById('fecha_resp').focus(); }, 10);
                                    return false;
                                } else {}
                                
                                if(Date.parse(fecha_ofic_compare) > Date.parse(fecha_resp_compare)){
                                    alert("Las fechas no corresponden, la fecha de recepción debe ser igual o despúes que la fecha de envío");
                                    setTimeout(function() { document.getElementById('fecha_resp').focus(); }, 10);
                                           return false;
                                } 
                              /*  else if(!file_resp1){
                                     alert("Selecciona el archivo del 1er oficio de respuesta");
                                     setTimeout(function() { document.getElementById('file_resp1').focus(); }, 10);
                                     return false;
                                }*/
                                else{}
                                
                        }else{}

                        if(first_resp.checked && !sin_fechas2.checked){
                             if(!nom_destinatario2){
                                alert("Ingresa El nombre del destinatario (2do oficio)");
                                setTimeout(function() { document.getElementById('nom_destinatario2').focus(); }, 10);
                                return false;
                            }
                            else if(!nom_remitente2){
                                alert("Ingresa El nombre del remitente (2do oficio)");
                                setTimeout(function() { document.getElementById('nom_remitente2').focus(); }, 10);
                                return false;
                            }
                            
                           else if(!fecha_ofic2){
                                 alert("Ingresa la fecha del 2do oficio enviado");
                                  setTimeout(function() { document.getElementById('fecha_ofic2').focus(); }, 10);
                                return false;
                            }
                            /*else if(!file_oficio2){
                                 alert("Selecciona el archivo del 2do oficio enviado");
                                 setTimeout(function() { document.getElementById('file_oficio2').focus(); }, 10);
                                return false;
                            }*/
                            else if(!second_resp.checked){  //SI el segundo Checkbox NO esta marcado...
                                  if(!fecha_resp2){ //y el campo fecha respuesta2 esta vacio...
                                      alert("Ingresa la fecha de Respuesta del 2do oficio");
                                      setTimeout(function() { document.getElementById('fecha_resp2').focus(); }, 10);
                                      return false;
                                  }
                                /*  else if(!file_resp2){  //el archvio recibido 2
                                      alert("Selecciona el archivo del 2do oficio recibido");
                                      setTimeout(function() { document.getElementById('file_resp2').focus(); }, 10);
                                      return false;
                                  }*/
                                 
                             }
                              
                            else  if(Date.parse(fecha_ofic_compare2) > Date.parse(fecha_resp_compare2)){
                                    alert("Las fechas no corresponden, la fecha de recepción debe ser igual o despúes que la fecha de envío");
                                    setTimeout(function() { document.getElementById('fecha_resp2').focus(); }, 10);
                                           return false;
                            }
                            
                            
                             
                            else{}
                        }else{}
                        
                       if(second_resp.checked && !sin_fechas3.checked){ //Si Sin fechas 3 no esta marcado (el checkbox)
                           if(!nom_destinatario3){
                                alert("Ingresa El nombre del destinatario (3er oficio)");
                                setTimeout(function() { document.getElementById('nom_destinatario3').focus(); }, 10);
                                return false;
                            }
                            else if(!nom_remitente3){
                                alert("Ingresa El nombre del remitente (3er oficio)");
                                setTimeout(function() { document.getElementById('nom_remitente3').focus(); }, 10);
                                return false;
                            }
                           
                           else if(!fecha_ofic3){
                                 alert("Ingresa la fecha del 3er oficio enviado");
                                 setTimeout(function() { document.getElementById('fecha_ofic3').focus(); }, 10);
                                 return false;
                            }
                            
                         /*  else if(!file_oficio3){
                                alert("Selecciona el archivo del 3er oficio enviado");
                                setTimeout(function() { document.getElementById('file_oficio3').focus(); }, 10);
                                return false;
                            }*/
                            else if(!third_resp.checked){  //SI el campo fecha respuesta3 esta vacio y el tercer Checkbox NO esta marcado...
                                    if(!fecha_resp3){
                                        alert("Ingresa la fecha de Respuesta del 3er oficio");
                                        setTimeout(function() { document.getElementById('fecha_resp3').focus(); }, 10);
                                        return false;
                                    }
                                /*    else if(!file_resp3){  //el archvio recibido 2
                                          alert("Selecciona el archivo del 3er oficio recibido");
                                          setTimeout(function() { document.getElementById('file_resp3').focus(); }, 10);
                                          return false;
                                      }*/
                            }
                            
                            else if(Date.parse(fecha_ofic_compare3) > Date.parse(fecha_resp_compare3)){
                                    alert("Las fechas no corresponden, la fecha de recepción debe ser igual o despúes que la fecha de envío");
                                    setTimeout(function() { document.getElementById('fecha_resp3').focus(); }, 10);
                                           return false;
                            }
                            
                         
                           else{}
                        }else{}
                        
                       
                        
                     //else{}
                
                }else{}
                
            
            if(first_resp.checked && second_resp.checked  &&  third_resp.checked || sin_fechas1.checked || sin_fechas2.checked || sin_fechas3.checked){
                     //Si el primer y segundo y tercer SIN respuesta estan marcados, ó sin_fechas1 ó sin_fechas2 ó sin_fechas3
                    //SI estan marcados aqui termina la validación
            }    
            else{  //Si No estan marcados, validar esto...
                    if(!seleccionado) { //SI no esta seleccionada ninguna opcion...
                       alert("¿Aceptó?, selecciona una Opción");
                       setTimeout(function() { document.getElementById('acepto_si').focus(); }, 10);
                       return false;

                    }
                    else{
                        if(valor_opcion ==="SI"){
                            if(!selectQueAcepto){
                                alert("¿Qué aceptó?, selecciona una Opción");
                                setTimeout(function() { document.getElementById('gen_curt').focus(); }, 10);
                                return false;
                            }else{}
                        }
                        else if(valor_opcion=== "NO"){
                            if(!motivo){
                                alert("Ingresa el motivo por el cúal no se aceptó");
                                setTimeout(function() { document.getElementById('motivo').focus(); }, 10);
                                return false;
                            }else{}
                        }

                    }
            } 
            
             if(observaciones.length > 498){
                             alert("El campo observaciones sólo acepta como máximo 500 carácteres");
                                    setTimeout(function() { document.getElementById('observaciones').focus(); }, 10);
                                           return false;
                            
                        }else{}
            
        }         
     //TERMINAN VALIDACIONES  
    
   
  
 
      
        $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
          var dataString = $('#curtp1').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

           // alert('Datos serializados: '+datos);

                $.ajax({
                    type: "POST",
                    url: "GrabaCurtP1",
                    data: dataString,
                   
                  
                    success: function(data) {
                        carga_actualizaP1(id_ue);
                        cargaTablaP1(id_ue);
                        
                          $('div#notif').slideDown("swing","linear");
                          document.getElementById("result").innerHTML = data;
                        
                            if(data==="Error_al_conectar_la_bd"){
                                 $('div#notif').css("background","red"); //cambio el color a rojo
                            }
                            else if(data==="Datos Ingresados correctamente"){
                               $('div#notif').css("background","#00aced");   //cambio a color verde
                               $('div#notif').css("border", "3px solid #71ff38"); //bordes verdes
                            }
                        
                      // alert(data);
                      // location.href = "captura.jsp?ue="+id_ue;
                      // postwith('captura.jsp',{ue:id_ue}); //mandamos la URL
                    
                    
                    }
                });
                  return false;
     
    
    
};
//REFERENCIAS...
// https://desarrolloweb.com/articulos/upload-archivos-ajax-jquery.html
//https://www.mkyong.com/jquery/jquery-ajax-submit-a-multipart-form/
//https://stackoverflow.com/questions/2422468/how-to-upload-files-to-server-using-jsp-servlet