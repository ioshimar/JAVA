/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function carga_datp5(valor_recibido)
{
    //alert(valor_recibido);
    var param = new Object();
    param["id_entrega"] = valor_recibido;
    
    var url="CargaP5";  
   
    $.post(url,param,function(listaIdent){   
        var elementoP5 = listaIdent[0];
        
        var tipo_entrega = elementoP5.tipo_entrega;
        if(tipo_entrega==="app_web"){ //si es web
            $("#nom_respgen").val(elementoP5.nom_resp_ent); //ponemos el nombre del responsable que entrega
           // $("#nom_respgen").attr("readonly",true); //le agregamos el readonly
           // $("#nom_respgen").addClass("read");     //agregamos clase read
            $("#nom_archivo").val(elementoP5.nom_archivo);
            document.getElementById("lbl_resp").innerHTML = "Responsable en UE que genera la Curt"; 
        }
        else if(tipo_entrega==="ent_fis"){ //si es fisica
            //$("#nom_respgen").val(elementoP5.nom_resp_rec);
            $("#nom_respgen").removeAttr("readonly"); //quitamos el readonly
            $("#nom_respgen").removeClass("read"); //quitamos la clase read
            $("#nom_respgen").val("");   // ponemos el valor en blanco 
            $("#nom_archivo").val(elementoP5.nom_archivo);
            document.getElementById("lbl_resp").innerHTML = "Responsable del INEGI que genera la Curt"; 
        }
        
        $("#con_curt").val(elementoP5.pred_con_curt);
        $("#sin_curt").val(elementoP5.pred_sin_curt);
        
     /*    var param2= new Object();
        param2["idsolicitud"] = elementoP5.idsolicitud;
       // $("#con_curt").val(idsolicitud);
       
        var url2="ConsultaConCurt";  
            $.post(url2,param2,function(listaIdent2){   
                var elementoP5b = listaIdent2[0];
              $("#con_curt").val(elementoP5b.TotalconCurt);
           });
        */
      
    });
    
    
}