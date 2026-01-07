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
public class FilasDTOp6 {
    private int id_val;
    private int id_ue;
    private String nom_respval;
    private String fec_ini;
    private String fec_fin;
    private String for_shape;
    private String ext_min;
    private String est_cor;
    private String atrib;
    private String info_cord;
    private String code_total;
    private String fecha_llenado;
    private String fecha_actualizacion;
    private int id_entrega;
    private String nom_archivo;
    
    
     public int getid_val() {
        return id_val;
    }

    /**
     * @param id_val the Id_entrega to set
     */
    public void setid_val(int id_val) {
        this.id_val = id_val;
    }
    
    public int getid_entrega(){
        return id_entrega;
    }
    
    public void setid_entrega(int id_entrega){
        this.id_entrega = id_entrega;
    }
    
    /*return id_ue*/
    
    public int getid_ue() {
        return id_ue;
    }
     
    public void setid_ue(int id_ue) {
        this.id_ue = id_ue;
    }
    
    
    /*return nom_respval*/
      
    public String getnom_respval(){
        return nom_respval;
    }  
    
    public void setnom_respval(String nom_respval){
        this.nom_respval = nom_respval;
    }
    
    
    /*return fec_ini*/
      
    public String getfec_ini(){
        return fec_ini;
    }  
    
    public void setfec_ini(String fec_ini){
        this.fec_ini = fec_ini;
    }
    
    
     /*return fec_fin*/
      
    public String getfec_fin(){
        return fec_fin;
    }  
    
    public void setfec_fin(String fec_fin){
        this.fec_fin = fec_fin;
    }
    
    
      
     /*return for_shape*/
      
    public String getfor_shape(){
        return for_shape;
    }  
    
    public void setfor_shape(String for_shape){
        this.for_shape = for_shape;
    }
    
    
      
     /*return ext_min*/
      
    public String getext_min(){
        return ext_min;
    }  
    
    public void setext_min(String ext_min){
        this.ext_min = ext_min;
    }
    
    
    
    
            
             
     /*return est_cor*/
      
    public String getest_cor(){
        return est_cor;
    }  
    
    public void setest_cor(String est_cor){
        this.est_cor = est_cor;
    }
    
    
     /*return atrib*/
      
    public String getatrib(){
        return atrib;
    }  
    
    public void setatrib(String atrib){
        this.atrib = atrib;
    }
    
     /*return atrib*/
      
    public String info_cord(){
        return info_cord;
    }  
    
    public void setinfo_cord(String info_cord){
        this.info_cord = info_cord;
    }
    
    
    /*return code_total*/
      
    public String code_total(){
        return code_total;
    }  
    
    public void setcode_total(String code_total){
        this.code_total = code_total;
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
