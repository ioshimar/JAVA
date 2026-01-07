/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


//YA NO SE USA esta Función... desde el 26 noviembre 2018
function carga_actualizaP12(id_ue){
   // alert(id_ue);  //probar que manda el ID
    
        var param = new Object();
    param["id_ue"] = id_ue;
    
    var url="CargaP12";  
    $.post(url,param,function(listaIdent){   
   //alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP12 = listaIdent[0];
         
      
        if(listaIdent.length > 0){  //Si encuentra Algún registro
         /*   if(elementoP12.fecha_ofic2 ==="01/01/0001"){
              elementoP12.fecha_ofic2 = "";  
            }*/
            
          //  $("#sol_registro").val(elementoP12.fec_sol_reg);       //Nota lo que va despues de (elementoP12.ejemplo) (debe de estar como lo declaramos en FilasDTOp4.java)
            $("#fecha_ent12").val(elementoP12.fec_dr);
                if(elementoP12.fec_dr==="01/01/0001"){
                       $("#fecha_ent12").val("");
                   }else{}
                   
            $("#nom_resp_oc").val(elementoP12.nom_resp_ocent);
            $("#resp_rec_dr").val(elementoP12.nom_resp_drec);
            $("#nom_archdr").val(elementoP12.arch_dr);
            $("#cant_regdr").val(elementoP12.cant_dr);
            
            $("#fecha_ent_ue").val(elementoP12.fec_ue);
                   if(elementoP12.fec_ue==="01/01/0001"){
                       $("#fecha_ent_ue").val("");
                   }else{}
            $("#nom_resp_dr").val(elementoP12.nom_resp_drent);  
            $("#resp_reci_ue").val(elementoP12.nom_resp_uerec);  
            $("#nom_arch_ue").val(elementoP12.arch_ue);  
            $("#cant_reg_ue").val(elementoP12.cant_ue);  
            
             var tipo_entrega = elementoP12.tipo_entrega; 
          
             if(tipo_entrega==="A Direccion Regional"){
                 document.getElementById("chk_adr").checked = true;
                  $('#div_dr').show(700); 
            }else if (tipo_entrega==="A Unidad del Estado"){
                 document.getElementById("chk_aue").checked =true;
                 $('#div_ue').show(700); 
            }
       
            
         // alert(elementoP12.id_concer);
         
           //$("#id_ue").val(id_ue);//Mandamos el id_ue*/
            
           $("#actualizar").css("display","inline-block");
           $(".boton_delete").css("display","inline-block");
           $("#guarda_reg").css("display","none");
         
        } 
    }
            
            
            );
    
    
    
}

