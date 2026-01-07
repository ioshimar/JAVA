/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_DeleteFile(){
  
  var id_ue = document.getElementById("id_ue").value;    
 
 
  
  //VALIDACIONES
  var r = confirm(" ¿ Estas seguro que deseas ELIMINAR el archivo ?");
               if (r === false) {
                  return false;
               } 
               else {
                     
                   }
              
           
              
     //TERMINAN VALIDACIONES  
    
   
  
        $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
         var dataString = $('#form_delete').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

           // alert('Datos serializados: '+datos);

                $.ajax({
                    type: "POST",
                    url: "DeleteArchivo",
                    data: dataString,
                   
                  
                    success: function(data) {
                      
                        alert(data);
                      // location.href = "captura.jsp?ue="+id_ue;
                       postwith('curt_p1.jsp',{ue:id_ue}); //mandamos la URL
                    }
                });
                  return false;
     
    
    
};