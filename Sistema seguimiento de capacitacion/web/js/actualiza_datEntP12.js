/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_ActualizaP12(){
   var id_ue =document.getElementById("id_ue").value;
  var fecha_ent = document.getElementById("fecha_ent").value;    
  var nom_resp_ent = document.getElementById("nom_resp_ent").value;
  var resp_rec =document.getElementById("resp_rec").value;

  var nom_arch =document.getElementById("nom_arch").value;
  var cant_reg =document.getElementById("cant_reg").value;
  /*var fecha_ent_ue =document.getElementById("fecha_ent_ue").value; 
  
  var nom_resp_dr =document.getElementById("nom_resp_dr").value;  
  var resp_reci_ue =document.getElementById("resp_reci_ue").value; 
  var nom_arch_ue =document.getElementById("nom_arch_ue").value; 
  var cant_reg_ue =document.getElementById("cant_reg_ue").value; 
    */
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
  
  var chk_adr = document.getElementById("chk_adr");
  var chk_aue = document.getElementById("chk_aue");
  //VALIDACIONES
  
  
   if(!selectTipoEntre){
                     alert("Selecciona una opción");
                            setTimeout(function() { document.getElementById('chk_adr').focus(); }, 10);
                            return false;
                }else{}
  
                if(!fecha_ent){
                    alert("Ingresa la fecha");
                     setTimeout(function() { document.getElementById('fecha_ent').focus(); }, 10);
                    return false;
                 }
               
                else if(!nom_resp_ent){
                    alert("Ingresa el nombre del responsable en OC que entrega");
                    setTimeout(function() { document.getElementById('nom_resp_ent').focus(); }, 10);
                    return false;
                }
               
                else if(!resp_rec){
                        alert("Ingresa el nombre del responsable que recibe");
                        setTimeout(function() { document.getElementById('resp_rec').focus(); }, 10);
                        return false;
                }
                
                else if(!nom_arch){
                        alert("Ingresa el nombre del archivo");
                        setTimeout(function() { document.getElementById('nom_arch').focus(); }, 10);
                        return false;
                }
                
                else if(!cant_reg){
                        alert("Ingresa la cantidad de registros");
                        setTimeout(function() { document.getElementById('cant_reg').focus(); }, 10);
                        return false;
                }
                
                  else if(!cant_reg.match(valida_num)){
                          alert("Este campo solo acepta valores númericos");
                        setTimeout(function() { document.getElementById('cant_reg').focus(); }, 10);
                        return false;
                }
           
                
              
     
   //TERMINAN VALIDACIONES               
      
       $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
           var dataString = $('#curtp12').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "ActualizaCurtP12",
                    data: dataString,

                    success: function(data) {
                         $('div#notif').slideDown("swing","linear");
                          document.getElementById("result").innerHTML = data;
                         $('div#notif').fadeOut(5000);
                        
                            if(data==="Error_al_conectar_la_bd"){
                               $('div#notif').css("background","red"); //cambio el color a rojo
                            }
                            else if(data==="Datos actualizados correctamente"){
                               $('div#notif').css("background","#3fb85c");   //cambio a color verde
                                ResetForm12();//resetemaos el formulario con la función
                            }
                        
                        
                          carga_FilasP12(id_ue);
                      
                       // alert(data);
                       
                       //location.href = "captura.jsp?ue="+id_ue;
                    }
                });
                  return false;
     
    
    
};