/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datosDAO;

import Modelo.FilasDTOSolSop;
import Modelo.FilasDTOlibcap;
import Modelo.FilasDTOp1;
import Modelo.FilasDTOp10;
import Modelo.FilasDTOp11;
import Modelo.FilasDTOp12;
import Modelo.FilasDTOp13;
import Modelo.FilasDTOp2;
import Modelo.FilasDTOp3;
import Modelo.FilasDTOp4;
import java.sql.SQLException;
import java.util.List;
import javax.sql.DataSource;

import Modelo.FilasDTOp5;
import Modelo.FilasDTOp6;
import Modelo.FilasDTOp7;
import Modelo.FilasDTOp8;
import Modelo.FilasDTOp9;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

/**
 *
 * @author RICARDO.MACIAS
 */
public class ObtenDatosDAO {

    /**
     *
     * @param id_ue
    
 
     * @return
     * @throws java.sql.SQLException
     */
 /*FILAS PARTE 5*/
    DataSource ds = AdministradorDataSource.getDataSource();  //Variable de los datos de acceso a la BD
    
 /* public List<FilasDTOp2> cargaFilasP2(int Id_ue) throws SQLException {
       try { 
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_entrega, id_ue, TO_CHAR(fecha, 'dd/MM/yyyy') as fecha, nom_resp_ent, unidad_admin, nom_resp_rec, medio, nom_archivo, tamano, total_reg, TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado, TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as fecha_actualizacion, \n" +
"       idsolicitud, tipo_entrega, pred_con_curt, pred_sin_curt FROM \"seguim_CURT\".datos_entrega_fis WHERE id_ue = ? ORDER BY fecha_actualizacion";
        Object[] params = {Id_ue};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp2.class);
        List<FilasDTOp2> psisref = (List<FilasDTOp2>) qr.query(sql, rsh, params);
        return psisref;
       }
        finally {
         ds.getConnection().close();
        }
    } 
    */
    
    public List<FilasDTOp5> cargaFilasP5(int Id_ue) throws SQLException {
       try { 
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_entrega, id_ue, TO_CHAR(fecha, 'dd/MM/yyyy') as fecha, nom_resp_ent, unidad_admin, nom_resp_rec, medio, nom_archivo, tamano, total_reg, TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado, TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as fecha_actualizacion, \n" +
"       idsolicitud, tipo_entrega, pred_con_curt, pred_sin_curt FROM \"seguim_CURT\".datos_entrega_fis WHERE id_ue = ? ORDER BY fecha_actualizacion";
        Object[] params = {Id_ue};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp5.class);
        List<FilasDTOp5> psisref = (List<FilasDTOp5>) qr.query(sql, rsh, params);
        return psisref;
       }
        finally {
         ds.getConnection().close();
        }
    }    
   

  /*Datos Parte 5 para actualizar*/
  public List<FilasDTOp5> cargaEntrega(int id_entrega) throws SQLException {
        //DataSource ds = AdministradorDataSource.getDataSource();
        try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_entrega, id_ue, TO_CHAR(fecha, 'dd/MM/yyyy') as fecha, nom_resp_ent, unidad_admin, nom_resp_rec, medio, nom_archivo, tamano, total_reg, TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado, TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as fecha_actualizacion, \n" +
"       idsolicitud, tipo_entrega, pred_con_curt, pred_sin_curt FROM \"seguim_CURT\".datos_entrega_fis WHERE id_entrega = ?";
        Object[] params = {id_entrega};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp5.class);
        List<FilasDTOp5> consultaP5 = (List<FilasDTOp5>) qr.query(sql, rsh, params);
        return consultaP5;
         }
        finally {
         ds.getConnection().close();
        }
    }    
  
  
   public List<FilasDTOp1> cargaConcertacion(int id_ue) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_concer, id_ue, nom_ent, cve_ent, nom_ue, TO_CHAR(fec_pri_env, 'dd/MM/yyyy') as fec_pri_env,  TO_CHAR(fec_pri_res, 'dd/MM/yyyy') as fec_pri_res, \n" +
