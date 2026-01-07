/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
       $("#cerrarDiv").click(function(){
          $("div#notif").slideUp() ;
             });
             
       $("input").keypress(function(){ //al teclear en cualquier input... cerrar el div notif
         $("div#notif").slideUp() ;
       }); 
       
        $("input").click(function(){    //al dar clic sobre el  input... cerrar el div notif
             $("div#notif").slideUp() ;
       }); 
             
 });
