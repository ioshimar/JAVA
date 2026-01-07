/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function carga_actualizaP1(id_ue){
   // alert(id_entrega);  //probar que manda el ID
    
        var param = new Object();
    param["id_ue"] = id_ue;
    
    var url="CargaP1";  
    $.post(url,param,function(listaIdent){   
    // alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP1 = listaIdent[0];
         
      
        if(listaIdent.length > 0){  //Si encuentra Algún registro
         /*   if(elementoP1.fecha_ofic2 ==="01/01/0001"){
              elementoP1.fecha_ofic2 = "";  
            }*/
            
            $("#fecha_ofic").val(elementoP1.fec_pri_env);       //Nota lo que va despues de (elementoP1.ejemplo) (debe de estar como lo declaramos en FilasDTOp5.java)
                if(elementoP1.fec_pri_env==="01/01/0001"){
                    $("#fecha_ofic").val("");
                }else{}
                
            $("#fecha_resp").val(elementoP1.fec_pri_res);
                if(elementoP1.fec_pri_res==="01/01/0001"){ // si trae este resultado...
                  $("#fecha_resp").val("");  
                }else{}
                
                
            $("#fecha_ofic2").val(elementoP1.fec_seg_env);
                if(elementoP1.fec_seg_env ==="01/01/0001"){
                     $("#fecha_ofic2").val("");
                }else{}
                
            $("#fecha_resp2").val(elementoP1.fec_seg_res);
                if(elementoP1.fec_seg_res==="01/01/0001"){
                    $("#fecha_resp2").val("");
                }else{}
                
                
            $("#fecha_ofic3").val(elementoP1.fec_ter_env);
                if(elementoP1.fec_ter_env ==="01/01/0001"){
                     $("#fecha_ofic3").val("");
                }else{}
                
            $("#fecha_resp3").val(elementoP1.fec_ter_res);
                if(elementoP1.fec_ter_res==="01/01/0001"){
                    $("#fecha_resp3").val("");
                }else{}    
                
            
            $("#motivo").val(elementoP1.motivo);
            $("#nom_destinatario").val(elementoP1.nombre_destin1);
            $("#nom_remitente").val(elementoP1.nombre_remi1);
            $("#nom_destinatario2").val(elementoP1.nombre_destin2);
            $("#nom_remitente2").val(elementoP1.nombre_remi2);
            $("#nom_destinatario3").val(elementoP1.nombre_destin3);
            $("#nom_remitente3").val(elementoP1.nombre_remi3);
            $("#observaciones").val(elementoP1.observaciones);
         //   $("#file_oficio1").val(elementoP1.ruta_ofi_env1);
          //  $("#file_resp1").val(elementoP1.ruta_ofi_recib1);
           /* $("#file_oficio2").val(elementoP1.ruta_ofi_env2);
            $("#file_resp2").val(elementoP1.ruta_ofi_recib2);
            $("#file_oficio3").val(elementoP1.ruta_ofi_env3);
            $("#file_resp3").val(elementoP1.ruta_ofi_recib3);*/
            
            var Respuesta1 = elementoP1.respuesta1;
            var Respuesta2 = elementoP1.respuesta2;
            var Respuesta3 = elementoP1.respuesta3;
          
        var fechas_1er_oficio = elementoP1.fechas_primer_oficio;    
        var fechas_2do_oficio = elementoP1.fechas_segundo_oficio;  
        var fechas_3er_oficio = elementoP1.fechas_tercer_oficio; 
        
        var activa_2of = elementoP1.activa_2of;
        var activa_3of = elementoP1.activa_3of;
        //alert(activa_2of);
        var privilegio = elementoP1.privilegio;
       
        
         
        var acepto = elementoP1.acepto;
        
         var que_acepto = elementoP1.que_acepto;  
         var arryaQueAcepto = que_acepto.split(", "); //convertimos en array la variable "que_acepto", usando el .split separado por coma y un espacio (, )
       
         // alert(elementoP1.id_concer);
            
            if(Respuesta1 ==="NO"){
                document.getElementById("first_resp").checked =true;  //marcamos el primer Check de Sin respuesta
                $("#fecha_ofic, #fecha_resp, #nom_destinatario, #nom_remitente, #file_oficio1, #file_resp1").attr("disabled",true); //deshabilitamos estos input
               
                 $("#div_fechas2").show(700);
            }else{}
            
            if(activa_2of ===true){ //---------------- NOTA: *el valor lo traigo como boolean desde la BD, por eso el true
                 document.getElementById("activa_2doOf").checked =true;
                $("#div_fechas2").show(700); 
            }
            
            if(Respuesta2 ==="NO"){
                document.getElementById("second_resp").checked =true; //marcamos el Segundo Check de Sin respuesta
               $("#fecha_ofic2, #fecha_resp2, #nom_destinatario2, #nom_remitente2, #file_oficio2, #file_resp2").attr("disabled", true); 
            
                $("#div_fechas3").show(700);
            }else{}
            
             if(activa_3of ===true){
                 document.getElementById("activa_3erOf").checked =true;
                 $("#div_fechas3").show(700);
             }
            
             if(Respuesta3 ==="NO"){
                document.getElementById("third_resp").checked =true; //marcamos el Tercer Check de Sin respuesta
                document.getElementById("fecha_resp3").disabled =true; //deshabilitamos la tercer respuesta
            }else{}
            
            if(acepto==="SI"){
                 document.getElementById("acepto_si").checked = true;
                  $('#condicionSi').show(700); 
            }else if (acepto==="NO"){
                 document.getElementById("acepto_no").checked =true;
                 $('#condicionNo').show(700); 
            }else if(acepto==="SR"){
                document.getElementById("acept_sinresp").checked =true;
            } else{}
            
           
            
          
            
            if(arryaQueAcepto.indexOf("Generar y/o actualizar la CURT") >= 0){ // si encontró algo, (devolvió un número mayor o igual a cero) marcar el check
                document.getElementById("gen_curt").checked =true; 
            }else{}
            
             if(arryaQueAcepto.indexOf("Recibir capacitación sobre la Norma Técnica de la CURT") >= 0){// si encontró algo, (devolvió un número mayor o igual a cero) marcar el check
               document.getElementById("cap_curt").checked =true; 
            }else{}
            
             if(arryaQueAcepto.indexOf("Otro") >= 0){// si encontró algo, (devolvió un número mayor o igual a cero) marcar el check
               document.getElementById("otro").checked =true; 
            }else{}
            
            
            if(fechas_1er_oficio==="sin fechas"){
                 document.getElementById("sin_fechas1").checked = true;
                // $("#fecha_ofic, #fecha_resp, #fecha_ofic2, #fecha_resp2, #fecha_ofic3, #fecha_resp3").attr("disabled", true); //deshabilito todos los input fecha
                // $("#first_resp, #sin_fechas2, #second_resp,  #sin_fechas3, #third_resp").attr("disabled",true); // deshabilito los checkbox
                 $('#cont_fechas').find('input, textarea, select').attr("disabled",true);
                 $("#cont_fechas").hide(700);  //ocultamos el div 
                 $("#div_acepto").hide(700);
            }else{}
            
            if(fechas_2do_oficio === "sin fechas"){
               document.getElementById("sin_fechas2").checked =true;
               
               document.getElementById("fecha_ofic2").disabled = true;//deshabilito la 3er fecha
               document.getElementById("fecha_resp2").disabled = true; //deshabilito la 4ta fecha
               $(".backdiv2").hide(700);
               $("#div_acepto").hide(700);
               
                $("#second_resp").attr("disabled",true); // deshabilito los checkbox
                $("#second_resp").removeAttr('checked');
              
            }else{}
            
            
            
            if(fechas_3er_oficio === "sin fechas"){
               document.getElementById("sin_fechas3").checked =true;
               
               document.getElementById("fecha_ofic3").disabled = true;//deshabilito la 3er fecha
               document.getElementById("fecha_resp3").disabled = true; //deshabilito la 4ta fecha
               $(".backdiv3").hide(700);
               $("#div_acepto").hide(700);
               
                $("#third_resp").attr("disabled",true); // deshabilito los checkbox
                $("#third_resp").removeAttr('checked');
              
            }else{}
            
            var concerta = elementoP1.concerta;
            if(concerta==="NO"){
                document.getElementById("concerta").checked =true;  
                $("#fld_concert").hide(500);
            }else{
                $("#fld_concert").show(500);
            }
            
           //$("#id_ue").val(id_ue);//Mandamos el id_ue*/
            
           $("#actualizar").css("display","inline-block");
           $(".boton_delete").css("display","inline-block");
           $("#guarda_reg").css("display","none");
           
        
           var inp_privilegio = $("#privilegio").val();// tomamos el valor que tiene el input privilegio
           
           //alert(inp_privilegio.indexOf(privilegio));
           
         //  if(inp_privilegio.indexOf(privilegio) >= 0){  //buscamos en el input si contiene REGIONAL O ESTATAL
           if( $("#privilegio").val() === privilegio){  //Si el input Privilegio es igual a lo que trae el campo privilegio... o ADMIN
              // alert("simon");
              //Todo como si nada, (muestra los botones de actualizar, eliminar...)
               
           }else{
              // alert("nel");
              $("#actualizar").css("display","none");   //btn Actualizar
              $("#guarda_reg").css("display","none");   //btn Guardar
              $(".boton_delete").css("display","none"); //btn eliminar
              $("table#lis_filas_curtp1").css("display","none"); //btn subir docmentos
              $("#cont_formulario").find('input, textarea, select').attr("disabled",true);  //deshabilito todo el formulario
              $(".bcancelar").attr("disabled",false); //solo hanilito el de Regresar
              $("#cont_formulario").find('input, textarea, select').attr("title",'No cuentas con permisos para modificar'); //mando una leyenda en el hover de cualquier input
              
           }
         
        } 
    }
            
            
            );
    
    
    
}

