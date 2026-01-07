
/*Función para guardar los datos*/
function Agrega_entfis(){
   
   var form = document.getElementById("form_entregaP5");
   
   var verificar = true;
   
     var id_ue5 = form.id_ue5.value;
        var fecha_dat = form.fecha_dat.value;
        var nom_resp  = form.nom_resp.value;
        var nom_ua = form.nom_ua.value;
        var resp_estr =form.resp_estr.value;
        var medio_udo = form.medio_udo.value;
        var nom_arch =form.nom_arch.value;
        var tamano =form.tamano.value;
        var no_reg = form.no_reg.value;
        var pred_con_curt = form.pred_con_curt.value;
        var pred_sin_curt = form.pred_sin_curt.value;
        
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
             
       var entrega_web = document.getElementById("entrega_web") ;    
       var entrega_fis = document.getElementById("entrega_fis") ;        
             
        if(!selectTipoEntre){
                     alert("Selecciona una opción");
                            setTimeout(function() { document.getElementById('entrega_web').focus(); }, 10);
                            return false;
                }else{}     
        
     
 if(entrega_web.checked){ //solo validamos estos campos ...
            if(!fecha_dat){ /*si esta vacio campo nombre...*/
              alert("Ingresa la fecha");
              setTimeout(function() { document.getElementById('fecha_dat').focus(); }, 10);
              return false;
         }
         
         else if(!nom_resp){ /*si esta vacio campo nombre...*/
            alert("El nombre del Responsable no puede estar vacio, puedes agregar N/A");
            setTimeout(function() { document.getElementById('nom_resp').focus(); }, 10);
            return false;
       }

         else if(!nom_arch){ /*si esta vacio campo nombre...*/
              alert("Ingresa el nombre del archivo");
              setTimeout(function() { document.getElementById('nom_arch').focus(); }, 10);
              return false;
         }
         else if(!tamano){ /*si esta vacio campo nombre...*/
              alert("Ingresa el tamaño del archivo en MB");
              setTimeout(function() { document.getElementById('tamano').focus(); }, 10);
              return false;
         }

         else if(!tamano.match(valida_num)){ /*si esta vacio campo nombre...*/
                alert("Este campo solo acepta valores númericos");
                     setTimeout(function() { document.getElementById('tamano').focus(); }, 10);
                     return false;
         }
         else if(!no_reg){ /*si esta vacio campo nombre...*/
              alert("Ingresa el número de registros");
              setTimeout(function() { document.getElementById('no_reg').focus(); }, 10);
              return false;
         }

         else if(!no_reg.match(valida_num)){ /*si esta vacio campo nombre...*/
              alert("Este campo solo acepta valores númericos");
              setTimeout(function() { document.getElementById('no_reg').focus(); }, 10);
              return false;
         }
         
         else if(!pred_con_curt){ /*si esta vacio campo nombre...*/
              alert("Ingresa los predios con curt");
              setTimeout(function() { document.getElementById('pred_con_curt').focus(); }, 10);
              return false;
         }

         else if(!pred_con_curt.match(valida_num)){ /*si esta vacio campo nombre...*/
              alert("Este campo solo acepta valores númericos");
              setTimeout(function() { document.getElementById('pred_con_curt').focus(); }, 10);
              return false;

          }
          
          else if(!pred_sin_curt){ /*si esta vacio campo nombre...*/
              alert("Ingresa los predios sin curt");
              setTimeout(function() { document.getElementById('pred_sin_curt').focus(); }, 10);
              return false;
         }

         else if(!pred_sin_curt.match(valida_num)){ /*si esta vacio campo nombre...*/
              alert("Este campo solo acepta valores númericos");
              setTimeout(function() { document.getElementById('pred_sin_curt').focus(); }, 10);
              return false;

          }
   
 }
    
else if(entrega_fis.checked){
    
   
   if(!fecha_dat){ /*si esta vacio campo nombre...*/
	alert("Ingresa la fecha");
	setTimeout(function() { document.getElementById('fecha_dat').focus(); }, 10);
	return false;
   }
   
  else if(!nom_resp){ /*si esta vacio campo nombre...*/
	alert("Ingresa el nombre del responsable");
	setTimeout(function() { document.getElementById('nom_resp').focus(); }, 10);
	return false;
   }
   else if(!nom_ua){ /*si esta vacio campo nombre...*/
	alert("Ingresa el nombre de la Unidad administrativa");
	setTimeout(function() { document.getElementById('nom_ua').focus(); }, 10);
	return false;
   }
   
   else if(!resp_estr){ /*si esta vacio campo nombre...*/
	alert("Ingresa el nombre del responsable que recibe la información");
	setTimeout(function() { document.getElementById('resp_estr').focus(); }, 10);
	return false;
   }
   else if(!medio_udo){ /*si esta vacio campo nombre...*/
	alert("Ingresa el nombre del medio utilizado para la entrega");
	setTimeout(function() { document.getElementById('medio_udo').focus(); }, 10);
	return false;
   }
   else if(!nom_arch){ /*si esta vacio campo nombre...*/
	alert("Ingresa el nombre del archivo");
	setTimeout(function() { document.getElementById('nom_arch').focus(); }, 10);
	return false;
   }
   else if(!tamano){ /*si esta vacio campo nombre...*/
	alert("Ingresa el tamaño del archivo en MB");
	setTimeout(function() { document.getElementById('tamano').focus(); }, 10);
	return false;
   }
   
   else if(!tamano.match(valida_num)){ /*si esta vacio campo nombre...*/
	  alert("Este campo solo acepta valores númericos");
               setTimeout(function() { document.getElementById('tamano').focus(); }, 10);
               return false;
   }
    else if(!no_reg){ /*si esta vacio campo nombre...*/
	alert("Ingresa el número de registros");
	setTimeout(function() { document.getElementById('no_reg').focus(); }, 10);
	return false;
   }
   
   else if(!no_reg.match(valida_num)){ /*si esta vacio campo nombre...*/
	alert("Este campo solo acepta valores númericos");
	setTimeout(function() { document.getElementById('no_reg').focus(); }, 10);
	return false;
   
    }
    
    else if(!pred_con_curt){ /*si esta vacio campo nombre...*/
              alert("Ingresa los predios con curt");
              setTimeout(function() { document.getElementById('pred_con_curt').focus(); }, 10);
              return false;
         }

         else if(!pred_con_curt.match(valida_num)){ /*si esta vacio campo nombre...*/
              alert("Este campo solo acepta valores númericos");
              setTimeout(function() { document.getElementById('pred_con_curt').focus(); }, 10);
              return false;

          }
          
          else if(!pred_sin_curt){ /*si esta vacio campo nombre...*/
              alert("Ingresa los predios sin curt");
              setTimeout(function() { document.getElementById('pred_sin_curt').focus(); }, 10);
              return false;
         }

         else if(!pred_sin_curt.match(valida_num)){ /*si esta vacio campo nombre...*/
              alert("Este campo solo acepta valores númericos");
              setTimeout(function() { document.getElementById('pred_sin_curt').focus(); }, 10);
              return false;

          }
    
}   //entrega fisica
else{}
   
/*
    if (verificar === true){
      
        var url = "GrabaEntregaFisica";
        var param = new Object();
        param["id_ue5"] = id_ue5;            
        param["fecha_dat"] = fecha_dat;            
        param["nom_resp"] = nom_resp;
        param["nom_ua"] = nom_ua;
        param["resp_estr"] = resp_estr;
        param["medio_udo"] =  medio_udo; 
        param["nom_arch"] =  nom_arch; 
        param["tamano"] =  tamano; 
        param["no_reg"] =  no_reg;
        
            $.post(url,param,function(listadoMuns){
            });                         
        alert("Infromación agregada correctamente");
        //var conta = form.Ocu_conta.value;
      //  conta++;
        
        
        //Corremos la funcion carga para que mueste las capas que se han agregado
        carga();
        
        //Se vuelven a poner los valores vacios otra vez
        form.nom_arch.value = "";
        form.tamano.value = "";
        form.no_reg.value ="";
       // form.Ocu_conta.value = conta;        
    }	
    */
    
     $("input,textarea,select").removeAttr("disabled"); //remover el atributo DISABLED para que se envien los datos 
           var dataString = $('#form_entregaP5').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "GrabaEntregaFisica",
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
                      
                            
                       // alert(data);
                       //location.href = "captura.jsp?ue="+id_ue;
               
                        carga(id_ue5);   //mandamos el Id
                        //Se vuelven a poner los valores vacios otra vez
                            form.nom_arch.value = "";
                            form.tamano.value = "";
                            form.no_reg.value ="";
                       
                    }
                });
                  return false;
    

    
    //else{}
} 




