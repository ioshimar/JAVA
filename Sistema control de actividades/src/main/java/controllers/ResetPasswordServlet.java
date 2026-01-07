/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import utils.DBConnection;
import utils.BCryptUtil;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * Servlet para manejar el restablecimiento de contraseña.
 * @author IOSHIMAR.RODRIGUEZ
 */
public class ResetPasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");

        if (token == null || token.isEmpty() || newPassword == null || newPassword.isEmpty()) {
            request.setAttribute("error", "Token inválido o contraseña vacía.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sqlVerify = "SELECT user_id FROM seguimiento_actividades.password_reset_tokens " +
                               "WHERE token = ? AND expiry_date > now()";
            PreparedStatement psVerify = conn.prepareStatement(sqlVerify);
            psVerify.setString(1, token);
            ResultSet rsVerify = psVerify.executeQuery();

            if (rsVerify.next()) {
                int userId = rsVerify.getInt("user_id");

                // Encriptar nueva contraseña con BCrypt
                String hashedPassword = BCryptUtil.hashPassword(newPassword);

                // Actualizar la contraseña
                String sqlUpdate = "UPDATE seguimiento_actividades.users SET password = ? WHERE id = ?";
                PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate);
                psUpdate.setString(1, hashedPassword);
                psUpdate.setInt(2, userId);
                psUpdate.executeUpdate();

                // Eliminar el token usado
                String sqlDeleteToken = "DELETE FROM seguimiento_actividades.password_reset_tokens WHERE token = ?";
                PreparedStatement psDeleteToken = conn.prepareStatement(sqlDeleteToken);
                psDeleteToken.setString(1, token);
                psDeleteToken.executeUpdate();
                
                // Codificar mensaje correctamente
                String mensaje = "Contraseña cambiada con éxito. Inicia sesión.";
                String mensajeCodificado = URLEncoder.encode(mensaje, StandardCharsets.UTF_8.toString());


                // Redirigir con mensaje de éxito
                response.sendRedirect(request.getContextPath() + "/login.jsp?message=" + mensajeCodificado);

            } else {
                request.setAttribute("error", "El token es inválido o ha expirado.");
                request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error de base de datos.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        }
    }
}