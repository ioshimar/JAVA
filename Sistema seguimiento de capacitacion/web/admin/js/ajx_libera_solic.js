/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_libera_solic(){
  var id_ue =document.getElementById("id_ue").value;
 /* var fecha_impart = document.getElementById("fecha_impart").value;    
  var lugar = document.getElementById("lugar").value;
  var responsable =document.getElementById("responsable").value;
  var cantidad_p = document.getElementById("cantidad_p").value;  */
  var valida_num=/^([0-9])*$/;
      
        
  
  //VALIDACIONES
  
              /*   if(!fecha_impart){
                    alert("Ingresa la fecha");
                     setTimeout(function() { document.getElementById('fecha_impart').focus(); }, 10);
                    return false;
                 }
               
                else if(!lugar){
                    alert("Ingresa el lugar");
                    setTimeout(function() { document.getElementById('lugar').focus(); }, 10);
                    return false;
                }
               
              
                
                else{}
                */
              
     
   //TERMINAN VALIDACIONES             
      
         $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
           var dataString = $('#soporte').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "../GrabaLiberaCap",
                    data: dataString,

                    success: function(data) {
                        alert(data);
                        location.href = "solicitudes.jsp";
                         //carga_actualizaP2(id_ue);
                        //******************código para la notificación**************
                        //  $('div#notif').slideDown("swing","linear");
                          //document.getElementById("result").innerHTML = data;
                          
                        
                          /*  if(data==="Error_al_conectar_la_bd"){
                                 $('div#notif').css("background","red"); //cambio el color a rojo
                            }
                            else if(data==="Datos Ingresados correctamente"){
                               $('div#notif').css("background","#00aced");   //cambio a color azul
                            }*/
                        //***************** Termina código notificación *******************
                        
                    }
                });
                  return false;
     
    
    
};