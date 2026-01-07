/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function agrega_gencurtP10(){
  var id_ue =document.getElementById("id_ue").value;
  var cve_edo =document.getElementById("cve_edo").value;
  var id_archivo = document.getElementById("id_archivo").value;    
  var nom_respgen = document.getElementById("nom_respgen").value;
  var fech_ini10 =document.getElementById("fech_ini10").value;
  var fech_ter10  = document.getElementById("fech_ter10").value;
  var con_curt  = document.getElementById("con_curt").value;
  var sin_curt  = document.getElementById("sin_curt").value;    
 // var total_motivo  = document.getElementById("total_motivo").value;   
 // var motivo  = document.getElementById("motivo").value; 
   var valida_num=/^([0-9])*$/;
   
     //Split de las fechas recibidas para separarlas
                    var x  = fech_ini10.split("/");
                    var z = fech_ter10.split("/");  
                    
            //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fech_ini10_compare = x[1] + "/" + x[0] + "/" + x[2];
            var fech_ter10_compare = z[1] + "/"  + z[0] + "/"  + z[2];    
 
  //VALIDACIONES
  
                 if(!id_archivo){
                    alert("Selecciona un archivo");
                     setTimeout(function() { document.getElementById('id_archivo').focus(); }, 10);
                    return false;
                 }
               
                else if(!nom_respgen){
                    alert("Ingresa el nombre del responsable");
                    setTimeout(function() { document.getElementById('nom_respgen').focus(); }, 10);
                    return false;
                }
               
                else if(!fech_ini10){
                        alert("Ingresa la fecha de inicio");
                        setTimeout(function() { document.getElementById('fech_ini10').focus(); }, 10);
                        return false;
                }
                
                else if(!fech_ter10){
                        alert("Ingresa la fecha de término");
                          setTimeout(function() { document.getElementById('fech_ter10').focus(); }, 10);
                        return false;
                }
                
                else  if(Date.parse(fech_ini10_compare) > Date.parse(fech_ter10_compare)){
                                    alert("Las fechas no corresponden, la fecha de término debe ser igual o despúes que la fecha de inicio");
                                    setTimeout(function() { document.getElementById('fech_ter10').focus(); }, 10);
                                           return false;
                            }
                
                else if(!con_curt){
                        alert("Ingresa los predios con CURT");
                          setTimeout(function() { document.getElementById('con_curt').focus(); }, 10);
                        return false;
                }
                
                 else if(!con_curt.match(valida_num)){
                        alert("Este campo solo acepta valores númericos");
                          setTimeout(function() { document.getElementById('con_curt').focus(); }, 10);
                        return false;
                }
                
                else if(!sin_curt){
                        alert("Ingresa los predios sin CURT");
                          setTimeout(function() { document.getElementById('sin_curt').focus(); }, 10);
                        return false;
                }
                 else if(!sin_curt.match(valida_num)){
                        alert("Este campo solo acepta valores númericos");
                        setTimeout(function() { document.getElementById('sin_curt').focus(); }, 10);
                        return false;
                }
                
                
              /*  else if(!total_motivo){
                     alert("Ingresa el total de los motivos");
                     setTimeout(function() { document.getElementById('total_motivo').focus(); }, 10);
                     return false;
                }
                
                 else if(!total_motivo.match(valida_num)){
                    alert("Este campo solo acepta valores númericos");
                     setTimeout(function() { document.getElementById('total_motivo').focus(); }, 10);
                     return false;
                }
                
                else if(!motivo){
                    alert("Ingresa los motivos");
                    setTimeout(function() { document.getElementById('motivo').focus(); }, 10);
                    return false;
                }
                */
               
                
            
                else{}
                
              
     
   //TERMINAN VALIDACIONES             
      
       $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
           var dataString = $('#curtp10').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "GrabaCurtP10",
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
                                ResetForm10();//resetemaos el formulario con la función
                            }
                      
                     // alert(data);
                     //location.href = "captura.jsp?ue="+id_ue;
                
                carga_resultadosP10(id_ue);       
                       
                    }
                });
                  return false;
     
};



