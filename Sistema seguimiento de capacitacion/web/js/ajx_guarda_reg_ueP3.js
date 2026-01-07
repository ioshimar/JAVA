/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_guardaP3(){
  var id_ue =document.getElementById("id_ue").value;
  var sol_registro = document.getElementById("sol_registro").value;    
  var envio_doc = document.getElementById("envio_doc").value;
  var val_doc =document.getElementById("val_doc").value;
  var fec_firma = document.getElementById("fec_firma").value;  
  var fec_usu = document.getElementById("fec_usu").value;  
  var fec_rece = document.getElementById("fec_rece").value;  
      
        
  
  //VALIDACIONES
  
                if(!sol_registro){
                    alert("Ingresa la fecha de solicitud de registro");
                     setTimeout(function() { document.getElementById('sol_registro').focus(); }, 10);
                    return false;
                 }
               /*
                else if(!envio_doc){
                    alert("Ingresa la fecha del envio de documentos");
                    setTimeout(function() { document.getElementById('envio_doc').focus(); }, 10);
                    return false;
                }
               
                else if(!val_doc){
                        alert("Ingresa la fecha de validación de documentos");
                        setTimeout(function() { document.getElementById('val_doc').focus(); }, 10);
                        return false;
                }
                
                else if(!fec_firma){
                        alert("Ingresa la fecha del envío de la firma electrónica");
                          setTimeout(function() { document.getElementById('fec_firma').focus(); }, 10);
                        return false;
                }
                
                else if(!fec_usu){
                        alert("Ingresa la fecha del registro de usuarios responsables");
                          setTimeout(function() { document.getElementById('fec_usu').focus(); }, 10);
                        return false;
                }
                
                else if(!fec_rece){
                        alert("Ingresa la fecha de recepción de documentos originales");
                          setTimeout(function() { document.getElementById('fec_rece').focus(); }, 10);
                        return false;
                }
                */
                else{}
                
              
     
   //TERMINAN VALIDACIONES             
      
       
           var dataString = $('#curtp3').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "GrabaCurtP3",
                    data: dataString,

                    success: function(data) {
                      
                        alert(data);
                       location.href = "captura.jsp?ue="+id_ue;
                    }
                });
                  return false;
     
    
    
};