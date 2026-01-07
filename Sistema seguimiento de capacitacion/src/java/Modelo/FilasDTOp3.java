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
public class FilasDTOp3 {
    
  
            
    private int id_reg;
    private int id_ue;
    private String fec_sol_reg;
    private String fec_env_doc;
    private String fec_val_doc;
    private String fec_env_firm;    
    private String fec_regus;
    private String fec_rec_doc;
    private String fecha_llenado;
    private String fecha_actualizacion;
    
     /*return id_cap*/
    
    public int getid_reg() {
        return id_reg;
    }
     
    public void setid_reg(int id_reg) {
        this.id_reg = id_reg;
    }
    
     /*return id_ue*/
    
    public int getid_ue() {
        return id_ue;
    }
     
    public void setid_ue(int id_ue) {
        this.id_ue = id_ue;
    }
    
     
     /*return fec_sol_reg*/
      
    public String getfec_sol_reg(){
        return fec_sol_reg;
    }  
    
    public void setfec_sol_reg(String fec_sol_reg){
        this.fec_sol_reg = fec_sol_reg;
    }
    
      /*return fec_env_doc*/
      
    public String getfec_env_doc(){
        return fec_env_doc;
    }  
    
    public void setfec_env_doc(String fec_env_doc){
        this.fec_env_doc = fec_env_doc;
    }
    
     /*return fec_val_doc*/
      
    public String getfec_val_doc(){
        return fec_val_doc;
    }  
    
    public void setfec_val_doc(String fec_val_doc){
        this.fec_val_doc = fec_val_doc;
    }
    
    
      /*return fec_val_doc*/
      
    public String getfec_env_firm(){
        return fec_env_firm;
    }  
    
    public void setfec_env_firm(String fec_env_firm){
        this.fec_env_firm = fec_env_firm;
    }
    
       /*return fec_regus*/
      
    public String getfec_regus(){
        return fec_regus;
    }  
    
    public void setfec_regus(String fec_regus){
        this.fec_regus = fec_regus;
    }
    
        /*return fec_rec_doc*/
      
    public String getfec_rec_doc(){
        return fec_rec_doc;
    }  
    
    public void setfec_rec_doc(String fec_rec_doc){
        this.fec_rec_doc = fec_rec_doc;
    }
    
    
        /*return fecha_llenado*/
      
    public String getfecha_llenado(){
        return fecha_llenado;
    }  
    
    public void setfecha_llenado(String fecha_llenado){
        this.fecha_llenado = fecha_llenado;
    }
    
    
        /*return fecha_actualizacion*/
      
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
