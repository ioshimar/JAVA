 $(document).ready(function(){  
      var i=1;  
      $('#add').click(function(){  
           i++;  
           $('#dynamic_field').append('<tr id="row'+i+'">\n\
                                        <td><input type="text" name="nom_arch" class="w50" placeholder="Nombre archivo"></td>\n\
                                        <td><input type="text" name="tamano" id="tamano" class="w10" placeholder="MB"></td>\n\
                                        <td><input type="text" name="no_reg" id="no_reg" class="w10" placeholder="No. de registros"></td>\n\
                                        <td><input type="text" name="cobertura" id="cobertura" class="w10" placeholder="Cobertura"></td>\n\
                                        <td><button type="button" name="remove" id="'+i+'" class="btn btn-danger btn_remove">X</button></td></tr>');  
      });  
      $(document).on('click', '.btn_remove', function(){  
           var button_id = $(this).attr("id");   
           $('#row'+button_id+'').remove();  
      });  
     /* $('#subirBtn').click(function(){            
           $.ajax({  
                url:"imagen.php",  
                method:"GET", 
				data:$('#form-img').serialize(),  
                success:function(data)  
                {  
                     alert(data);  
                     $('#form-img')[0].reset();  
                }   
                
           });  
      });*/
 });  
   // JavaScript Document
   /*----------------------------APARTADO COBERTURA------------------------------------------------------------------*/
   
  