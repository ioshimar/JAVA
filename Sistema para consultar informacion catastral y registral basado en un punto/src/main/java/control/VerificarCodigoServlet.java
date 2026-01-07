/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class VerificarCodigoServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:postgresql://10.153.3.25:5434/db_seguimientos";
    private static final String DB_USER = "us_seguimientos";
    private static final String DB_PASSWORD = "normAcAt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String codigo = request.getParameter("codigo");

        try {
            Class.forName("org.postgresql.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT id, reset_token_expira FROM consulta_curt.client WHERE correo = ? AND reset_token = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, correo);
                    ps.setString(2, codigo);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            Timestamp expira = rs.getTimestamp("reset_token_expira");
                            if (expira == null || expira.toLocalDateTime().isBefore(LocalDateTime.now())) {
                                request.setAttribute("error", "El código ya expiró. Solicita uno nuevo.");
                                request.setAttribute("correo", correo);
                                request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
                                return;
                            }
                            // Código válido, pasa a cambiar contraseña
                            request.setAttribute("correo", correo);
                            request.getRequestDispatcher("reset_password.jsp").forward(request, response);
                            return;
                        } else {
                            request.setAttribute("error", "El código es incorrecto.");
                            request.setAttribute("correo", correo);
                            request.getRequestDispatcher("verify_code.jsp").forward(request, response);
                        }
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Error inesperado: " + ex.getMessage());
            request.setAttribute("correo", correo);
            request.getRequestDispatcher("verify_code.jsp").forward(request, response);
        }
    }
}
