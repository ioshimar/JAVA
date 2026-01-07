<%-- 
    Document   : operaciones_ufg
    Created on : 10-jun-2014, 9:41:04
    Author     : est.cynthia.rivera
--%>

<%@page import="BaseDatos.ConexionDirecBD"%>
<%@page import="java.sql.*"%>
<%@page import="BaseDatos.ConexionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><!-- codificacion de la pagina -->
        <link href="css/estilos_formularios_ugig.css" rel="stylesheet" type="text/css"/>
        <title>Directorio</title><!-- titulo de pestaña de la pagina -->
    </head>
    <body>
        <%
            String nom_user = request.getParameter("nom_user");
//se obtienen todos los valores del formulario anterior
//String folio=request.getParameter("folio");
String ambito_ins =request.getParameter("ambito_ins");
String tipo_ambito =request.getParameter("tipo_ambito");



String ambito_concatenado = ambito_ins + "-" +tipo_ambito;

String ambito_completo ="";
if(ambito_ins.equals("E")){ambito_completo ="ESTATAL";}
if(ambito_ins.equals("M")){ambito_completo ="MUNICIPAL";}
if(ambito_ins.equals("F")){ambito_completo ="FEDERAL";}

String ID_nombre_UE =request.getParameter("nombre_ues");  //Mando el ID


String fecha_llenado=request.getParameter("fecha_llenado");
String nom_oficial = new String(request.getParameter("nomoficial").getBytes("ISO-8859-1"),"UTF-8");
/*String tipovia = new String(request.getParameter("tipovia").getBytes("ISO-8859-1"),"UTF-8");
String nomvial = new String(request.getParameter("nomvial").getBytes("ISO-8859-1"),"UTF-8");
String numexterior=request.getParameter("numexterior");
String numexterioralfa = new String(request.getParameter("numexterioralfa").getBytes("ISO-8859-1"),"UTF-8");
String numexteriorant=request.getParameter("numexteriorant");
String numinterior=request.getParameter("numinterior");
String numinterioralfa= new String(request.getParameter("numinterioralfa").getBytes("ISO-8859-1"),"UTF-8");
String edificio= new String(request.getParameter("edificio").getBytes("ISO-8859-1"),"UTF-8");
String nivel = new String(request.getParameter("nivel").getBytes("ISO-8859-1"),"UTF-8");
String nomvial1= new String(request.getParameter("nomvial1").getBytes("ISO-8859-1"),"UTF-8");
String nomvial2= new String(request.getParameter("nomvial2").getBytes("ISO-8859-1"),"UTF-8");
String nomvial3 = new String(request.getParameter("nomvial3").getBytes("ISO-8859-1"),"UTF-8");
String nomasentamiento= new String(request.getParameter("nomasentamiento").getBytes("ISO-8859-1"),"UTF-8");
*/
String codigopostal=request.getParameter("codigopostal");
//String descripcion= new String(request.getParameter("descripcion").getBytes("ISO-8859-1"),"UTF-8");

//String paginternet=request.getParameter("paginternet");

/*String paginternetConcatenada = "";

    if(paginternet.equals("")){   //si el campo paginternet esta vacio (si no se escribio nada)
        paginternetConcatenada = "";
    }
         else{
             paginternetConcatenada = "http://" + paginternet;
         }
    */


String telefono = request.getParameter("telefono");
String extension = request.getParameter("extension");
/*String apepattitular = new String(request.getParameter("apepattitular").getBytes("ISO-8859-1"),"UTF-8");
String apemattitular = new String(request.getParameter("apemattitular").getBytes("ISO-8859-1"),"UTF-8");
String nomtitular = new String(request.getParameter("nomtitular").getBytes("ISO-8859-1"),"UTF-8");
String puestotitular = new String(request.getParameter("puestotitular").getBytes("ISO-8859-1"),"UTF-8");
String titularprofesion= new String(request.getParameter("titularprofesion").getBytes("ISO-8859-1"),"UTF-8");
String teltitular=request.getParameter("teltitular");
String exttitular=request.getParameter("exttitular");
String mailtitular=request.getParameter("mailtitular");*/
String cve_entidad=new String(request.getParameter("cve_entidad").getBytes("ISO-8859-1"),"UTF-8");
String cve_mun=new String(request.getParameter("lista_categoria").getBytes("ISO-8859-1"),"UTF-8");
//String nommun=request.getParameter("l");
String cve_loc=new String(request.getParameter("lista_subcategoria").getBytes("ISO-8859-1"),"UTF-8");
String concatena = cve_entidad + cve_mun + cve_loc;

