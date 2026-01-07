/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_guardaP6(){
  var id_ue =document.getElementById("id_ue").value;
  var resp_val = document.getElementById("resp_val").value;    
  var fech_ini6 = document.getElementById("fech_ini6").value;
  var fech_ter6 =document.getElementById("fech_ter6").value;
  var f_shape  = document.getElementsByName("f_shape");
  var extension  = document.getElementsByName("extension");
  var estruc  = document.getElementsByName("estruc");    
  var atrib  = document.getElementsByName("atrib");   
  var coord_geo  = document.getElementsByName("coord_geo");   
  var total_reg  = document.getElementsByName("total_reg");  
  var id_archivo = document.getElementById("id_archivo").value;
  
  
  
     //Split de las fechas recibidas para separarlas
                    var x  = fech_ini6.split("/");
                    var z = fech_ter6.split("/");  
                    
            //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fech_ini6_compare = x[1] + "/" + x[0] + "/" + x[2];
            var fech_ter6_compare = z[1] + "/"  + z[0] + "/"  + z[2];      
  
   var selec_shape = false;    // Para validar los Radio Button
            for(var i=0; i < f_shape.length; i++) {    
                   var valor_opcion1 = f_shape[i].value;  //obtener el valor
                if(f_shape[i].checked) {  //validar que se seleccione al menos una
                   selec_shape = true;
                    break;
                }
             }
             
    var selec_exten = false;    // Para validar los Radio Button
            for(var i=0; i < extension.length; i++) {    
                   var valor_opcion2 = extension[i].value;  //obtener el valor
                if(extension[i].checked) {  //validar que se seleccione al menos una
                   selec_exten = true;
                    break;
                }
             }  
             
    var selec_estruc = false;    // Para validar los Radio Button
            for(var i=0; i < estruc.length; i++) {    
                   var valor_opcion3 = estruc[i].value;  //obtener el valor
                if(estruc[i].checked) {  //validar que se seleccione al menos una
                   selec_estruc = true;
                    break;
                }
             }    
             
     var selec_atributo = false;    // Para validar los Radio Button
            for(var i=0; i < atrib.length; i++) {    
                   var valor_opcion4 = atrib[i].value;  //obtener el valor
                if(atrib[i].checked) {  //validar que se seleccione al menos una
                   selec_atributo = true;
                    break;
                }
             } 
             
             
      var selec_coord = false;    // Para validar los Radio Button
            for(var i=0; i < coord_geo.length; i++) {    
                   var valor_opcion5 = coord_geo[i].value;  //obtener el valor
                if(coord_geo[i].checked) {  //validar que se seleccione al menos una
                   selec_coord = true;
                    break;
                }
             }
             
       var selec_total = false;    // Para validar los Radio Button
            for(var i=0; i < total_reg.length; i++) {    
                   var valor_opcion6 = total_reg[i].value;  //obtener el valor
                if(total_reg[i].checked) {  //validar que se seleccione al menos una
                   selec_total = true;
                    break;
                }
             }       
  
  
  
  
  //VALIDACIONES
                if(!id_archivo){
                    alert("Selecciona un archivo");
                     setTimeout(function() { document.getElementById('id_archivo').focus(); }, 10);
                    return false;
                 }
                 
                 else if(!resp_val){
                    alert("Ingresa el responsable de aplicar la validación");
                     setTimeout(function() { document.getElementById('resp_val').focus(); }, 10);
                    return false;
                 }
               
                else if(!fech_ini6){
                    alert("Ingresa la fecha de inicio");
                    setTimeout(function() { document.getElementById('fech_ini6').focus(); }, 10);
                    return false;
                }
               
                else if(!fech_ter6){
                        alert("Ingresa la fecha de Término");
                        setTimeout(function() { document.getElementById('fech_ter6').focus(); }, 10);
                        return false;
                }
                
                else if(Date.parse(fech_ini6_compare) > Date.parse(fech_ter6_compare)){
                        alert("Las fechas no corresponden, la fecha de término debe ser despúes que la fecha de inicio");
                        setTimeout(function() { document.getElementById('fech_ter6').focus(); }, 10);
                        return false;
                                } 
                
                else if(!selec_shape){
                        alert("¿el archivo esta en formato shape?, selecciona una opción,");
                          setTimeout(function() { document.getElementById('f_shapeSi').focus(); }, 10);
                        return false;
                }
                else{}
                
                
           if(valor_opcion1==="SI"){ 
                
                if(!selec_exten){
                        alert("¿Contiene las 4 extensiones mínimas?, selecciona una opción");
                          setTimeout(function() { document.getElementById('extensionSi').focus(); }, 10);
                        return false;
                }
                
                else if(!selec_estruc){
                        alert("¿La estructura del archivo es correcta?, selecciona una opción");
                          setTimeout(function() { document.getElementById('estrucSi').focus(); }, 10);
                        return false;
                }
                
                else if(!selec_atributo){
                     alert("¿Atributos?, selecciona una opción");
                     setTimeout(function() { document.getElementById('atribSi').focus(); }, 10);
                     return false;
                }
                
                else if(!selec_coord){
                    alert("¿La información está en coordenadas geográficas?, selecciona una opción");
                    setTimeout(function() { document.getElementById('coord_geoSi').focus(); }, 10);
                    return false;
                }
                
                else if(!selec_total){
                    alert("¿Coincide con el total de registros?, selecciona una opción");
                    setTimeout(function() { document.getElementById('total_regSi').focus(); }, 10);
                    return false;
                }
            }  
            
                else{}
                
              
     
   //TERMINAN VALIDACIONES             
      
       
           var dataString = $('#curtp6').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "GrabaCurtP6",
                    data: dataString,

                    success: function(data) {
                       //alert(data);
                       carga_resultadosP6(id_ue);
                           $('div#notif').slideDown("swing","linear");
                            document.getElementById("result").innerHTML = data;
                            
                            if(data==="Error ya se ha guardado este registro en la Base de Datos, intenta con otro archivo" || data==="Error_al_conectar_la_bd"){
                               $('div#notif').css("background","red"); //cambio el color a rojo
                            }
                            else if(data==="Datos Ingresados correctamente"){
                               $('div#notif').css("background","#00aced");
                               $('div#notif').css("border", "3px solid #71ff38");
                            }
                       
                       //location.href = "captura.jsp?ue="+id_ue;
                    }
                });
                  return false;
     
    
    
};





