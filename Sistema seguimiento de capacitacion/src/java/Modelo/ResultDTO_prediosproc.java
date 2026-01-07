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
public class ResultDTO_prediosproc {
    private int id_solicitud;
    private String TotalconCurt;
    private String TotalSinCurt;
    
   
    public int getid_solicitud() {
        return id_solicitud;
    }

    public void setid_solicitud(int id_solicitud) {
        this.id_solicitud = id_solicitud;
    }
    
    
     /*return TotalconCurt*/
    public String getTotalconCurt() {
        return TotalconCurt;
    }
     
    public void setTotalconCurt(String TotalconCurt) {
        this.TotalconCurt = TotalconCurt;
    }
    
    
     /*return TotalSinCurt*/
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
