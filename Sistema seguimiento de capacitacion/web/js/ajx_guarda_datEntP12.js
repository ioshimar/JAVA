/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_guardaP12(){
  var id_ue =document.getElementById("id_ue").value;
  var fecha_ent = document.getElementById("fecha_ent").value;    
  var nom_resp_ent = document.getElementById("nom_resp_ent").value;
  var resp_rec =document.getElementById("resp_rec").value;

 var id_archivo = document.getElementById("id_archivo").value;
  var nom_arch =document.getElementById("nom_arch").value;
  var cant_reg =document.getElementById("cant_reg").value;
  /*var fecha_ent_ue =document.getElementById("fecha_ent_ue").value; 
  
  var nom_resp_dr =document.getElementById("nom_resp_dr").value;  
  var resp_reci_ue =document.getElementById("resp_reci_ue").value; 
  var nom_arch_ue =document.getElementById("nom_arch_ue").value; 
  var cant_reg_ue =document.getElementById("cant_reg_ue").value; 
    */
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
  
                if(!fecha_ent){
                    alert("Ingresa la fecha");
                     setTimeout(function() { document.getElementById('fecha_ent').focus(); }, 10);
                    return false;
                 }
               
                else if(!nom_resp_ent){
                    alert("Ingresa el nombre del responsable en OC que entrega");
                    setTimeout(function() { document.getElementById('nom_resp_ent').focus(); }, 10);
                    return false;
                }
               
                else if(!resp_rec){
                        alert("Ingresa el nombre del responsable que recibe");
                        setTimeout(function() { document.getElementById('resp_rec').focus(); }, 10);
                        return false;
                }
                
                else if(!id_archivo){
                        alert("Selecciona un archivo");
                        setTimeout(function() { document.getElementById('id_archivo').focus(); }, 10);
                        return false;
                }
                
                else if(!nom_arch){
                        alert("Ingresa el nombre del archivo");
                        setTimeout(function() { document.getElementById('nom_arch').focus(); }, 10);
                        return false;
                }
                
                else if(!cant_reg){
                        alert("Ingresa la cantidad de registros");
                        setTimeout(function() { document.getElementById('cant_reg').focus(); }, 10);
                        return false;
                }
                
                  else if(!cant_reg.match(valida_num)){
                          alert("Este campo solo acepta valores númericos");
                        setTimeout(function() { document.getElementById('cant_reg').focus(); }, 10);
                        return false;
                }
           
            
     
                
              
     
   //TERMINAN VALIDACIONES             
      
       
           var dataString = $('#curtp12').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "GrabaCurtP12",
                    data: dataString,

                    success: function(data) {
                        
                         $('div#notif').slideDown("swing","linear");
                          document.getElementById("result").innerHTML = data;
                         $('div#notif').fadeOut(5000);//des´parece a los 5 seg 
                        
                            if(data==="Error_al_conectar_la_bd" || data==="Error ya se ha guardado este registro en la Base de Datos, intenta con otro archivo"){
                               $('div#notif').css("background","red"); //cambio el color a rojo
                            }
                            else if(data==="Datos Ingresados correctamente"){
                               $('div#notif').css("background","#00aced");   //cambio a color azul
                               $('div#notif').css("border", "3px solid #71ff38"); //bordes verdes
                                 ResetForm12();
                            }
                        
                      // alert(data);
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
                                      <td class="cabeReg" style="font-weight: bold;"> Nombre del responsable del INEGI que entrega la información </td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Nombre del responsable que recibe la información  </td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Nombre del archivo</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;">Cantidad de Registros</td>\n\
                                      <td colspan="3" class="cabeReg" style="font-weight: bold;"> Acción</td></tr>');    

            for (var i=0; i<icapas; i++){
                     var elemento = listaIdent[i];
                    
                    
             
                    fila = '<tr class="hov"><td>'+ elemento.fecha_entrega+'</td>\n\
                                <td>'+ elemento.nom_resp_ent+'</td>\n\
                                <td>'+ elemento.nom_resp_rec+'</td>\n\
                                <td>'+ elemento.nom_arch+'</td>\n\
                                <td>'+ elemento.cant_reg+'</td>\n\
                                <td class="center"> <a onclick="javascript:carga_dat_actP12('+elemento.id_dae+')"> <span class="icon-edit"></span><span class="text-e">Editar </span></a> </td>\n\
                                <td class="center"> <a href="elimina_entrega_p12.jsp?id_dae='+elemento.id_dae+'&id_ue='+id_ue+'"> <span class="icon-trashcan"></span><span class="text-e">Eliminar</span> </a> </td></tr>' ;
                              $("#lis_filas").append(fila);
                         
                
                          
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
       
        
            $("#fecha_ent").val(elementoP12.fecha_entrega);
                if(elementoP12.fecha_entrega==="01/01/0001"){
                       $("#fecha_ent").val("");
                   }else{}
                   
            $("#nom_resp_ent").val(elementoP12.nom_resp_ent);
            $("#resp_rec").val(elementoP12.nom_resp_rec);
            $("#id_archivo").val(elementoP12.id_entrega);
            $("#nom_arch").val(elementoP12.nom_arch);
            $("#cant_reg").val(elementoP12.cant_reg);
                    if(elementoP12.cant_reg==="0"){$("#cant_reg").val("");}
                    else{}
                
           
            
             var tipo_entrega = elementoP12.tipo_entrega; 
          
             if(tipo_entrega==="A Direccion Regional"){
                 document.getElementById("chk_adr").checked = true;
                 // $('#div_dr').show(700);
                  //$('#div_ue').hide(700); 
            }else if (tipo_entrega==="A Unidad del Estado"){
                 document.getElementById("chk_aue").checked =true;
                 //$('#div_ue').show(700); 
                 //$('#div_dr').hide(700);
            }
       
       
            $("#id_archivo").attr('disabled', true);
            $("#id_archivo").addClass('read');
       
          
           $("#id_dae").val(id_dae);//Mandamos el id_entrega 
            
           $("#actualizar").css("display","inline-block");
           $(".boton_delete").css("display","inline-block");
           $("#guarda_reg").css("display","none");
         
        } 
    }
            
            
            );
    
    
    
}



  function ResetForm12(){
            document.getElementById("curtp12").reset();
              $("#actualizar").css("display","none");  //quitamos el boton actualizar
             // $("#nuevo_reg").css("display","none");  //quitamos el boton Nuevo Reg
              $("#guarda_reg").css("display","inline-block"); //Aparecemos el botón Nuevo Reg
              $("#id_archivo").attr('disabled', false);  //quitamos el disabled
              $("#id_archivo").removeClass('read');
          };