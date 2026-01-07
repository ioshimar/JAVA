package control;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


public class RegisterServlet extends HttpServlet {

    private static final String DB_URL      = "jdbc:postgresql://10.153.3.25:5434/db_seguimientos";
    private static final String DB_USER     = "us_seguimientos";
    private static final String DB_PASSWORD = "normAcAt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Asegura el driver
        try { Class.forName("org.postgresql.Driver"); }
        catch (ClassNotFoundException ex) { throw new ServletException("No se pudo cargar el driver de PostgreSQL", ex); }

        String correo         = request.getParameter("correo");
        String nombreCompleto = request.getParameter("nombre_completo");
        String password       = request.getParameter("password");
        String password2      = request.getParameter("password2");
        String tipoUsuario    = request.getParameter("tipo_usuario"); // "unidad" o "publico"
        String unidadEstado   = null;

        // Si es unidad del estado, obtiene el nombre
        if ("unidad".equalsIgnoreCase(tipoUsuario)) {
            unidadEstado = request.getParameter("unidad_estado");
        }

        // Validación
        if (correo == null || nombreCompleto == null || password == null || password2 == null ||
            correo.isEmpty() || nombreCompleto.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        if (!password.equals(password2)) {
            request.setAttribute("error", "Las contraseñas no coinciden.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        if ("unidad".equalsIgnoreCase(tipoUsuario) && (unidadEstado == null || unidadEstado.trim().isEmpty())) {
            request.setAttribute("error", "Debes ingresar el nombre de la Unidad del Estado.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        String passwordHash = hashPassword(password);

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // 1. Valida que el correo no exista
            String checkSql = "SELECT COUNT(*) FROM consulta_curt.client WHERE correo = ?";
            try (PreparedStatement stmt = conn.prepareStatement(checkSql)) {
                stmt.setString(1, correo);
                try (ResultSet rs = stmt.executeQuery()) {
                    rs.next();
                    if (rs.getInt(1) > 0) {
                        request.setAttribute("error", "Ya existe una cuenta con ese correo.");
                        request.getRequestDispatcher("register.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // 2. Insertar usuario
            String insertSql = "INSERT INTO consulta_curt.client (correo, nombre_completo, unidad_estado, password_hash, fecha_registro) VALUES (?, ?, ?, ?, NOW())";
            try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                stmt.setString(1, correo);
                stmt.setString(2, nombreCompleto);
                stmt.setString(3, unidadEstado); // Puede ser null
                stmt.setString(4, passwordHash);
                stmt.executeUpdate();
            }

            // 3. Muestra mensaje de éxito en register.jsp, después redirige a login.jsp
            request.setAttribute("success", "¡Registro exitoso! Ahora puedes iniciar sesión.");
            request.getRequestDispatcher("register.jsp").forward(request, response);

        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Error de base de datos: " + ex.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    // SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (NoSuchAlgorithmException | java.io.UnsupportedEncodingException e) {
            throw new RuntimeException("No se pudo hashear la contraseña", e);
        }
    }
}
