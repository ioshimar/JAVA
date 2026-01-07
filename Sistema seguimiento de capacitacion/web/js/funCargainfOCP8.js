/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function carga_actualizaP8(id_eoc){
   // alert(id_ue);  //probar que manda el ID
    
        var param = new Object();
    param["id_eoc"] = id_eoc;
    
    var url="CargaFilasP8";  
    $.post(url,param,function(listaIdent){   
   // alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP8 = listaIdent[0];
         
      
        if(listaIdent.length > 0){  //Si encuentra Algún registro
         /*   if(elementoP8.fecha_ofic2 ==="01/01/0001"){
              elementoP8.fecha_ofic2 = "";  
            }*/
            
          //  $("#sol_registro").val(elementoP8.fec_sol_reg);       //Nota lo que va despues de (elementoP8.ejemplo) (debe de estar como lo declaramos en FilasDTOp4.java)
            $("#fech_ent").val(elementoP8.fec_oc);    
            $("#resp_ent").val(elementoP8.nom_resp_ent);
            $("#respoc_reci").val(elementoP8.nom_recibe);
           
    
            
          
            
         // alert(elementoP8.id_concer);
         
           //$("#id_ue").val(id_ue);//Mandamos el id_ue*/
           $("#id_eoc").val(id_eoc);//Mandamos el id_entrega 
            
           $("#actualizar").css("display","inline-block");
           $(".boton_delete").css("display","inline-block");
           $("#guarda_reg").css("display","none");
         
        } 
    }
            
            
            );
    
    
    
}

