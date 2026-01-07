/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



     function valida_altasue(){
            
        var expresion=/^([0-9]){3}$/;//expresion regular de solo numeros de 3 digitos
        var codigo=/^([0-9]){5}$/;//expresion regular de solo numeros de 5 digitos 
        var tel=/^([0-9])*$/;//expresion regular de solo numeros sin tamaño especifico
        var nombre=/^([a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s\(\).,])*$/;//expresion regular de solo letras sin tamaño especifico
        var numexte=/^([0-9\-snSN\/])*$/;
         var tel_10=/^([0-9]{10})*$/;     //10 DIgitos y NO obligatorio
          // var url_1 = /^((www|WWW|www2|WW2|www3|WWW3)\.[a-zA-Z0-9\-\.]+\.[a-zA-Z0-9\/\-_\.]{2,300})*$/;   //validar URL   (no obligatorio) con el    ( [caracteres] )*$ es para NO obligatorios
     var url_1 = /^([a-zA-Z0-9\-\.]+\.[a-zA-Z0-9\/\-_\.]{2,300})*$/;   //validar URL   (no obligatorio) con el    ( [caracteres] )*$ es para NO obligatorios 
     var expRegEmail=/^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})*$/ ; /*validar Email*/
        
    
     
           var ambito_ins_f = document.getElementById("ambito_ins").value;       
                
      
   
     
        if(!ambito_ins_f) /*si esta vacio campo nombre...*/ {
                 alert("Selecciona el Ambito de la Institución");
               setTimeout(function() { document.getElementById('ambito_ins').focus(); }, 10);
             return false;
        }
            
    
        else if (document.getElementById("tipo_ambito").value.length==0){
            alert("Selecciona El Tipo Ambito");
           setTimeout(function() { document.getElementById('tipo_ambito').focus(); }, 10);
         return false;
        }
    
        
        
        
        else if (document.getElementById("nombre_ues").value.length==0){
            alert("Selecciona La Unidad de Estado");
           setTimeout(function() { document.getElementById('nombre_ues').focus(); }, 10);
         return false;
        }
        
        
        else if(document.getElementById("nomoficial").value.length==0){
            alert("Ingresa el nombre de la Institución");
          setTimeout(function() { document.getElementById('nomoficial').focus(); }, 10);
            return false;
        }
        
        
        else if(!document.getElementById("nomoficial").value.match(nombre)){
            alert("Nombre Incorrecto. Sólo acepta letras");
            setTimeout(function() { document.getElementById('nomoficial').focus(); }, 10);
            return false;
        }     
           
    
       
        else if (document.getElementById("lista_categoria").value.length==0){
            alert("Selecciona el Municipio");
           setTimeout(function() { document.getElementById('lista_categoria').focus(); }, 10);
         return false;
        }
    
        else if (document.getElementById("lista_subcategoria").value.length==0){
            alert("Selecciona la Localidad");
           setTimeout(function() { document.getElementById('lista_subcategoria').focus(); }, 10);
         return false;
        }
        
          
        /*else if(document.getElementById("codigopostal").value.length==0){
            alert("Código postal es necesario que contenga información");
           setTimeout(function() { document.getElementById('codigopostal').focus(); }, 10);
            return false;
        }*/
        
        /*else if(!document.getElementById("codigopostal").value.match(codigo)){
            alert("Código Postal Se constituye de 5 dígitos");
            setTimeout(function() { document.getElementById('codigopostal').focus(); }, 10);
            return false;
        }*/
    
       
        
        
        /*else if(document.getElementById("telefono").value.length==0){
            alert("Teléfono  Es necesario que tenga información");
            setTimeout(function() { document.getElementById('telefono').focus(); }, 10);
            return false;
        }*/
        
        /*else if(!document.getElementById("telefono").value.match(tel)) {
            alert("Teléfono Incorrecto. Sólo acepta números y sin espacios");
            setTimeout(function() { document.getElementById('telefono').focus(); }, 10);
            return false;
        }*/
           
        /*else if(document.getElementById("telefono").value.length <10){
	  alert("Debes introducir al menos 10 digitos en el No. de Teléfono");
	  setTimeout(function() { document.getElementById('telefono').focus(); }, 10);
	  return false;
        }*/
           
        /*else if((!document.getElementById("extension").value.match(tel) )){
            alert("Extensión Incorrecta. Sólo acepta números y sin espacios");
            setTimeout(function() { document.getElementById('extension').focus(); }, 10);
            return false;
        }     */
           
           
     
      
   
        
        
        
        return true;//si pasa su validacion correspondiente se envia el formulario
         }
