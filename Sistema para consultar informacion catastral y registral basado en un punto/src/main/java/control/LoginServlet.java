/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Servlet para login de usuarios.
 */

public class LoginServlet extends HttpServlet {
    private static final String DB_URL      = "jdbc:postgresql://10.153.3.25:5434/db_seguimientos";
    private static final String DB_USER     = "us_seguimientos";
    private static final String DB_PASSWORD = "normAcAt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String correo    = request.getParameter("correo");
        String password  = request.getParameter("password");

        // Validación básica
        if (correo == null || password == null || correo.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Hashea la contraseña para comparar con la base de datos
        String passwordHash = hashPassword(password);

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("No se pudo cargar el driver de PostgreSQL", e);
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT id, nombre_completo, unidad_estado FROM consulta_curt.client WHERE correo = ? AND password_hash = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, correo.trim());
                stmt.setString(2, passwordHash);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // Usuario autenticado correctamente
                        HttpSession session = request.getSession(true);
                        session.setAttribute("user_id", rs.getInt("id"));
                        session.setAttribute("nombre_completo", rs.getString("nombre_completo"));
                        session.setAttribute("unidad_estado", rs.getString("unidad_estado"));

                        // Mensaje de bienvenida (opcional)
                        session.setAttribute("bienvenida", "¡Bienvenido " + rs.getString("nombre_completo") + "!");

                        // Redirigir a la página principal (cámbiala según tu flujo)
                        response.sendRedirect("index.jsp");
                        return;
                    } else {
                        // Usuario o contraseña incorrectos
                        request.setAttribute("error", "Correo o contraseña incorrectos.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                        return;
                    }
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Error de base de datos: " + ex.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // Utilidad para hashear contraseñas (SHA-256)
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (NoSuchAlgorithmException | java.io.UnsupportedEncodingException e) {
            throw new RuntimeException("No se pudo hashear la contraseña", e);
        }
    }
}