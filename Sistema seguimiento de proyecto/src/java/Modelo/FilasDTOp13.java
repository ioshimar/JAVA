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
public class FilasDTOp13 {
 
    private int id_cons;
    private int id_ue;
    private String fec_sol;
    private String fec_emi;
    private String folio_cons;   
    private String fecha_llenado;
    private String fecha_actualizacion;
    
    
    /*return id_cap*/
    
    public int getid_cons() {
        return id_cons;
    }
     
    public void setid_cons(int id_cons) {
        this.id_cons = id_cons;
    }
    
     /*return id_ue*/
    
    public int getid_ue() {
        return id_ue;
    }
     
    public void setid_ue(int id_ue) {
        this.id_ue = id_ue;
    }
    
    
     /*return fec_sol*/
      
    public String getfec_sol(){
        return fec_sol;
    }  
    
    public void setfec_sol(String fec_sol){
        this.fec_sol = fec_sol;
    }
    
    
     /*return fec_sol*/
      
    public String getfec_emi(){
        return fec_emi;
    }  
    
    public void setfec_emi(String fec_emi){
        this.fec_emi = fec_emi;
    }
    
    
     /*return folio_cons*/
      
    public String getfolio_cons(){
        return folio_cons;
    }  
    
    public void setfolio_cons(String folio_cons){
        this.folio_cons = folio_cons;
    }
    
    
         /*return fecha_llenado*/
      
    public String getfecha_llenado(){
        return fecha_llenado;
    }  
    
    public void setfecha_llenado(String fecha_llenado){
        this.fecha_llenado = fecha_llenado;
    }
    
      /*return fecha_llenado*/
      
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
