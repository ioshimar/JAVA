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
public class FilasDTOp11 {
    

       
    private int id_act;
    private int id_ue;
    private String nom_resp_ue;
    private String fech_ini_a;
    private String fech_fin_a;
    private String pred_concurt_a;
    private String pred_sincurt_a;
    private String fecha_llenado;
    private String fecha_actualizacion;
    private String total_motgen;
    private String mot_gen;
    private String nom_archivo;
    private int id_entrega;
    
      
      public int getid_act() {
        return id_act;
    }

    /**
     * @param id_act the Id_entrega to set
     */
    public void setid_act(int id_act) {
        this.id_act = id_act;
    }
    
    /*return id_entrega*/
    
    public int getid_entrega() {
        return id_entrega;
    }
     
    public void setid_entrega(int id_entrega) {
        this.id_entrega = id_entrega;
    }
    
    
     /*return id_ue*/
    
    public int getid_ue() {
        return id_ue;
    }
     
    public void setid_ue(int id_ue) {
        this.id_ue = id_ue;
    }
    
     /*nom_resp*/
    public String getnom_resp_ue(){
         return nom_resp_ue;
    } 
    
    public void setnom_resp_ue(String nom_resp_ue){
        this.nom_resp_ue = nom_resp_ue;
    }
    
    
         /*fech_ini_a*/
    public String getfech_ini_a(){
         return fech_ini_a;
    } 
    
    public void setfech_ini_a (String fech_ini_a){
        this.fech_ini_a = fech_ini_a;
    }
    
    
        /*fech_fin_a*/
    public String getfech_fin_a(){
         return fech_fin_a;
    } 
    
    public void setfech_fin_a(String fech_fin_a){
        this.fech_fin_a = fech_fin_a;
    }
    
    
     /*pred_concurt_a*/
    public String getpred_concurt_a(){
         return pred_concurt_a;
    } 
    
    public void setpred_concurt_a(String pred_concurt_a){
        this.pred_concurt_a = pred_concurt_a;
    }
    
    
       /*pred_sincurt_a*/
    public String getpred_sincurt_a(){
         return pred_sincurt_a;
    } 
    
    public void setpred_sincurt_a(String pred_sincurt_a){
        this.pred_sincurt_a = pred_sincurt_a;
    }
    
    
    
       /*total_motgen*/
    public String gettotal_motgen(){
         return total_motgen;
    } 
    
    public void settotal_motgen(String total_motgen){
        this.total_motgen = total_motgen;
    }
    
    
        /*mot_gen*/
    public String getmot_gen(){
         return mot_gen;
    } 
    
    public void setmot_gen(String mot_gen){
        this.mot_gen = mot_gen;
    }
    
    
        /*nom_archivo*/
    public String getnom_archivo(){
         return nom_archivo;
    } 
    
    public void setnom_archivo(String nom_archivo){
        this.nom_archivo = nom_archivo;
    }
    
    
    
    
    
    
    /*fecha_llenado*/
    public String getfecha_llenado(){
         return fecha_llenado;
    } 
    
    public void setfecha_llenado(String fecha_llenado){
        this.fecha_llenado = fecha_llenado;
    }
    
    /*fecha_actualizacion*/
    public String getfecha_actualizacion(){
         return fecha_actualizacion;
    } 
    
    public void setfecha_actualizacion(String fecha_actualizacion){
        this.fecha_actualizacion = fecha_actualizacion;
    }
    
    
    public void executeUpdate() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    
}
