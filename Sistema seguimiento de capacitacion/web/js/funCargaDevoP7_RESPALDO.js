/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function carga_actualizaP7(id_ue){
   // alert(id_ue);  //probar que manda el ID
    
        var param = new Object();
    param["id_ue"] = id_ue;
    
    var url="CargaP7";  
    $.post(url,param,function(listaIdent){   
   // alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP7 = listaIdent[0];
         
      
        if(listaIdent.length > 0){  //Si encuentra Algún registro
         /*   if(elementoP7.fecha_ofic2 ==="01/01/0001"){
              elementoP7.fecha_ofic2 = "";  
            }*/
            
          //  $("#sol_registro").val(elementoP7.fec_sol_reg);       //Nota lo que va despues de (elementoP7.ejemplo) (debe de estar como lo declaramos en FilasDTOp4.java)
            $("#fech_dev").val(elementoP7.fecha_dev);    
            $("#resp_dev").val(elementoP7.nom_resp_dev);
            $("#resp_reci").val(elementoP7.nom_rec_dev);
            $("#arch_dev").val(elementoP7.arch_dev);
            $("#total_dev").val(elementoP7.total_regdev);
          //  $("#motivos_dev").val(elementoP7.motivos_dev);
            
          
            
         // alert(elementoP7.id_concer);
         
           //$("#id_ue").val(id_ue);//Mandamos el id_ue*/
            
           $("#actualizar").css("display","inline-block");
           $("#guarda_reg").css("display","none");
         
        } 
    }
            
            
            );
    
    
    
}

