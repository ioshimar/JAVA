/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function verifica_lib_cap(id_ue){
      /*-----------------PARA VERIFICAR la liberación la tabla capacitacion-------------------*/
        
        var fecha_actual = new Date(); //tomamos la fecha de hoy
                 //var fecha_hoy = fecha_actual.getDate() + "/" + (fecha_actual.getMonth() +1) + "/" + fecha_actual.getFullYear();
                 var Arraymeses = new Array ("ENERO","FEBRERO","MARZO","ABRIL","MAYO","JUNIO","JULIO","AGOSTO","SEPTIEMBRE","OCTUBRE","NOVIEMBRE","DICIEMBRE");
                 
                 var mes_actual = Arraymeses[fecha_actual.getMonth()];
                 var anio_actual =fecha_actual.getFullYear();
                 var dia_actual = fecha_actual.getDate();
                // alert(meses[fecha_actual.getMonth()]);
                 
    if( dia_actual >=10 ){ //solo si el dia de hoy es mayor o igual a 28
        $("#btn_enviar").css("display","none");   //botones div
        $("#div_delete").css("display","none"); //btn eliminar
        $("#cont_contacto").css("display","block");
                    
        $("#cont_formulario").find('input, textarea, select').attr("disabled",true);  //deshabilito todo el formulario
        $(".bcancelar").attr("disabled",false); //solo habilito el de Regresar
        $("#cont_formulario").find('input, textarea, select').attr("title",'La fecha limite para inscribir capacitación ha caducado, contactate con el administrador del sistema'); //mando una leyenda en el hover de cualquier input

             
            /*CHECAMOS LOS si ya tiene liberado  en la BD...*/
             var param_lc= new Object();
                         param_lc["id_ue"] = id_ue;
                         var urlC1="Carga_liberaCap";  //aqui cargará la consulta 
                  $.post(urlC1,param_lc,function(listaIdent_C1){
                         var elemento_P1 = listaIdent_C1[0];

                      if(listaIdent_C1.length > 0){  //Si encuentra Algún registro  aparecera los botones
                           var libera_solicitud = elemento_P1.libera_solicitud;  //tomamos el campo liberar (true o false)
                           var mes_liberado = elemento_P1.mes_liberado; //este lo puedo Usar para checar el Mes 
                           //Tomamos la fecha de solicitud de la Base de datos...
                           var fecha_solicitud = new Date(elemento_P1.fecha_solicitud); //tomamos el valor del campo fecha_solicitud y lo convertimos a formato fecha de javascript
                           var nom_mes_BD = Arraymeses[fecha_solicitud.getMonth()]; //nombre de el mes que viene de la BD
                           var anio_BD = fecha_solicitud.getFullYear();
                        //  alert(mes_liberado);
                      
                          //   setTimeout(verifica_lib_cap(id_ue), 1000 ); //carga la FUNCION cada 1 segundos
                          if( libera_solicitud === true && mes_actual === mes_liberado && anio_actual === anio_BD){  //Si la solicitud es aceptada (es true), el mes actual es igual al de la solicitud, y el año tambien 
                               $("#btn_enviar").css("display","block");   //botones div
                               $("#div_delete").css("display","block"); //btn eliminar
                               $("#cont_contacto").css("display","none");

                               $("#cont_formulario").find('input, textarea, select').attr("disabled",false);  //deshabilito todo el formulario
                               $(".bcancelar").attr("disabled",false); //solo habilito el de Regresar
                               
                                

                           }else{} //si no comple las condiciones quedan ocultas las opciones
                     
                      }else{} //Si no encuentra nada de registros
                  });
     }else{}
}