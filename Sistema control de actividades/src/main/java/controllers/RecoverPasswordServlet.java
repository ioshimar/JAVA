package controllers;

import utils.DBConnection;
import utils.EmailUtil;
import java.io.IOException;
import java.sql.*;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.*;

/**
 * Servlet para recuperar contraseña y enviar enlace por correo
 * @author IOSHIMAR.RODRIGUEZ
 */
public class RecoverPasswordServlet extends HttpServlet {
    private static final String SERVER_IP = "10.107.12.36"; // IP fija del servidor

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String email = request.getParameter("email");

        try (Connection conn = DBConnection.getConnection()) {
            String sqlUser = "SELECT id FROM seguimiento_actividades.users WHERE institutional_email = ?";
            PreparedStatement psUser = conn.prepareStatement(sqlUser);
            psUser.setString(1, email);
            ResultSet rsUser = psUser.executeQuery();

            if (rsUser.next()) {
                int userId = rsUser.getInt("id");
                String token = UUID.randomUUID().toString();

                // Insertar token con expiración de 1 hora
                String sqlToken = "INSERT INTO seguimiento_actividades.password_reset_tokens (user_id, token, expiry_date) "
                                + "VALUES (?, ?, now() + interval '1 hour')";
                PreparedStatement psToken = conn.prepareStatement(sqlToken);
                psToken.setInt(1, userId);
                psToken.setString(2, token);
                psToken.executeUpdate();

                // Construcción del enlace con la IP fija
                String resetLink = request.getScheme() + "://" + 
                                   SERVER_IP + ":" + 
                                   request.getServerPort() + 
                                   request.getContextPath() + 
                                   "/resetPassword.jsp?token=" + token;

                // Enviar correo con el enlace corregido
                String subject = "Recuperación de Contraseña - Seguimiento de Actividades";
                String text = "Haz clic en el siguiente enlace para restablecer tu contraseña:<br><a href='" + resetLink + "'>Restablecer Contraseña</a>";
                EmailUtil.sendEmail(email, subject, text);

                request.setAttribute("message", "Se envió un enlace a tu correo, revisa tú bandeja de entrada.");
            } else {
                request.setAttribute("error", "No existe un usuario con ese correo.");
            }
            rsUser.close();
            request.getRequestDispatcher("recoverPassword.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error de base de datos.");
            request.getRequestDispatcher("recoverPassword.jsp").forward(request, response);
        }
    }
}
