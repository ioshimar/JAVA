/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function carga_actualizaP2(id_ue){
   // alert(id_entrega);  //probar que manda el ID
   
   var param = new Object();
    param["id_ue"] = id_ue;
    
    var url="CargaCapacP2";  
    $.post(url,param,function(listaIdent){   
    // alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP2 = listaIdent[0];
         
      
        if(listaIdent.length > 0){  //Si encuentra Algún registro
            $("#fecha_impart").val(elementoP2.fecha_cap);       //Nota lo que va despues de (elementoP2.ejemplo) (debe de estar como lo declaramos en FilasDTOp5.java)
            $("#lugar").val(elementoP2.lugar);
            $("#responsable").val(elementoP2.resp_inegi);
            $("#cantidad_p").val(elementoP2.cant_pers);
         
         // alert(elementoP2.id_concer);
        //$("#id_ue").val(id_ue);//Mandamos el id_ue*/
            
           $("#actualizar").css("display","inline-block");
           $("#guarda_reg").css("display","none");
           $(".boton_delete").css("display","inline-block");
         
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
                     if( $("#privilegio").val() === privilegio ){  //Si el input Privilegio es igual a lo que trae el campo privilegio... o es ADMIN
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

