/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function agrega_actcurtP11(){
  var id_ue =document.getElementById("id_ue").value;
  var id_archivo = document.getElementById("id_archivo").value;    
  var nom_respue = document.getElementById("nom_respue").value;
  var fech_ini11 =document.getElementById("fech_ini11").value;
  var fech_ter11  = document.getElementById("fech_ter11").value;
  var con_curt11  = document.getElementById("con_curt11").value;
  var sin_curt11  = document.getElementById("sin_curt11").value;    
  var total_motivo_a  = document.getElementById("total_motivo_a").value;   
  var motivo_a  = document.getElementById("motivo_a").value;   
  var valida_num=/^([0-9])*$/;
  
             
      //Split de las fechas recibidas para separarlas
                    var x  = fech_ini11.split("/");
                    var z = fech_ter11.split("/");  
                    
            //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fech_ini11_compare = x[1] + "/" + x[0] + "/" + x[2];
            var fech_ter11_compare = z[1] + "/"  + z[0] + "/"  + z[2];    
  
  
  
  //VALIDACIONES
  
                 if(!id_archivo){
                    alert("Selecciona un archivo");
                     setTimeout(function() { document.getElementById('id_archivo').focus(); }, 10);
                    return false;
                 }
               
                else if(!nom_respue){
                    alert("Ingresa el nombre del responsable");
                    setTimeout(function() { document.getElementById('nom_respue').focus(); }, 10);
                    return false;
                }
               
                else if(!fech_ini11){
                        alert("Ingresa la fecha de inicio");
                        setTimeout(function() { document.getElementById('fech_ini11').focus(); }, 10);
                        return false;
                }
                
                else if(!fech_ter11){
                        alert("Ingresa la fecha de término");
                          setTimeout(function() { document.getElementById('fech_ter11').focus(); }, 10);
                        return false;
                }
                
                 else  if(Date.parse(fech_ini11_compare) > Date.parse(fech_ter11_compare)){
                                    alert("Las fechas no corresponden, la fecha de término debe ser igual o despúes que la fecha de inicio");
                                    setTimeout(function() { document.getElementById('fech_ter11').focus(); }, 10);
                                           return false;
                            }
                
                
                else if(!con_curt11){
                        alert("Ingresa los predios con CURT");
                          setTimeout(function() { document.getElementById('con_curt11').focus(); }, 10);
                        return false;
                }
                
                 else if(!con_curt11.match(valida_num)){
                        alert("Este campo solo acepta valores númericos y sin espacios");
                          setTimeout(function() { document.getElementById('con_curt11').focus(); }, 10);
                        return false;
                }
                
                else if(!sin_curt11){
                        alert("Ingresa los predios sin CURT");
                          setTimeout(function() { document.getElementById('sin_curt11').focus(); }, 10);
                        return false;
                }
                
                else if(!sin_curt11.match(valida_num)){
                        alert("Este campo solo acepta valores númericos y sin espacios");
                          setTimeout(function() { document.getElementById('sin_curt11').focus(); }, 10);
                        return false;
                }
                
                else if(!total_motivo_a){
                     alert("Ingresa el total de los motivos");
                     setTimeout(function() { document.getElementById('total_motivo_a').focus(); }, 10);
                     return false;
                }
                
                else if(!total_motivo_a.match(valida_num)){
                     alert("Este campo solo acepta valores númericos y sin espacios");
                     setTimeout(function() { document.getElementById('total_motivo_a').focus(); }, 10);
                     return false;
                }
                
                else if(!motivo_a){
                    alert("Ingresa los motivos");
                    setTimeout(function() { document.getElementById('motivo_a').focus(); }, 10);
                    return false;
                }
                
               
                
            
                else{}
                
              
     
   //TERMINAN VALIDACIONES             
      
       $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
           var dataString = $('#curtp11').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "GrabaCurtP11",
                    data: dataString,

                    success: function(data) {
                             // alert(data);
                               $('div#notif').slideDown("swing","linear");
                              document.getElementById("result").innerHTML = data;
                        
                            if(data==="Error_al_conectar_la_bd" || data==="Error ya se ha guardado este registro en la Base de Datos, intenta con otro archivo"){
                               $('div#notif').css("background","red"); //cambio el color a rojo
                            }
                            else if(data==="Datos Ingresados correctamente"){
                               $('div#notif').css("background","#00aced");   //cambio a color azul
                                $('div#notif').css("border", "3px solid #71ff38"); //bordes verdes
                            }
                              ResetForm11();//resetemaos el formulario con la función
                             carga_resultadosP11(id_ue);       
                    }
                });
                  return false;
     
};



