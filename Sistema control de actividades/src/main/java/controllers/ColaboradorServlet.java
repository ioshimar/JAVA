package controllers;

import utils.DBConnection;
import utils.BCryptUtil;
import java.io.IOException;
import java.sql.*;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class ColaboradorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // Ajustar codificación a UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if("delete".equalsIgnoreCase(action)) {
            deleteColaborador(request, response);
        } else {
            response.sendRedirect("createUser.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // Ajustar codificación a UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if("save".equalsIgnoreCase(action)) {
            saveColaborador(request, response);
        } else {
            response.sendRedirect("createUser.jsp");
        }
    }

    private void saveColaborador(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("userId") == null){
            response.sendRedirect("login.jsp");
            return;
        }
        int sessionRole = (Integer) session.getAttribute("roleId");
        // Subdirector=1 o Jefe=2
        if(sessionRole != 1 && sessionRole != 2){
            response.sendRedirect("dashboard.jsp");
            return;
        }

        // Parámetros
        String uIdStr = request.getParameter("uId");
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("institutional_email");
        String phone = request.getParameter("personal_phone");
        String functions = request.getParameter("functions");
        String roleSel = request.getParameter("role"); // 'jefe' o 'operativo'
        String deptIdStr = request.getParameter("department_id");
        String ageStr = request.getParameter("age");
        String address = request.getParameter("address");

        // Validar campos obligatorios
        if(fullName == null || fullName.trim().isEmpty() ||
           email == null || email.trim().isEmpty()){
            request.setAttribute("error", "Faltan campos obligatorios (Nombre, Correo).");
            request.getRequestDispatcher("createUser.jsp").forward(request, response);
            return;
        }

        // Forzar a mayúsculas (Ñ y acentos)
        fullName = fullName.trim().toUpperCase(new Locale("es","ES"));

        // Si el subdirector elige 'jefe' => 2, 'operativo' => 3
        // Si es jefe, ignoramos 'roleSel' y forzamos 3
        int newRoleId;
        if(sessionRole == 1) {
            if("jefe".equalsIgnoreCase(roleSel)) newRoleId = 2;
            else newRoleId = 3;
        } else {
            newRoleId = 3; // Jefe => operativo
        }

        // Departamento
        int deptId = 0;
        if(sessionRole == 1){
            // Subdirector => deptId del form
            if(deptIdStr == null || deptIdStr.trim().isEmpty()){
                request.setAttribute("error", "Debes seleccionar un departamento.");
                request.getRequestDispatcher("createUser.jsp").forward(request, response);
                return;
            }
            deptId = Integer.parseInt(deptIdStr);
        } else {
            // Jefe => su dept
            try(Connection c = DBConnection.getConnection()){
                PreparedStatement pDept = c.prepareStatement(
                  "SELECT department_id FROM seguimiento_actividades.users WHERE id=?"
                );
                pDept.setInt(1, (Integer)session.getAttribute("userId"));
                ResultSet rD = pDept.executeQuery();
                if(rD.next()){
                    deptId = rD.getInt("department_id");
                }
                rD.close();
                pDept.close();
            } catch(Exception ex){
                ex.printStackTrace();
            }
        }

        // parsear edad
        Integer age = null;
        if(ageStr != null && !ageStr.trim().isEmpty()){
            try {
                age = Integer.parseInt(ageStr.trim());
            } catch(NumberFormatException e) {
                // ignorar, se queda null
            }
        }

        try(Connection conn = DBConnection.getConnection()){
            // Validar que el subdirector sea dueño de ese departmentId
            if(sessionRole == 1) {
                PreparedStatement psChk = conn.prepareStatement(
                  "SELECT 1 FROM seguimiento_actividades.departments WHERE id=? AND subdirector_id=?"
                );
                psChk.setInt(1, deptId);
                psChk.setInt(2, (Integer)session.getAttribute("userId"));
                ResultSet rsChk = psChk.executeQuery();
                if(!rsChk.next()){
                    request.setAttribute("error", "No puedes asignar este departamento, no te pertenece.");
                    request.getRequestDispatcher("createUser.jsp").forward(request, response);
                    return;
                }
                rsChk.close();
                psChk.close();
            }

            if(uIdStr == null || uIdStr.isEmpty()){
                // Crear nuevo usuario
                String defaultPass = "123456";
                String hashedPass = BCryptUtil.hashPassword(defaultPass);

                String sql = "INSERT INTO seguimiento_actividades.users "
                           + "(full_name, institutional_email, personal_phone, functions, "
                           + " role_id, department_id, password, age, address, first_time_login) "
                           + "VALUES (?,?,?,?,?,?,?,?,?, false)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, fullName);
                ps.setString(2, email.trim());
                ps.setString(3, (phone == null ? "" : phone.trim()));
                ps.setString(4, (functions == null ? "" : functions.trim()));
                ps.setInt(5, newRoleId);
                ps.setInt(6, deptId);
                ps.setString(7, hashedPass);

                if(age == null) ps.setNull(8, Types.INTEGER);
                else ps.setInt(8, age);

                if(address == null || address.trim().isEmpty()){
                    ps.setNull(9, Types.VARCHAR);
                } else {
                    ps.setString(9, address.trim());
                }
                ps.executeUpdate();
                ps.close();

                request.setAttribute("message", "Colaborador creado exitosamente.");
            } else {
                // Editar
                int colabId = Integer.parseInt(uIdStr);

                String sqlUp = "UPDATE seguimiento_actividades.users "
                             + "SET full_name=?, institutional_email=?, personal_phone=?, functions=?, "
                             + "    role_id=?, department_id=?, age=?, address=? "
                             + "WHERE id=? AND role_id IN (2,3)";
                PreparedStatement psUp = conn.prepareStatement(sqlUp);
                psUp.setString(1, fullName);
                psUp.setString(2, email.trim());
                psUp.setString(3, (phone == null ? "" : phone.trim()));
                psUp.setString(4, (functions == null ? "" : functions.trim()));
                psUp.setInt(5, newRoleId);
                psUp.setInt(6, deptId);

                if(age == null) psUp.setNull(7, Types.INTEGER);
                else psUp.setInt(7, age);

                if(address == null || address.trim().isEmpty()){
                    psUp.setNull(8, Types.VARCHAR);
                } else {
                    psUp.setString(8, address.trim());
                }
                psUp.setInt(9, colabId);

                int rows = psUp.executeUpdate();
                psUp.close();

                if(rows > 0){
                    request.setAttribute("message", "Colaborador actualizado exitosamente.");
                } else {
                    request.setAttribute("error", "No se pudo actualizar o no existe.");
                }
            }
        } catch(Exception e){
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
        }

        request.getRequestDispatcher("createUser.jsp").forward(request, response);
    }

    private void deleteColaborador(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("userId") == null){
            response.sendRedirect("login.jsp");
            return;
        }
        int sessionRole = (Integer) session.getAttribute("roleId");
        if(sessionRole != 1 && sessionRole != 2){
            response.sendRedirect("dashboard.jsp");
            return;
        }

        String uIdStr = request.getParameter("uId");
        if(uIdStr != null && !uIdStr.trim().isEmpty()){
            try(Connection conn = DBConnection.getConnection()){
                int colabId = Integer.parseInt(uIdStr);
                String sqlDel = "DELETE FROM seguimiento_actividades.users "
                              + "WHERE id=? AND role_id IN (2,3)";
                PreparedStatement psDel = conn.prepareStatement(sqlDel);
                psDel.setInt(1, colabId);
                int rows = psDel.executeUpdate();
                psDel.close();

                if(rows > 0){
                    request.setAttribute("message", "Colaborador eliminado.");
                } else {
                    request.setAttribute("error", "No se pudo eliminar o no existe.");
                }
            } catch(Exception e){
                e.printStackTrace();
                request.setAttribute("error", "Error: " + e.getMessage());
            }
        }
        request.getRequestDispatcher("createUser.jsp").forward(request, response);
    }
}