function carga_resultadosP6(id_ue){
  
      //var callingURL = document.URL;
      //     var cgiString = callingURL.substring(callingURL.indexOf('=')+1,callingURL.length);   //sacamos el valor del id_ue
      //    var Id_ue = cgiString;
 //alert(Id_ue);
    var param = new Object();
    param["id_ue"] = id_ue;
    
    var url="CargaP6";  
    $.post(url,param,function(listaIdent){   
    // alert(listaIdent);
            var icapas = listaIdent.length;
            var fila = "";  //option
           // var option2 = "";
           $("#lis_filas").empty();
       
       

   
   if(listaIdent.length !== 0){ //SI no esta vacio el arrayList
          $("#lis_filas").append('<tr><td class="cabeReg" style="font-weight: bold;"  width="25%"> Archivo</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;">  ¿Formato Shape?</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> ¿Extensiones (shp, dbf, prj, shx)? </td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> ¿Estructura del archivo  correcta?</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Atributos sin valores nulos </td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> inf. en coordenadas geográficas</td> \n\
                                      <td class="cabeReg" style="font-weight: bold;"> Coincide con el total de registros</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;" colspan="2"> Acción</td></tr>');    

                for (var i=0; i<icapas; i++){
                    var elemento = listaIdent[i];
                    fila = '<tr class="hov"><td>'+ elemento.nom_archivo+'</td>\n\
                                <td>'+elemento.for_shape+'</td>\n\
                                <td>'+elemento.ext_min+'</td>\n\
                                <td>'+elemento.est_cor+'</td>\n\
                                <td>'+elemento.atrib+'</td>\n\
                                <td>'+elemento.info_cord+'</td> \n\
                                <td>'+elemento.code_total+'</td> \n\
                                <td class="center"> <a onclick="javascript:carga_actualizaP6('+elemento.id_val+')"> <span class="icon-edit"></span><span class="text-e">Editar </span></a> </td>\n\
                                <td class="center"> <a href="elimina_cri_vali.jsp?id_validacion='+elemento.id_val+'&ue='+elemento.id_ue+'&entrega='+elemento.id_entrega+'"> <span class="icon-trashcan"></span><span class="text-e">Eliminar</span> </a> </td></tr>' ;
                              $("#lis_filas").append(fila);
                } 
        

   }else{
          $("#lis_filas").append('<tr><td class="center" style=" background:none; padding:8px 0; font-size:18px; border:none;"> NO HAY REGISTROS AGREGADOS</td></tr>');    
   }


    });    
}