"       TO_CHAR(fec_seg_env, 'dd/MM/yyyy') as fec_seg_env,  TO_CHAR(fec_seg_res, 'dd/MM/yyyy') as fec_seg_res, acepto, que_acepto, motivo, TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado, \n" +
"       TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as fecha_actualizacion, respuesta1, respuesta2, fechas_primer_oficio, fechas_segundo_oficio,   TO_CHAR(fec_ter_env, 'dd/MM/yyyy') as fec_ter_env, TO_CHAR(fec_ter_res, 'dd/MM/yyyy') as fec_ter_res, respuesta3, fechas_tercer_oficio,"
                + " nombre_destin1, nombre_remi1, nombre_destin2, nombre_remi2, nombre_destin3, nombre_remi3, ruta_ofi_env1, ruta_ofi_recib1, ruta_ofi_env2, ruta_ofi_recib2, ruta_ofi_env3, ruta_ofi_recib3, municipio, observaciones, activa_2of, activa_3of, privilegio, concerta \n" +
"  FROM \"seguim_CURT\".concertacion  WHERE id_ue = ? ORDER BY id_concer";
        Object[] params = {id_ue};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp1.class);
        List<FilasDTOp1> consultaP1 = (List<FilasDTOp1>) qr.query(sql, rsh, params);
        return consultaP1;
        }
        finally {
         ds.getConnection().close();
        }
    }    
   
   
    public List<FilasDTOp2> cargaCap(int id_cap) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_cap, id_ue, nom_user, TO_CHAR(fecha_cap, 'dd/MM/yyyy') as fecha_cap, lugar, norma_cat, norma_curt, lineamiento, diccionario, resp_inegi, cant_pers, TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado, TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as  fecha_actualizacion\n" +
"  FROM seguimiento_cap.capacitacion WHERE id_cap = ?";
        Object[] params = {id_cap};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp2.class);
        List<FilasDTOp2> consulP2 = (List<FilasDTOp2>) qr.query(sql, rsh, params);
        return consulP2;
        }
        finally {
         ds.getConnection().close();
        }
    }
    
    
    public List<FilasDTOp2> cargaCapacitacion(int id_ue) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_cap, id_ue, nom_user, TO_CHAR(fecha_cap, 'dd/MM/yyyy') as fecha_cap, lugar, norma_cat, norma_curt, lineamiento, diccionario, resp_inegi, cant_pers, tipo_cap, TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado, TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as  fecha_actualizacion\n" +
"  FROM seguimiento_cap.capacitacion WHERE id_ue = ? ORDER BY id_cap";
        Object[] params = {id_ue};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp2.class);
        List<FilasDTOp2> consultaP2 = (List<FilasDTOp2>) qr.query(sql, rsh, params);
        return consultaP2;
        }
        finally {
         ds.getConnection().close();
        }
    } 
    
    
     public List<FilasDTOp3> cargaRegUe(int id_ue) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_reg, id_ue, TO_CHAR(fec_sol_reg, 'dd/MM/yyyy') as fec_sol_reg, TO_CHAR(fec_env_doc, 'dd/MM/yyyy') as fec_env_doc,  TO_CHAR(fec_val_doc, 'dd/MM/yyyy') as fec_val_doc, "
                + "TO_CHAR(fec_env_firm, 'dd/MM/yyyy') as fec_env_firm, TO_CHAR(fec_regus, 'dd/MM/yyyy') as  fec_regus, TO_CHAR(fec_rec_doc, 'dd/MM/yyyy') as  fec_rec_doc,"
                + "TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado, TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy')  as fecha_actualizacion\n" +
