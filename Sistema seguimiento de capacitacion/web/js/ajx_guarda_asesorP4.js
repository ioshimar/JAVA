/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function proceso_guardaP4(){
  var id_ue =document.getElementById("id_ue").value;
  var fecha_ini = document.getElementById("fecha_ini").value;    
  var fecha_fin = document.getElementById("fecha_fin").value;
  var name_resp =document.getElementById("name_resp").value;
  var name_ase = document.getElementById("name_ase").value;  
  var fecha_ini_ap = document.getElementById("fecha_ini_ap").value;  
  var fecha_fin_ap = document.getElementById("fecha_fin_ap").value;  
  var name_resp_ap = document.getElementById("name_resp_ap").value;
  var name_ase_ap = document.getElementById("name_ase_ap").value;
  var fecha_ini_conv = document.getElementById("fecha_ini_conv").value;
  var fecha_fin_conv = document.getElementById("fecha_fin_conv").value;
  var name_resp_conv = document.getElementById("name_resp_conv").value;
  var name_ase_conv = document.getElementById("name_ase_conv").value;
  var fecha_ini_est = document.getElementById("fecha_ini_est").value;
  var fecha_fin_est = document.getElementById("fecha_fin_est").value;
  var name_resp_est = document.getElementById("name_resp_est").value;
  var name_ase_est = document.getElementById("name_ase_est").value;
  var fecha_ini_ref = document.getElementById("fecha_ini_ref").value;
  var fecha_fin_ref = document.getElementById("fecha_fin_ref").value;
  var name_resp_ref = document.getElementById("name_resp_ref").value;
  var name_ase_ref = document.getElementById("name_ase_ref").value;
  var fecha_ini_int = document.getElementById("fecha_ini_int").value;
  var fecha_fin_int = document.getElementById("fecha_fin_int").value;
  var name_resp_int = document.getElementById("name_resp_int").value;
  var name_ase_int = document.getElementById("name_ase_int").value;
  var tipo_asesoria = document.getElementsByName("tipo_asesoria");
  
  
  
  /********* Validar que se seleccione al menos un checkbox ********/
  var selectTipoAses= false;    // Para validar los checkbox
            for(var i=0; i < tipo_asesoria.length; i++) {    
                   var valor_Tipo= tipo_asesoria[i].value;  //obtener el valor
                if(tipo_asesoria[i].checked) {  //validar que se seleccione al menos una
                   selectTipoAses = true;
                    break;
                }
             }  
             
  /************************************ Comparar Fechas **************************************/ 
      //Split de las fechas recibidas para separarlas
                    var x  = fecha_ini.split("/");
                    var z = fecha_fin.split("/");  
            //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fecha_ini_compare = x[1] + "/" + x[0] + "/" + x[2];
            var fecha_fin_compare = z[1] + "/"  + z[0] + "/"  + z[2];     
            
            
      //Split de las fechas recibidas para separarlas
                    var w  = fecha_ini_ap.split("/");
                    var y = fecha_fin_ap.split("/");  
           //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fecha_ini_ap_compare = w[1] + "/" + w[0] + "/" + w[2];
            var fecha_fin_ap_compare = y[1] + "/"  + y[0] + "/"  + y[2];       
            
       //Split de las fechas recibidas para separarlas
                    var u  = fecha_ini_conv.split("/");
                    var v = fecha_fin_conv.split("/");  
           //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fecha_ini_conv_compare = u[1] + "/" + u[0] + "/" + u[2];
            var fecha_fin_conv_compare = v[1] + "/"  + v[0] + "/"  + v[2];          
            
      //Split de las fechas recibidas para separarlas
                    var r = fecha_ini_est.split("/");
                    var s = fecha_fin_est.split("/");  
           //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fecha_ini_est_compare = r[1] + "/" + r[0] + "/" + r[2];
            var fecha_fin_est_compare = s[1] + "/"  + s[0] + "/"  + s[2]; 
            
            
            
        //Split de las fechas recibidas para separarlas
                    var o = fecha_ini_ref.split("/");
                    var p = fecha_fin_ref.split("/");  
           //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fecha_ini_ref_compare = o[1] + "/" + o[0] + "/" + o[2];
            var fecha_fin_ref_compare = p[1] + "/"  + p[0] + "/"  + p[2];  
            
     //Split de las fechas recibidas para separarlas
                    var m = fecha_ini_int.split("/");
                    var n = fecha_fin_int.split("/");  
           //Cambiamos el orden al formato americano, de esto dd/mm/yyyy a esto mm/dd/yyyy
            var fecha_ini_int_compare = m[1] + "/" + m[0] + "/" + m[2];
            var fecha_fin_int_compare = n[1] + "/"  + n[0] + "/"  + n[2];         
            
            
  
  
  
  /****** Para validar los Checkbox por separado  *******/
  var chk_reg_ue = document.getElementById("chk_reg_ue");
  var chk_usoapp = document.getElementById("chk_usoapp");  
  var chk_coord = document.getElementById("chk_coord"); 
  var chk_estr = document.getElementById("chk_estr"); 
  var chk_convert = document.getElementById("chk_convert");   
  var chk_interp = document.getElementById("chk_interp");  
      
        
  
  //VALIDACIONES
                if(!selectTipoAses){
                     alert("Selecciona una opción");
                            setTimeout(function() { document.getElementById('chk_reg_ue').focus(); }, 10);
                            return false;
                }else{}
  
  
            if(chk_reg_ue.checked){
                 if(!fecha_ini){
                    alert("Ingresa la fecha de inicio del registro de la UE en el aplicativo");
                     setTimeout(function() { document.getElementById('fecha_ini').focus(); }, 10);
                    return false;
                 }
               
                else if(!fecha_fin){
                    alert("Ingresa la fecha de término del registro de la UE en el aplicativo");
                    setTimeout(function() { document.getElementById('fecha_fin').focus(); }, 10);
                    return false;
                }
                
               else if(Date.parse(fecha_ini_compare) > Date.parse(fecha_fin_compare)){
                                    alert("Las fechas no corresponden, la fecha de término debe ser igual o despúes que la fecha inicial");
                                    setTimeout(function() { document.getElementById('fecha_fin').focus(); }, 10);
                                           return false;
                                } 
               
                else if(!name_resp){
                        alert("Ingresa el nombre del responsable del registro de la UE en el aplicativo");
                        setTimeout(function() { document.getElementById('name_resp').focus(); }, 10);
                        return false;
                }
                
                else if(!name_ase){
                        alert("Ingresa el nombre de la persona que recibió la asesoría");
                          setTimeout(function() { document.getElementById('name_ase').focus(); }, 10);
                        return false;
                }
            }else{}
            
            
            if(chk_usoapp.checked){
                    if(!fecha_ini_ap){
                            alert("Ingresa la fecha de inicio");
                              setTimeout(function() { document.getElementById('fecha_ini_ap').focus(); }, 10);
                            return false;
                    }

                    else if(!fecha_fin_ap){
                            alert("Ingresa la fecha de término");
                              setTimeout(function() { document.getElementById('fecha_fin_ap').focus(); }, 10);
                            return false;
                    }
                    
                    else if(Date.parse(fecha_ini_ap_compare) > Date.parse(fecha_fin_ap_compare)){
                                    alert("Las fechas no corresponden, la fecha de término debe ser igual o despúes que la fecha inicial");
                                    setTimeout(function() { document.getElementById('fecha_fin_ap').focus(); }, 10);
                                           return false;
                                } 

                    else if(!name_resp_ap){
                         alert("Ingresa el nombre del responsable");
                         setTimeout(function() { document.getElementById('name_resp_ap').focus(); }, 10);
                         return false;
                    }

                    else if(!name_ase_ap){
                        alert("Ingresa el nombre de la persona que recibió la asesoría");
                        setTimeout(function() { document.getElementById('name_ase_ap').focus(); }, 10);
                        return false;
                    }
            }else{}
            
            if(chk_coord.checked){
                if(!fecha_ini_conv){
                    alert("Ingresa la fecha de inicio");
                    setTimeout(function() { document.getElementById('fecha_ini_conv').focus(); }, 10);
                    return false;
                }
                
                else if(!fecha_fin_conv){
                    alert("Ingresa la fecha de término");
                    setTimeout(function() { document.getElementById('fecha_fin_conv').focus(); }, 10);
                    return false;
                }
                
                 else if(Date.parse(fecha_ini_conv_compare) > Date.parse(fecha_fin_conv_compare)){
                                    alert("Las fechas no corresponden, la fecha de término debe ser igual o despúes que la fecha inicial");
                                    setTimeout(function() { document.getElementById('fecha_fin_conv').focus(); }, 10);
                                           return false;
                                }
                
                else if(!name_resp_conv){
                    alert("Ingresa el nombre del responsable");
                    setTimeout(function() { document.getElementById('name_resp_conv').focus(); }, 10);
                    return false;
                }
                
                else if(!name_ase_conv){
                    alert("Ingresa el nombre de la persona que recibió la asesoría");
                    setTimeout(function() { document.getElementById('name_ase_conv').focus(); }, 10);
                    return false;
                }
            }else{}
            
           if(chk_estr.checked){
                        if(!fecha_ini_est){
                           alert("Ingresa la fecha de inicio");
                           setTimeout(function() { document.getElementById('fecha_ini_est').focus(); }, 10);
                           return false;
                       }

                       else if(!fecha_fin_est){
                           alert("Ingresa la fecha de término");
                           setTimeout(function() { document.getElementById('fecha_fin_est').focus(); }, 10);
                           return false;
                       }
                       
                         else if(Date.parse(fecha_ini_est_compare) > Date.parse(fecha_fin_est_compare)){
                                    alert("Las fechas no corresponden, la fecha de término debe ser igual o despúes que la fecha inicial");
                                    setTimeout(function() { document.getElementById('fecha_fin_est').focus(); }, 10);
                                           return false;
                                }

                       else if(!name_resp_est){
                           alert("Ingresa el nombre del responsable");
                           setTimeout(function() { document.getElementById('name_resp_est').focus(); }, 10);
                           return false;
                       }

                       else if(!name_ase_est){
                           alert("Ingresa el nombre de la persona que recibió la asesoría");
                           setTimeout(function() { document.getElementById('name_ase_est').focus(); }, 10);
                           return false;
                       }
            }  else{} 
            
            if(chk_convert.checked){
                    if(!fecha_ini_ref){
                       alert("Ingresa la fecha de inicio");
                       setTimeout(function() { document.getElementById('fecha_ini_ref').focus(); }, 10);
                       return false;
                   }

                   else if(!fecha_fin_ref){
                       alert("Ingresa la fecha de término");
                       setTimeout(function() { document.getElementById('fecha_fin_ref').focus(); }, 10);
                       return false;
                   }
                   
                   
                  else if(Date.parse(fecha_ini_ref_compare) > Date.parse(fecha_fin_ref_compare)){
                                    alert("Las fechas no corresponden, la fecha de término debe ser igual o despúes que la fecha inicial");
                                    setTimeout(function() { document.getElementById('fecha_fin_ref').focus(); }, 10);
                                           return false;
                                } 

                    else if(!name_resp_ref){
                       alert("Ingresa el nombre del responsable");
                       setTimeout(function() { document.getElementById('name_resp_ref').focus(); }, 10);
                       return false;
                   }

                   else if(!name_ase_ref){
                       alert("Ingresa el nombre de la persona que recibió la asesoría");
                       setTimeout(function() { document.getElementById('name_ase_ref').focus(); }, 10);
                       return false;
                   }
            }else{}    
                
                
             if(chk_interp.checked){  
                if(!fecha_ini_int){
                    alert("Ingresa la fecha de inicio");
                    setTimeout(function() { document.getElementById('fecha_ini_int').focus(); }, 10);
                    return false;
                }
                
                else if(!fecha_fin_int){
                    alert("Ingresa la fecha de término");
                    setTimeout(function() { document.getElementById('fecha_fin_int').focus(); }, 10);
                    return false;
                }
                
               else if(Date.parse(fecha_ini_int_compare) > Date.parse(fecha_fin_int_compare)){
                                    alert("Las fechas no corresponden, la fecha de término debe ser igual o despúes que la fecha inicial");
                                    setTimeout(function() { document.getElementById('fecha_fin_int').focus(); }, 10);
                                           return false;
                                } 
                
                 else if(!name_resp_int){
                    alert("Ingresa el nombre del responsable");
                    setTimeout(function() { document.getElementById('name_resp_int').focus(); }, 10);
                    return false;
                }
                
                else if(!name_ase_int){
                    alert("Ingresa el nombre de la persona que recibió la asesoría");
                    setTimeout(function() { document.getElementById('name_ase_int').focus(); }, 10);
                    return false;
                }
            }  else{}
                
              
     
   //TERMINAN VALIDACIONES             
      
       
           var dataString = $('#curtp4').serialize();  // declaramos la variable data String (traera los valores del name de todo el formulario)

              // alert('Datos serializados: '+dataString);

                $.ajax({
                    type: "POST",
                    url: "GrabaCurtP4",
                    data: dataString,

                    success: function(data) {
                      
                        alert(data);
                       location.href = "captura.jsp?ue="+id_ue;
                    }
                });
                  return false;
     
    
    
};