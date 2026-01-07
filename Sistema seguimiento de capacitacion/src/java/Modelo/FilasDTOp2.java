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
public class FilasDTOp2 {

    
    private int id_cap;
    private int id_ue;
    private String fecha_cap;
    private String lugar;
    private String resp_inegi;
    private String cant_pers;
    private String tipo_cap;       
    private String fecha_llenado;
    private String fecha_actualizacion;
    private String norma_cat;
    private String norma_curt;
    private String lineamiento;
    private String diccionario;
    
    
     /*return id_cap*/
    
    public int getid_cap() {
        return id_cap;
    }
     
    public void setid_cap(int id_cap) {
        this.id_cap = id_cap;
    }
    
     /*return id_ue*/
    
    public int getid_ue() {
        return id_ue;
    }
     
    public void setid_ue(int id_ue) {
        this.id_ue = id_ue;
    }
    
     /*return fecha_cap*/
      
    public String getfecha_cap(){
        return fecha_cap;
    }  
    
    public void setfecha_cap(String fecha_cap){
        this.fecha_cap = fecha_cap;
    }
    
    
    /*return lugar*/
      
    public String getlugar(){
        return lugar;
    }  
    
    public void setlugar(String lugar){
        this.lugar = lugar;
    }
    
    /*return tipo de capacitacion*/
      
    public String gettipo_cap(){
        return tipo_cap;
    }  
    
    public void settipo_cap(String tipo_cap){
        this.tipo_cap = tipo_cap;
    }
    
    
     /*return resp_inegi*/
      
    public String getresp_inegi(){
        return resp_inegi;
    }  
    
    public void setresp_inegi(String resp_inegi){
        this.resp_inegi = resp_inegi;
    }
    
     /*return cant_pers*/
      
    public String getcant_pers(){
        return cant_pers;
    }  
    
    public void setcant_pers(String cant_pers){
        this.cant_pers = cant_pers;
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

    public String getNorma_cat() {
        return norma_cat;
    }

    public void setNorma_cat(String norma_cat) {
        this.norma_cat = norma_cat;
    }

    public String getNorma_curt() {
        return norma_curt;
    }

    public void setNorma_curt(String norma_curt) {
        this.norma_curt = norma_curt;
    }

    public String getLineamiento() {
        return lineamiento;
    }

    public void setLineamiento(String lineamiento) {
        this.lineamiento = lineamiento;
    }

    public String getDiccionario() {
        return diccionario;
    }

    public void setDiccionario(String diccionario) {
        this.diccionario = diccionario;
    }
    
    
    
 public void executeUpdate() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    
}
