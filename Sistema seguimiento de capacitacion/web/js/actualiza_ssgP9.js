/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_ActualizaP9(){
  var id_ue =document.getElementById("id_ue").value;
  var fech_entssg = document.getElementById("fech_entssg").value;    
  var resp_entssg = document.getElementById("resp_entssg").value;
  var resp_recssg =document.getElementById("resp_recssg").value;
 
      
        
  
  //VALIDACIONES
  
                 if(!fech_entssg){
                    alert("Ingresa la fecha");
                     setTimeout(function() { document.getElementById('fech_entssg').focus(); }, 10);
                    return false;
                 }
               
                else if(!resp_entssg){
                    alert("Ingresa el responsable que entrega la información ");
                    setTimeout(function() { document.getElementById('resp_entssg').focus(); }, 10);
                    return false;
                }
               
                else if(!resp_recssg){
                        alert("Ingresa el responsable de la Subdirección");
                        setTimeout(function() { document.getElementById('resp_recssg').focus(); }, 10);
                        return false;
                }
                
               
                
                else{}
                
              
     
   //TERMINAN VALIDACIONES             
      
       
           var dataString = $('#curtp9').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "ActualizaCurtP9",
                    data: dataString,

                    success: function(data) {
                      
                        alert(data);
                       location.href = "captura.jsp?ue="+id_ue;
                    }
                });
                  return false;
     
    
    
};