/*----------------------------------------------FUNCION PARA CARGAR LAS FILAS en la tabla #lis_filas  -----------------------------------------------*/

function carga(id_ue){
  
  //  var callingURL = document.URL;
       // var cgiString = callingURL.substring(callingURL.indexOf('=')+1,callingURL.length);   //sacamos el valor del id_ue
          //var Id_ue = cgiString;
 
    var param = new Object();
    param["id_ue"] = id_ue;
    
   
    
    var url="CargaFilasP5";  
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
  // var result_frame = document.getElementById("result_frame");
   if(listaIdent.length !== 0){ //SI no esta vacio el arrayList
          $("#lis_filas").append('<tr><td class="cabeReg" style="font-weight: bold;"> Fecha</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Responsable UE Entrega</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Unidad Administrativa</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Responsable que recibe</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;">Medio Utilizado</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Nombre archivo</td> \n\
                                      <td class="cabeReg" style="font-weight: bold;"> Tamaño</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> No. de Registros</td>\n\
                                      <td colspan="3" class="cabeReg" style="font-weight: bold;"> Acción</td></tr>');    

                for (var i=0; i<icapas; i++){
                    var elemento = listaIdent[i];
                    fila = '<tr class="hov"><td>'+ elemento.fecha+'</td>\n\
                                <td>'+ elemento.nom_resp_ent+'</td>\n\
                                <td>'+ elemento.unidad_admin+'</td>\n\
                                <td>'+ elemento.nom_resp_rec+'</td>\n\
                                <td>'+ elemento.medio+'</td>\n\
                                <td>'+ elemento.nom_archivo+'</td> \n\
                                <td>'+elemento.tamano+' MB </td>\n\
                                <td>'+elemento.total_reg+'</td>\n\
                                <td class="center"> <a onclick="javascript:carga_actualizaP5('+elemento.id_entrega+')"> <span class="icon-edit"></span><span class="text-e">Editar </span></a> </td>\n\
                                <td class="center"> <a href="cobertura.jsp?ue='+id_ue+'&entrega=' +elemento.id_entrega+' "> <span class="icon-folder-open-o"></span><span class="text-e">Cobertura del .ZIP</span> </a> </td>\n\
                                <td class="center"> <a href="elimina_reg_ent_fis.jsp?id_entrega='+elemento.id_entrega+'&id_ue='+id_ue+'"> <span class="icon-trashcan"></span><span class="text-e">Eliminar</span> </a> </td></tr>' ;
                              $("#lis_filas").append(fila);
                              
                              //elimina_reg_ent_fis.jsp?id_entrega='+elemento.id_entrega+'
                } 
      //  }     

   }else{
          $("#lis_filas").append('<tr><td class="center" style=" background:none; padding:8px 0; font-size:18px; border:none;"> NO HAY REGISTROS AGREGADOS</td></tr>');    
   }


    });    
}    

