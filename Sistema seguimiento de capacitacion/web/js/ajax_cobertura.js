/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



function proceso_cobertura(){
    
  var id_entrega = document.getElementById("id_entrega").value;
  var id_ue =document.getElementById("id_ue").value;
  var municipio = document.getElementsByName("municipio");  //los RadioButton
  var nom_shape = document.getElementsByName("nom_shape");
  var no_reg = document.getElementsByName("no_reg");

  

      
             
            var valor_municipio = true;    // Para validar los Radio Button
            for(var i=0; i < municipio.length; i++) {   //recorremos el array  
                if(municipio[i].value=== "") {  //si algun valoe esta vacio...
                   valor_municipio = false;
                    break;
                }
             }   
             
             var valnom_shape = true;    // Para validar los Radio Button
            for(var j=0; j < nom_shape.length; j++) {   //recorremos el array  
                if(nom_shape[j].value=== "") {  //si algun valoe esta vacio...
                   valnom_shape = false;
                    break;
                }
             }  
             
            var valno_reg= true;    // Para validar los Radio Button
            for(var k=0; k < no_reg.length; k++) {   //recorremos el array  
                if(no_reg[k].value=== "") {  //si algun valoe esta vacio...
                   valno_reg = false;
                    break;
                }
             }  
  
  //VALIDACIONES
  
                 if(valor_municipio === false){
                    alert("Ingresa el nombre del municipio que falta");
                    //setTimeout(function() { $(this).focus(); }, 10);
                    return false;
               }
               
                else if(valnom_shape === false){
                    alert("Ingresa el nombre del shape que falta");
                    //setTimeout(function() { $(this).focus(); }, 10);
                    return false;
               }
               
                else if(valno_reg === false){
                    alert("Ingresa el número de registros que falta");
                    //setTimeout(function() { $(this).focus(); }, 10);
                    return false;
               }
    
     
   //TERMINAN VALIDACIONES             
      
       
           var dataString = $('#form_cober').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "GrabaCobertura",
                    data: dataString,

                    success: function(data) {
                      
                        alert(data);
                        location.href = "cobertura.jsp?ue="+id_ue+"&entrega="+id_entrega;
                    }
                });
                  return false;
     
    
    
};