/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_guardaP2(){
  var id_ue =document.getElementById("id_ue").value;
  var nom_user =document.getElementById("nom_user").value;
  var fecha_impart = document.getElementById("fecha_impart").value;    
  var lugar = document.getElementById("lugar").value;
  var norma_cat = document.getElementById("norma_cat").value;
  var norma_curt = document.getElementById("norma_curt").value;
  var lineamiento = document.getElementById("lineamiento").value;
  var diccionario = document.getElementById("diccionario").value;
  var responsable =document.getElementById("responsable").value;
  var cantidad_p = document.getElementById("cantidad_p").value;
  var tipo_cap = document.getElementById("tipo_cap").value;
  
  var valida_num=/^([0-9])*$/;
  
    //alert("entre");
    
  
  //VALIDACIONES
  
  
                
            
  
                 if(!fecha_impart){
                    alert("Ingresa la fecha");
                     setTimeout(function() { document.getElementById('fecha_impart').focus(); }, 10);
                    return false;
                 }
               
                else if(!lugar){
                    alert("Ingresa el lugar");
                    setTimeout(function() { document.getElementById('lugar').focus(); }, 10);
                    return false;
                }
                
               
                /*
                else if(!responsable){
                        alert("Ingresa el responsable");
                        setTimeout(function() { document.getElementById('responsable').focus(); }, 10);
                        return false;
                }
                
                */
                
                else if(!cantidad_p){
                        alert("Ingresa la cantidad de personas capacitadas");
                          setTimeout(function() { document.getElementById('cantidad_p').focus(); }, 10);
                        return false;
                 
                }
                
                  else  if(!cantidad_p.match(valida_num)){
                      alert("Este campo solo acepta valores númericos");
                          setTimeout(function() { document.getElementById('cantidad_p').focus(); }, 10);
                        return false;
                  }
                
                else{}
                
              
     
   //TERMINAN VALIDACIONES             
      
       
           var dataString = $('#curtp2').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

             //alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "GrabaCurtP2",
                    data: dataString,

                    success: function(data) {
                       //alert(data);
                      //  location.href = "captura.jsp?ue="+id_ue;
                        // carga_actualizaP2(id_ue);
                        //******************código para la notificación**************
                          $('div#notif').slideDown("swing","linear");
                          document.getElementById("result").innerHTML = data;
                          
                        
                            if(data==="Error_al_conectar_la_bd"){
                                 $('div#notif').css("background","red"); //cambio el color a rojo
                            }
                            else if(data==="Datos Ingresados correctamente"){
                               $('div#notif').css("background","#00aced");   //cambio a color azul
                            }
                        //***************** Termina código notificación *******************
                        ResetFormp2();
                        carga_cap(id_ue);
                    }
                });
                  return false;
     
    
    
};

/*----------------------------------------------FUNCION PARA CARGAR LAS FILAS en la tabla #lis_filas  -----------------------------------------------*/

