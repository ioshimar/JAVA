/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_guardaP8(){
  var id_ue =document.getElementById("id_ue").value;
  var fech_ent = document.getElementById("fech_ent").value;    
  var resp_ent = document.getElementById("resp_ent").value;
  var respoc_reci =document.getElementById("respoc_reci").value;
 
      
        
  
  //VALIDACIONES
  
                 if(!fech_ent){
                    alert("Ingresa la fecha");
                     setTimeout(function() { document.getElementById('fech_ent').focus(); }, 10);
                    return false;
                 }
               
                else if(!resp_ent){
                    alert("Ingresa el responsable de la Unidad administrativa que entrega");
                    setTimeout(function() { document.getElementById('resp_ent').focus(); }, 10);
                    return false;
                }
               
                else if(!respoc_reci){
                        alert("Ingresa el responsable de Oficinas centrales que recibe");
                        setTimeout(function() { document.getElementById('name_resp').focus(); }, 10);
                        return false;
                }
                
               
                
                else{}
                
              
     
   //TERMINAN VALIDACIONES             
      
           $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
           var dataString = $('#curtp8').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "GrabaCurtP8",
                    data: dataString,

                    success: function(data) {
                       alert(data);
                       //location.href = "captura.jsp?ue="+id_ue;
                       
                       ResetFormP8();
                        cargaP8(id_ue);   //mandamos el Id 
                    }
                });
                  return false;
     
    
    
};



function cargaP8(id_ue){
  
  //  var callingURL = document.URL;
       // var cgiString = callingURL.substring(callingURL.indexOf('=')+1,callingURL.length);   //sacamos el valor del id_ue
          //var Id_ue = cgiString;
 
    var param = new Object();
    param["id_ue"] = id_ue;
    
   
    
    var url="CargaP8";  
    $.post(url,param,function(listaIdent){   
    // alert(listaIdent);
            var icapas = listaIdent.length;
            var fila = "";  //option
           // var option2 = "";
           $("#lis_filas").empty();
       
       
   /*    if(clave_edo==("33")){ //Incluimos la Opción Desagregar
           $("#lis_filas").append('<tr><td style="font-weight: bold;"> NOMBRE CAPA</td> <td style="font-weight: bold;"> No. DE ELEMENTOS</td></tr>');    

                for (var i=0; i<icapas; i++){
                    var elemento = listaIdent[i];
                    option = '<tr><td>'+ elemento.Nom_capa+'</td> <td>'+elemento.Num_ele+'</td><td> <a href="actualiza_capa.jsp?id='+elemento.Id+' "> <span class="icon-edit"></span><span class="text-e">Editar</span></a> </td> <td> <a href="desagregar_capa.jsp?id='+elemento.Id+' "> <span class="icon-scissors"></span><span class="text-e">Desagregar</span></a> </td> <td> <a href="elimina_capa.jsp?id='+elemento.Id+' "> <span class="icon-trashcan"></span><span class="text-e">Eliminar</span> </a> </td></tr>' ;
                              $("#lis_filas").append(option);
                } 
           
       }*/
       
   /*    else{*/
   var result_frame = document.getElementById("result_frame");
   if(listaIdent.length !== 0){ //SI no esta vacio el arrayList
          $("#lis_filas").append('<tr><td class="cabeReg" style="font-weight: bold;"> Fecha</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Responsable de la UA entrega</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Responsable de OC que recibe</td>\n\
                                      <td colspan="3" class="cabeReg" style="font-weight: bold;"> Acción</td></tr>');    

                for (var i=0; i<icapas; i++){
                    var elemento = listaIdent[i];
                    fila = '<tr class="hov"><td>'+ elemento.fec_oc+'</td>\n\
                                <td>'+ elemento.nom_resp_ent+'</td>\n\
                                <td>'+ elemento.nom_recibe+'</td>\n\
                                <td class="center"> <a onclick="javascript:carga_actualizaP8('+elemento.id_eoc+')"> <span class="icon-edit"></span><span class="text-e">Editar </span></a> </td>\n\
                                <td class="center"> <a href="elimina_p8.jsp?id_eoc='+elemento.id_eoc+'"> <span class="icon-trashcan"></span><span class="text-e">Eliminar</span> </a> </td></tr>' ;
                              $("#lis_filas").append(fila);
                              
                              //elimina_reg_ent_fis.jsp?id_entrega='+elemento.id_entrega+'
                } 
      //  }     

   }else{
          $("#lis_filas").append('<tr><td class="center" style=" background:none; padding:8px 0; font-size:18px; border:none;"> NO HAY REGISTROS AGREGADOS</td></tr>');    
   }


    });    
}    