/*String tipovia1=new String(request.getParameter("tipovia1").getBytes("ISO-8859-1"),"UTF-8");
String tipovia2=new String(request.getParameter("tipovia2").getBytes("ISO-8859-1"),"UTF-8");
String tipovia3=new String(request.getParameter("tipovia3").getBytes("ISO-8859-1"),"UTF-8");
String tipoasent=new String(request.getParameter("tipoasent").getBytes("ISO-8859-1"),"UTF-8");
String observaciones=new String(request.getParameter("mytextarea").getBytes("ISO-8859-1"),"UTF-8");
String si_no=request.getParameter("fun_esta");
String siglas=new String(request.getParameter("siglas").getBytes("ISO-8859-1"),"UTF-8");*/
//se valida que si la siguiente variable esta vacia se tome como negacion
/*if(si_no==null){//se verifica que esta variable no se guarde nula
    si_no="";//se agregan comillas
}
else{//si contiene algo
if(si_no.equals("No")){//se verifica su contenido
    si_no="No";
   }
else
    si_no="Si";
}*/
//out.print(si_no);

/*
String apepaten= new String(request.getParameter("apepatenlace").getBytes("ISO-8859-1"),"UTF-8");
String apematen= new String(request.getParameter("apematenlace").getBytes("ISO-8859-1"),"UTF-8");
String nomen= new String(request.getParameter("nomenlace").getBytes("ISO-8859-1"),"UTF-8");
String puestoen= new String(request.getParameter("puestoenlace").getBytes("ISO-8859-1"),"UTF-8");
String areaen= new String(request.getParameter("areads").getBytes("ISO-8859-1"),"UTF-8");
String telen=request.getParameter("telenlace");
String exten=request.getParameter("extenlace");
String mailen=request.getParameter("mailenlace");
String apepatres= new String(request.getParameter("apepatresp").getBytes("ISO-8859-1"),"UTF-8");
String apematres= new String(request.getParameter("apematresp").getBytes("ISO-8859-1"),"UTF-8");
String nomres= new String(request.getParameter("nomresp").getBytes("ISO-8859-1"),"UTF-8");
String areares= new String(request.getParameter("adsresp").getBytes("ISO-8859-1"),"UTF-8");
String fechares=request.getParameter("fecha");
String firmares=request.getParameter("firma");
if(firmares==null){
   firmares="No";
}
else firmares="Si";
String apepatllen= new String(request.getParameter("apepatllenado").getBytes("ISO-8859-1"),"UTF-8");
String apematllen= new String(request.getParameter("apematllenado").getBytes("ISO-8859-1"),"UTF-8");
String nomllen= new String(request.getParameter("nomllenado").getBytes("ISO-8859-1"),"UTF-8");
//String areallen=request.getParameter("adsllenado");
String fechallen=request.getParameter("fecha2");

String firmallen=request.getParameter("firma2");
if(firmallen==null){
   firmallen="No";
}
else firmallen="Si";
String apepatver= new String(request.getParameter("apepatver").getBytes("ISO-8859-1"),"UTF-8");
String apematver= new String(request.getParameter("apematver").getBytes("ISO-8859-1"),"UTF-8");
String nomver= new String(request.getParameter("nomver").getBytes("ISO-8859-1"),"UTF-8");
//String areaver=request.getParameter("adsver");
String fechaver=request.getParameter("fecha3");
String firmaver=request.getParameter("firma3");
if(firmaver==null){
   firmaver="No";
}
else firmaver="Si";
String[] grupodatos=request.getParameterValues("grupodatos");
String descrip_otro = new String(request.getParameter("otro_esp").getBytes("ISO-8859-1"),"UTF-8");*/
ConexionDirecBD conexion=new ConexionDirecBD();//nueva conexion  la base de datos
ConexionBD conexionSegCurt=new ConexionBD();


String entidad="";

