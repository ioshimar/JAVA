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

/**
 *
 * @author IOSHIMAR.RODRIGUEZ
 */
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id, full_name, role_id, password, first_time_login "
                       + "FROM seguimiento_actividades.users "
                       + "WHERE institutional_email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("password");
                boolean match = BCryptUtil.checkPassword(password, hashedPassword);

                if (match) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", rs.getInt("id"));
                    session.setAttribute("userName", rs.getString("full_name"));
                    session.setAttribute("roleId", rs.getInt("role_id"));
                    boolean firstTime = rs.getBoolean("first_time_login");

                    if (firstTime) {
                        // Redirigir a página para que el usuario cambie su contraseña
                        response.sendRedirect("resetPassword.jsp?firstTime=true");
                    } else {
                        response.sendRedirect("dashboard.jsp");
                    }
                } else {
                    request.setAttribute("error", "Contraseña incorrecta");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Correo no registrado");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error de base de datos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
