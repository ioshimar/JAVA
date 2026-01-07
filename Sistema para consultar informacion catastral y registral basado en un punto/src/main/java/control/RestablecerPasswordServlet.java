/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class RestablecerPasswordServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:postgresql://10.153.3.25:5434/db_seguimientos";
    private static final String DB_USER = "us_seguimientos";
    private static final String DB_PASSWORD = "normAcAt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String pass1 = request.getParameter("password1");
        String pass2 = request.getParameter("password2");

        if (pass1 == null || pass2 == null || !pass1.equals(pass2) || pass1.length() < 6) {
            request.setAttribute("error", "Las contraseñas no coinciden o son demasiado cortas.");
            request.setAttribute("correo", correo);
            request.getRequestDispatcher("reset_password.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // Cambia la contraseña (aquí debes hashearla si usas hash)
                String update = "UPDATE consulta_curt.client SET password = ?, reset_token = NULL, reset_token_expira = NULL WHERE correo = ?";
                try (PreparedStatement ps = conn.prepareStatement(update)) {
                    ps.setString(1, pass1); // Hashea si tu sistema así lo usa
                    ps.setString(2, correo);
                    ps.executeUpdate();
                }
                request.setAttribute("success", "¡Contraseña restablecida exitosamente!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Error inesperado: " + ex.getMessage());
            request.setAttribute("correo", correo);
            request.getRequestDispatcher("reset_password.jsp").forward(request, response);
        }
    }
}