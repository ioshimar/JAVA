/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/**
 *
 * @author RICARDO.MACIAS
 */
public class FilasDTOp5 {
    private int id_entrega;
    private int id_ue;
    private String fecha;
    private String nom_resp_ent;
    private String unidad_admin;    
    private String nom_resp_rec;
    private String medio;
    private String nom_archivo;
    private String tamano;
    private String total_reg;
    private String fecha_llenado;
    private String fecha_actualizacion; 
    private int idsolicitud; 
    private String tipo_entrega;
    private int pred_con_curt; 
    private int pred_sin_curt;

    /**
     * @return the Folio
     */
    public int getid_entrega() {
        return id_entrega;
    }

    /**
     * @param id_entrega the Id_entrega to set
     */
    public void setid_entrega(int id_entrega) {
        this.id_entrega = id_entrega;
    }

    /**
     * @return the Id_entrega
     */
    public int getid_ue() {
        return id_ue;
    }

    /**
     * @param id_ue the Id_ue to set
     */
    public void setid_ue(int id_ue) {
        this.id_ue = id_ue;
    }

        /**
     * @return the Ent
     */
    public String getfecha() {
        return fecha;
    }

    /**
     * @param fecha the Fecha to set
     */
    public void setfecha(String fecha) {
        this.fecha = fecha;
    }

    /**
     * @return the Nom_capa
     */
    public String getnom_resp_ent() {
        return nom_resp_ent;
    }

    /**
     * @param nom_resp_ent the Nom_resp_ent to set
     */
    public void setnom_resp_ent(String nom_resp_ent) {
        this.nom_resp_ent = nom_resp_ent;
    }

    /**
     * @return the Num_ele     */
    public String getunidad_admin() {
        return unidad_admin;
    }

    /**
     * @param unidad_admin the Unidad_admin to set
     */
    public void setunidad_admin(String unidad_admin) {
        this.unidad_admin = unidad_admin;
    }

    /**
     * @return the Estatus_ca
     */
    public String getnom_resp_rec() {
        return nom_resp_rec;
    }

    /**
     * @param nom_resp_rec the Nom_resp_rec to set
     */
    public void setnom_resp_rec(String nom_resp_rec) {
        this.nom_resp_rec = nom_resp_rec;
    }
    
    
     /**
     * @return the Id
     */
    public String getmedio() {
        return medio;
    }

    /**
     * @param medio the Medio to set
     */
    public void setmedio(String medio) {
        this.medio = medio;
    }

    
    
     public String getnom_archivo() {
        return nom_archivo;
    }

    /**
     * @param nom_archivo the Nom_archivo to set
     */
    public void setnom_archivo(String nom_archivo) {
        this.nom_archivo = nom_archivo;
    }
    
    
     public String gettamano() {
        return tamano;
    }

    /**
     * @param tamano the Tamano to set
     */
    public void settamano(String tamano) {
        this.tamano = tamano;
    }
    
    
     public String gettotal_reg() {
        return total_reg;
    }

    /**
     * @param total_reg the Total_reg to set
     */
    public void settotal_reg(String total_reg) {
        this.total_reg = total_reg;
    }
    
    /*fecha_llenado*/
    public String getfecha_llenado() {
        return fecha_llenado;
    }

    
    public void setfecha_llenado(String fecha_llenado) {
        this.fecha_llenado = fecha_llenado;
    }
    
    
    /*fecha_actualizacion*/
    public String getfecha_actualizacion(){
         return fecha_actualizacion;
    } 
    
    public void setfecha_actualizacion(String fecha_actualizacion){
        this.fecha_actualizacion = fecha_actualizacion;
    }
    
    
    /*idsolicitud */
    public int getidsolicitud() {
        return idsolicitud;
    }

    public void setidsolicitud(int idsolicitud) {
        this.idsolicitud = idsolicitud;
    }
    
    
    /*tipo_entrega*/
    public String gettipo_entrega(){
         return tipo_entrega;
    } 
    
    public void settipo_entrega(String tipo_entrega){
        this.tipo_entrega = tipo_entrega;
    }
    
    /*pred_con_curt */
    public int getpred_con_curt() {
        return pred_con_curt;
    }

    public void setpred_con_curt(int pred_con_curt) {
        this.pred_con_curt = pred_con_curt;
    }
    
    /*pred_con_curt */
    public int getpred_sin_curt() {
        return pred_sin_curt;
    }

    public void setpred_sin_curt(int pred_sin_curt) {
        this.pred_sin_curt = pred_sin_curt;
    }
    
 
    
   

    public void executeUpdate() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    
}
