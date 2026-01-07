function cancelar_activ(){
    
     var r = confirm("¿Deseas cancelar el registro?");
    if (r == true) {
       // document.getElementById("formul2").reset();
       // window.history.back();
      location.href = "captura.jsp";
    } 
        else {
  
        }
}

