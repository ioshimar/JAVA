/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function verifica_permisos(id_ue){
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
                       
                       $("#agrega_reg").css("display","none");
                       $("#nuevo_reg").css("display","none");
                       
                       $("table#lis_filas").css("display","none"); //btn subir docmentos
                       $(".boton_delete").css("display","none"); //btn eliminar
                       $("#cont_formulario").find('input, textarea, select').attr("disabled",true);  //deshabilito todo el formulario
                       $(".bcancelar").attr("disabled",false); //solo hanilito el de Regresar
                       $("#cont_formulario").find('input, textarea, select').attr("title",'No cuentas con permisos para modificar'); //mando una leyenda en el hover de cualquier input

                    }
                 }
                else{}
            });
    
}