"  FROM \"seguim_CURT\".registro_ue WHERE id_ue = ? ORDER BY id_reg";
        Object[] params = {id_ue};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp3.class);
        List<FilasDTOp3> consultaP3 = (List<FilasDTOp3>) qr.query(sql, rsh, params);
        return consultaP3;
        }
        finally {
         ds.getConnection().close();
        }
    } 
     
     
      public List<FilasDTOp4> cargaAsesoria(int id_ue) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_ase, id_ue, TO_CHAR(fec_ini_regue, 'dd/MM/yyyy') as fec_ini_regue, TO_CHAR(fec_fin_regue, 'dd/MM/yyyy') as fec_fin_regue, nom_resp_ue, nom_reci_ue, \n" +
"       TO_CHAR(fec_ini_ap, 'dd/MM/yyyy') as fec_ini_ap, TO_CHAR(fec_fin_ap, 'dd/MM/yyyy') as fec_fin_ap, nom_resp_ap, nom_reci_ap,TO_CHAR(fec_ini_cord, 'dd/MM/yyyy') as fec_ini_cord, \n" +
"       TO_CHAR(fec_fin_cord, 'dd/MM/yyyy') as fec_fin_cord, nom_resp_cord, nom_rec_cord, TO_CHAR(fec_ini_est, 'dd/MM/yyyy') as  fec_ini_est, TO_CHAR(fec_fin_est, 'dd/MM/yyyy')  as fec_fin_est, \n" +
"       nom_resp_est, nom_rec_est, TO_CHAR(fec_ini_info, 'dd/MM/yyyy') as fec_ini_info, TO_CHAR(fec_fin_info, 'dd/MM/yyyy') as  fec_fin_info, nom_resp_info, \n" +
"       nom_rec_info, TO_CHAR(fec_ini_inte, 'dd/MM/yyyy') as fec_ini_inte, TO_CHAR(fec_fin_inte, 'dd/MM/yyyy') as fec_fin_inte, nom_resp_inte, nom_rec_inte, \n" +
"       TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado,TO_CHAR(\"fecha_Actualizacion\", 'dd/MM/yyyy') as  \"fecha_Actualizacion\", tipo_asesoria \n" +
"       FROM \"seguim_CURT\".asesoria WHERE id_ue = ? ORDER BY id_ase";
        Object[] params = {id_ue};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp4.class);
        List<FilasDTOp4> consultaP4 = (List<FilasDTOp4>) qr.query(sql, rsh, params);
        return consultaP4;
      }
        finally {
         ds.getConnection().close();
        }
    } 
      
      
      
      public List<FilasDTOp6> cargaCriterios(int id_ue) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_val, id_ue, nom_respval, TO_CHAR(fec_ini, 'dd/MM/yyyy') as fec_ini, TO_CHAR(fec_fin, 'dd/MM/yyyy') as  fec_fin, for_shape, ext_min, \n" +
        "       est_cor, atrib, info_cord, code_total, fecha_llenado, fecha_actualizacion, id_entrega, nom_archivo \n" +
        "  FROM \"seguim_CURT\".criterios_validacion  WHERE id_ue = ? ORDER BY id_val ";
        Object[] params = {id_ue};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp6.class);
        List<FilasDTOp6> consultaP6 = (List<FilasDTOp6>) qr.query(sql, rsh, params);
        return consultaP6;
      }
        finally {
         ds.getConnection().close();
        }
    } 
      
      
      
      public List<FilasDTOp6> cargaActualizaP6(int id_val) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_val, id_ue, nom_respval, TO_CHAR(fec_ini, 'dd/MM/yyyy') as fec_ini, TO_CHAR(fec_fin, 'dd/MM/yyyy') as  fec_fin, for_shape, ext_min, \n" +
        "       est_cor, atrib, info_cord, code_total, fecha_llenado, fecha_actualizacion, id_entrega, nom_archivo \n" +
        "  FROM \"seguim_CURT\".criterios_validacion  WHERE id_val = ? ORDER BY id_val ";
        Object[] params = {id_val};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp6.class);
        List<FilasDTOp6> consultaP6 = (List<FilasDTOp6>) qr.query(sql, rsh, params);
        return consultaP6;
        }
        finally {
         ds.getConnection().close();
        }
    } 
      
      
       public List<FilasDTOp6> cargaDevoluciones(int id_entrega) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_val, id_ue, nom_respval, TO_CHAR(fec_ini, 'dd/MM/yyyy') as fec_ini, TO_CHAR(fec_fin, 'dd/MM/yyyy') as  fec_fin, for_shape, ext_min, \n" +
        "       est_cor, atrib, info_cord, code_total, fecha_llenado, fecha_actualizacion, id_entrega, nom_archivo \n" +
        "  FROM \"seguim_CURT\".criterios_validacion  WHERE id_entrega = ?";
        Object[] params = {id_entrega};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp6.class);
        List<FilasDTOp6> consultaDevolP6 = (List<FilasDTOp6>) qr.query(sql, rsh, params);
        return consultaDevolP6;
       }
        finally {
         ds.getConnection().close();
        }
    } 
      
      
      
       public List<FilasDTOp7> cargaDevolucion(int id_ue) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_dev, id_ue, TO_CHAR(fecha_dev, 'dd/MM/yyyy') as fecha_dev, nom_resp_dev, nom_rec_dev, arch_dev, \n" +
