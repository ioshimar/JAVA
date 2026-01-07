/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function carga_actualizaP9(id_ue){
   // alert(id_ue);  //probar que manda el ID
    
        var param = new Object();
    param["id_ue"] = id_ue;
    
    var url="CargaP9";  
    $.post(url,param,function(listaIdent){   
   // alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP9 = listaIdent[0];
         
      
        if(listaIdent.length > 0){  //Si encuentra Algún registro
         /*   if(elementoP9.fecha_ofic2 ==="01/01/0001"){
              elementoP9.fecha_ofic2 = "";  
            }*/
            
          //  $("#sol_registro").val(elementoP9.fec_sol_reg);       //Nota lo que va despues de (elementoP9.ejemplo) (debe de estar como lo declaramos en FilasDTOp4.java)
            $("#fech_entssg").val(elementoP9.fecha);    
            $("#resp_entssg").val(elementoP9.nom_resp_ent);
            $("#resp_recssg").val(elementoP9.nom_resp_rec);
     
            
          
            
         // alert(elementoP9.id_concer);
         
           //$("#id_ue").val(id_ue);//Mandamos el id_ue*/
            
           $("#actualizar").css("display","inline-block");
           $(".boton_delete").css("display","inline-block");
           $("#guarda_reg").css("display","none");
         
        } 
    }
            
            
            );
    
    
    
}

