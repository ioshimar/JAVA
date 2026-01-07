/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_guardaP12_RESP(){
  var id_ue =document.getElementById("id_ue").value;
  var fecha_ent12 = document.getElementById("fecha_ent12").value;    
  var nom_resp_oc = document.getElementById("nom_resp_oc").value;
  var resp_rec_dr =document.getElementById("resp_rec_dr").value;

  var nom_archdr =document.getElementById("nom_archdr").value;
  var cant_regdr =document.getElementById("cant_regdr").value;
  var fecha_ent_ue =document.getElementById("fecha_ent_ue").value; 
  
  var nom_resp_dr =document.getElementById("nom_resp_dr").value;  
  var resp_reci_ue =document.getElementById("resp_reci_ue").value; 
  var nom_arch_ue =document.getElementById("nom_arch_ue").value; 
  var cant_reg_ue =document.getElementById("cant_reg_ue").value; 
  var valida_num=/^([0-9])*$/;      
  
  var tipo_entrega = document.getElementsByName("tipo_entrega");
  
   /********* Validar que se seleccione al menos un checkbox ********/
  var selectTipoEntre= false;    // Para validar los checkbox
            for(var i=0; i < tipo_entrega.length; i++) {    
                   var valor_Tipo= tipo_entrega[i].value;  //obtener el valor
                if(tipo_entrega[i].checked) {  //validar que se seleccione al menos una
                   selectTipoEntre = true;
                    break;
                }
             }  
  
  var chk_adr = document.getElementById("chk_adr");
  var chk_aue = document.getElementById("chk_aue");
  //VALIDACIONES
  
  
   if(!selectTipoEntre){
                     alert("Selecciona una opción");
                            setTimeout(function() { document.getElementById('chk_adr').focus(); }, 10);
                            return false;
                }else{}
  
  if(chk_adr.checked){
                 if(!fecha_ent12){
                    alert("Ingresa la fecha");
                     setTimeout(function() { document.getElementById('fecha_ent12').focus(); }, 10);
                    return false;
                 }
               
                else if(!nom_resp_oc){
                    alert("Ingresa el nombre del responsable en OC");
                    setTimeout(function() { document.getElementById('nom_resp_oc').focus(); }, 10);
                    return false;
                }
               
                else if(!resp_rec_dr){
                        alert("Ingresa el nombre del responsable en DR");
                        setTimeout(function() { document.getElementById('resp_rec_dr').focus(); }, 10);
                        return false;
                }
                
                else if(!nom_archdr){
                        alert("Ingresa el nombre del archivo");
                        setTimeout(function() { document.getElementById('nom_archdr').focus(); }, 10);
                        return false;
                }
                
                else if(!cant_regdr){
                        alert("Ingresa la cantidad de registros");
                        setTimeout(function() { document.getElementById('cant_regdr').focus(); }, 10);
                        return false;
                }
                
                  else if(!cant_regdr.match(valida_num)){
                          alert("Este campo solo acepta valores númericos");
                        setTimeout(function() { document.getElementById('cant_regdr').focus(); }, 10);
                        return false;
                }
            }else{}
            
          if(chk_aue.checked){  
                 if(!fecha_ent_ue){
                        alert("Ingresa la fecha");
                        setTimeout(function() { document.getElementById('fecha_ent_ue').focus(); }, 10);
                        return false;
                }
                
                 else if(!nom_resp_dr){
                        alert("Ingresa el nombre del responsable en DR/CE");
                        setTimeout(function() { document.getElementById('nom_resp_dr').focus(); }, 10);
                        return false;
                }
                
                 else if(!resp_reci_ue){
                        alert("Ingresa el nombre del responsable en UE");
                        setTimeout(function() { document.getElementById('resp_reci_ue').focus(); }, 10);
                        return false;
                }
                
                else if(!nom_arch_ue){
                        alert("Ingresa el nombre del archivo");
                        setTimeout(function() { document.getElementById('nom_arch_ue').focus(); }, 10);
                        return false;
                }
                
                else if(!cant_reg_ue){
                        alert("Ingresa la cantidad de registros");
                        setTimeout(function() { document.getElementById('cant_reg_ue').focus(); }, 10);
                        return false;
                }
                
                 else if(!cant_reg_ue.match(valida_num)){
                        alert("Este campo solo acepta valores númericos");
                        setTimeout(function() { document.getElementById('cant_reg_ue').focus(); }, 10);
                        return false;
                }
                
        }    else{}
                
              
     
   //TERMINAN VALIDACIONES             
      
       
           var dataString = $('#curtp12').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "GrabaCurtP12",
                    data: dataString,

                    success: function(data) {
                       alert(data);
                     //  location.href = "captura.jsp?ue="+id_ue;
                       carga_FilasP12(id_ue);
                     
                    }
                });
                  return false;
     
    
    
};



