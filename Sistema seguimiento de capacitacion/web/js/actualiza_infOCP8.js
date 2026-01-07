/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



function proceso_ActualizaP8(){   //Actualiza 
var id_ue =document.getElementById("id_ue").value;
  var fech_ent = document.getElementById("fech_ent").value;    
  var resp_ent = document.getElementById("resp_ent").value;
  var respoc_reci =document.getElementById("respoc_reci").value;

      
 //VALIDACIONES
  
                 if(!fech_ent){
                    alert("Ingresa la fecha");
                     setTimeout(function() { document.getElementById('fech_ent').focus(); }, 10);
                    return false;
                 }
               
                else if(!resp_ent){
                    alert("Ingresa el responsable de la Unidad administrativa que entrega");
                    setTimeout(function() { document.getElementById('resp_ent').focus(); }, 10);
                    return false;
                }
               
                else if(!respoc_reci){
                        alert("Ingresa el responsable de Oficinas centrales que recibe");
                        setTimeout(function() { document.getElementById('name_resp').focus(); }, 10);
                        return false;
                }
                
               else{}
   //TERMINAN VALIDACIONES             
      
       
           var dataString = $('#curtp8').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "ActualizaCurtP8",
                    data: dataString,

                    success: function(data) {
                      
                        alert(data);
                       // location.href = "captura.jsp?ue="+id_ue;
                        cargaP8(id_ue);   //mandamos el Id 
                       
                    }
                });
                  return false;
     
    
    
};