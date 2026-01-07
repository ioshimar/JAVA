/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import BaseDatos.ConexionBD;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author RICARDO.MACIAS
 */
public class Consultas1 extends ConexionBD  {
    
      public boolean autenticacion1(String estado, String password){
        PreparedStatement pst = null;
        ResultSet rs = null;
        try{
            String consulta = "Select * from seguimiento_cap.usuarios where \"user\" = ? and pwd = ?";
            pst = conn.prepareStatement(consulta,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);    //ya no ponemos Conexion.conn porque en la clase de arriba lo heredamos con el extends
            //pasar los parametros
            pst.setString(1, estado);
            pst.setString(2, password);
            rs = pst.executeQuery();//guardamos el resultado de la consulta en la variable rs     //ya no ponemos Conexion.conn porque en la clase de arriba lo heredamos con el extends
            
            if(rs.absolute(1)){  //Si tiene un registro
                return true;
            }
            
        
           } catch(Exception e){
                    System.err.println("Error" + e);
                }   
             finally{
                    try{
                         if(conn != null){ conn.close(); }//Cerrar la conexion
                         if(pst != null){pst.close();}
                         if(rs != null){ rs.close();}
                    }   
                        catch(Exception e){
                            System.err.println("Error" + e);
                        }
             }
        
    return false;
    }
    
}