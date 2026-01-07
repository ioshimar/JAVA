 $(document).ready(function(){  
      var i=1;  
      $('#add2').click(function(){  
           i++;  
           $('#dynamic_field2').append('<tr id="row'+i+'">\n\
                                        <td><input type="text" name="total_motivo" class="w10" placeholder="Total"></td>\n\
                                        <td><input type="text" name="motivo" class="w30" placeholder="Motivo(s)"></td>\n\
                                        <td><button type="button" name="remove" id="'+i+'" class="btn btn-danger btn_remove">X</button></td></tr>');  
      });  
      $(document).on('click', '.btn_remove', function(){  
           var button_id = $(this).attr("id");   
           $('#row'+button_id+'').remove();  
      });  
    
 });  
   // JavaScript Document
   
   
   // ---------------------------------------------------------------------------------Part 11 (actualizacion)--------------------------------------------------
   
    $(document).ready(function(){  
      var i=1;  
      $('#add3').click(function(){  
           i++;  
           $('#dynamic_field3').append('<tr id="row'+i+'">\n\
                                        <td><input type="text" name="total_motivo_a" class="w10" placeholder="Total"></td>\n\
                                        <td><input type="text" name="motivo_a" class="w30" placeholder="Motivo(s)"></td>\n\
                                        <td><button type="button" name="remove" id="'+i+'" class="btn btn-danger btn_remove">X</button></td></tr>');  
      });  
      $(document).on('click', '.btn_remove', function(){  
           var button_id = $(this).attr("id");   
           $('#row'+button_id+'').remove();  
      });  
    
 });  
   