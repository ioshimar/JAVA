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
public class FilasDTOp10 {
    
    private int id_gen;
    private int id_ue;
    private String nom_resp;
    private String fech_ini;
    private String fech_fin;
    private String pred_concurt;
    private String pred_sincurt;
    private String fecha_llenado;
    private String fecha_actualizacion;
    private String total_motgen;
    private String mot_gen;
    private String nom_archivo;
    private int id_entrega;
    private String MotivosB;
    
    
    
      public int getid_gen() {
        return id_gen;
    }

    /**
     * @param id_gen the Id_entrega to set
     */
    public void setid_gen(int id_gen) {
        this.id_gen = id_gen;
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
    public String getnom_resp(){
         return nom_resp;
    } 
    
    public void setnom_resp (String nom_resp){
        this.nom_resp = nom_resp;
    }
    
    
         /*nom_resp*/
    public String getfech_ini(){
         return fech_ini;
    } 
    
    public void setfech_ini (String fech_ini){
        this.fech_ini = fech_ini;
    }
    
    
        /*nom_resp*/
    public String getfech_fin(){
         return fech_fin;
    } 
    
    public void setfech_fin(String fech_fin){
        this.fech_fin = fech_fin;
    }
    
    
     /*pred_concurt*/
    public String getpred_concurt(){
         return pred_concurt;
    } 
    
    public void setpred_concurt(String pred_concurt){
        this.pred_concurt = pred_concurt;
    }
    
    
       /*pred_sincurt*/
    public String getpred_sincurt(){
         return pred_sincurt;
    } 
    
    public void setpred_sincurt(String pred_sincurt){
        this.pred_sincurt = pred_sincurt;
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
    
    
    /*MotivosB*/
    public String getMotivosB(){
         return MotivosB;
    } 
    
    public void setMotivosB(String MotivosB){
        this.MotivosB = MotivosB;
    }
    
    
    
    
    
    public void executeUpdate() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