/*
//las siguientes consultas cambian nombres por claves en caso de ser necesario
 PreparedStatement pst1 =(PreparedStatement) conexion.conn.prepareStatement( "select tipovia from db_directorio.cat_tipovia where tipoviadescripcion='"+tipovia.toUpperCase()+"' ");
    conexion.rs =pst1.executeQuery(); 
       while(conexion.rs.next()) {
   entidad = conexion.rs.getString("tipovia");
   //out.println("tipovia "+entidad);
    }
   String seltipovia1="";
 PreparedStatement pst2 =(PreparedStatement) conexion.conn.prepareStatement( "select tipovia from db_directorio.cat_tipovia where tipoviadescripcion='"+tipovia1.toUpperCase()+"' ");
    conexion.rs =pst2.executeQuery(); 
       while(conexion.rs.next()) {
   seltipovia1 = conexion.rs.getString("tipovia");
  // out.println("tipovia1"+seltipovia1);
    }
   String seltipovia2="";
 PreparedStatement pst3 =(PreparedStatement) conexion.conn.prepareStatement( "select tipovia from db_directorio.cat_tipovia where tipoviadescripcion='"+tipovia2.toUpperCase()+"' ");
    conexion.rs =pst3.executeQuery(); 
       while(conexion.rs.next()) {
   seltipovia2 = conexion.rs.getString("tipovia");
  // out.println("tipovia2 "+seltipovia2);
    }
  String seltipovia3="";
 PreparedStatement pst4 =(PreparedStatement) conexion.conn.prepareStatement( "select tipovia from db_directorio.cat_tipovia where tipoviadescripcion='"+tipovia3.toUpperCase()+"' ");
    conexion.rs =pst4.executeQuery(); 
       while(conexion.rs.next()) {
   seltipovia3 = conexion.rs.getString("tipovia");
  // out.println("tipovia3 "+seltipovia3);
    }
       String seltipoasen="";
 PreparedStatement pst5 =(PreparedStatement) conexion.conn.prepareStatement( "select id_asen from db_directorio.cat_asen where tipoasen='"+tipoasent.toUpperCase()+"' ");
    conexion.rs =pst5.executeQuery(); 
       while(conexion.rs.next()) {
   seltipoasen = conexion.rs.getString("id_asen");
   //out.println("tipoasent "+seltipoasen);
    }
       */
   /*    
   String estado="";
 PreparedStatement pst6 =(PreparedStatement) conexion.conn.prepareStatement( "select \"CVE_EDO\" from db_directorio.cat_edo where \"NOM_EDO\"='"+cve_entidad+"' ");
    conexion.rs =pst6.executeQuery(); 
       while(conexion.rs.next()) {
   estado = conexion.rs.getString("CVE_EDO");
   //out.println("cveedo "+estado);
    }*/
       
   String selmun="";
   String nommun ="";
   PreparedStatement pst7 =(PreparedStatement) conexion.conn.prepareStatement( "select \"CVE_MUN\",\"NOM_MUN\" from db_directorio.cat_mun where \"CVE_MUN\"='"+cve_mun+"'  and \"CVE_EDO\" ='"+cve_entidad+"'");
    conexion.rs =pst7.executeQuery(); 
       while(conexion.rs.next()) {
   selmun = conexion.rs.getString("CVE_MUN");
   nommun = conexion.rs.getString("NOM_MUN");
  // out.print("cvemun "+selmun);
  // out.print("nommun "+nommun);
       }
    String nomloca="";
       PreparedStatement pst9=(PreparedStatement) conexion.conn.prepareStatement( "select \"nomloc\" FROM db_directorio.cat_loc"
               + " WHERE cve_loc = '"+cve_loc+"' and cve_edo = '"+cve_entidad+"' and cve_mun = '"+cve_mun+"' ");
    conexion.rs =pst9.executeQuery(); 
       while(conexion.rs.next()) {
   nomloca = conexion.rs.getString("nomloc");
   //out.print("nomlocal "+nomloca);
       }
       
 /*      
 String selgrupo="";
 if(grupodatos!=null && grupodatos.length>0){
    for(int i=0; i<grupodatos.length; i++){
    //out.print(new String(grupodatos[i].getBytes("ISO-8859-1"),"UTF-8")+",");
     PreparedStatement pst10=(PreparedStatement) conexion.conn.prepareStatement( "select \"GRUPODATOS\" from db_directorio.ufg_grupodatos where descrip_gd='"+new String(grupodatos[i].getBytes("ISO-8859-1"),"UTF-8")+"' ");
    conexion.rs =pst10.executeQuery(); 
       while(conexion.rs.next()) {
   selgrupo = conexion.rs.getString("GRUPODATOS");
  //out.print(selgrupo);
       }
    }
}
 */
 /*
  String ues_Id="";
  String ues_cve_entidad="";
  String ues_cve_mun="";
  String ues_Ins_nombre_mpio="";
  String ues_Ins_nombre_loc="";
  String ues_folio=""; 
  String ues_Ins_nombre="";
  String ues_siglas="";
  String ues_ambito="";
       PreparedStatement pst18=(PreparedStatement) conexion.conn.prepareStatement( "select * from db_directorio.ufg_directori_ue  WHERE \"Id\" = '"+ID_nombre_UE+"' ");
    conexion.rs =pst18.executeQuery(); 
       while(conexion.rs.next()) {
            //ues_Id = conexion.rs.getString("Id"); 
            ues_cve_entidad= conexion.rs.getString("CVE_ENTIDAD"); 
            ues_cve_mun = conexion.rs.getString("CVE_MUN"); 
            ues_Ins_nombre_mpio = conexion.rs.getString("INSNOMBRECIUDADMPIO");
            ues_Ins_nombre_loc = conexion.rs.getString("INSNOMBRELOCALIDAD");
            ues_folio = conexion.rs.getString("FOLIO");
            ues_Ins_nombre = conexion.rs.getString("INSNOMBRE");
            ues_siglas = conexion.rs.getString("SIGLAS");
            ues_ambito = conexion.rs.getString("AMBITO");
        }*/
 