function carga_cap(id_ue){
  
  //  var callingURL = document.URL;
       // var cgiString = callingURL.substring(callingURL.indexOf('=')+1,callingURL.length);   //sacamos el valor del id_ue
          //var Id_ue = cgiString;
 
    var param = new Object();
    param["id_ue"] = id_ue;
    
   
    
    var url="CargaFilasP2";  
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
          $("#lis_filas").append('<tr><td class="cabeReg" style="font-weight: bold;" width="8%"> Fecha</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Lugar</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Responsable de INEGI que la impartió</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Cantidad de personas capacitadas</td>\n\ \n\
                                      <td class="cabeReg" style="font-weight: bold;"> Tipo</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Norma de Catastro</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Norma de la CURT</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Diccionarios de Datos</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Lineamientos de Intercambio</td>\n\
                                      <td colspan="3" class="cabeReg" style="font-weight: bold;" width="8%"> Acción</td></tr>');    

                for (var i=0; i<icapas; i++){
                    var elemento = listaIdent[i];
                    
                   var catastro = elemento.norma_cat;
                   
                   var normacurt = elemento.norma_curt;
                   
                   var diccion = elemento.diccionario;
                   
                   var intercambio = elemento.lineamiento;
                   
                   var tipo = elemento.tipo_cap;
                   
                   if(catastro==="SI"){
                       
                       catastro = '<img src="images/si.png" width="25px" height="25px" alt=""/>';
                   }else{
                      catastro = '<img src="images/no.png" width="25px" height="25px" alt=""/>'; 
                   }
                   
                   if(normacurt==="SI"){
                       
                       normacurt = '<img src="images/si.png" width="25px" height="25px" alt=""/>';
                   }else{
                      normacurt = '<img src="images/no.png" width="25px" height="25px" alt=""/>'; 
                   }
                   
                    if(diccion==="SI"){
                       
                       diccion = '<img src="images/si.png" width="25px" height="25px" alt=""/>';
                   }else{
                      diccion = '<img src="images/no.png" width="25px" height="25px" alt=""/>'; 
                   }
                   
                   if(intercambio==="SI"){
                       
                       intercambio = '<img src="images/si.png" width="25px" height="25px" alt=""/>';
                   }else{
                      intercambio = '<img src="images/no.png" width="25px" height="25px" alt=""/>'; 
                   }
                   
                   if(tipo===null || tipo==="null"){
                      //alert(tipo);
                      tipo = 'Sin registro'
                   }else{
                      tipo = elemento.tipo_cap;
                   }
                   
                    
                    fila = '<tr class="hov">\n\
                            <td>'
                            + elemento.fecha_cap+
                            '</td>\n\
                            <td>'
                            + elemento.lugar+
                            '</td>\n\
                            <td>'
                            + elemento.resp_inegi+
                            '</td>\n\
                            <td>'
                            + elemento.cant_pers+
                            '</td>\n\
                            <td>' 
                            + tipo+
                            '</td>\n\
                             <td>'
                            + catastro+
                            '</td>\n\
                            <td>'
                            + normacurt+
                            '</td>\n\
                            <td>'
                            + diccion+
                            '</td>\n\
                            <td>'
                            + intercambio+
                            '</td>\n\
                                <td class="center"> <a onclick="javascript:carga_actualizaP2('+elemento.id_cap+')"> <span class="icon-edit"></span><span class="text-e">Editar </span></a> </td>\n\
                                <td class="center"> <a href="eliminar_reg_cap.jsp?id_cap='+elemento.id_cap+'&id_ue='+id_ue+'"> <span class="icon-trashcan"></span><span class="text-e">Eliminar</span> </a> </td></tr>' ;
                              $("#lis_filas").append(fila);
                              
                              //elimina_reg_ent_fis.jsp?id_entrega='+elemento.id_entrega+'
                } 
      //  }     

   }else{
          $("#lis_filas").append('<tr><td class="center" style=" background:none; padding:8px 0; font-size:18px; border:none;"> NO HAY REGISTROS AGREGADOS</td></tr>');    
   }


    });    
}

/* ----------------------------------------- FUNCION que CARGA los datos para actualizar -----------------------------------------------*/

function carga_actualizaP2(id_cap){
   // alert(id_entrega);  //probar que manda el ID
    
        var param = new Object();
    param["id_cap"] = id_cap;
    
    var url="CargaP2";  
    $.post(url,param,function(listaIdent){   
    // alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP2 = listaIdent[0];
            
                        
            $("#fecha_impart").val(elementoP2.fecha_cap);       //Nota lo que va despues de (elementoP5.ejemplo) (debe de estar como lo declaramos en FilasDTOp5.java)
            $("#lugar").val(elementoP2.lugar);
           // $("#noma_cat").val(elementoP2.norma_cat);
           // $("#noma_curt").val(elementoP2.norma_curt);
           // $("#diccionario").val(elementoP2.diccionario);
           // $("#lineamiento").val(elementoP2.lineamiento);
            $("#responsable").val(elementoP2.resp_inegi);
            $("#cantidad_p").val(elementoP2.cant_pers);
            
            var cat = elementoP2.norma_cat;
            var curt = elementoP2.norma_curt;
            var dicc = elementoP2.diccionario;
            var linea = elementoP2.lineamiento;
            
            if(cat==="SI"){
                document.getElementById("norma_cat").checked = true;
            }else{document.getElementById("norma_cat").checked = false;}
            
            
            if(curt==="SI"){
                document.getElementById("norma_curt").checked = true;
            }else{document.getElementById("norma_curt").checked = false;}
            
            
            if(dicc==="SI"){
                document.getElementById("diccionario").checked = true;
            }else{document.getElementById("diccionario").checked = false;}
            
            
            if(linea==="SI"){
                document.getElementById("lineamiento").checked = true;
            }else{document.getElementById("lineamiento").checked = false;}
            
         //  $("#nom_arch, #tamano, #no_reg, #pred_con_curt, #pred_sin_curt").attr('disabled', true); //lo deshabilitamos
            
            $("#id_cap").val(id_cap);//Mandamos el id_entrega 
            
            $("#actualizar").css("display","inline-block");
            $("#guarda_reg").css("display","none");
          });
      }  