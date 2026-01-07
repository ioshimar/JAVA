/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



function proceso_ActualizaP2(){   //Actualiza Capacitacion
  
  var id_ue = document.getElementById("id_ue").value;
  var nom_user =document.getElementById("nom_user").value;
  var id_cap = document.getElementById("id_cap").value;
  var fecha_impart = document.getElementById("fecha_impart").value;    
  var lugar = document.getElementById("lugar").value;
  var norma_cat = document.getElementById("norma_cat").value;
  var norma_curt = document.getElementById("norma_curt").value;
  var lineamiento = document.getElementById("lineamiento").value;
  var diccionario = document.getElementById("diccionario").value;
  var responsable =document.getElementById("responsable").value;
  var cantidad_p = document.getElementById("cantidad_p").value;  
  var valida_num=/^([0-9])*$/;
      
 //VALIDACIONES
  
                 if(!fecha_impart){
                    alert("Ingresa la fecha");
                     setTimeout(function() { document.getElementById('fecha_impart').focus(); }, 10);
                    return false;
                 }
               
                else if(!lugar){
                    alert("Ingresa el lugar");
                    setTimeout(function() { document.getElementById('lugar').focus(); }, 10);
                    return false;
                }
               
                else if(!responsable){
                        alert("Ingresa el responsable");
                        setTimeout(function() { document.getElementById('responsable').focus(); }, 10);
                        return false;
                }
                
                else if(!cantidad_p){
                        alert("Ingresa la cantidad de personas capacitadas");
                          setTimeout(function() { document.getElementById('cantidad_p').focus(); }, 10);
                        return false;
                 
                }
                
                else  if(!cantidad_p.match(valida_num)){
                      alert("Este campo solo acepta valores númericos");
                          setTimeout(function() { document.getElementById('cantidad_p').focus(); }, 10);
                        return false;
                  }
                
                else{}
   //TERMINAN VALIDACIONES             
      
       
           var dataString = $('#curtp2').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "ActualizaCurtP2",
                    data: dataString,

                    success: function(data) {
                      
                        //alert(data);
                        //location.href = "captura.jsp?ue="+id_ue;
                      //******************código para la notificación**************
                          $('div#notif').slideDown("swing","linear");
                          document.getElementById("result").innerHTML = data;
                        
                            if(data==="Error_al_conectar_la_bd"){
                                 $('div#notif').css("background","red"); //cambio el color a rojo
                            }
                            else if(data==="Datos actualizados correctamente"){
                               $('div#notif').css("background","#3fb85c");   //cambio a color verde
                            }
                            
                       // setTimeout("location.href ='captura.jsp?ue="+id_ue+"' ",2000 );  
                        //***************** Termina código notificación *******************   
                    ResetFormp2();
                    carga_cap(id_ue);    
                       
                    }
                    
                    
                });
                  return false;
     
    
    
};