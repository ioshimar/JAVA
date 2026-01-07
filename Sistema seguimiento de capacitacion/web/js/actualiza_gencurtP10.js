/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function proceso_ActualizaP10(){
  var id_ue =document.getElementById("id_ue").value;
 var id_archivo = document.getElementById("id_archivo").value; 
  var nom_archivo = document.getElementById("nom_archivo").value;    
  var nom_respgen = document.getElementById("nom_respgen").value;
  var fech_ini10 =document.getElementById("fech_ini10").value;
  var fech_ter10  = document.getElementById("fech_ter10").value;
  var con_curt  = document.getElementById("con_curt").value;
  var sin_curt  = document.getElementById("sin_curt").value;    
//  var total_motivo  = document.getElementById("total_motivo").value;   
 // var motivo  = document.getElementById("motivo").value;   
   var valida_num=/^([0-9])*$/;
  
             
   //Split de las fechas recibidas para separarlas
                    var x  = fech_ini10.split("/");
                    var z = fech_ter10.split("/");  
                    
            //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fech_ini10_compare = x[1] + "/" + x[0] + "/" + x[2];
            var fech_ter10_compare = z[1] + "/"  + z[0] + "/"  + z[2];    
 
  //VALIDACIONES
  
                 if(!id_archivo){
                    alert("Selecciona un archivo");
                     setTimeout(function() { document.getElementById('id_archivo').focus(); }, 10);
                    return false;
                 }
               
                else if(!nom_respgen){
                    alert("Ingresa el nombre del responsable");
                    setTimeout(function() { document.getElementById('nom_respgen').focus(); }, 10);
                    return false;
                }
               
                else if(!fech_ini10){
                        alert("Ingresa la fecha de inicio");
                        setTimeout(function() { document.getElementById('fech_ini10').focus(); }, 10);
                        return false;
                }
                
                else if(!fech_ter10){
                        alert("Ingresa la fecha de término");
                          setTimeout(function() { document.getElementById('fech_ter10').focus(); }, 10);
                        return false;
                }
                
                else  if(Date.parse(fech_ini10_compare) > Date.parse(fech_ter10_compare)){
                                    alert("Las fechas no corresponden, la fecha de término debe ser igual o despúes que la fecha de inicio");
                                    setTimeout(function() { document.getElementById('fech_ter10').focus(); }, 10);
                                           return false;
                            }
                
                else if(!con_curt){
                        alert("Ingresa los predios con CURT");
                          setTimeout(function() { document.getElementById('con_curt').focus(); }, 10);
                        return false;
                }
                
                 else if(!con_curt.match(valida_num)){
                        alert("Este campo solo acepta valores númericos");
                          setTimeout(function() { document.getElementById('con_curt').focus(); }, 10);
                        return false;
                }
                
                else if(!sin_curt){
                        alert("Ingresa los predios sin CURT");
                          setTimeout(function() { document.getElementById('sin_curt').focus(); }, 10);
                        return false;
                }
                 else if(!sin_curt.match(valida_num)){
                        alert("Este campo solo acepta valores númericos");
                        setTimeout(function() { document.getElementById('sin_curt').focus(); }, 10);
                        return false;
                }
                
                
          /*      else if(!total_motivo){
                     alert("Ingresa el total de los motivos");
                     setTimeout(function() { document.getElementById('total_motivo').focus(); }, 10);
                     return false;
                }
                
                 else if(!total_motivo.match(valida_num)){
                    alert("Este campo solo acepta valores númericos");
                     setTimeout(function() { document.getElementById('total_motivo').focus(); }, 10);
                     return false;
                }
                
                else if(!motivo){
                    alert("Ingresa los motivos");
                    setTimeout(function() { document.getElementById('motivo').focus(); }, 10);
                    return false;
                }
                */
               
                
            
                else{}
                
              
              
     
   //TERMINAN VALIDACIONES             
      
       $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
           var dataString = $('#curtp10').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "ActualizaCurtP10",
                    data: dataString,

                    success: function(data) {
                       $('div#notif').slideDown("swing","linear");
                          document.getElementById("result").innerHTML = data;
                        
                            if(data==="Error_al_conectar_la_bd"){
                               $('div#notif').css("background","red"); //cambio el color a rojo
                            }
                            else if(data==="Datos actualizados correctamente"){
                               $('div#notif').css("background","#3fb85c");   //cambio a color verde
                            }
                     
                $("#id_archivo").attr('disabled', true); //mantenemos deshabilitado el select
                ResetForm10();//resetemaos el formulario con la función
                carga_resultadosP10(id_ue);      
                
                  // alert(data);
                       //location.href = "captura.jsp?ue="+id_ue;
                       
                    }
                });
                  return false;
     
};
