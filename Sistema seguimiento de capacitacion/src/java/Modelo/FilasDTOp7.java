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
public class FilasDTOp7 {
    
    private int id_dev;
    private int id_ue;
    private String nom_ent;
    private String fecha_dev;
    private String nom_resp_dev;
    private String nom_rec_dev;
    private String arch_dev;
    private String total_regdev;
    private String motivos_dev;
    private String nom_archivo ;
    private int id_entrega;
    
    
    private String fecha_llenado;
    private String fecha_actualizacion;
    
    
      public int getid_dev() {
        return id_dev;
    }

    /**
     * @param id_dev the Id_entrega to set
     */
    public void setid_dev(int id_dev) {
        this.id_dev = id_dev;
    }
    
    /*return id_ue*/
    
    public int getid_ue() {
        return id_ue;
    }
     
    public void setid_ue(int id_ue) {
        this.id_ue = id_ue;
    }
    
    //id_entrega
       public int getid_entrega() {
        return id_entrega;
    }

    public void setid_entrega(int id_entrega) {
        this.id_entrega = id_entrega;
    }
    
    /*return nom_ent*/
      
    public String getnom_ent(){
        return nom_ent;
    }  
    
    public void setnom_ent(String nom_ent){
        this.nom_ent = nom_ent;
    }
    
    
    /*return nom_ent*/
      
    public String getfecha_dev(){
        return fecha_dev;
    }  
    
    public void setfecha_dev(String fecha_dev){
        this.fecha_dev = fecha_dev;
    }
    
    
    /*return nom_resp_dev*/
      
    public String getnom_resp_dev(){
        return nom_resp_dev;
    }  
    
    public void setnom_resp_dev(String nom_resp_dev){
        this.nom_resp_dev = nom_resp_dev;
    }
    
    
       /*return nom_rec_dev*/
      
    public String getnom_rec_dev(){
        return nom_rec_dev;
    }  
    
    public void setnom_rec_dev(String nom_rec_dev){
        this.nom_rec_dev = nom_rec_dev;
    }
    
    
      /*return nom_rec_dev*/
      
    public String getarch_dev(){
        return arch_dev;
    }  
    
    public void setarch_dev(String arch_dev){
        this.arch_dev = arch_dev;
    }
    
    
     /*return total_regdev*/
      
    public String gettotal_regdev(){
        return total_regdev;
    }  
    
    public void settotal_regdev(String total_regdev){
        this.total_regdev = total_regdev;
    }
    
    
            
   /*return motivos_dev*/
      
    public String getmotivos_dev(){
        return motivos_dev;
    }  
    
    public void setmotivos_dev(String motivos_dev){
        this.motivos_dev = motivos_dev;
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
    
    
    //nom_archivo
     public String getnom_archivo(){
         return nom_archivo;
    } 
    
    public void setnom_archivo(String nom_archivo){
        this.nom_archivo = nom_archivo;
    }
    
    
     public void executeUpdate() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    
}