/*ESTE NO SE USA AÚN*/
function cargaFrame(id_entrega){
   // $("#frame").show();
    document.getElementById("frame").style.display = "block";
     var memURL = "elimina_reg_ent_fis.jsp?id_entrega="+id_entrega;
        window.open( memURL, 'result_frame');
        
}



/* ----------------------------------------- FUNCION que CARGA los datos para actualizar -----------------------------------------------*/

function carga_actualizaP5(id_entrega){
   // alert(id_entrega);  //probar que manda el ID
    
        var param = new Object();
    param["id_entrega"] = id_entrega;
    
    var url="CargaP5";  
    $.post(url,param,function(listaIdent){   
    // alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP5 = listaIdent[0];
            
            var tipo_entrega = elementoP5.tipo_entrega;
            
            if(tipo_entrega==="app_web"){
               document.getElementById("entrega_web").checked =true; 
                $('#div_ent_fis').hide(700); 
                $('#div_ent_fis').find('input, textarea, select').val(''); //resetamos el valor
            }else{}
            
            if(tipo_entrega==="ent_fis"){
                document.getElementById("entrega_fis").checked =true;
                $('#div_ent_fis').show(700); 
            }else{}
            
            $("#fecha_dat").val(elementoP5.fecha);       //Nota lo que va despues de (elementoP5.ejemplo) (debe de estar como lo declaramos en FilasDTOp5.java)
            $("#nom_resp").val(elementoP5.nom_resp_ent);
            $("#nom_ua").val(elementoP5.unidad_admin);
            $("#resp_estr").val(elementoP5.nom_resp_rec);
            $("#medio_udo").val(elementoP5.medio);
            $("#nom_arch").val(elementoP5.nom_archivo);
            $("#tamano").val(elementoP5.tamano);
            $("#no_reg").val(elementoP5.total_reg);
            $("#pred_con_curt").val(elementoP5.pred_con_curt);
            $("#pred_sin_curt").val(elementoP5.pred_sin_curt);
            
           $("#nom_arch, #tamano, #no_reg, #pred_con_curt, #pred_sin_curt").attr('disabled', true); //lo deshabilitamos
            
            $("#id_entrega").val(id_entrega);//Mandamos el id_entrega 
            
            $("#actualizar").css("display","inline-block");
            $("#nuevo_reg").css("display","inline-block");
            $("#agrega_reg").css("display","none");
    });
    
    
  
    
    
}