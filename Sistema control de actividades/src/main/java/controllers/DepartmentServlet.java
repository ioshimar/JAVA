package controllers;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.DBConnection;

public class DepartmentServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // Establecer codificación UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        if ("delete".equalsIgnoreCase(action)) {
            deleteDepartment(request, response);
        } else {
            response.sendRedirect("createDepartment.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // Establecer codificación UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if ("save".equalsIgnoreCase(action)) {
            saveDepartment(request, response);
        } else {
            response.sendRedirect("createDepartment.jsp");
        }
    }

    private void saveDepartment(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = (Integer) session.getAttribute("userId");
        int roleId = (Integer) session.getAttribute("roleId");
        if (roleId != 1) { // Solo subdirector
            response.sendRedirect("dashboard.jsp");
            return;
        }

        String deptIdStr = request.getParameter("deptId");
        String name = request.getParameter("name");
        String extension = request.getParameter("extension");
        String func = request.getParameter("function");

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("error", "El nombre del departamento es obligatorio.");
            request.getRequestDispatcher("createDepartment.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            if (deptIdStr == null || deptIdStr.isEmpty()) {
                // Crear
                String sql = "INSERT INTO seguimiento_actividades.departments(name, extension_phone, function, subdirector_id) VALUES (?,?,?,?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, name.trim());
                if (extension == null || extension.trim().isEmpty()) {
                    ps.setNull(2, Types.VARCHAR);
                } else {
                    ps.setString(2, extension.trim());
                }
                if (func == null || func.trim().isEmpty()) {
                    ps.setNull(3, Types.VARCHAR);
                } else {
                    ps.setString(3, func.trim());
                }
                ps.setInt(4, userId);
                ps.executeUpdate();
                ps.close();
                request.setAttribute("message", "Departamento creado exitosamente.");
            } else {
                // Editar
                int deptId = Integer.parseInt(deptIdStr);
                String sqlUp = "UPDATE seguimiento_actividades.departments SET name=?, extension_phone=?, function=? WHERE id=? AND subdirector_id=?";
                PreparedStatement psUp = conn.prepareStatement(sqlUp);
                psUp.setString(1, name.trim());
                if (extension == null || extension.trim().isEmpty()) {
                    psUp.setNull(2, Types.VARCHAR);
                } else {
                    psUp.setString(2, extension.trim());
                }
                if (func == null || func.trim().isEmpty()) {
                    psUp.setNull(3, Types.VARCHAR);
                } else {
                    psUp.setString(3, func.trim());
                }
                psUp.setInt(4, deptId);
                psUp.setInt(5, userId);
                int rows = psUp.executeUpdate();
                psUp.close();
                if (rows > 0) {
                    request.setAttribute("message", "Departamento actualizado.");
                } else {
                    request.setAttribute("error", "No se encontró o no tienes permiso para editar.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
        }
        request.getRequestDispatcher("createDepartment.jsp").forward(request, response);
    }

    private void deleteDepartment(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // Configurar codificación
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = (Integer) session.getAttribute("userId");
        int roleId = (Integer) session.getAttribute("roleId");
        if (roleId != 1) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        String deptIdStr = request.getParameter("deptId");
        if (deptIdStr != null && !deptIdStr.isEmpty()) {
            try (Connection conn = DBConnection.getConnection()) {
                int deptId = Integer.parseInt(deptIdStr);
                String sqlDel = "DELETE FROM seguimiento_actividades.departments WHERE id=? AND subdirector_id=?";
                PreparedStatement psDel = conn.prepareStatement(sqlDel);
                psDel.setInt(1, deptId);
                psDel.setInt(2, userId);
                int rows = psDel.executeUpdate();
                psDel.close();
                if (rows > 0) {
                    // Redirigir para que la URL se actualice y se muestre el mensaje
                    response.sendRedirect("createDepartment.jsp?message=Departamento+eliminado+exitosamente.");
                    return;
                } else {
                    request.setAttribute("error", "No se encontró o no tienes permiso para eliminarlo.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error: " + e.getMessage());
            }
        } else {
            request.setAttribute("error", "No se proporcionó un departamento para eliminar.");
        }
        request.getRequestDispatcher("createDepartment.jsp").forward(request, response);
    }
}
