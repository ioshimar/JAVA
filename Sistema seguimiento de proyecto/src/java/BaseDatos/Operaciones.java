/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package BaseDatos;

import java.sql.*;


public class Operaciones{
    public Operaciones(){
        
    }
   public String id,folio,fecha_llenado,nom_oficial,nomvial,numexterior,numexterioralfa,numexteriorant,numinterior,
            numinteriorant,edificio,nivel,nomvial1,nomvial2,nomvial3,nomasentamiento,descripcion,paginternet,
            telefono,extension,apepattitular,apemattitular,nomtitular,puestotitular,profesiontitular,teltitular,exttitular,
            mailtitular,ambito,cve_entidad,cve_mun,nommun,nomloc,
            tipovia,tipovia1,tipovia2,tipovia3,tipoasent,codigopostal;
    public String imprimir_ue(int idpar){
        ConexionBD conexion=new ConexionBD();
        String res="";
        try{
    PreparedStatement pst1 =(PreparedStatement) conexion.conn.prepareStatement( "selec * from db_directorio.ufg_directori_ue where \"Id\"='"+idpar+"' ");
    conexion.rs =pst1.executeQuery();
    res= conexion.rs.getString("F0LIO");
        }catch(SQLException error){
           System.err.print("Error"+error);
               if(res.equals(""))
                res="";
        }
        return res;
    }
    
    }
