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
public class FilasDTOlibcap {
    private int id_libcap;
    private int id_ue;
    private String fecha_llenado;
    private boolean libera_solicitud;
    private String fecha_solicitud;
    private String mes_liberado;

    
    
    /*id_libcap*/
    public int getid_libcap() {
        return id_libcap;
    }

    public void setid_libcap(int id_libcap) {
        this.id_libcap = id_libcap;
    }
    

    
     /*return id_ue*/
    
    public int getid_ue() {
        return id_ue;
    }
     
    public void setid_ue(int id_ue) {
        this.id_ue = id_ue;
    }
    
     /*nom_resp*/
    public String getfecha_solicitud(){
         return fecha_solicitud;
    } 
    
    public void setfecha_solicitud(String fecha_solicitud){
        this.fecha_solicitud = fecha_solicitud;
    }
    
    
         /*nom_resp*/
    public String getmes_liberado(){
         return mes_liberado;
    } 
    
    public void setmes_liberado (String mes_liberado){
        this.mes_liberado = mes_liberado;
    }
    
    
        /*libera_solicitud*/
    public boolean getlibera_solicitud(){
         return libera_solicitud;
    } 
    
    public void setlibera_solicitud(boolean libera_solicitud){
        this.libera_solicitud = libera_solicitud;
    }
    
    
   
    
    
    
    
    /*fecha_llenado*/
    public String getfecha_llenado(){
         return fecha_llenado;
    } 
    
    public void setfecha_llenado(String fecha_llenado){
        this.fecha_llenado = fecha_llenado;
    }
    
  
    
    
    
    
    public void executeUpdate() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
