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
public class FilasDTOp9 {
    
    private int id_essg;
    private int id_ue;
    private String fecha;
    private String nom_resp_ent;
    private String nom_resp_rec;
    
    private String fecha_llenado;
    private String fecha_actualizacion;
    
    
      public int getid_essg() {
        return id_essg;
    }

    /**
     * @param id_essg the Id_entrega to set
     */
    public void setid_essg(int id_essg) {
        this.id_essg = id_essg;
    }
    
    /*return id_ue*/
    
    public int getid_ue() {
        return id_ue;
    }
     
    public void setid_ue(int id_ue) {
        this.id_ue = id_ue;
    }
    
    
     /*return fecha*/
    
    public String getfecha() {
        return fecha;
    }
     
    public void setfecha(String fecha) {
        this.fecha = fecha;
    }
    
    
     /*return nom_resp_ent*/
    
    public String getnom_resp_ent() {
        return nom_resp_ent;
    }
     
    public void setnom_resp_ent(String nom_resp_ent) {
        this.nom_resp_ent = nom_resp_ent;
    }
    
    
      /*return nom_resp_ent*/
    
    public String getnom_resp_rec() {
        return nom_resp_rec;
    }
     
    public void setnom_resp_rec(String nom_resp_rec) {
        this.nom_resp_rec = nom_resp_rec;
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
