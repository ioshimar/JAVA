/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_uploadFile(){
  
  var id_ue = document.getElementById("id_ue").value;    
  var arch1 = document.getElementById("arch1").value;
  
  
  //alert(nombre_archivo);
  //alert(nombre_archivo.length);
 
   
  
             
       
  
  //VALIDACIONES
  
                 if(!arch1){
                    alert("Selecciona el archivo");
                     setTimeout(function() { document.getElementById('arch1').focus(); }, 10);
                    return false;
                 }
                 
                 else{ //Si no esta vacio checa los caracteres
                     var nombre_archivo = document.getElementById('arch1').files[0].name;
                        if(nombre_archivo.length > 200){
                            alert("El nombre del archivo es demasiado largo y excede de los 200 caracteres, acortalo");
                            setTimeout(function() { document.getElementById('arch1').focus(); }, 10);
                            return false;
                        }

                       else{}
                  }
                 
                 
           
              
     //TERMINAN VALIDACIONES  
    
   
  
  // Get form
        var form = $('#form_upload')[0];
                // Create an FormData object 
        var datos = new FormData(form);   //Generar el objeto datos a partir del formulario y agregarle los datos del formulario.
    //datos.append("CustomField", "This is some extra data, testing"); //Además podremos agregar cualquier otro dato, incluso aunque éste no esté en un campo del formulario
      
        $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
          // var dataString = $('#curtp1').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

           // alert('Datos serializados: '+datos);

                $.ajax({
                    type: "POST",
                    url: "SubirArchivo",
                    enctype: 'multipart/form-data',
                    data: datos,
                    processData: false,
                    contentType: false,
                    cache: false,
                    timeout: 600000,
                  
                    success: function(data) {
                      
                        alert(data);
                      // location.href = "captura.jsp?ue="+id_ue;
                       postwith('curt_p1.jsp',{ue:id_ue}); //mandamos la URL
                    }
                });
                  return false;
     
    
    
};
//REFERENCIAS...
// https://desarrolloweb.com/articulos/upload-archivos-ajax-jquery.html
//https://www.mkyong.com/jquery/jquery-ajax-submit-a-multipart-form/
//https://stackoverflow.com/questions/2422468/how-to-upload-files-to-server-using-jsp-servlet