function carga_actualizaP6(id_val){
   // alert(id_ue);  //probar que manda el ID
    
        var param = new Object();
    param["id_val"] = id_val;
    
    var url="CargaActualizaP6";  
    $.post(url,param,function(listaIdent){   
   // alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP6 = listaIdent[0];
         
      
        if(listaIdent.length > 0){  //Si encuentra Algún registro
         /*   if(elementoP6.fecha_ofic2 ==="01/01/0001"){
              elementoP6.fecha_ofic2 = "";  
            }*/
            
          //  $("#sol_registro").val(elementoP6.fec_sol_reg);       //Nota lo que va despues de (elementoP6.ejemplo) (debe de estar como lo declaramos en FilasDTOp4.java)
            $("#resp_val").val(elementoP6.nom_respval);    
            $("#fech_ini6").val(elementoP6.fec_ini);
            $("#fech_ter6").val(elementoP6.fec_fin);
           
            var f_shape = elementoP6.for_shape;
            var exte = elementoP6.ext_min;
            var estructura = elementoP6.est_cor;
            var atribu = elementoP6.atrib;
            var coord_geo = elementoP6.info_cord;
            var total_reg = elementoP6.code_total;
            
            
            
            if(f_shape==="SI"){
                document.getElementById("f_shapeSi").checked = true;
                 $('input[name="extension"], input[name="estruc"], input[name="atrib"], input[name="coord_geo"], input[name="total_reg"]').attr("disabled",false); //habilito los radiobuttons
            }else if(f_shape==="NO"){
                document.getElementById("f_shapeNo").checked = true;
                $('input[name="extension"], input[name="estruc"], input[name="atrib"], input[name="coord_geo"], input[name="total_reg"]').attr("disabled",true); //Deshabilito los radiobuttons
                 $('input[name="extension"], input[name="estruc"], input[name="atrib"], input[name="coord_geo"], input[name="total_reg"]').removeAttr('checked');
            }else{}
            
             if(exte==="SI"){
                document.getElementById("extensionSi").checked = true;
            }else if(exte==="NO"){
                document.getElementById("extensionNo").checked = true;
            }else{}
            
            if(estructura==="SI"){
                document.getElementById("estrucSi").checked = true;
            }else if(estructura==="NO"){
                document.getElementById("estrucNo").checked = true;
            }else{}
            
            
             if(atribu==="SI"){
                document.getElementById("atribSi").checked = true;
            }else if(atribu==="NO"){
                document.getElementById("atribNo").checked = true;
            }else{}
            
             if(coord_geo==="SI"){
                document.getElementById("coord_geoSi").checked = true;
            }else if(coord_geo==="NO"){
                document.getElementById("coord_geoNo").checked = true;
            }else{}
            
             if(total_reg==="SI"){
                document.getElementById("total_regSi").checked = true;
            }else if(total_reg==="NO"){
                document.getElementById("total_regNo").checked = true;
            }else{}
            
          
            $("#id_archivo").val(elementoP6.id_entrega);
           $("#id_archivo").attr('disabled', true); //lo deshabilitamos
           $("#id_archivo").addClass('read');
            
            
          $("#id_validacion").val(id_val);//Mandamos el id_generación al input 
            
         // alert(elementoP6.id_concer);
         
           //$("#id_ue").val(id_ue);//Mandamos el id_ue*/
            
            
            $("#actualizar").css("display","inline-block");
            $("#nuevo_reg").css("display","inline-block");
            $("#agrega_reg").css("display","none");
         
        } 
    }
            
            
            );
    
    
    
}






function ResetForm6(){
            document.getElementById("curtp6").reset();
              $("#actualizar").css("display","none");  //quitamos el boton actualizar
            //  $("#nuevo_reg").css("display","none");  //quitamos el boton Nuevo Reg
              $("#agrega_reg").css("display","inline-block"); //Aparecemos el botón Nuevo Reg
              $("#id_archivo").attr('disabled', false);  //quitamos el disabled
              $("#id_archivo").removeClass('read');
          };