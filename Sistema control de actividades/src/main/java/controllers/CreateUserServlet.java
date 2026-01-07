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
public class CreateUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String fullName = request.getParameter("full_name");
        String email = request.getParameter("institutional_email");
        String functions = request.getParameter("functions");
        String phone = request.getParameter("personal_phone");
        String roleName = request.getParameter("role");
        String supervisorIdStr = request.getParameter("supervisor_id");
        String departmentIdStr = request.getParameter("department_id");
        String plainPassword = request.getParameter("password"); 

        int supervisorId = 0;
        int departmentId = 0;
        try {
            if (supervisorIdStr != null && !supervisorIdStr.isEmpty()) {
                supervisorId = Integer.parseInt(supervisorIdStr);
            }
            if (departmentIdStr != null && !departmentIdStr.isEmpty()) {
                departmentId = Integer.parseInt(departmentIdStr);
            }
        } catch (NumberFormatException e) {
            // Ignorar parse error
        }

        try (Connection conn = DBConnection.getConnection()) {
            // Obtener role_id
            String roleSql = "SELECT id FROM seguimiento_actividades.roles WHERE name = ?";
            PreparedStatement roleStmt = conn.prepareStatement(roleSql);
            roleStmt.setString(1, roleName);
            ResultSet rsRole = roleStmt.executeQuery();

            int roleId = 0;
            if (rsRole.next()) {
                roleId = rsRole.getInt("id");
            }

            // Hashear password con BCrypt
            String hashedPassword = BCryptUtil.hashPassword(plainPassword);

            String insertUser = 
                "INSERT INTO seguimiento_actividades.users (" +
                "full_name, institutional_email, functions, personal_phone, role_id, " +
                "supervisor_id, department_id, password) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement stmt = conn.prepareStatement(insertUser);
            stmt.setString(1, fullName);
            stmt.setString(2, email);
            stmt.setString(3, functions);
            stmt.setString(4, phone);
            stmt.setInt(5, roleId);
            
            if (supervisorId > 0) {
                stmt.setInt(6, supervisorId);
            } else {
                stmt.setNull(6, Types.INTEGER);
            }

            if (departmentId > 0) {
                stmt.setInt(7, departmentId);
            } else {
                stmt.setNull(7, Types.INTEGER);
            }

            stmt.setString(8, hashedPassword);

            stmt.executeUpdate();
            response.sendRedirect("dashboard.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al crear usuario: " + e.getMessage());
            request.getRequestDispatcher("createUser.jsp").forward(request, response);
        }
    }
}