"       total_regdev, fecha_llenado, fecha_actualizacion, motivos_dev,  id_entrega, nom_archivo \n" +
"  FROM \"seguim_CURT\".devolucion WHERE id_ue = ? ORDER BY id_dev ";
        Object[] params = {id_ue};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp7.class);
        List<FilasDTOp7> consultaP7 = (List<FilasDTOp7>) qr.query(sql, rsh, params);
        return consultaP7;
        }
        finally {
         ds.getConnection().close();
        }
      } 
       
       
       public List<FilasDTOp7> cargaActualizaP7(int id_dev) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_dev, id_ue, TO_CHAR(fecha_dev, 'dd/MM/yyyy') as fecha_dev, nom_resp_dev, nom_rec_dev, arch_dev, \n" +
"       total_regdev, fecha_llenado, fecha_actualizacion, motivos_dev,  id_entrega, nom_archivo \n" +
"  FROM \"seguim_CURT\".devolucion WHERE id_dev = ? ORDER BY id_dev ";
        Object[] params = {id_dev};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp7.class);
        List<FilasDTOp7> consultaActP7 = (List<FilasDTOp7>) qr.query(sql, rsh, params);
        return consultaActP7;
      }
        finally {
         ds.getConnection().close();
        }
    } 
       
       
       
       
       
       
    public List<FilasDTOp8> cargaInfOC(int id_ue) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_eoc, id_ue, TO_CHAR(fec_oc, 'dd/MM/yyyy') as fec_oc, nom_resp_ent, nom_recibe, fecha_llenado, \n" +
        "       fecha_actualizacion\n" +
        "  FROM \"seguim_CURT\".entrega_oc  WHERE id_ue = ? ORDER BY id_eoc ";
        Object[] params = {id_ue};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp8.class);
        List<FilasDTOp8> consultaP8 = (List<FilasDTOp8>) qr.query(sql, rsh, params);
        return consultaP8;
        }
        finally {
         ds.getConnection().close();
        }
    } 
    
    
     public List<FilasDTOp8> cargaFilasP8(int id_eoc) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      
     try {   
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_eoc, id_ue, TO_CHAR(fec_oc, 'dd/MM/yyyy') as fec_oc, nom_resp_ent, nom_recibe, fecha_llenado, \n" +
        "       fecha_actualizacion\n" +
        "  FROM \"seguim_CURT\".entrega_oc  WHERE id_eoc = ? ORDER BY id_eoc ";
        Object[] params = {id_eoc};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp8.class);
        List<FilasDTOp8> consultaFilasP8 = (List<FilasDTOp8>) qr.query(sql, rsh, params);
        return consultaFilasP8;
     } finally {
         ds.getConnection().close();
        }
    } 
        
        
    public List<FilasDTOp9> cargaEntSSg(int id_ue) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_essg, id_ue,  TO_CHAR(fecha, 'dd/MM/yyyy') as fecha, nom_resp_ent, nom_resp_rec, fecha_llenado, \n" +
