/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_guardaP13(){
  var id_ue =document.getElementById("id_ue").value;  
  var fech_soli =document.getElementById("fech_soli").value;
  var fech_emi = document.getElementById("fech_emi").value;    
  var folio = document.getElementById("folio").value;
      
        
        
         //Split de las fechas recibidas para separarlas
                    var x  = fech_soli.split("/");
                    var z = fech_emi.split("/");  
                    
            //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fech_soli_compare = x[1] + "/" + x[0] + "/" + x[2];
            var fech_emi_compare = z[1] + "/"  + z[0] + "/"  + z[2];  
  
  //VALIDACIONES
  
                 if(!fech_soli){
                    alert("Ingresa la fecha de solicitud");
                     setTimeout(function() { document.getElementById('fech_soli').focus(); }, 10);
                    return false;
                 }
               
                else if(!fech_emi){
                    alert("Ingresa la fecha de emisión");
                    setTimeout(function() { document.getElementById('fech_emi').focus(); }, 10);
                    return false;
                }
                
                
                 else if(Date.parse(fech_soli_compare) > Date.parse(fech_emi_compare)){
                                    alert("Las fechas no corresponden, la fecha de emisión debe ser igual o despúes que la fecha de solicitud");
                                    setTimeout(function() { document.getElementById('fech_emi').focus(); }, 10);
                                           return false;
                                } 
               
                else if(!folio){
                        alert("Ingresa el folio");
                        setTimeout(function() { document.getElementById('folio').focus(); }, 10);
                        return false;
                }
                
             
               
                
                else{}
                
              
     
   //TERMINAN VALIDACIONES             
      
       
           var dataString = $('#curtp13').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "GrabaCurtP13",
                    data: dataString,

                    success: function(data) {
                      
                        alert(data);
                       location.href = "captura.jsp?ue="+id_ue;
                    }
                });
                  return false;
     
    
    
};