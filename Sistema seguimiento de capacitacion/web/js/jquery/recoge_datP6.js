/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function carga_datp6(valor_recibido)
{
    //alert(valor_recibido);
    var param = new Object();
    param["id_entrega"] = valor_recibido;

    
    var url="CargaDevoluciones";  
    var array2 = []; 
    $.post(url,param,function(listaIdent){   
        var elementoP6 = listaIdent[0];
    
                                var for_shape =elementoP6.for_shape;
                                var ext_min =elementoP6.ext_min;
                                var est_cor =elementoP6.est_cor;
                                var atrib =elementoP6.atrib;
                                var info_cord =elementoP6.info_cord;
                                var code_total =elementoP6.code_total;
                                
                                //Agregamos el texto a los array
                               if(for_shape==="NO"){ array2.push(" El archivo no esta en formato shape");}        
                               if(ext_min==="NO"){ array2.push(" El archivo no contiene las 4 extenciones minimas");}
                               if(est_cor==="NO"){ array2.push(" La estructura del archivo no es correcta");}
                               if(atrib==="NO"){ array2.push(" Atributos sin valores nulos o vacíos");}
                               if(info_cord==="NO"){ array2.push(" La información no esta en coordenadas geográficas");}
                               if(code_total==="NO"){ array2.push(" No coincide con el total de registros entregados");}
      
      
      $("#motivos_dev").val(array2);
      $("#arch_dev").val(elementoP6.nom_archivo); //agregamos el nombre al input
    });
   
    
    /*CARGAMOS LOS DATOS DE LA TABLA datos_entrega_fis*/
    var url2="CargaP5";  
   
    $.post(url2,param,function(listaIdent5){   
        var elementoP5 = listaIdent5[0];
    
      
      $("#total_dev").val(elementoP5.total_reg); //agregamos el nombre al input
    });
    
    
}