"       fecha_actualizacion\n" +
"  FROM \"seguim_CURT\".entrega_ssg WHERE id_ue = ? ORDER BY id_essg ";
        Object[] params = {id_ue};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp9.class);
        List<FilasDTOp9> consultaP9 = (List<FilasDTOp9>) qr.query(sql, rsh, params);
        return consultaP9;
        }
        finally {
         ds.getConnection().close();
        }
    } 
    
    public List<FilasDTOp12> cargaDatEnt(int id_dae) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_dae, id_ue, TO_CHAR(fecha_entrega, 'dd/MM/yyyy') as  fecha_entrega, nom_resp_ent, nom_resp_rec, id_entrega, \n" +
"       nom_arch, cant_reg, TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado, TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as fecha_actualizacion, tipo_entrega\n" +
"  FROM \"seguim_CURT\".datos_entrega_p12 WHERE id_dae = ? ORDER BY fecha_actualizacion";
        Object[] params = {id_dae};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp12.class);
        List<FilasDTOp12> consultaP12 = (List<FilasDTOp12>) qr.query(sql, rsh, params);
        return consultaP12;
        }
        finally {
         ds.getConnection().close();
        }
    } 
    
    
    public List<FilasDTOp12> cargaFilasP12(int id_ue) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_dae, id_ue, TO_CHAR(fecha_entrega, 'dd/MM/yyyy') as  fecha_entrega, nom_resp_ent, nom_resp_rec, id_entrega, \n" +
"       nom_arch, cant_reg, TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado, TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as fecha_actualizacion, tipo_entrega\n" +
"  FROM \"seguim_CURT\".datos_entrega_p12 WHERE id_ue = ? ORDER BY id_dae";
        Object[] params = {id_ue};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp12.class);
        List<FilasDTOp12> consultaFilasP12 = (List<FilasDTOp12>) qr.query(sql, rsh, params);
        return consultaFilasP12;
        }
        finally {
         ds.getConnection().close();
        }
    } 
    
    
    
    
    
    
    
    public List<FilasDTOp13> cargaConst(int id_ue) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_cons, id_ue,  TO_CHAR(fec_sol, 'dd/MM/yyyy') as fec_sol, TO_CHAR(fec_emi, 'dd/MM/yyyy') as fec_emi, folio_cons, fecha_llenado, \n" +
"       fecha_actualizacion\n" +
"  FROM \"seguim_CURT\".constancia WHERE id_ue = ? ORDER BY id_cons";
        Object[] params = {id_ue};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp13.class);
        List<FilasDTOp13> consultaP13 = (List<FilasDTOp13>) qr.query(sql, rsh, params);
        return consultaP13;
        }
        finally {
         ds.getConnection().close();
        }
    } 
    
     public List<FilasDTOp10> cargaGenCurt(int id_ue) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_gen, id_ue, nom_resp, TO_CHAR(fech_ini, 'dd/MM/yyyy') as fech_ini,  TO_CHAR(fech_fin, 'dd/MM/yyyy') as fech_fin, pred_concurt, pred_sincurt, \n" +
"       TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado,  TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as fecha_actualizacion, total_motgen, mot_gen, id_entrega, \n" +
"       nom_archivo\n" +
"  FROM \"seguim_CURT\".generacion_curt WHERE id_ue = ? ORDER BY fecha_actualizacion";
        Object[] params = {id_ue};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp10.class);
        List<FilasDTOp10> consultaP10 = (List<FilasDTOp10>) qr.query(sql, rsh, params);
        return consultaP10;
        }
        finally {
         ds.getConnection().close();
        }
    } 
     
     
     
     public List<FilasDTOp10> cargaDatosGen(int id_gen) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_gen, id_ue, nom_resp, TO_CHAR(fech_ini, 'dd/MM/yyyy') as fech_ini,  TO_CHAR(fech_fin, 'dd/MM/yyyy') as fech_fin, pred_concurt, pred_sincurt, \n" +
