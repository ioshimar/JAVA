/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_guardaP7(){
  var id_ue =document.getElementById("id_ue").value;
  var fech_dev = document.getElementById("fech_dev").value;    
  var resp_dev = document.getElementById("resp_dev").value;
  var resp_reci =document.getElementById("resp_reci").value;
  var arch_dev = document.getElementById("arch_dev").value;  
  var total_dev = document.getElementById("total_dev").value;  
  var id_archivo = document.getElementById("id_archivo").value;
  var valida_num=/^([0-9])*$/;
      
        
  
  //VALIDACIONES
  
                if(!id_archivo){
                    alert("Selecciona un archivo");
                     setTimeout(function() { document.getElementById('id_archivo').focus(); }, 10);
                    return false;
                 }
  
                 else if(!fech_dev){
                    alert("Ingresa la fecha de la devolución");
                     setTimeout(function() { document.getElementById('fech_dev').focus(); }, 10);
                    return false;
                 }
               
                else if(!resp_dev){
                    alert("Ingresa el nombre del responsable  de la devolución");
                    setTimeout(function() { document.getElementById('resp_dev').focus(); }, 10);
                    return false;
                }
               
                else if(!resp_reci){
                        alert("Ingresa el nombre del  responsable de recibir la información en la UE");
                        setTimeout(function() { document.getElementById('resp_reci').focus(); }, 10);
                        return false;
                }
                
                else if(!arch_dev){
                        alert("Ingresa el nombre del archivo que se devolvió");
                          setTimeout(function() { document.getElementById('arch_dev').focus(); }, 10);
                        return false;
                }
                
                else if(!total_dev){
                        alert("Ingresa el total de registros en el archivo devuelto");
                          setTimeout(function() { document.getElementById('total_dev').focus(); }, 10);
                        return false;
                }
                
                else if(!total_dev.match(valida_num)){
                        alert("Este campo solo acepta valores númericos");
                          setTimeout(function() { document.getElementById('total_dev').focus(); }, 10);
                        return false;
                }
                
               
                
                else{}
                
              
     
   //TERMINAN VALIDACIONES             
      
        $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
           var dataString = $('#curtp7').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "GrabaCurtP7",
                    data: dataString,

                    success: function(data) {
                         $('div#notif').slideDown("swing","linear");
                          document.getElementById("result").innerHTML = data;
                        
                            if(data==="Error_al_conectar_la_bd" || data==="Error ya se ha guardado este registro en la Base de Datos, intenta con otro archivo"){
                               $('div#notif').css("background","red"); //cambio el color a rojo
                            }
                            else if(data==="Datos Ingresados correctamente"){
                               $('div#notif').css("background","#00aced");   //cambio a color azul
                               $('div#notif').css("border", "3px solid #71ff38"); //bordes verdes
                            }
                      carga_resultadosP7(id_ue);
                      
                      
                       // alert(data);
                      //  location.href = "captura.jsp?ue="+id_ue;
                    }
                });
                  return false;
     
    
    
};




function carga_resultadosP7(id_ue){
  
      //var callingURL = document.URL;
      //     var cgiString = callingURL.substring(callingURL.indexOf('=')+1,callingURL.length);   //sacamos el valor del id_ue
      //    var Id_ue = cgiString;
 //alert(Id_ue);
    var param = new Object();
    param["id_ue"] = id_ue;
    
    var url="CargaP7";  
    $.post(url,param,function(listaIdent){   
    // alert(listaIdent);
            var ResFilas = listaIdent.length;
            var fila = "";  //option
           // var option2 = "";
           $("#lis_filas").empty();
       
       

   
   if(listaIdent.length !== 0){ //SI no esta vacio el arrayList
          $("#lis_filas").append('<tr><td class="cabeReg" style="font-weight: bold;" > Fecha devolución</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;">  Archivo devuelto</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Responsable del INEGI de la devolución </td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Responsable de recibir la información en la UE</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"  width="25%"> Motivos de devolución</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Registros devueltos</td> \n\
                                      <td class="cabeReg" style="font-weight: bold;" colspan="2"> Acción</td></tr>');    

                for (var i=0; i<ResFilas; i++){
                    var elemento = listaIdent[i];
                    fila = '<tr class="hov"><td>'+ elemento.fecha_dev+'</td>\n\
                                <td>'+elemento.arch_dev+'</td>\n\
                                <td>'+elemento.nom_resp_dev+'</td>\n\
                                <td>'+elemento.nom_rec_dev+'</td>\n\
                                <td>'+elemento.motivos_dev+'</td>\n\
                                <td>'+elemento.total_regdev+'</td> \n\
                                <td class="center"> <a onclick="javascript:carga_actualizaP7('+elemento.id_dev+'), carga_datp6('+elemento.id_entrega+')"> <span class="icon-edit"></span><span class="text-e">Editar </span></a> </td>\n\
                                <td class="center"> <a href="elimina_reg_devolucion.jsp?id_devolucion='+elemento.id_dev+'&ue='+elemento.id_ue+' "> <span class="icon-trashcan"></span><span class="text-e">Eliminar</span> </a> </td></tr>' ;
                              $("#lis_filas").append(fila);
                } 
        

   }else{
          $("#lis_filas").append('<tr><td class="center" style=" background:none; padding:8px 0; font-size:18px; border:none;"> NO HAY REGISTROS AGREGADOS</td></tr>');    
   }


    });    
}




function carga_actualizaP7(id_dev){
   // alert(id_ue);  //probar que manda el ID
    
        var param = new Object();
    param["id_dev"] = id_dev;
    
    var url="CargaActualizaP7";  
    $.post(url,param,function(listaIdent){   
   // alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP7 = listaIdent[0];
         
      
        if(listaIdent.length > 0){  //Si encuentra Algún registro
         /*   if(elementoP7.fecha_ofic2 ==="01/01/0001"){
              elementoP7.fecha_ofic2 = "";  
            }*/
            
          //  $("#sol_registro").val(elementoP7.fec_sol_reg);       //Nota lo que va despues de (elementoP7.ejemplo) (debe de estar como lo declaramos en FilasDTOp4.java)
            $("#fech_dev").val(elementoP7.fecha_dev);    
            $("#resp_dev").val(elementoP7.nom_resp_dev);
            $("#resp_reci").val(elementoP7.nom_rec_dev);
            $("#arch_dev").val(elementoP7.arch_dev);
            $("#total_dev").val(elementoP7.total_regdev);
          //  $("#motivos_dev").val(elementoP7.motivos_dev);
            $("#id_archivo").val(elementoP7.id_entrega);
            
             $("#id_archivo").attr('disabled', true); //lo deshabilitamos
             $("#id_archivo").addClass('read'); //agregamos la clase read
             
             $("#id_devolucion").val(elementoP7.id_dev);
            
          
            
         // alert(elementoP7.id_concer);
         
           //$("#id_ue").val(id_ue);//Mandamos el id_ue*/
         
           
            $("#actualizar").css("display","inline-block");
            $("#nuevo_reg").css("display","inline-block");
            $("#agrega_reg").css("display","none");
         
        } 
    }
            
            
            );
    
    
    
}


function ResetForm7(){
            document.getElementById("curtp7").reset();
              $("#actualizar").css("display","none");  //quitamos el boton actualizar
            //  $("#nuevo_reg").css("display","none");  //quitamos el boton Nuevo Reg
              $("#agrega_reg").css("display","inline-block"); //Aparecemos el botón Nuevo Reg
              $("#id_archivo").attr('disabled', false);  //quitamos el disabled
              $("#id_archivo").removeClass('read'); //quitamos la clase read
          };