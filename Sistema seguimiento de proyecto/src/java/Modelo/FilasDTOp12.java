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
public class FilasDTOp12 {
 
  private int id_dae;
  private int id_ue;
  private int id_entrega;
  private String fecha_entrega;
  private String nom_resp_ent;
  private String nom_resp_rec;
  private String nom_arch;
  private String cant_reg;
 /* private String fec_ue;
  private String nom_resp_drent;
  private String nom_resp_uerec;       
  private String arch_ue;
  private String cant_ue; */       
  private String fecha_llenado;        
  private String fecha_actualizacion;      
  private String tipo_entrega;
  
 public int getid_dae() {
        return id_dae;
    }

    /**
     * @param id_dae the Id_entrega to set
     */
    public void setid_dae(int id_dae) {
        this.id_dae = id_dae;
    }  
    
      /*return id_ue*/
    
    public int getid_ue() {
        return id_ue;
    }
     
    public void setid_ue(int id_ue) {
        this.id_ue = id_ue;
    }
    
    
     /*return id_entrega*/
    
    public int getid_entrega() {
        return id_entrega;
    }
     
    public void setid_entrega(int id_entrega) {
        this.id_entrega = id_entrega;
    }
    
    /*fecha_entrega*/
    public String getfecha_entrega(){
         return fecha_entrega;
    }
    
    public void setfecha_entrega(String fecha_entrega){
        this.fecha_entrega = fecha_entrega;
    }
    
     /*nom_resp_ent*/
    public String getnom_resp_ent(){
         return nom_resp_ent;
    }
    
    public void setnom_resp_ent(String nom_resp_ent){
        this.nom_resp_ent = nom_resp_ent;
    }
    
    /*nom_resp_rec*/
     public String getnom_resp_rec(){
         return nom_resp_rec;
    }
    
    public void setnom_resp_rec(String nom_resp_rec){
        this.nom_resp_rec = nom_resp_rec;
    }
    
    
    
    /*nom_arch*/
    public String getnom_arch(){
        return nom_arch;
    }
    
    public void setnom_arch(String nom_arch){
        this.nom_arch = nom_arch;
    }
    
    /*cant_reg*/
    
    public String getcant_reg(){
        return cant_reg;
    }
    
    public void setcant_reg(String cant_reg){
        this.cant_reg= cant_reg;
    }
    
     /*cant_reg*/
  /*  
    public String getfec_ue(){
        return fec_ue;
    }
    
    public void setfec_ue(String fec_ue){
        this.fec_ue= fec_ue;
    }
    */
    /*cant_reg*/
    
 /*   public String getnom_resp_drent(){
        return nom_resp_drent;
    }
    
    public void setnom_resp_drent(String nom_resp_drent){
        this.nom_resp_drent= nom_resp_drent;
    }
    
    */
     /*cant_reg*/
   /* 
    public String getnom_resp_uerec(){
        return nom_resp_uerec;
    }
    
    public void setnom_resp_uerec(String nom_resp_uerec){
        this.nom_resp_uerec= nom_resp_uerec;
    }
    
    */
     /*cant_reg*/
    
  /*  public String getarch_ue(){
        return arch_ue;
    }
    
    public void setarch_ue(String arch_ue){
        this.arch_ue= arch_ue;
    }
    */
     
     /*cant_ue*/
 /*   
    public String getcant_ue(){
        return cant_ue;
    }
    
    public void setcant_ue(String cant_ue){
        this.cant_ue= cant_ue;
    }
    */
    
    /*tipo_entrega*/
     public String gettipo_entrega(){
        return tipo_entrega;
    }
    
    public void settipo_entrega(String tipo_entrega){
        this.tipo_entrega= tipo_entrega;
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
