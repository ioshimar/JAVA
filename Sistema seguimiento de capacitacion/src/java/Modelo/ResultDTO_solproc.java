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
public class ResultDTO_solproc {
    private int idue;
    private String fechasolicitud;
    private String fechaproceso;
    private String describe;
    private String idsolicitud;
    private String idresponsable;
    private String id_status; 
    private String estatus;
    private String tamano; 
    private String tamano_shp;
    private String Total;
    private String TotalConCurt;
    private String TotalSinCurt;
    
    
    
    public int getidue() {
        return idue;
    }

    public void setidue(int idue) {
        this.idue = idue;
    }
    
    
     /*return fechasolicitud*/
    public String getfechasolicitud() {
        return fechasolicitud;
    }
     
    public void setfechasolicitud(String fechasolicitud) {
        this.fechasolicitud = fechasolicitud;
    }
    
     /*return fechasolicitud*/
    public String getfechaproceso() {
        return fechaproceso;
    }
     
    public void setfechaproceso(String fechaproceso) {
        this.fechaproceso = fechaproceso;
    }
    
    
    /*describe*/
    
    public String getdescribe() {
        return describe;
    }
     
    public void setdescribe(String describe) {
        this.describe = describe;
    }
    
    /*tamano*/
    
    public String gettamano() {
        return tamano;
    }
     
    public void settamano(String tamano) {
        this.tamano = tamano;
    }
    
    /*Total*/
    
    public String getTotal() {
        return Total;
    }
     
    public void setTotal(String Total) {
        this.Total = Total;
    }
    
    /*TotalConCurt*/
    
    public String getTotalConCurt() {
        return TotalConCurt;
    }
     
    public void setTotalConCurt(String TotalConCurt) {
        this.TotalConCurt = TotalConCurt;
    }
    
    
     /*TotalSinCurt*/
    
    public String getTotalSinCurt() {
        return TotalSinCurt;
    }
     
    public void setTotalSinCurt(String TotalSinCurt) {
        this.TotalSinCurt = TotalSinCurt;
    }
    
    
    public void executeUpdate() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