/*
  String ultimo_folio="";
       PreparedStatement pst15=(PreparedStatement) conexion.conn.prepareStatement( "select MAX(\"FOLIO\") AS ultimo_f from db_directorio.catalogo_ue_ugig  WHERE \"AMBITO\" LIKE '"+ambito_ins+"%' AND \"CVE_ENTIDAD\" = '"+cve_entidad+"'   ");
    conexion.rs =pst15.executeQuery(); 
       while(conexion.rs.next()) {
   ultimo_folio= conexion.rs.getString("ultimo_f"); 

       }

  */


String folio_oficial = "";   //Variable

//if(ID_nombre_UE.equals("no_aplica")){ //Si es No aplica, Agregamos este tipo de Folio...
    
    String last_folio="";
       PreparedStatement pst11=(PreparedStatement) conexionSegCurt.conn.prepareStatement( "select SUBSTR((MAX(\"FOLIO\")),2) AS ultimo_f from seguimiento_cap.ufg_directori_ufg WHERE \"FOLIO\" LIKE '"+ambito_ins+"%'");
    conexionSegCurt.rs =pst11.executeQuery(); 
       while(conexionSegCurt.rs.next()) {
   last_folio= conexionSegCurt.rs.getString("ultimo_f");
  // out.print("ambito "+selambito_ins);
       }
       
   int folio_1 = Integer.parseInt(last_folio) + 1; // convertir a entero el resultado de la consulta  (selambito_ins = 2424 (en caso de 4 cifras)   191+1 = 192 folio = 192(en caso de 3 cifras)
    //NOTA: Cuando se convierte a Enteros quita los CEROS a la izquierda
   int caracteres =  Integer.toString(folio_1).length();     // pasar el folio a string para contar los caracteres
  
    //Estas LINEAS solucionan el Problema de los CEROS a la Izquierda 
         if( caracteres  == 3 ){    // 193  
         folio_oficial =  ambito_ins + 0 + String.valueOf(folio_1);        //M 0193
        }
        
        if( caracteres  == 2 ){    // 93  
         folio_oficial =  ambito_ins + 0 + 0 + String.valueOf(folio_1);        //M 0093
        }
       
        if( caracteres  == 1 ){    // 3  
         folio_oficial =  ambito_ins + 0 + 0 + 0 + String.valueOf(folio_1);       //M 0003  
        }
        
        if( caracteres  == 4 ){ // 1193
             folio_oficial = ambito_ins + String.valueOf(folio_1); //convertir a String  el folio_1 y agregarle la letra M,E o F que viene en la variable ambito_ins  //X 1193
       }
        
        //ambito_concatenado = ambito_ins;  //esta opción se puede usar para solo agregar E,M o F en el campo Ambito

//}


/*

else{ //si es diferente a no aplica, le agregamos este otro Tipo de Folio
    String conteo_UE="";
       PreparedStatement pst30=(PreparedStatement) conexion.conn.prepareStatement( "select count(*) AS Total_Registros from db_directorio.catalogo_ue_ugig  WHERE \"ue_Id\" = '"+ID_nombre_UE+"' AND \"ue_CVE_ENTIDAD\" = '"+cve_entidad+"'   ");
    conexion.rs =pst30.executeQuery(); 
       while(conexion.rs.next()) {
            conteo_UE = conexion.rs.getString("Total_Registros"); 
       }
 
    int folio_1 = Integer.parseInt(conteo_UE) + 1;
    int caracteres =  Integer.toString(folio_1).length();  //Variable  //Contamos los Caracteres que trae la Variable folio_1  
     
      if( caracteres  == 3 ){    // 123 
         folio_oficial =  String.valueOf(folio_1);        //123   Si trae 3 caracteres lo dejamos igual
        }
      
       if( caracteres  == 2 ){    // 23 
         folio_oficial =  "0" + String.valueOf(folio_1);        //23  si trae 2 caracteres le agregamos un 0 a la izquierda
        }
      
       if( caracteres  == 1 ){    // 23 
         folio_oficial =  "00" + String.valueOf(folio_1);        //3  si trae 1 caracter le agregamos dos ceros (00) a la izquierda
        }
 
}    */
 
