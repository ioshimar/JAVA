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
public class FilasDTOp8 {
    
    
    private int id_eoc;
    private int id_ue;
    private String fec_oc;
    private String nom_resp_ent;
    private String nom_recibe;
    
    private String fecha_llenado;
    private String fecha_actualizacion;
    
    
      public int getid_eoc() {
        return id_eoc;
    }

    /**
     * @param id_eoc the Id_entrega to set
     */
    public void setid_eoc(int id_eoc) {
        this.id_eoc = id_eoc;
    }
    
    /*return id_ue*/
    
    public int getid_ue() {
        return id_ue;
    }
     
    public void setid_ue(int id_ue) {
        this.id_ue = id_ue;
    }
    
    
     /*fec_oc*/
    public String getfec_oc(){
         return fec_oc;
    } 
    
    public void setfec_oc(String fec_oc){
        this.fec_oc = fec_oc;
    }
    
    
      /*nom_resp_ent*/
    public String getnom_resp_ent(){
         return nom_resp_ent;
    } 
    
    public void setnom_resp_ent(String nom_resp_ent){
        this.nom_resp_ent = nom_resp_ent;
    }
    
    
     /*nom_recibe*/
    public String getnom_recibe(){
         return nom_recibe;
    } 
    
    public void setnom_recibe(String nom_recibe){
        this.nom_recibe = nom_recibe;
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
