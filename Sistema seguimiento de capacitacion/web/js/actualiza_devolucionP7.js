/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_ActualizaP7(){
  var id_ue =document.getElementById("id_ue").value;
  var fech_dev = document.getElementById("fech_dev").value;    
  var resp_dev = document.getElementById("resp_dev").value;
  var resp_reci =document.getElementById("resp_reci").value;
  var arch_dev = document.getElementById("arch_dev").value;  
  var total_dev = document.getElementById("total_dev").value;  
   var valida_num=/^([0-9])*$/;
      
      
        
  
  //VALIDACIONES
  
                 if(!fech_dev){
                    alert("Ingresa la fecha de la devolución");
                     setTimeout(function() { document.getElementById('fech_dev').focus(); }, 10);
                    return false;
                 }
               
                else if(!resp_dev){
                    alert("Ingresa el responsable  de la devolución");
                    setTimeout(function() { document.getElementById('resp_dev').focus(); }, 10);
                    return false;
                }
               
                else if(!resp_reci){
                        alert("Ingresa el responsable de recibir la información en la UE");
                        setTimeout(function() { document.getElementById('resp_reci').focus(); }, 10);
                        return false;
                }
                
                else if(!arch_dev){
                        alert("Ingresa el nombre del archivo que se devolvió");
                          setTimeout(function() { document.getElementById('arch_dev').focus(); }, 10);
                        return false;
                }
                
                else if(!total_dev){
                        alert("Ingresa el total de registros en el archivo devuelto");
                          setTimeout(function() { document.getElementById('total_dev').focus(); }, 10);
                        return false;
                }
                
                else if(!total_dev.match(valida_num)){
                        alert("Este campo solo acepta valores númericos");
                          setTimeout(function() { document.getElementById('total_dev').focus(); }, 10);
                        return false;
                }
                
                else{}
                
              
     
   //TERMINAN VALIDACIONES             
      
        $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
           var dataString = $('#curtp7').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

             // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "ActualizaCurtP7",
                    data: dataString,

                    success: function(data) {
                      // alert(data);
                      $('div#notif').slideDown("swing","linear");
                          document.getElementById("result").innerHTML = data;
                        
                            if(data==="Error_al_conectar_la_bd"){
                               $('div#notif').css("background","red"); //cambio el color a rojo
                            }
                            else if(data==="Datos actualizados correctamente"){
                               $('div#notif').css("background","#3fb85c");   //cambio a color verde
                            }
                        carga_resultadosP7(id_ue);//Carga Tabla
                        ResetForm7();
                      // location.href = "captura.jsp?ue="+id_ue;
                    }
                });
                  return false;
     
    
    
};