function carga_FilasP12(id_ue){
  
  //  var callingURL = document.URL;
       // var cgiString = callingURL.substring(callingURL.indexOf('=')+1,callingURL.length);   //sacamos el valor del id_ue
          //var Id_ue = cgiString;
 
    var param = new Object();
    param["id_ue"] = id_ue;
    
   
    
    var url="CargaFilasP12";  
    $.post(url,param,function(listaIdent){   
    // alert(listaIdent);
            var icapas = listaIdent.length;
            var fila = "";  //option
           // var option2 = "";
           $("#lis_filas").empty();
       
       
  
   if(listaIdent.length !== 0){ //SI no esta vacio el arrayList
       
       $("#lis_filas").append('<tr><td class="cabeReg" style="font-weight: bold;"> Fecha entrega</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Entrega:</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Nombre del responsable en OC que entrega la información </td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Nombre del responsable que recibe la información  </td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Nombre del archivo</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;">Cantidad de Registros</td>\n\
                                      <td colspan="3" class="cabeReg" style="font-weight: bold;"> Acción</td></tr>');    

            for (var i=0; i<icapas; i++){
                     var elemento = listaIdent[i];
                    
                     var tipo_entrega = elemento.tipo_entrega; 
          
                if(tipo_entrega==="A Direccion Regional"){
                    fila = '<tr class="hov"><td>'+ elemento.fec_dr+'</td>\n\
                                <td>'+ elemento.tipo_entrega+'</td>\n\
                                <td>'+ elemento.nom_resp_ocent+'</td>\n\
                                <td>'+ elemento.nom_resp_drec+'</td>\n\
                                <td>'+ elemento.arch_dr+'</td>\n\
                                <td>'+ elemento.cant_dr+'</td>\n\
                                <td class="center"> <a onclick="javascript:carga_dat_actP12('+elemento.id_dae+')"> <span class="icon-edit"></span><span class="text-e">Editar </span></a> </td>\n\
                                <td class="center"> <a href="elimina_reg_ent_fis.jsp?id_dae='+elemento.id_dae+'"> <span class="icon-trashcan"></span><span class="text-e">Eliminar</span> </a> </td></tr>' ;
                              $("#lis_filas").append(fila);
                         
                }else if (tipo_entrega==="A Unidad del Estado"){
                      fila = '<tr class="hov"><td>'+ elemento.fec_ue+'</td>\n\
                                <td>'+ elemento.tipo_entrega+'</td>\n\
                                <td>'+ elemento.nom_resp_drent+'</td>\n\
                                <td>'+ elemento.nom_resp_uerec+'</td>\n\
                                <td>'+ elemento.arch_ue+'</td>\n\
                                <td>'+ elemento.cant_ue+'</td>\n\
                                <td class="center"> <a onclick="javascript:carga_dat_actP12('+elemento.id_dae+')"> <span class="icon-edit"></span><span class="text-e">Editar </span></a> </td>\n\
                                <td class="center"> <a href="elimina_reg_ent_fis.jsp?id_dae='+elemento.id_dae+'"> <span class="icon-trashcan"></span><span class="text-e">Eliminar</span> </a> </td></tr>' ;
                              $("#lis_filas").append(fila);
                
                }          
                          
             } 
   

   }else{
          $("#lis_filas").append('<tr><td class="center" style=" background:none; padding:8px 0; font-size:18px; border:none;"> NO HAY REGISTROS AGREGADOS</td></tr>');    
   }


    });    
}    
/*---------------------------------FUNCION CARGA ACTUALIZA---------------------------------------------*/

function carga_dat_actP12(id_dae){
   // alert(id_ue);  //probar que manda el ID
    
        var param = new Object();
    param["id_dae"] = id_dae;
    
    var url="CargaP12";  
    $.post(url,param,function(listaIdent){   
   //alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP12 = listaIdent[0];
         
      
        if(listaIdent.length > 0){  //Si encuentra Algún registro
         /*   if(elementoP12.fecha_ofic2 ==="01/01/0001"){
              elementoP12.fecha_ofic2 = "";  
            }*/
       
        
            $("#fecha_ent12").val(elementoP12.fec_dr);
                if(elementoP12.fec_dr==="01/01/0001"){
                       $("#fecha_ent12").val("");
                   }else{}
                   
            $("#nom_resp_oc").val(elementoP12.nom_resp_ocent);
            $("#resp_rec_dr").val(elementoP12.nom_resp_drec);
            $("#nom_archdr").val(elementoP12.arch_dr);
            $("#cant_regdr").val(elementoP12.cant_dr);
                    if(elementoP12.cant_dr==="0"){$("#cant_regdr").val("");}
                    else{}
                
            $("#fecha_ent_ue").val(elementoP12.fec_ue);
                   if(elementoP12.fec_ue==="01/01/0001"){
                       $("#fecha_ent_ue").val("");
                   }else{}
            $("#nom_resp_dr").val(elementoP12.nom_resp_drent);  
            $("#resp_reci_ue").val(elementoP12.nom_resp_uerec);  
            $("#nom_arch_ue").val(elementoP12.arch_ue);  
            $("#cant_reg_ue").val(elementoP12.cant_ue);  
                if(elementoP12.cant_ue==="0"){$("#cant_reg_ue").val("");}
                else{}
            
             var tipo_entrega = elementoP12.tipo_entrega; 
          
             if(tipo_entrega==="A Direccion Regional"){
                 document.getElementById("chk_adr").checked = true;
                  $('#div_dr').show(700);
                  //$('#div_ue').hide(700); 
            }else if (tipo_entrega==="A Unidad del Estado"){
                 document.getElementById("chk_aue").checked =true;
                 $('#div_ue').show(700); 
                 //$('#div_dr').hide(700);
            }
       
           $("#id_dae").val(id_dae);//Mandamos el id_entrega 
            
           $("#actualizar").css("display","inline-block");
           $(".boton_delete").css("display","inline-block");
           $("#guarda_reg").css("display","none");
         
        } 
    }
            
            
            );
    
    
    
}



