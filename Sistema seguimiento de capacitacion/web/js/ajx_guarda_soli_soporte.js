/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_guarda_solicitud(){
  var id_ue =document.getElementById("id_ue").value;
  var tipo_solicitud = document.getElementById("tipo_solicitud").value;    
  var nombre_soli = document.getElementById("nombre_soli").value;
  var correo =document.getElementById("correo").value;
  var mensaje = document.getElementById("mensaje").value;  
  var valida_num=/^([0-9])*$/;
      
  var expRegEmail=/^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})*$/ ; /*validar Email*/      
  
  //VALIDACIONES
  
                 if(!nombre_soli){
                    alert("Ingresa el nombre");
                     setTimeout(function() { document.getElementById('nombre_soli').focus(); }, 10);
                    return false;
                 }
               
                else if(!correo){
                    alert("Ingresa el correo");
                    setTimeout(function() { document.getElementById('correo').focus(); }, 10);
                    return false;
                }
                
                else if((!document.getElementById("correo").value.match(expRegEmail))) {
                    alert("El correo no es válido, Ejemplo: nombre@dominio.com");
                    setTimeout(function() { document.getElementById('correo').focus(); }, 10);
                    return false;
                }
                
                  else if(!mensaje){
                    alert("El campo mensaje no puede estar vacío");
                    setTimeout(function() { document.getElementById('mensaje').focus(); }, 10);
                    return false;
                }
               
                else if(mensaje.length > 199){
                          alert("El campo mensaje sólo acepta como máximo 200 carácteres");
                          setTimeout(function() { document.getElementById('mensaje').focus(); }, 10);
                          return false;
                }
                
                
                
                else{}
                
              
     
   //TERMINAN VALIDACIONES             
      
         $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
           var dataString = $('#form_contacto').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "GrabaSolicitudSop",
                    data: dataString,

                    success: function(data) {
                        alert(data);
                        location.href = "curt_p2.jsp?ue="+id_ue;
                     }
                });
                  return false;
     
    
    
};