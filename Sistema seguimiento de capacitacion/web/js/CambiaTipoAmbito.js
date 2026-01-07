/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function CambiaTipoAmbito(s1,s2){
    
    var s1 = document.getElementById(s1);
    var s2 = document.getElementById(s2);
    

    $("#tipo_ambito").attr('disabled',false);
    $("#tipo_ambito").removeClass('read');
    
    
    s2.innerHTML = "";
    
      
       if(s1.value == "E"){
            var opcionArray = ["|Seleccione una opción" ,"RPP|Registro Público de la Propiedad","CR|Catastral y Registral", "C|Catastral", "O|Otro"];    // [valor|label]
        }
        
         else if(s1.value == "M"){
            var opcionArray = ["|Seleccione una opción" ,"C|Centralizado", "D|Descentralizado o Autónomo" ,"DCR|Delegación Regional Catastral", "O|Otro"];    // [valor|label]
         }
        
       else if(s1.value == "F"){
        var opcionArray = ["|Seleccione una opción" ,"RAN|Registro Agrario Nacional", "O|Otro"];    // [valor|label]
      }
      
      for(var opcion in opcionArray){
          var pair = opcionArray[opcion].split("|");
          var newOpcion = document.createElement("option");  //Crea una nueva Opcion <option> </option>
          newOpcion.value = pair[0];     //value : el valor de la opcion
          newOpcion.innerHTML = pair[1];  //label : el nombre de la opcion 
          s2.options.add(newOpcion);
          
      }
    
    
}