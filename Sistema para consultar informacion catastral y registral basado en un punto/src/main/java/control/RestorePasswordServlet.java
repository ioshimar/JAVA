/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import java.io.IOException;
import java.security.MessageDigest;
import java.sql.*;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


public class RestorePasswordServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:postgresql://10.153.3.25:5434/db_seguimientos";
    private static final String DB_USER = "us_seguimientos";
    private static final String DB_PASSWORD = "normAcAt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String token = request.getParameter("token");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");

        if (token == null || token.isEmpty() || password == null || confirm == null
            || password.length() < 8 || !password.equals(confirm)) {
            request.setAttribute("error", "Verifica que ambas contraseñas coincidan y tengan al menos 8 caracteres.");
            request.getRequestDispatcher("restore_password.jsp?token=" + token).forward(request, response);
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Busca el token y que NO esté vencido ni usado
            String sql = "SELECT user_id, expires_at, used FROM consulta_curt.password_reset_tokens WHERE token = ?";
            int userId = -1;
            boolean used = true;
            Timestamp expiresAt = null;
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, token);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        userId = rs.getInt("user_id");
                        expiresAt = rs.getTimestamp("expires_at");
                        used = rs.getBoolean("used");
                    }
                }
            }
            if (userId == -1 || used || expiresAt == null || expiresAt.toLocalDateTime().isBefore(LocalDateTime.now())) {
                request.setAttribute("error", "El enlace ya expiró o no es válido.");
                request.getRequestDispatcher("restore_password.jsp?token=" + token).forward(request, response);
                return;
            }

            // Actualiza la contraseña (asegúrate de usar el mismo hash que en registro)
            String hash = hashPassword(password);
            String updateUser = "UPDATE consulta_curt.client SET password_hash = ? WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(updateUser)) {
                ps.setString(1, hash);
                ps.setInt(2, userId);
                ps.executeUpdate();
            }

            // Marca el token como usado
            try (PreparedStatement ps = conn.prepareStatement(
                "UPDATE password_reset_tokens SET used = TRUE WHERE token = ?")) {
                ps.setString(1, token);
                ps.executeUpdate();
            }

            // Mensaje de éxito
            request.setAttribute("success", "Tu contraseña fue restablecida correctamente. Ahora puedes iniciar sesión.");
            request.getRequestDispatcher("restore_password.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Ocurrió un error inesperado. Intenta de nuevo.");
            request.getRequestDispatcher("restore_password.jsp?token=" + token).forward(request, response);
        }
    }

    // El mismo método hash que usas en registro/login
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("No se pudo hashear la contraseña", e);
        }
    }
}