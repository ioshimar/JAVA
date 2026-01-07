/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function ajax_sesion(){
  var estado = document.getElementById("estado").value;
  var  pwd =   document.getElementById("pwd").value;  
  var nom_user = document.getElementById("nom_usuario").value;  
  
  $('.alert_psw').hide();
//VALIDACIONES
  if(!estado) {
        alert("Selecciona un estado");
        //document.getElementById("result").innerHTML ="Selecciona un estado";
        setTimeout(function() { document.getElementById('estado').focus(); }, 10);
        return false;
    }        
   // else if(!pwd){ // si contesto SI... validar lo siguiente...
     //   alert("Ingresa la contraseña");
       // document.getElementById("result").innerHTML ="Ingresa la contraseña";
       // setTimeout(function() { document.getElementById('pwd').focus(); }, 10);
        //return false;
    //}
  //TERMINAN VALIDACIONES    
  
           document.getElementById("result").innerHTML="Procesando...";
      var dataString = $('#form_sesion').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

             //alert('Datos serializados: '+dataString);
                $.ajax({
                    type: "POST",
                    url: "InicioSesion",
                    data: dataString,

                    success: function(respuesta) {
                      //alert(respuesta);
                        $('section#R1').slideDown("swing","linear");
                       
                        if(respuesta=='succes'){
                            window.location.href ="inicio_curt.jsp?nom_user="+nom_user;
                        }
                        else if(respuesta=='error'){
                            //  alert("La contraseña es incorrecta");
                            $("#pwd").addClass("error");
                              document.getElementById("pwd").value = "";
                              document.getElementById("result").innerHTML ="La contraseña es incorrecta";
                              setTimeout(function() { document.getElementById('pwd').focus(); }, 10);
                        }
                    }
                });
                  return false;
};
