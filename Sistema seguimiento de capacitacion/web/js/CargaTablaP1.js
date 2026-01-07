/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



/*----------------------------------------------FUNCION PARA CARGAR LAS FILAS en la tabla #lis_filas  -----------------------------------------------*/

function cargaTablaP1(id_ue){
  
  //  var callingURL = document.URL;
       // var cgiString = callingURL.substring(callingURL.indexOf('=')+1,callingURL.length);   //sacamos el valor del id_ue
          //var Id_ue = cgiString;
 
    var param = new Object();
    param["id_ue"] = id_ue;
    
   
    
    var url="CargaP1";  
    $.post(url,param,function(listaIdent){   
    // alert(listaIdent);
            var icapas = listaIdent.length;
            var fila = "";  //option
           // var option2 = "";
           $("#lis_filas_curtp1").empty();
       
       
   /*    if(clave_edo==("33")){ //Incluimos la Opción Desagregar
           $("#lis_filas").append('<tr><td style="font-weight: bold;"> NOMBRE CAPA</td> <td style="font-weight: bold;"> No. DE ELEMENTOS</td></tr>');    

                for (var i=0; i<icapas; i++){
                    var elemento = listaIdent[i];
                    option = '<tr><td>'+ elemento.Nom_capa+'</td> <td>'+elemento.Num_ele+'</td><td> <a href="actualiza_capa.jsp?id='+elemento.Id+' "> <span class="icon-edit"></span><span class="text-e">Editar</span></a> </td> <td> <a href="desagregar_capa.jsp?id='+elemento.Id+' "> <span class="icon-scissors"></span><span class="text-e">Desagregar</span></a> </td> <td> <a href="elimina_capa.jsp?id='+elemento.Id+' "> <span class="icon-trashcan"></span><span class="text-e">Eliminar</span> </a> </td></tr>' ;
                              $("#lis_filas").append(option);
                } 
           
       }*/
       
   /*    else{*/

   if(listaIdent.length !== 0){ //SI no esta vacio el arrayList
     
       
       
          $("#lis_filas_curtp1").append('<tr><td class="cabeReg" style="font-weight: bold;" width="20%"> Nombre UE</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> 1er Oficio Enviado</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Respuesta 1er oficio</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> 2do Oficio Enviado</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Respuesta 2do oficio</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> 3er Oficio Enviado</td>\n\
                                      <td class="cabeReg" style="font-weight: bold;"> Respuesta 3er oficio</td></tr>');    

                for (var i=0; i<icapas; i++){
                    var elemento = listaIdent[i];
                      var ruta_env1 = elemento.ruta_ofi_env1;
                      var ruta_recib1 = elemento.ruta_ofi_recib1;
                      var ruta_env2 = elemento.ruta_ofi_env2;
                      var ruta_recib2 = elemento.ruta_ofi_recib2;
                      var ruta_env3 = elemento.ruta_ofi_env3;
                      var ruta_recib3 = elemento.ruta_ofi_recib3;
                      var patron_sustit = 'archivos/'+elemento.id_ue+'_'; //declararemos el patron que sustituiremos
                       
                       /*comprobar si hay no trae nada la variable*/
                          if(!ruta_env1){ruta_env1="No hay archivo";}  //con el substring cortamos la cadena, y quitamos el texto la palabra archivos
                             else{ruta_env1 = '<a class="link_to" target="_blank" href='+ruta_env1+'>'+ruta_env1.replace(patron_sustit,'...')+'</a> &nbsp; &nbsp;\n\
                                 <a class="delete_r" href=elimina_doc.jsp?id_ue='+elemento.id_ue+'&colum=ruta_ofi_env1&nom_arch='+ruta_env1.replace('archivos/','')+'>X</a>'; 
                         
                             } 
                             
                          if(!ruta_recib1){ruta_recib1="No hay archivo";}
                              else{ruta_recib1 = '<a class="link_to" target="_blank" href='+ruta_recib1+'>'+ruta_recib1.replace(patron_sustit,'...')+'</a> &nbsp; &nbsp;\n\
                                <a class="delete_r" href=elimina_doc.jsp?id_ue='+elemento.id_ue+'&colum=ruta_ofi_recib1&nom_arch='+ruta_recib1.replace('archivos/','')+'>X</a>';
                            }
                              
                          if(!ruta_env2){ruta_env2="No hay archivo";}
                            else{ruta_env2 = '<a class="link_to" target="_blank" href='+ruta_env2+'>'+ruta_env2.replace(patron_sustit,'...')+'</a> &nbsp; &nbsp;\n\
                             <a class="delete_r" href=elimina_doc.jsp?id_ue='+elemento.id_ue+'&colum=ruta_ofi_env2&nom_arch='+ruta_env2.replace('archivos/','')+'>X</a> ';
                            }
                            
                          if(!ruta_recib2){ruta_recib2="No hay archivo";}
                            else{ruta_recib2 = '<a class="link_to" target="_blank" href='+ruta_recib2+'>'+ruta_recib2.replace(patron_sustit,'...')+'</a> &nbsp; &nbsp; \n\
                              <a class="delete_r" href=elimina_doc.jsp?id_ue='+elemento.id_ue+'&colum=ruta_ofi_recib2&nom_arch='+ruta_recib2.replace('archivos/','')+'>X</a> ';
                            }
                          
                          if(!ruta_env3){ruta_env3="No hay archivo";}
                           else{ruta_env3 = '<a class="link_to" target="_blank" href='+ruta_env3+'>'+ruta_env3.replace(patron_sustit,'...')+'</a> &nbsp; &nbsp;\n\
                             <a class="delete_r" href=elimina_doc.jsp?id_ue='+elemento.id_ue+'&colum=ruta_ofi_env3&nom_arch='+ruta_env3.replace('archivos/','')+'>X</a> '; 
                           } 
                          
                          if(!ruta_recib3){ruta_recib3="No hay archivo";}
                          else{ruta_recib3='<a class="link_to" target="_blank" href='+ruta_recib3+'>'+ruta_recib3.replace(patron_sustit,'...')+  '</a> &nbsp; &nbsp;\n\
                             <a class="delete_r" href=elimina_doc.jsp?id_ue='+elemento.id_ue+'&colum=ruta_ofi_recib3&nom_arch='+ruta_recib3.replace('archivos/','')+'>X</a>';
                          }
                    
                    fila = '<tr class="hov"><td>'+ elemento.nom_ue+'</td>\n\
                                <td>'+ ruta_env1+' <br><br> <a class="boton" href=subir_documento.jsp?id_ue='+elemento.id_ue+'&colum=ruta_ofi_env1>Subir documento</a> </td>\n\
                                <td>'+ ruta_recib1+' <br><br> <a class="boton" href=subir_documento.jsp?id_ue='+elemento.id_ue+'&colum=ruta_ofi_recib1>Subir documento</a> </td>\n\
                                <td>'+ ruta_env2+'  <br><br> <a class="boton" href=subir_documento.jsp?id_ue='+elemento.id_ue+'&colum=ruta_ofi_env2>Subir documento</a> </td></td>\n\
                                <td>'+ ruta_recib2+'  <br><br> <a class="boton" href=subir_documento.jsp?id_ue='+elemento.id_ue+'&colum=ruta_ofi_recib2>Subir documento</a> </td></td>\n\
                                <td>'+ ruta_env3+'  <br><br> <a class="boton" href=subir_documento.jsp?id_ue='+elemento.id_ue+'&colum=ruta_ofi_env3>Subir documento</a> </td> </td>\n\
                                <td>'+ ruta_recib3+'  <br><br> <a class="boton" href=subir_documento.jsp?id_ue='+elemento.id_ue+'&colum=ruta_ofi_recib3>Subir documento</a> </td></td></tr>' ;
                              $("#lis_filas_curtp1").append(fila);
                } 
      //  }     

   }else{
          $("#lis_filas_curtp1").append('<tr><td class="center" style=" background:none; padding:8px 0; font-size:18px; border:none;"> NO HAY REGISTROS AGREGADOS</td></tr>');    
   }


    });    
}    