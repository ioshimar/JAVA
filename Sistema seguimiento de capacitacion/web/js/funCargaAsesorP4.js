/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function carga_actualizaP4(id_ue){
   // alert(id_ue);  //probar que manda el ID
    
        var param = new Object();
    param["id_ue"] = id_ue;
    
    var url="CargaP4";  
    $.post(url,param,function(listaIdent){   
   // alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP4 = listaIdent[0];
         
      
        if(listaIdent.length > 0){  //Si encuentra Algún registro
         /*   if(elementoP4.fecha_ofic2 ==="01/01/0001"){
              elementoP4.fecha_ofic2 = "";  
            }*/
            
          //  $("#sol_registro").val(elementoP4.fec_sol_reg);       //Nota lo que va despues de (elementoP4.ejemplo) (debe de estar como lo declaramos en FilasDTOp4.java)
            $("#fecha_ini").val(elementoP4.fec_ini_regue);    
            $("#fecha_fin").val(elementoP4.fec_fin_regue);
            $("#name_resp").val(elementoP4.nom_resp_ue);
            $("#name_ase").val(elementoP4.nom_reci_ue);  
            $("#fecha_ini_ap").val(elementoP4.fec_ini_ap);  
            $("#fecha_fin_ap").val(elementoP4.fec_fin_ap);  
            $("#name_resp_ap").val(elementoP4.nom_resp_ap);
            $("#name_ase_ap").val(elementoP4.nom_reci_ap);
            $("#fecha_ini_conv").val(elementoP4.fec_ini_cord);
            $("#fecha_fin_conv").val(elementoP4.fec_fin_cord);
            $("#name_resp_conv").val(elementoP4.nom_resp_cord);
            $("#name_ase_conv").val(elementoP4.nom_rec_cord);
            $("#fecha_ini_est").val(elementoP4.fec_ini_est);
            $("#fecha_fin_est").val(elementoP4.fec_fin_est);
            $("#name_resp_est").val(elementoP4.nom_resp_est);
            $("#name_ase_est").val(elementoP4.nom_rec_est);
            $("#fecha_ini_ref").val(elementoP4.fec_ini_info);
            $("#fecha_fin_ref").val(elementoP4.fec_fin_info);
            $("#name_resp_ref").val(elementoP4.nom_resp_info);
            $("#name_ase_ref").val(elementoP4.nom_rec_info);
            $("#fecha_ini_int").val(elementoP4.fec_ini_inte);
            $("#fecha_fin_int").val(elementoP4.fec_fin_inte);
            $("#name_resp_int").val(elementoP4.nom_resp_inte);
            $("#name_ase_int").val(elementoP4.nom_rec_inte);
            
            
            
            /*si las fechas traen 01/01/0001, poner el valor vacio*/
            if(elementoP4.fec_ini_regue==="01/01/0001"){ $("#fecha_ini").val(""); }
            if(elementoP4.fec_fin_regue==="01/01/0001"){ $("#fecha_fin").val(""); }
            if(elementoP4.fec_ini_ap==="01/01/0001"){ $("#fecha_ini_ap").val(""); }
            if(elementoP4.fec_fin_ap==="01/01/0001"){ $("#fecha_fin_ap").val(""); }
            if(elementoP4.fec_ini_cord==="01/01/0001"){ $("#fecha_ini_conv").val(""); }
            if(elementoP4.fec_fin_cord==="01/01/0001"){ $("#fecha_fin_conv").val(""); }
            if(elementoP4.fec_ini_est==="01/01/0001"){ $("#fecha_ini_est").val(""); }
            if(elementoP4.fec_fin_est==="01/01/0001"){ $("#fecha_fin_est").val(""); }
            if(elementoP4.fec_ini_info==="01/01/0001"){ $("#fecha_ini_ref").val(""); }
            if(elementoP4.fec_fin_info==="01/01/0001"){ $("#fecha_fin_ref").val(""); }
            if(elementoP4.fec_ini_inte==="01/01/0001"){ $("#fecha_ini_int").val(""); }
            if(elementoP4.fec_fin_inte==="01/01/0001"){ $("#fecha_fin_int").val(""); }
            
            
              var Tipoasesoria = elementoP4.tipo_asesoria;  
               var arryaTipoAsesoria = Tipoasesoria.split(", "); //convertimos en array la variable "que_acepto", usando el .split separado por coma y un espacio (, )
          
            
            if(arryaTipoAsesoria.indexOf("Registro de la UE en el aplicativo") >= 0){ // si encontró algo, (devolvió un número mayor o igual a cero) marcar el check
                document.getElementById("chk_reg_ue").checked =true; 
                $('#div_reg_ue').show(700);
            }else{}
            
            if(arryaTipoAsesoria.indexOf("Uso y manejo del aplicativo") >= 0){ // si encontró algo, (devolvió un número mayor o igual a cero) marcar el check
                document.getElementById("chk_usoapp").checked =true; 
                 $('#div_usoapp').show(700);
            }else{}
            
            if(arryaTipoAsesoria.indexOf("Convertir coordenadas cartesianas a geográficas") >= 0){ // si encontró algo, (devolvió un número mayor o igual a cero) marcar el check
                document.getElementById("chk_coord").checked =true; 
                 $('#div_coord').show(700); 
            }else{}
            
            if(arryaTipoAsesoria.indexOf("Estructuración de la información") >= 0){ // si encontró algo, (devolvió un número mayor o igual a cero) marcar el check
                document.getElementById("chk_estr").checked =true; 
                $('#div_estr').show(700);
            }else{}
            
            if(arryaTipoAsesoria.indexOf("Convertir información de un sistema de referencia geodésico a otro") >= 0){ // si encontró algo, (devolvió un número mayor o igual a cero) marcar el check
                document.getElementById("chk_convert").checked =true; 
                 $('#div_convert').show(700); 
            }else{}
            
            if(arryaTipoAsesoria.indexOf("Interpretación de los resultados de generación/actualización de la CURT") >= 0){ // si encontró algo, (devolvió un número mayor o igual a cero) marcar el check
                document.getElementById("chk_interp").checked =true; 
                $('#div_interp').show(700); 
            }else{}
            
            
            
         // alert(elementoP4.id_concer);
         
           //$("#id_ue").val(id_ue);//Mandamos el id_ue*/
            
           $("#actualizar").css("display","inline-block");
           $(".boton_delete").css("display","inline-block");
           $("#guarda_reg").css("display","none");
         
        } 
    });
    
     /*-----------------PARA VERIFICAR el privilegio que tiene el campo en la tabla concertación-------------------*/
       var paramC1 = new Object();
                   paramC1["id_ue"] = id_ue;
                   var urlC1="CargaP1";  
            $.post(urlC1,paramC1,function(listaIdent_C1){
                       var elemento_P1 = listaIdent_C1[0];
                       
                if(listaIdent_C1.length > 0){  //Si encuentra Algún registro
                     var privilegio = elemento_P1.privilegio;  //Est o Reg
                     if( $("#privilegio").val() === privilegio){  //Si el input Privilegio es igual a lo que trae el campo privilegio...
                            //Todo como si nada, (muestra los botones de actualizar, eliminar...)
                     }else{
                       // alert("nel");
                       $("#actualizar").css("display","none");   //btn Actualizar
                       $("#guarda_reg").css("display","none");   //btn Guardar
                       $(".boton_delete").css("display","none"); //btn eliminar
                       $("#cont_formulario").find('input, textarea, select').attr("disabled",true);  //deshabilito todo el formulario
                       $(".bcancelar").attr("disabled",false); //solo hanilito el de Regresar
                       $("#cont_formulario").find('input, textarea, select').attr("title",'No cuentas con permisos para modificar'); //mando una leyenda en el hover de cualquier input

                    }
                 }
                else{}
            });
    
    
    
}