function carga_resultadosP10(id_ue){
  
      //var callingURL = document.URL;
      //     var cgiString = callingURL.substring(callingURL.indexOf('=')+1,callingURL.length);   //sacamos el valor del id_ue
      //    var Id_ue = cgiString;
 //alert(Id_ue);
    var param = new Object();
    param["id_ue"] = id_ue;
    
    var url="CargaFilasP10";  
    $.post(url,param,function(listaIdent){   
    // alert(listaIdent);
            var icapas = listaIdent.length;
            var fila = "";  //option
           // var option2 = "";
           $("#lis_filas").empty();
       
       

   
   if(listaIdent.length !== 0){ //SI no esta vacio el arrayList
          $("#lis_filas").append('<tr><td class="cabeReg" style="font-weight: bold;"> Archivo</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Responsable</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Fecha inicio</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Fecha término</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Predios con CURT</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Predios sin CURT</td> \n\
                                      <td class="cabeReg" style="font-weight: bold;"> Motivos por los que NO se generó la CURT</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;" colspan="2"> Acción</td></tr>');    

                for (var i=0; i<icapas; i++){
                    var elemento = listaIdent[i];
                    fila = '<tr class="hov"><td>'+ elemento.nom_archivo+'</td>\n\
                                <td>'+ elemento.nom_resp+'</td>\n\
                                <td>'+ elemento.fech_ini+'</td>\n\
                                <td>'+ elemento.fech_fin+'</td>\n\
                                <td>'+ elemento.pred_concurt+'</td>\n\
                                <td>'+ elemento.pred_sincurt+'</td> \n\
                                <td class="center">   <a href="motivos_gencurt.jsp?ue='+id_ue+'&gencurt='+elemento.id_gen+'&id_entrega='+elemento.id_entrega+'"> <span class=""> + </span><span class="text-e">Agrega los motivos </span></a> </td>\n\
                                <td class="center"> <a onclick="javascript:carga_actualizaP10('+elemento.id_gen+')"> <span class="icon-edit"></span><span class="text-e">Editar </span></a> </td>\n\
                                <td class="center"> <a href="elimina_reg_gencurt.jsp?generacion='+elemento.id_gen+'&ue='+elemento.id_ue+' "> <span class="icon-trashcan"></span><span class="text-e">Eliminar</span> </a> </td></tr>' ;
                              $("#lis_filas").append(fila);
                } 
        

   }else{
          $("#lis_filas").append('<tr><td class="center" style=" background:none; padding:8px 0; font-size:18px; border:none;"> NO HAY REGISTROS AGREGADOS</td></tr>');    
   }


    });    
} 


function carga_actualizaP10(id_gen){
   // alert(id_entrega);  //probar que manda el ID
    
        var param = new Object();
    param["id_gen"] = id_gen;
    
    var url="CargaP10";  
    $.post(url,param,function(listaIdent){   
    // alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP10 = listaIdent[0];
           
            $("#nom_archivo").val(elementoP10.nom_archivo);       //Nota lo que va despues de (elementoP10.ejemplo) (debe de estar como lo declaramos en FilasDTOp5.java)
            $("#nom_respgen").val(elementoP10.nom_resp);
            $("#fech_ini10").val(elementoP10.fech_ini);
            $("#fech_ter10").val(elementoP10.fech_fin);
            $("#con_curt").val(elementoP10.pred_concurt);
            $("#sin_curt").val(elementoP10.pred_sincurt);
            $("#total_motivo").val(elementoP10.total_motgen);
            $("#motivo").val(elementoP10.mot_gen);
            $("#id_archivo").val(elementoP10.id_entrega);
            
            $("#id_archivo").attr('disabled', true);
            $("#id_archivo").addClass('read');
            
            
          $("#id_generacion").val(id_gen);//Mandamos el id_generación al input 
            
            $("#actualizar").css("display","inline-block");
            $("#nuevo_reg").css("display","inline-block");
            $("#agrega_reg").css("display","none");
         

    });
   
};


  function ResetForm10(){
            document.getElementById("curtp10").reset();
              $("#actualizar").css("display","none");  //quitamos el boton actualizar
              $("#nuevo_reg").css("display","none");  //quitamos el boton Nuevo Reg
              $("#agrega_reg").css("display","inline-block"); //Aparecemos el botón Nuevo Reg
              $("#id_archivo").attr('disabled', false);  //quitamos el disabled
              $("#id_archivo").removeClass('read');
          };