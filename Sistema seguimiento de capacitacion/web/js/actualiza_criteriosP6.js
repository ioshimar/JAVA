/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_ActualizaP6(){
  var id_ue =document.getElementById("id_ue").value;
  var resp_val = document.getElementById("resp_val").value;    
  var fech_ini6 = document.getElementById("fech_ini6").value;
  var fech_ter6 =document.getElementById("fech_ter6").value;
  var f_shape  = document.getElementsByName("f_shape");
  var extension  = document.getElementsByName("extension");
  var estruc  = document.getElementsByName("estruc");    
  var atrib  = document.getElementsByName("atrib");   
  var coord_geo  = document.getElementsByName("coord_geo");   
  var total_reg  = document.getElementsByName("total_reg");  
  
     //Split de las fechas recibidas para separarlas
                    var x  = fech_ini6.split("/");
                    var z = fech_ter6.split("/");  
                    
            //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fech_ini6_compare = x[1] + "/" + x[0] + "/" + x[2];
            var fech_ter6_compare = z[1] + "/"  + z[0] + "/"  + z[2];      
  
   var selec_shape = false;    // Para validar los Radio Button
            for(var i=0; i < f_shape.length; i++) {    
                   var valor_opcion1 = f_shape[i].value;  //obtener el valor
                if(f_shape[i].checked) {  //validar que se seleccione al menos una
                   selec_shape = true;
                    break;
                }
             }
             
    var selec_exten = false;    // Para validar los Radio Button
            for(var i=0; i < extension.length; i++) {    
                   var valor_opcion2 = extension[i].value;  //obtener el valor
                if(extension[i].checked) {  //validar que se seleccione al menos una
                   selec_exten = true;
                    break;
                }
             }  
             
    var selec_estruc = false;    // Para validar los Radio Button
            for(var i=0; i < estruc.length; i++) {    
                   var valor_opcion3 = estruc[i].value;  //obtener el valor
                if(estruc[i].checked) {  //validar que se seleccione al menos una
                   selec_estruc = true;
                    break;
                }
             }    
             
     var selec_atributo = false;    // Para validar los Radio Button
            for(var i=0; i < atrib.length; i++) {    
                   var valor_opcion4 = atrib[i].value;  //obtener el valor
                if(atrib[i].checked) {  //validar que se seleccione al menos una
                   selec_atributo = true;
                    break;
                }
             } 
             
             
      var selec_coord = false;    // Para validar los Radio Button
            for(var i=0; i < coord_geo.length; i++) {    
                   var valor_opcion5 = coord_geo[i].value;  //obtener el valor
                if(coord_geo[i].checked) {  //validar que se seleccione al menos una
                   selec_coord = true;
                    break;
                }
             }
             
       var selec_total = false;    // Para validar los Radio Button
            for(var i=0; i < total_reg.length; i++) {    
                   var valor_opcion6 = total_reg[i].value;  //obtener el valor
                if(total_reg[i].checked) {  //validar que se seleccione al menos una
                   selec_total = true;
                    break;
                }
             }       
  
  
  
  
  //VALIDACIONES
  
                 if(!resp_val){
                    alert("Ingresa el responsable de aplicar la validación");
                     setTimeout(function() { document.getElementById('resp_val').focus(); }, 10);
                    return false;
                 }
               
                else if(!fech_ini6){
                    alert("Ingresa la fecha de inicio");
                    setTimeout(function() { document.getElementById('fech_ini6').focus(); }, 10);
                    return false;
                }
               
                else if(!fech_ter6){
                        alert("Ingresa la fecha de Término");
                        setTimeout(function() { document.getElementById('fech_ter6').focus(); }, 10);
                        return false;
                }
                
                else if(Date.parse(fech_ini6_compare) > Date.parse(fech_ter6_compare)){
                        alert("Las fechas no corresponden, la fecha de término debe ser despúes que la fecha de inicio");
                        setTimeout(function() { document.getElementById('fech_ter6').focus(); }, 10);
                        return false;
                                } 
                
                else if(!selec_shape){
                        alert("¿el archivo esta en formato shape?, selecciona una opción,");
                          setTimeout(function() { document.getElementById('f_shapeSi').focus(); }, 10);
                        return false;
                }
                else{}
                
                
           if(valor_opcion1==="SI"){ 
                
                if(!selec_exten){
                        alert("¿Contiene las 4 extensiones mínimas?, selecciona una opción");
                          setTimeout(function() { document.getElementById('extensionSi').focus(); }, 10);
                        return false;
                }
                
                else if(!selec_estruc){
                        alert("¿La estructura del archivo es correcta?, selecciona una opción");
                          setTimeout(function() { document.getElementById('estrucSi').focus(); }, 10);
                        return false;
                }
                
                else if(!selec_atributo){
                     alert("¿Atributos?, selecciona una opción");
                     setTimeout(function() { document.getElementById('atribSi').focus(); }, 10);
                     return false;
                }
                
                else if(!selec_coord){
                    alert("¿La información está en coordenadas geográficas?, selecciona una opción");
                    setTimeout(function() { document.getElementById('coord_geoSi').focus(); }, 10);
                    return false;
                }
                
                else if(!selec_total){
                    alert("¿Coincide con el total de registros?, selecciona una opción");
                    setTimeout(function() { document.getElementById('total_regSi').focus(); }, 10);
                    return false;
                }
            }  
            
                else{}
                
            
     
   //TERMINAN VALIDACIONES     
       
           var dataString = $('#curtp6').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "ActualizaCurtP6",
                    data: dataString,

                    success: function(data) {
                         carga_resultadosP6(id_ue);
                         ResetForm6();
                         $('div#notif').slideDown("swing","linear");
                         document.getElementById("result").innerHTML = data;
                         
                          if(data==="Error_ya_se_ha_guardado_este_registro_en_la_bd_seleccione_otro_archivo" || data==="Error_al_conectar_la_bd"){
                               $('div#notif').css("background","red"); //cambio el color a rojo
                            }
                            else if(data==="Datos actualizados correctamente"){
                               $('div#notif').css("background","#3fb85c"); 
                            }
                        //alert(data);
                      // location.href = "captura.jsp?ue="+id_ue;
                    }
                });
                  return false;
     
    
    
};