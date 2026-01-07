/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_guarda_admin(){
  var nombre =document.getElementById("nombre").value;
  var nom_usuario = document.getElementById("nom_usuario").value;    
  var psw = document.getElementById("psw").value;
  var permisos = document.getElementsByName("permisos");
  
  var selec_permisos = false;    // Para validar los Radio Button
            for(var i=0; i < permisos.length; i++) {    
                   var valor_opcion1 = permisos[i].value;  //obtener el valor
                if(permisos[i].checked) {  //validar que se seleccione al menos una
                   selec_permisos = true;
                    break;
                }
             }
      
        
  
  //VALIDACIONES
  
                 if(!nombre){
                    alert("Ingresa el nombre completo");
                     setTimeout(function() { document.getElementById('nombre').focus(); }, 10);
                    return false;
                 }
               
                else if(!nom_usuario){
                    alert("Ingresa el nombre de usuario");
                    setTimeout(function() { document.getElementById('nom_usuario').focus(); }, 10);
                    return false;
                }
               
                else if(!psw){
                        alert("Ingresa la contraseña");
                        setTimeout(function() { document.getElementById('psw').focus(); }, 10);
                        return false;
                }
                
                else if(!selec_permisos){
                        alert("Selecciona una opción");
                          setTimeout(function() { document.getElementById('permiso_lectura').focus(); }, 10);
                        return false;
                 
                }
                
                  
                else{}
                
              
     
   //TERMINAN VALIDACIONES             
      
         $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
           var dataString = $('#formu_usuario').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "../Graba_admin",
                    data: dataString,

                    success: function(data) {
                         $('div#notif').slideDown("swing","linear");
                          document.getElementById("result").innerHTML = data;
                        
                            if(data==="Error_al_conectar_la_bd" || data==="Error este nombre de  usuario ya Existe"){
                                 $('div#notif').css("background","red"); //cambio el color a rojo
                            }
                            else if(data==="Administrador registrado correctamente"){
                               $('div#notif').css("background","#00aced");   //cambio a color verde
                               $('div#notif').css("border", "3px solid #71ff38"); //bordes verdes
                            }
                        //alert(data);
                      //  location.href = "captura.jsp?ue="+id_ue;
                       
                        
                    }
                });
                  return false;
     
    
    
};