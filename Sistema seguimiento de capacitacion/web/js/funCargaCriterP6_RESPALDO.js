/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function carga_actualizaP6(id_ue){
   // alert(id_ue);  //probar que manda el ID
    
        var param = new Object();
    param["id_ue"] = id_ue;
    
    var url="CargaP6";  
    $.post(url,param,function(listaIdent){   
   // alert(listaIdent);
            //var array_datosP5 = listaIdent.length;
            var elementoP6 = listaIdent[0];
         
      
        if(listaIdent.length > 0){  //Si encuentra Algún registro
         /*   if(elementoP6.fecha_ofic2 ==="01/01/0001"){
              elementoP6.fecha_ofic2 = "";  
            }*/
            
          //  $("#sol_registro").val(elementoP6.fec_sol_reg);       //Nota lo que va despues de (elementoP6.ejemplo) (debe de estar como lo declaramos en FilasDTOp4.java)
            $("#resp_val").val(elementoP6.nom_respval);    
            $("#fech_ini6").val(elementoP6.fec_ini);
            $("#fech_ter6").val(elementoP6.fec_fin);
           
            var f_shape = elementoP6.for_shape;
            var exte = elementoP6.ext_min;
            var estructura = elementoP6.est_cor;
            var atribu = elementoP6.atrib;
            var coord_geo = elementoP6.info_cord;
            var total_reg = elementoP6.code_total;
            
            
            
            if(f_shape==="SI"){
                document.getElementById("f_shapeSi").checked = true;
                 $('input[name="extension"], input[name="estruc"], input[name="atrib"], input[name="coord_geo"], input[name="total_reg"]').attr("disabled",false); //habilito los radiobuttons
            }else if(f_shape==="NO"){
                document.getElementById("f_shapeNo").checked = true;
                $('input[name="extension"], input[name="estruc"], input[name="atrib"], input[name="coord_geo"], input[name="total_reg"]').attr("disabled",true); //Deshabilito los radiobuttons
            }else{}
            
             if(exte==="SI"){
                document.getElementById("extensionSi").checked = true;
            }else if(exte==="NO"){
                document.getElementById("extensionNo").checked = true;
            }else{}
            
            if(estructura==="SI"){
                document.getElementById("estrucSi").checked = true;
            }else if(estructura==="NO"){
                document.getElementById("estrucNo").checked = true;
            }else{}
            
            
             if(atribu==="SI"){
                document.getElementById("atribSi").checked = true;
            }else if(atribu==="NO"){
                document.getElementById("atribNo").checked = true;
            }else{}
            
             if(coord_geo==="SI"){
                document.getElementById("coord_geoSi").checked = true;
            }else if(coord_geo==="NO"){
                document.getElementById("coord_geoNo").checked = true;
            }else{}
            
             if(total_reg==="SI"){
                document.getElementById("total_regSi").checked = true;
            }else if(total_reg==="NO"){
                document.getElementById("total_regNo").checked = true;
            }else{}
            
          
            
         // alert(elementoP6.id_concer);
         
           //$("#id_ue").val(id_ue);//Mandamos el id_ue*/
            
           $("#actualizar").css("display","inline-block");
           $("#guarda_reg").css("display","none");
         
        } 
    }
            
            
            );
    
    
    
}

