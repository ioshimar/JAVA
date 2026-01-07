/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_rec_psw(){
  var nom_usuario = document.getElementById("nom_usuario").value;    
  var psw = document.getElementById("psw").value;
  
  
      
        
  
  //VALIDACIONES
  
                 if(!nom_usuario){
                    alert("Ingresa el nombre de usuario");
                    setTimeout(function() { document.getElementById('nom_usuario').focus(); }, 10);
                    return false;
                }
               
                else if(!psw){
                        alert("Ingresa la contraseña");
                        setTimeout(function() { document.getElementById('psw').focus(); }, 10);
                        return false;
                }
                
                
                
                  
                else{}
                
              
     
   //TERMINAN VALIDACIONES             
      
         $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
           var dataString = $('#formu_usuario_psw').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "../RecupAdmin",
                    data: dataString,

                    success: function(data) {
                         $('div#notif').slideDown("swing","linear");
                          //document.getElementById("result").innerHTML = data;
                        
                            if(data==="succes"){
                               $('div#notif').css("background","#00aced");   //cambio a color verde
                               $('div#notif').css("border", "3px solid #71ff38"); //bordes verdes
                               document.getElementById("result").innerHTML = "La contraseña del usuario "+nom_usuario+" ha sido restablecida correctamente";
                            }
                            
                            else if(data==="error"){
                                 $('div#notif').css("background","red"); //cambio el color a rojo
                                  document.getElementById("result").innerHTML = "El Usuario "+nom_usuario+" No existe";
                            }else if(data==="Error_al_conectar_la_bd"){
                                 $('div#notif').css("background","red"); //cambio el color a rojo
                                 document.getElementById("result").innerHTML = data;
                            }
                        //alert(data);
                      //  location.href = "captura.jsp?ue="+id_ue;
                       
                        
                    }
                });
                  return false;
     
    
    
};