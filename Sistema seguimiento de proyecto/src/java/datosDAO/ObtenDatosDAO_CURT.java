/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datosDAO;


import BaseDatos.ConexionBD;
import Modelo.ResultDTO_prediosproc;
import Modelo.ResultDTO_prediosproc_2;
import Modelo.ResultDTO_solproc;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.sql.DataSource;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

/**
 *
 * @author RICARDO.MACIAS
 */



public class ObtenDatosDAO_CURT {
  //  public class ObtenDatosDAO_CURT extends ConexionBD
       

        DataSource ds = ConnCURT.getDataSource();  //Variable de los datos de acceso a la BD
    
      public List<ResultDTO_solproc> cargaTr_ue(int idsolicitud) throws SQLException {
      /*De aqui hacia arriba es prueba*/
    try { 
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT  A.describe as describe, A.tamano as tamano,\n" +
" count(B.*) as Total\n" +
" FROM registrocurt.tr_solicitudes_procesos as A, registrocurt.tr_predios_procesados as B\n" +
" WHERE A.idsolicitud = B.id_solicitud \n" +
" AND A.idsolicitud  = ? \n" +
" GROUP BY  A.describe, A.tamano ";
        Object[] params = {idsolicitud};        
        ResultSetHandler rsh = new BeanListHandler(ResultDTO_solproc.class);
        List<ResultDTO_solproc> consultaP3CURT = (List<ResultDTO_solproc>) qr.query(sql, rsh, params);
        return consultaP3CURT;
        }
         finally {
         ds.getConnection().close();
        }
    }
      
      
      
       public List<ResultDTO_solproc> ConsCompleta(int idsolicitud) throws SQLException {
      /*De aqui hacia arriba es prueba*/
    try { 
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT  (select count(*) as TotalConCurt from registrocurt.tr_predios_procesados where id_solicitud='"+idsolicitud+"' and status=1 ),\n" +
"(select count(*) as TotalSinCurt from registrocurt.tr_predios_procesados where id_solicitud='"+idsolicitud+"' and status<>1 ),\n" +
" A.describe as describe, \n" +
"A.tamano as tamano,\n" +
" count(B.*) as Total\n" +
" FROM registrocurt.tr_solicitudes_procesos as A, registrocurt.tr_predios_procesados as B\n" +
"  WHERE A.idsolicitud = B.id_solicitud \n" +
" AND A.idsolicitud  = ? \n" +
"  GROUP BY  A.describe, A.tamano";
        Object[] params = {idsolicitud};        
        ResultSetHandler rsh = new BeanListHandler(ResultDTO_solproc.class);
        List<ResultDTO_solproc> consultaCompCurt = (List<ResultDTO_solproc>) qr.query(sql, rsh, params);
        return consultaCompCurt;
        }
         finally {
         ds.getConnection().close();
        }
    }
      
      
      
      
      
   public List<ResultDTO_prediosproc> CountConCurt(int idsolicitud) throws SQLException {
      
    try { 
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT count(*) as TotalconCurt\n" +
"  FROM registrocurt.tr_predios_procesados Where id_solicitud=?  and status=1";
        Object[] params = {idsolicitud};        
        ResultSetHandler rsh = new BeanListHandler(ResultDTO_prediosproc.class);
        List<ResultDTO_prediosproc> consultaConCurt = (List<ResultDTO_prediosproc>) qr.query(sql, rsh, params);
        return consultaConCurt;
        }
         finally {
         ds.getConnection().close();
        }
    }    
   
   
      public List<ResultDTO_prediosproc_2> CountSinCurt(int idsolicitud) throws SQLException {
      
    try { 
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT count(*) as TotalSinCurt\n" +
" FROM registrocurt.tr_predios_procesados Where id_solicitud=?  and status <> 1";
        Object[] params = {idsolicitud};        
        ResultSetHandler rsh = new BeanListHandler(ResultDTO_prediosproc_2.class);
        List<ResultDTO_prediosproc_2> consultaSinCurt = (List<ResultDTO_prediosproc_2>) qr.query(sql, rsh, params);
        return consultaSinCurt;
        }
         finally {
         ds.getConnection().close();
        }
    } 
    
    
}
