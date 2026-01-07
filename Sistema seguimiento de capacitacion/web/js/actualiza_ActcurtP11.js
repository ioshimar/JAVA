/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function proceso_ActualizaP11(){

  var id_ue =document.getElementById("id_ue").value;
  var nom_archivo = document.getElementById("nom_archivo").value;    
  var id_archivo = document.getElementById("id_archivo").value;    
  var nom_respue = document.getElementById("nom_respue").value;
  var fech_ini11 =document.getElementById("fech_ini11").value;
  var fech_ter11  = document.getElementById("fech_ter11").value;
  var con_curt11  = document.getElementById("con_curt11").value;
  var sin_curt11  = document.getElementById("sin_curt11").value;    
  var total_motivo_a  = document.getElementById("total_motivo_a").value;   
  var motivo_a  = document.getElementById("motivo_a").value; 
  
  var valida_num=/^([0-9])*$/;
             
       //Split de las fechas recibidas para separarlas
                    var x  = fech_ini11.split("/");
                    var z = fech_ter11.split("/");  
                    
            //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fech_ini11_compare = x[1] + "/" + x[0] + "/" + x[2];
            var fech_ter11_compare = z[1] + "/"  + z[0] + "/"  + z[2];    
  
  
  
  //VALIDACIONES
  
                 if(!id_archivo){
                    alert("Selecciona un archivo");
                     setTimeout(function() { document.getElementById('id_archivo').focus(); }, 10);
                    return false;
                 }
               
                else if(!nom_respue){
                    alert("Ingresa el nombre del responsable");
                    setTimeout(function() { document.getElementById('nom_respue').focus(); }, 10);
                    return false;
                }
               
                else if(!fech_ini11){
                        alert("Ingresa la fecha de inicio");
                        setTimeout(function() { document.getElementById('fech_ini11').focus(); }, 10);
                        return false;
                }
                
                else if(!fech_ter11){
                        alert("Ingresa la fecha de término");
                          setTimeout(function() { document.getElementById('fech_ter11').focus(); }, 10);
                        return false;
                }
                
                 else  if(Date.parse(fech_ini11_compare) > Date.parse(fech_ter11_compare)){
                                    alert("Las fechas no corresponden, la fecha de término debe ser igual o despúes que la fecha de inicio");
                                    setTimeout(function() { document.getElementById('fech_ter11').focus(); }, 10);
                                           return false;
                            }
                
                
                else if(!con_curt11){
                        alert("Ingresa los predios con CURT");
                          setTimeout(function() { document.getElementById('con_curt11').focus(); }, 10);
                        return false;
                }
                
                 else if(!con_curt11.match(valida_num)){
                        alert("Este campo solo acepta valores númericos y sin espacios");
                          setTimeout(function() { document.getElementById('con_curt11').focus(); }, 10);
                        return false;
                }
                
                else if(!sin_curt11){
                        alert("Ingresa los predios sin CURT");
                          setTimeout(function() { document.getElementById('sin_curt11').focus(); }, 10);
                        return false;
                }
                
                else if(!sin_curt11.match(valida_num)){
                        alert("Este campo solo acepta valores númericos y sin espacios");
                          setTimeout(function() { document.getElementById('sin_curt11').focus(); }, 10);
                        return false;
                }
                
                else if(!total_motivo_a){
                     alert("Ingresa el total de los motivos");
                     setTimeout(function() { document.getElementById('total_motivo_a').focus(); }, 10);
                     return false;
                }
                
                else if(!total_motivo_a.match(valida_num)){
                     alert("Este campo solo acepta valores númericos y sin espacios");
                     setTimeout(function() { document.getElementById('total_motivo_a').focus(); }, 10);
                     return false;
                }
                
                else if(!motivo_a){
                    alert("Ingresa los motivos");
                    setTimeout(function() { document.getElementById('motivo_a').focus(); }, 10);
                    return false;
                }
                
               
                
            
                else{}
                
     
   //TERMINAN VALIDACIONES             
      
       $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
           var dataString = $('#curtp11').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "ActualizaCurtP11",
                    data: dataString,

                    success: function(data) {
                      
                       // alert(data);
                       //location.href = "captura.jsp?ue="+id_ue;
                       $('div#notif').slideDown("swing","linear");
                              document.getElementById("result").innerHTML = data;
                        
                            if(data==="Error_al_conectar_la_bd"){
                               $('div#notif').css("background","red"); //cambio el color a rojo
                            }
                            else if(data==="Datos actualizados correctamente"){
                               $('div#notif').css("background","#3fb85c");   //cambio a color verde
                            } 
                       
                            $("#id_archivo").attr('disabled', true); //mantenemos deshabilitado el select
                            ResetForm11();//resetemaos el formulario con la función
                            carga_resultadosP11(id_ue);       
                       
                    }
                });
                  return false;
     
};
