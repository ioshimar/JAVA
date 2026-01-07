/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function realizaProceso_expR(id_ue){
    var ue = id_ue;

 
    
     var xhttp = new XMLHttpRequest();
     //var url = '../exp_rep_mensual?fecha_inicio='+fecha_ini+"&fecha_fin="+fecha_fin;
     var url = 'exportar_reporte.jsp?ue='+ue;
     var verificar = true; //declaro la variable verificar
     
     document.getElementById("resultado").innerHTML = "Descargando archivo espere...";
     $('#loading').show();  // Mostramos el GIF
    //Validación
                if(!ue){
                   alert("Selecciona la Unidad del Estado");
                     setTimeout(function() { document.getElementById('ue').focus(); }, 10);
                    verificar = false;
                    
                }
                
     //TERMINA validación            
               
    
    xhttp.open("POST", url, true);
    xhttp.setRequestHeader("Content-Type", "application/json");
    xhttp.onreadystatechange = function() {
                var a;
            if (xhttp.readyState === 4 && xhttp.status === 200) {

               var archivo_blob = new Blob([xhttp.response], { type: 'text/csv;charset=utf-8' });  
               //alert(archivo_blob.size);
               if (archivo_blob.size < 2500){   //si el archivo equivale a menos de 5500 bytes (1KB) no Descargar nada de documento (es porque no contiene nada)
                   //alert("No hay regsitros en estas fechas"); 
                   $('#loading').hide(); // Ocultamos el GIF
                   document.getElementById("resultado").innerHTML = "El archivo que intentas descargar está vacío";
               }
               

               else {   //SI NO... si el archivo pesa mas de 1000 bytes (1KB) si imprimirá el documento
                            
                            var nombre_archivo = "Reporte"+ue+".xlsx"; //nombre del archivo con extension


                        if (navigator.appVersion.toString().indexOf('.NET') > 0){  //PARA QUE FUNCIONE EN EL IExplorer
                              window.navigator.msSaveBlob(archivo_blob, nombre_archivo);
                               $('#loading').hide(); // Ocultamos el GIF
                               document.getElementById("resultado").innerHTML = "";
                        }
                        else
                        {

                           // Truco para hacer un enlace descargable
                            a = document.createElement('a');
                            a.href = window.URL.createObjectURL(archivo_blob);
                            // Dar el nombre de archivo que deseas descargar
                            a.download = nombre_archivo;
                            a.style.display = 'none';
                            document.body.appendChild(a);
                            a.click();

                            $('#loading').hide(); // Ocultamos el GIF
                            document.getElementById("resultado").innerHTML = "";
                        }
                  }        
            }
    };
  
 // Debes configurar responseType como blob para respuestas binarias.
          xhttp.responseType = 'blob';

  
   if(verificar==false){
      $('#loading').hide(); // lo mantenemos oculto
      document.getElementById("resultado").innerHTML = ""; // quitamos el texto
   }
  
    if(verificar==true){   //Enviar los archivos
        //xhttp.send();
        xhttp.send(JSON.stringify(url));
   }

 }