"       TO_CHAR(fecha_llenado, 'dd/MM/yyyy') as fecha_llenado,  TO_CHAR(fecha_actualizacion, 'dd/MM/yyyy') as fecha_actualizacion, total_motgen, mot_gen, id_entrega, \n" +
"       nom_archivo\n" +
"  FROM \"seguim_CURT\".generacion_curt WHERE id_gen = ? ORDER BY id_gen";
        Object[] params = {id_gen};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp10.class);
        List<FilasDTOp10> consultaP101 = (List<FilasDTOp10>) qr.query(sql, rsh, params);
        return consultaP101;
        }
        finally {
         ds.getConnection().close();
        }
    } 
     
     
      public List<FilasDTOp11> cargaActuaCurt(int id_ue) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_act, id_ue, nom_resp_ue, TO_CHAR(fech_ini_a, 'dd/MM/yyyy HH24:MI:SS')  as fech_ini_a, TO_CHAR(fech_fin_a, 'dd/MM/yyyy') as fech_fin_a, pred_concurt_a, \n" +
"       pred_sincurt_a, fecha_llenado, fecha_actualizacion, total_motgen, \n" +
"       mot_gen, id_entrega, nom_archivo\n" +
"  FROM \"seguim_CURT\".actualizacion_curt WHERE id_ue = ? ORDER BY id_act";
        Object[] params = {id_ue};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp11.class);
        List<FilasDTOp11> consultaP11 = (List<FilasDTOp11>) qr.query(sql, rsh, params);
        return consultaP11;
        }
        finally {
         ds.getConnection().close();
        }
    } 

      
      
         public List<FilasDTOp11> cargaDatosActu(int id_act) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_act, id_ue, nom_resp_ue, TO_CHAR(fech_ini_a, 'dd/MM/yyyy HH24:MI:SS')  as fech_ini_a, TO_CHAR(fech_fin_a, 'dd/MM/yyyy') as fech_fin_a, pred_concurt_a, \n" +
"       pred_sincurt_a, fecha_llenado, fecha_actualizacion, total_motgen, \n" +
"       mot_gen, id_entrega, nom_archivo\n" +
"  FROM \"seguim_CURT\".actualizacion_curt WHERE id_act = ? ORDER BY id_act";
        Object[] params = {id_act};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOp11.class);
        List<FilasDTOp11> consultaP112 = (List<FilasDTOp11>) qr.query(sql, rsh, params);
        return consultaP112;
        }
        finally {
         ds.getConnection().close();
        }
    } 

         
    public List<FilasDTOlibcap> cargaLiberaCap(int id_ue) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT id_libcap, fecha_llenado, id_ue, libera_solicitud, fecha_solicitud, \n" +
    "       mes_liberado\n" +
    "  FROM \"seguim_CURT\".libera_capacitacion  WHERE id_ue = ? ORDER BY id_libcap DESC"; //para que tome el ultimo registro
        Object[] params = {id_ue};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOlibcap.class);
        List<FilasDTOlibcap> consultaLibCap = (List<FilasDTOlibcap>) qr.query(sql, rsh, params);
        return consultaLibCap;
        }
        finally {
         ds.getConnection().close();
        }
    }    
     
    
    
    
             
    public List<FilasDTOSolSop> cargaSoliSop(String estatus) throws SQLException {
      //  DataSource ds = AdministradorDataSource.getDataSource();
      try{
        QueryRunner qr = new QueryRunner(ds);
        String sql = "SELECT Count(*) as total  FROM \"seguim_CURT\".solicitud_soporte \n" +
"       WHERE estatus = ?"; 
        Object[] params = {estatus};        
        ResultSetHandler rsh = new BeanListHandler(FilasDTOSolSop.class);
        List<FilasDTOSolSop> consultaSoliSop = (List<FilasDTOSolSop>) qr.query(sql, rsh, params);
        return consultaSoliSop;
        }
        finally {
         ds.getConnection().close();
        }
    }    
     
      
       
       
       
   
   
}
