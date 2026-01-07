/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



function proceso_ActualizaP5(){
  var id_ue =document.getElementById("id_ue5").value;  
  var fecha_dat = document.getElementById("fecha_dat").value;
  var nom_resp =document.getElementById("nom_resp").value;
  var nom_ua = document.getElementById("nom_ua").value;  //los RadioButton
  var resp_estr = document.getElementById("resp_estr").value;
  var medio_udo = document.getElementById("medio_udo").value;
  var nom_arch = document.getElementById("nom_arch").value;
  var tamano = document.getElementById("tamano").value;
  var no_reg = document.getElementById("no_reg").value;
  var pred_con_curt = document.getElementById("pred_con_curt").value;
  var pred_sin_curt = document.getElementById("pred_sin_curt").value;
  var valida_num=/^([0-9])*$/;
  
  
  var tipo_entrega = document.getElementsByName("tipo_entrega");  
        
   /********* Validar que se seleccione al menos un checkbox ********/
  var selectTipoEntre= false;    // Para validar los checkbox
            for(var i=0; i < tipo_entrega.length; i++) {    
                   var valor_Tipo= tipo_entrega[i].value;  //obtener el valor
                if(tipo_entrega[i].checked) {  //validar que se seleccione al menos una
                   selectTipoEntre = true;
                    break;
                }
             }
             
       var entrega_web = document.getElementById("entrega_web") ;    
       var entrega_fis = document.getElementById("entrega_fis") ;        
   
    
   //VALIDACIONES  
        if(!selectTipoEntre){
                     alert("Selecciona una opción");
                            setTimeout(function() { document.getElementById('entrega_web').focus(); }, 10);
                            return false;
                }else{}  



 if(entrega_web.checked){ //solo valida la fecha
        if(!fecha_dat){ /*si esta vacio campo nombre...*/
          alert("Ingresa la fecha");
          setTimeout(function() { document.getElementById('fecha_dat').focus(); }, 10);
          return false;
     }
     else if(!nom_resp){ /*si esta vacio campo nombre...*/
            alert("El nombre del Responsable no puede estar vacio, puedes agregar N/A");
            setTimeout(function() { document.getElementById('nom_resp').focus(); }, 10);
            return false;
       }
   
        else if(!nom_arch){ /*si esta vacio campo nombre...*/
              alert("Ingresa el nombre del archivo");
              setTimeout(function() { document.getElementById('nom_arch').focus(); }, 10);
              return false;
         }
         else if(!tamano){ /*si esta vacio campo nombre...*/
              alert("Ingresa el tamaño del archivo en MB");
              setTimeout(function() { document.getElementById('tamano').focus(); }, 10);
              return false;
         }

         else if(!tamano.match(valida_num)){ /*si esta vacio campo nombre...*/
                alert("Este campo solo acepta valores númericos");
                     setTimeout(function() { document.getElementById('tamano').focus(); }, 10);
                     return false;
         }
          else if(!no_reg){ /*si esta vacio campo nombre...*/
              alert("Ingresa el número de registros");
              setTimeout(function() { document.getElementById('no_reg').focus(); }, 10);
              return false;
         }

         else if(!no_reg.match(valida_num)){ /*si esta vacio campo nombre...*/
              alert("Este campo solo acepta valores númericos");
              setTimeout(function() { document.getElementById('no_reg').focus(); }, 10);
              return false;
        }
        
        else if(!pred_con_curt){ /*si esta vacio campo nombre...*/
              alert("Ingresa los predios con curt");
              setTimeout(function() { document.getElementById('pred_con_curt').focus(); }, 10);
              return false;
         }

         else if(!pred_con_curt.match(valida_num)){ /*si esta vacio campo nombre...*/
              alert("Este campo solo acepta valores númericos");
              setTimeout(function() { document.getElementById('pred_con_curt').focus(); }, 10);
              return false;

          }
          
          else if(!pred_sin_curt){ /*si esta vacio campo nombre...*/
              alert("Ingresa los predios sin curt");
              setTimeout(function() { document.getElementById('pred_sin_curt').focus(); }, 10);
              return false;
         }

         else if(!pred_sin_curt.match(valida_num)){ /*si esta vacio campo nombre...*/
              alert("Este campo solo acepta valores númericos");
              setTimeout(function() { document.getElementById('pred_sin_curt').focus(); }, 10);
              return false;

          }
   
 }
    
else if(entrega_fis.checked){ //valida todo lo demás
   
        if(!fecha_dat){ /*si esta vacio campo nombre...*/
            alert("Ingresa la fecha");
            setTimeout(function() { document.getElementById('fecha_dat').focus(); }, 10);
            return false;
       }

      else if(!nom_resp){ /*si esta vacio campo nombre...*/
            alert("Ingresa el nombre del responsable");
            setTimeout(function() { document.getElementById('nom_resp').focus(); }, 10);
            return false;
       }
       else if(!nom_ua){ /*si esta vacio campo nombre...*/
            alert("Ingresa el nombre de la Unidad administrativa");
            setTimeout(function() { document.getElementById('nom_ua').focus(); }, 10);
            return false;
       }

       else if(!resp_estr){ /*si esta vacio campo nombre...*/
            alert("Ingresa el nombre del responsable que recibe la información");
            setTimeout(function() { document.getElementById('resp_estr').focus(); }, 10);
            return false;
       }
       else if(!medio_udo){ /*si esta vacio campo nombre...*/
            alert("Ingresa el nombre del medio utilizado para la entrega");
            setTimeout(function() { document.getElementById('medio_udo').focus(); }, 10);
            return false;
       }
       else if(!nom_arch){ /*si esta vacio campo nombre...*/
            alert("Ingresa el nombre del archivo");
            setTimeout(function() { document.getElementById('nom_arch').focus(); }, 10);
            return false;
       }
       else if(!tamano){ /*si esta vacio campo nombre...*/
            alert("Ingresa el tamaño del archivo en MB");
            setTimeout(function() { document.getElementById('tamano').focus(); }, 10);
            return false;
       }
       else if(!tamano.match(valida_num)){ /*si esta vacio campo nombre...*/
              alert("Este campo solo acepta valores númericos");
                   setTimeout(function() { document.getElementById('tamano').focus(); }, 10);
                   return false;
       }
        else if(!no_reg){ /*si esta vacio campo nombre...*/
            alert("Ingresa el número de registros");
            setTimeout(function() { document.getElementById('no_reg').focus(); }, 10);
            return false;
       }

       else if(!no_reg.match(valida_num)){ /*si esta vacio campo nombre...*/
            alert("Este campo solo acepta valores númericos");
            setTimeout(function() { document.getElementById('no_reg').focus(); }, 10);
            return false;
       }
       
       else if(!pred_con_curt){ /*si esta vacio campo nombre...*/
              alert("Ingresa los predios con curt");
              setTimeout(function() { document.getElementById('pred_con_curt').focus(); }, 10);
              return false;
         }

         else if(!pred_con_curt.match(valida_num)){ /*si esta vacio campo nombre...*/
              alert("Este campo solo acepta valores númericos");
              setTimeout(function() { document.getElementById('pred_con_curt').focus(); }, 10);
              return false;

          }
          
          else if(!pred_sin_curt){ /*si esta vacio campo nombre...*/
              alert("Ingresa los predios sin curt");
              setTimeout(function() { document.getElementById('pred_sin_curt').focus(); }, 10);
              return false;
         }

         else if(!pred_sin_curt.match(valida_num)){ /*si esta vacio campo nombre...*/
              alert("Este campo solo acepta valores númericos");
              setTimeout(function() { document.getElementById('pred_sin_curt').focus(); }, 10);
              return false;

          }
}   
     
   //TERMINAN VALIDACIONES             
      
          $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
           var dataString = $('#form_entregaP5').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "ActualizaEntregaFisica",
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
                    ResetForm();
                    carga(id_ue);
                         // alert(data);
                        //location.href = "curt_p5.jsp?ue="+id_ue;
                       
                    }
                });
                  return false;
     
    
    
};