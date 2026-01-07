/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BaseDatos;
import java.sql.*;
/**
 *
 * @author IOSHIMAR.RODRIGUEZ
 */
public class ConexionBDB {
    
          // informacion para acceder a la base de datos
    String bd ="db_seguimientos"; // nombre de la base de datos 
    String login = "us_seguimientos";  // usuario con permisos para acceder a la base de datos
    String password = "normAcAt";  // contraseña del usuario para la BD
    String url = "jdbc:postgresql://10.153.3.25:5434/"+bd;  
    // variables para el manejo de la BD
    public Statement stmt = null;
    public ResultSet rs= null;
    public Connection conn;

    public ConexionBDB(){ // hacemos la conexion con la BD
        try { 
       
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(url,login,password);
            if (conn != null) 
            { System.out.println("Conexión a base de datos "+url+" ... Ok"); //conn.close(); 
            } 
        } catch(SQLException ex) { 
            System.out.println("Hubo un problema al intentar conectarse con la base de datos "+url);
        } catch(ClassNotFoundException ex) { System.out.println(ex); } 
    }
    
    public void Consult(String query){
        //information_schema
        try {
            stmt = conn.createStatement();// para hacer consultas se crea un objeto Statement
            rs = stmt.executeQuery(query); // ResultSet, podemos guardar los resultados de una consulta
            if (stmt.execute(query)) {// Condicion para checar que en realidad se trajo informacion
                rs = stmt.getResultSet();// trae todos los resultados
                rs.first();// Se coloca sobre el primer registro de la base de datos
            }
        }
        catch (SQLException ex){
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("Error: " + ex.getErrorCode());
        }
    }
    
    public int Update(String query){
        //information_schema
        int rModif=0;
        try {
            stmt = conn.createStatement();
            rModif= stmt.executeUpdate(query);
        }
        catch (SQLException ex){
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("Error: " + ex.getErrorCode());
        }
        return rModif;
    }


    public void closeRsStmt(){
        if (rs != null) {// cierra rs
            try {
                rs.close();
            } catch (SQLException sqlEx) { } // ignore
            rs = null;
        }
        if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException sqlEx) { } // ignore
                stmt = null;
         }
        closeConnection(); 
        // al al de connection ya no se le aplica nada
    }
    
    public void closeConnection() {
        try {
            if (conn!=null) 
                conn.close();
        } catch (SQLException sqlEx) { } // ignore
        rs = null;
    }
    
}
