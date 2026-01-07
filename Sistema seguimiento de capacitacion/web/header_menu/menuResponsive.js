//jquery
$(document).ready(main);

	var contador=1;
	
function main(){
	$('.menu_bar').click(function(){
		if (contador==1){
			$('#nav').animate({
				right:'0'
				});
				
			$('.menu_bar span').removeClass('icon-menu3'); //CAMBIAR ICONOS
			$('.menu_bar span').addClass('icon-cross2');
				contador = 0; //regresamos la variable
			
}  
else{
	contador = 1;
	$('#nav').animate({
	right:'-100%'
});
			$('.menu_bar span').addClass('icon-menu3');
			$('.menu_bar span').removeClass('icon-cross2');			
}
				
});
		
		
		$('section').click(function(){/*elemento al cual le daran click*/
		contador = 1;
		$('#nav').animate({
		right: '-100%'
		});
			$('.menu_bar span').addClass('icon-menu3');
			$('.menu_bar span').removeClass('icon-cross2');	
		});
		
			
		
	//Mostramos y ocultamos Submenus
	$('.submenu').click(function(){
            $(this).children('.children').slideToggle(); //Los Hijos que tengan la clase .children van a aparecer
			
			//NOTA: El primer .children es una funcion JQuery y el segundo .children es una clase que agregamos
			 
	});
		
}






