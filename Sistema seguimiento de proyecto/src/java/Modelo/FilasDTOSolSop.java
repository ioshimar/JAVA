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
public class FilasDTOSolSop {
     
    private int id_solic;
    private int id_ue;
    private String fecha_solicitud;
    private String nombre_solicitante;
    private String correo;
    private String tipo_solicitud;    
    private String estatus;
    private String total;
    
    
    
     /*return id_cap*/
    
    public int getid_solic() {
        return id_solic;
    }
     
    public void setid_solic(int id_solic) {
        this.id_solic = id_solic;
    }
    
     /*return id_ue*/
    
    public int getid_ue() {
        return id_ue;
    }
     
    public void setid_ue(int id_ue) {
        this.id_ue = id_ue;
    }
    
     /*return fecha_cap*/
      
    public String getfecha_solicitud(){
        return fecha_solicitud;
    }  
    
    public void setfecha_solicitud(String fecha_solicitud){
        this.fecha_solicitud = fecha_solicitud;
    }
    
    
    /*return lugar*/
      
    public String getnombre_solicitante(){
        return nombre_solicitante;
    }  
    
    public void setnombre_solicitante(String nombre_solicitante){
        this.nombre_solicitante = nombre_solicitante;
    }
    
    
     /*return resp_inegi*/
      
    public String getcorreo(){
        return correo;
    }  
    
    public void setcorreo(String correo){
        this.correo = correo;
    }
    
     /*return cant_pers*/
      
    public String gettipo_solicitud(){
        return tipo_solicitud;
    }  
    
    public void settipo_solicitud(String tipo_solicitud){
        this.tipo_solicitud = tipo_solicitud;
    }
    
     /*return fecha_llenado*/
      
    public String getestatus(){
        return estatus;
    }  
    
    public void setestatus(String estatus){
        this.estatus = estatus;
    }
    
      /*return fecha_llenado*/
      
    public String gettotal(){
        return total;
    }  
    
    public void settotal(String total){
        this.total = total;
    }
    
 public void executeUpdate() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    
}