//se crea un objeto statement de la conexion
  conexionSegCurt.stmt=conexionSegCurt.conn.createStatement();
  //se ejecut el insert correspondiente
  conexionSegCurt.stmt.executeUpdate("INSERT INTO seguimiento_cap.ufg_directori_ufg (\"Id\",\"FOLIO\",\"FECHA_LLENADO\",\"INSNOMBRE\","
         + "\"CPOSTAL\",\"CVE_ENTIDAD\",\"CVE_MUN\",\"INSNOMBRECIUDADMPIO\",\"INSNOMBRELOCALIDAD\","
         + "\"INS_TEL\",\"INS_EXT\", \"GRUPODATOS\", "
         + "\"AMBITO\",\"MODIFICADO\", \"FECHA_ACTUALIZA\", cve_loc, \"CONCATENA\", \"AMBITO2\", \"CURT\", habilitado  )"
    +"VALUES(nextval('\"seguim_CURT\".id_ufg'),'"+folio_oficial+"','"+fecha_llenado+"','"+nom_oficial+"',"
        + "'"+codigopostal+"','"+cve_entidad+"','"+selmun+"','"+nommun+"','"+nomloca.toUpperCase()+"',"
        + "'"+telefono+"','"+extension+"', '13.9', " //agrego el grupo de datos otro
        + "'"+ambito_concatenado+"','false', CURRENT_DATE, '"+cve_loc+"', '"+concatena+"', '"+ambito_completo+"', '{Y}', TRUE)");
 
  
  
  /*
   String ultimo_ID_ufg="";
       PreparedStatement pst20=(PreparedStatement) conexion.conn.prepareStatement( "select MAX(\"Id\") AS ultimo_ID from db_directorio.ufg_directori_ufg");
    conexion.rs =pst20.executeQuery(); 
       while(conexion.rs.next()) {
           ultimo_ID_ufg= conexion.rs.getString("ultimo_ID"); 
       }
  
 
  conexion.stmt.executeUpdate("INSERT INTO db_directorio.catalogo_ue_ugig(\"ue_Id\",\"ue_CVE_ENTIDAD\",\"ue_CVE_MUN\",\"ue_INSNOMBRECIUDADMPIO\",\"ue_INSNOMBRELOCALIDAD\",\"ue_FOLIO\",\"ue_INSNOMBRE\",\"ue_SIGLAS\","
        + "\"ue_AMBITO\",\"Id\",\"CVE_ENTIDAD\",\"CVE_MUN\",\"INSNOMBRECIUDADMPIO\",\"INSNOMBRELOCALIDAD\",\"FOLIO\",\"INSNOMBRE\",\"AMBITO\",\"FOLIO_UE_UFG\")"
        +"VALUES('"+ID_nombre_UE+"','"+ues_cve_entidad+"','"+ues_cve_mun+"','"+ues_Ins_nombre_mpio+"','"+ues_Ins_nombre_loc+"','"+ues_folio+"','"+ues_Ins_nombre+"','"+ues_siglas+"',"
        + "'"+ues_ambito+"','"+ultimo_ID_ufg+"','"+cve_entidad+"','"+selmun+"','"+nommun+"','"+nomloca.toUpperCase()+"','"+folio_oficial+"','"+nom_oficial+"','"+ambito_concatenado+"',"
        + "'"+folio_concatenado+"')");
*/
  
 conexion.closeConnection(); //se cierra la conexion 
 conexionSegCurt.closeConnection(); //se cierra la conexion
%>
<div id="cont-mensaje">
  <!--  <h2 align="center">SE AGREGÓ UN REGISTRO A LA BASE DE DATOS</h2>
    <br><br>
    <a href="sis_dir.jsp"> Regresar </a>-->
  <script>
      alert("Se ha agregado una nueva Unidad de Estado");
      location.href = "selecciona_ue.jsp?nom_user=<%=nom_user%>";
      
  </script> 
  
</div>

    </body> 
</html>
