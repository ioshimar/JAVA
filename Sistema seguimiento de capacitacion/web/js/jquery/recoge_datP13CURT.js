/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function carga_datp13CURT(valor_recibido){
    //alert(valor_recibido);
    var param = new Object();
    param["idsolicitud"] = valor_recibido;
    
     document.getElementById("text_load").innerHTML = "Cargando información...";   
     $('#loading_data').show(); //mostramos el gif
    
    var url="ConsultaP13CURTp";  
   $.post(url,param,function(listaIdent){   
        var elementoP5 = listaIdent[0];
        
      $("#nom_arch").val(elementoP5.describe);
      $("#tamano").val(elementoP5.tamano);
      $("#no_reg").val(elementoP5.Total); //El total es el número de registros
      
        $("#nom_arch, #tamano, #no_reg").attr('disabled', true); //lo deshabilitamos
        //$("#id_archivo").addClass('read');
      
      
      document.getElementById("text_load").innerHTML = "";   
     $('#loading_data').hide(); //mostramos el gif
    
    });
    
  /*CONSULTAR PREDIOS CON CURT*/
  /*  var url2="ConsultaConCurt";  
    $.post(url2,param,function(listaIdent2){   
        var elementoP5b = listaIdent2[0];
      $("#pred_con_curt").val(elementoP5b.TotalconCurt);
   });
   */
   
    /*CONSULTAR PREDIOS SIN CURT
    var url3="ConsultaSinCurt";  
    $.post(url3,param,function(listaIdent3){   
        var elementoP5c = listaIdent3[0];
      $("#pred_sin_curt").val(elementoP5c.TotalSinCurt);
   });
   
    */
    
}