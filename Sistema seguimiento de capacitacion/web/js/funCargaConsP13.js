/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function carga_actualizaP13(id_ue){
   // alert(id_ue);  //probar que manda el ID
    
        var param = new Object();
    param["id_ue"] = id_ue;
    
    var url="CargaP13";  
    $.post(url,param,function(listaIdent){   
   //alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP13 = listaIdent[0];
         
      
        if(listaIdent.length > 0){  //Si encuentra Algún registro
         /*   if(elementoP13.fecha_ofic2 ==="01/01/0001"){
              elementoP13.fecha_ofic2 = "";  
            }*/
            
          //  $("#sol_registro").val(elementoP13.fec_sol_reg);       //Nota lo que va despues de (elementoP13.ejemplo) (debe de estar como lo declaramos en FilasDTOp4.java)
            $("#fech_soli").val(elementoP13.fec_sol);    
            $("#fech_emi").val(elementoP13.fec_emi);
            $("#folio").val(elementoP13.folio_cons);
          
          
            
         // alert(elementoP13.id_concer);
         
           //$("#id_ue").val(id_ue);//Mandamos el id_ue*/
            
           $("#actualizar").css("display","inline-block");
           $(".boton_delete").css("display","inline-block");
           $("#guarda_reg").css("display","none");
         
        } 
    }
            
            
            );
    
    
    
}