function carga_resultadosP11(id_ue){
  
   // var callingURL = document.URL;
    //       var cgiString = callingURL.substring(callingURL.indexOf('=')+1,callingURL.length);   //sacamos el valor del id_ue
   //       var Id_ue = cgiString;
 //alert(Id_ue);
    var param = new Object();
    param["id_ue"] = id_ue;
    
    var url="CargaFilasP11";  
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
                                      <td class="cabeReg" style="font-weight: bold;"> Total</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Motivos</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;" colspan="2"> Acción</td></tr>');    

                for (var i=0; i<icapas; i++){
                    var elemento = listaIdent[i];
                    fila = '<tr class="hov"><td>'+ elemento.nom_archivo+'</td>\n\
                                <td>'+ elemento.nom_resp_ue+'</td>\n\
                                <td>'+ elemento.fech_ini_a+'</td>\n\
                                <td>'+ elemento.fech_fin_a+'</td>\n\
                                <td>'+ elemento.pred_concurt_a+'</td>\n\
                                <td>'+ elemento.pred_sincurt_a+'</td> \n\
                                <td>'+elemento.total_motgen+' </td>\n\
                                <td>'+elemento.mot_gen+'</td>\n\
                                <td class="center"> <a onclick="javascript:carga_actualizaP11('+elemento.id_act+')"> <span class="icon-edit"></span><span class="text-e">Editar </span></a> </td>\n\
                                <td class="center"> <a href="elimina_reg_Actcurt.jsp?act='+elemento.id_act+'&ue='+elemento.id_ue+'"> <span class="icon-trashcan"></span><span class="text-e">Eliminar</span> </a> </td></tr>' ;
                              $("#lis_filas").append(fila);
                } 
        

   }else{
          $("#lis_filas").append('<tr><td class="center" style=" background:none; padding:8px 0; font-size:18px; border:none;"> NO HAY REGISTROS AGREGADOS</td></tr>');    
   }


    });    
} 


function carga_actualizaP11(id_act){
   // alert(id_entrega);  //probar que manda el ID
    
        var param = new Object();
    param["id_act"] = id_act;
    
    var url="CargaP11";  
    $.post(url,param,function(listaIdent){   
    // alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP11 = listaIdent[0];
            
            $("#nom_archivo").val(elementoP11.nom_archivo);       //Nota lo que va despues de (elementoP11.ejemplo) (debe de estar como lo declaramos en FilasDTOp5.java)
            $("#nom_respue").val(elementoP11.nom_resp_ue);
            $("#fech_ini11").val(elementoP11.fech_ini_a);
            $("#fech_ter11").val(elementoP11.fech_fin_a);
            $("#con_curt11").val(elementoP11.pred_concurt_a);
            $("#sin_curt11").val(elementoP11.pred_sincurt_a);
            $("#total_motivo_a").val(elementoP11.total_motgen);
            $("#motivo_a").val(elementoP11.mot_gen);
            $("#id_archivo").val(elementoP11.id_entrega);
            
            $("#id_archivo").attr('disabled', true); //deshabilitamos el select
            $("#id_archivo").addClass('read');
            
          $("#id_actcurt").val(id_act);//Mandamos el id_generación al input 
            
            $("#actualizar").css("display","inline-block");
            $("#nuevo_reg").css("display","inline-block");
            $("#agrega_reg").css("display","none");
         

    });
    
    
    
};


  function ResetForm11(){
            document.getElementById("curtp11").reset();
              $("#actualizar").css("display","none");  //quitamos el boton actualizar
              $("#nuevo_reg").css("display","none");  //quitamos el boton Nuevo Reg
              $("#agrega_reg").css("display","inline-block"); //Aparecemos el botón Nuevo Reg
              $("#id_archivo").attr('disabled', false);  //quitamos el disabled
              $("#id_archivo").removeClass('read');
          };