/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



function proceso_motivos_gencurt(){
    
  var id_gen = document.getElementById("id_gen").value;
  var id_ue =document.getElementById("id_ue").value;
  var id_entrega= document.getElementById("id_entrega").value;
  var total_motivos = document.getElementsByName("total_motivos");  //los RadioButton
  var motivo = document.getElementsByName("motivo");

  

      
             
            var valor_total = true;    // Para validar los Radio Button
            for(var i=0; i < total_motivos.length; i++) {   //recorremos el array  
                if(total_motivos[i].value=== "") {  //si algun valoe esta vacio...
                   valor_total = false;
                    break;
                }
             }   
             
             var valmotivo = true;    // Para validar los Radio Button
            for(var j=0; j < motivo.length; j++) {   //recorremos el array  
                if(motivo[j].value=== "") {  //si algun valoe esta vacio...
                   valmotivo = false;
                    break;
                }
             }  
             
            
  
  //VALIDACIONES
  
                 if(valor_total === false){
                    alert("Ingresa el total que falta");
                    //setTimeout(function() { $(this).focus(); }, 10);
                    return false;
               }
               
                else if(motivo === false){
                    alert("Ingresa el motivo que falta");
                    //setTimeout(function() { $(this).focus(); }, 10);
                    return false;
               }
               
    
     
   //TERMINAN VALIDACIONES             
      
         $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
           var dataString = $('#form_motivos_gen').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "GrabaMotivosGenC",
                    data: dataString,

                    success: function(data) {
                      
                        alert(data);
                        location.href = "motivos_gencurt.jsp?ue="+id_ue+"&gencurt="+id_gen+"&id_entrega="+id_entrega;
                    }
                });
                  return false;
     
    
    
};