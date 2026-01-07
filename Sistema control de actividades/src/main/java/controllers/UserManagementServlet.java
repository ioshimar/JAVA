/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.DBConnection;

/**
 *
 * @author IOSHIMAR.RODRIGUEZ
 */
public class UserManagementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int roleId = (int) session.getAttribute("roleId");
        // Solo el Subdirector (ej. roleId=1) puede ver/editar todos los usuarios
        // Si quieres que un Jefe vea a sus subordinados, ajusta la consulta.
        if (roleId != 1) {
            request.setAttribute("error", "No tienes permisos para ver todos los usuarios.");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            return;
        }

        // Listar usuarios
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT u.id, u.full_name, u.institutional_email, u.functions, u.personal_phone, " +
                         "       r.name AS role_name, u.supervisor_id, d.name AS dept_name " +
                         "FROM seguimiento_actividades.users u " +
                         "LEFT JOIN seguimiento_actividades.roles r ON (u.role_id = r.id) " +
                         "LEFT JOIN seguimiento_actividades.departments d ON (u.department_id = d.id) " +
                         "ORDER BY u.id";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            List<Map<String,Object>> userList = new ArrayList<>();
            while (rs.next()) {
                Map<String,Object> row = new HashMap<>();
                row.put("id", rs.getInt("id"));
                row.put("fullName", rs.getString("full_name"));
                row.put("email", rs.getString("institutional_email"));
                row.put("functions", rs.getString("functions"));
                row.put("phone", rs.getString("personal_phone"));
                row.put("roleName", rs.getString("role_name"));
                row.put("supervisorId", rs.getInt("supervisor_id"));
                row.put("deptName", rs.getString("dept_name"));
                userList.add(row);
            }
            request.setAttribute("users", userList);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar usuarios: " + e.getMessage());
        }
        request.getRequestDispatcher("listUsers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Eliminar usuario
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int roleId = (int) session.getAttribute("roleId");
        if (roleId != 1) {
            request.setAttribute("error", "No tienes permisos para borrar usuarios.");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            return;
        }

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "DELETE FROM seguimiento_actividades.users WHERE id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al eliminar usuario: " + e.getMessage());
            }
        }
        response.sendRedirect("users");
    }
}
