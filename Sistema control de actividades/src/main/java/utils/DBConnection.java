/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author IOSHIMAR.RODRIGUEZ
 */

import java.sql.*;

public class DBConnection {
    private static final String URL = "jdbc:postgresql://10.153.3.25:5434/db_seguimientos";
    private static final String USER = "us_seguimientos";
    private static final String PASSWORD = "normAcAt";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // REGISTRAR EL DRIVER MANUALMENTE
            Class.forName("org.postgresql.Driver");

            // INTENTAR LA CONEXIÓN
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Conexión exitosa a PostgreSQL.");
        } catch (ClassNotFoundException e) {
            System.out.println("❌ ERROR: No se encontró el driver de PostgreSQL.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("❌ ERROR: No se pudo conectar a la base de datos.");
            e.printStackTrace();
        }
        return conn;
    }
}