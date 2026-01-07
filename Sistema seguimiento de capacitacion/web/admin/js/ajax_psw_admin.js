/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */




function ajax_psw_adm(){
			var ajax=false;
			if(window.XMLHttpRequest){
                            // code for IE7+, Firefox, Chrome, Opera, Safari
				ajax = new XMLHttpRequest();
				
			}else{
				ajax = ActiveXObject("Microsoft.XMLHTTP");
				
			}
			
			var verificar = true; /*var significa que es una variable*/
				
	
	
			var url = "../cambia_pass_adm";
                        //var url = "ExpRepMensual";
			var user = document.getElementById("usuario").value;
			var old_pass = document.getElementById("old_psw").value;
			var new_pass = document.getElementById("new_psw").value;
			var rep_pass = document.getElementById("repeat_psw").value;
			
			
			
		
			/*VALIDACION DE CAMPOS*/
					if(!old_pass){ /*si esta vacio campo nombre...*/
						alert("Ingresa tu contraseña");
						 setTimeout(function() { document.getElementById('old_psw').focus(); }, 10);
						verificar = false;
                                            }
										
					else if(!new_pass)/*validar las letras*/{
                                            alert("Ingresa la nueva contraseña");	
                                             setTimeout(function() { document.getElementById('new_psw').focus(); }, 10);
                                            verificar=false;}
                                        
                                        else if(!rep_pass)/*validar las letras*/{
                                            alert("Confirma la nueva contraseña");	
                                             setTimeout(function() { document.getElementById('repeat_psw').focus(); }, 10);
                                            verificar=false;
                                        }
                                        
                                        else if(new_pass !== rep_pass){
                                            alert("Las contraseñas no coinciden");
                                             setTimeout(function() { document.getElementById('repeat_psw').focus(); }, 10);
                                            verificar=false;
                                        }
				
				
				
				/*TERMINA LA VALIDACION DE LOS CAMPOS*/
				

 
        ajax.open("POST",url,true);		
	var valores = "usuario="+user+"&old_psw="+old_pass+"&new_psw="+new_pass+"&repeat_psw="+rep_pass;
			
			ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			ajax.onreadystatechange=function(){
				if(ajax.readyState==4 && ajax.status==200){
					
                                       // alert('-'+ajax.responseText+'-'); ESTE CODIGO SOLO ES PARA VER QUE TRAE EL responseText
                                        
                                        var respuesta = ajax.responseText;
                                            if (respuesta == 'succes_psw'){
                                                alert("La contraseña se ha cambiado correctamente");
                                                    var conf = confirm("¿Deseas cerrar la sesión?");
                                                    if(conf == true){
                                                        window.location.href = "logout_admin.jsp";  //CERRAR SESIÓN     
                                                    }else{
                                                        window.location.href = "inicio_admin.jsp";
                                                    }
                                            }
                                            
                                            else if(respuesta == 'error_psw'){
                                                 alert("La contraseña anterior es incorrecta");
                                                 document.getElementById("old_psw").value = "";
                                                 setTimeout(function() { document.getElementById('old_psw').focus(); }, 10);
                                            }

				}
			}
					
        if(verificar==true){/*si verificar es verdadero (aqui puede quedar solo verificar sin el ==true ya que arriba esta declarado)*/
            ajax.send(valores);
        }
	
}
		