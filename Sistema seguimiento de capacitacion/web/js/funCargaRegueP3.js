/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function carga_actualizaP3(id_ue){
   // alert(id_entrega);  //probar que manda el ID
    
        var param = new Object();
    param["id_ue"] = id_ue;
    
    var url="CargaP3";  
    $.post(url,param,function(listaIdent){   
    // alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP3 = listaIdent[0];
         
      
        if(listaIdent.length > 0){  //Si encuentra Algún registro
         /*   if(elementoP3.fecha_ofic2 ==="01/01/0001"){
              elementoP3.fecha_ofic2 = "";  
            }*/
            
            $("#sol_registro").val(elementoP3.fec_sol_reg);       //Nota lo que va despues de (elementoP3.ejemplo) (debe de estar como lo declaramos en FilasDTOp5.java)
                if(elementoP3.fec_sol_reg==="01/01/0001"){
                    $("#sol_registro").val("");
                }else{}
                
            $("#envio_doc").val(elementoP3.fec_env_doc);
             if(elementoP3.fec_env_doc==="01/01/0001"){
                    $("#envio_doc").val("");
                }else{}
                
            $("#val_doc").val(elementoP3.fec_val_doc);
             if(elementoP3.fec_val_doc==="01/01/0001"){
                    $("#val_doc").val("");
                }else{}
            
            $("#fec_firma").val(elementoP3.fec_env_firm);
             if(elementoP3.fec_env_firm==="01/01/0001"){
                    $("#fec_firma").val("");
                }else{}
            
            $("#fec_usu").val(elementoP3.fec_regus);
             if(elementoP3.fec_regus==="01/01/0001"){
                    $("#fec_usu").val("");
                }else{}
                
            $("#fec_rece").val(elementoP3.fec_rec_doc);
            if(elementoP3.fec_rec_doc==="01/01/0001"){
                    $("#fec_rece").val("");
                }else{}
          
         // alert(elementoP3.id_concer);
        
            
           $("#id_ue").val(id_ue);//Mandamos el id_ue*/
            
           $("#actualizar").css("display","inline-block");
           $(".boton_delete").css("display","inline-block");
           $("#guarda_reg").css("display","none");
         
        } 
    });
    
    
     /*-----------------PARA VERIFICAR el privilegio que tiene el campo en la tabla concertación-------------------*/
       var paramC1 = new Object();
                   paramC1["id_ue"] = id_ue;
                   var urlC1="CargaP1";  
            $.post(urlC1,paramC1,function(listaIdent_C1){
                       var elemento_P1 = listaIdent_C1[0];
                       
                if(listaIdent_C1.length > 0){  //Si encuentra Algún registro
                     var privilegio = elemento_P1.privilegio;  //Est o Reg
                     if( $("#privilegio").val() === privilegio){  //Si el input Privilegio es igual a lo que trae el campo privilegio...
                            //Todo como si nada, (muestra los botones de actualizar, eliminar...)
                     }else{
                       // alert("nel");
                       $("#actualizar").css("display","none");   //btn Actualizar
                       $("#guarda_reg").css("display","none");   //btn Guardar
                       $(".boton_delete").css("display","none"); //btn eliminar
                       $("#cont_formulario").find('input, textarea, select').attr("disabled",true);  //deshabilito todo el formulario
                       $(".bcancelar").attr("disabled",false); //solo hanilito el de Regresar
                       $("#cont_formulario").find('input, textarea, select').attr("title",'No cuentas con permisos para modificar'); //mando una leyenda en el hover de cualquier input

                    }
                 }
                else{}
            });
    
    
    
}

