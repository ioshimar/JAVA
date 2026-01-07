package control;

import java.io.IOException;
import java.sql.*;
import java.util.Properties;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class RecuperarPasswordServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:postgresql://10.153.3.25:5434/db_seguimientos";
    private static final String DB_USER = "us_seguimientos";
    private static final String DB_PASSWORD = "normAcAt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String correo = request.getParameter("correo");
        if (correo == null || correo.trim().isEmpty()) {
            request.setAttribute("error", "Ingresa tu correo.");
            request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("org.postgresql.Driver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // Busca el usuario por correo
                String sql = "SELECT id FROM consulta_curt.client WHERE correo = ?";
                int userId = -1;
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, correo.trim());
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) userId = rs.getInt("id");
                    }
                }
                if (userId == -1) {
                    request.setAttribute("error", "El correo no está registrado.");
                    request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
                    return;
                }

                // Genera código de 6 dígitos
                String code = String.format("%06d", new Random().nextInt(999999));

                // Guarda el código en la base (en el campo reset_token de tu tabla client)
                String update = "UPDATE consulta_curt.client SET reset_token = ? WHERE id = ?";
                try (PreparedStatement ps = conn.prepareStatement(update)) {
                    ps.setString(1, code);
                    ps.setInt(2, userId);
                    ps.executeUpdate();
                }

                // Envia el código por correo
                sendEmail(correo, code);

                // Mensaje de éxito
                request.setAttribute("success", "Te enviamos las instrucciones a tu correo.");
                request.getRequestDispatcher("forgot_password.jsp").forward(request, response);

            }
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Error inesperado: " + ex.getMessage());
            request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
        }
    }

    private void sendEmail(String recipientEmail, String code) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.office365.com");
        props.put("mail.smtp.port", "587");

        String senderEmail = "ioshimar3@hotmail.com";
        String senderPassword = "ioSimino198419c";

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(senderEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        message.setSubject("Código de recuperación de contraseña");
        message.setText("Tu código para recuperar tu contraseña es: " + code
            + "\n\nIngresa este código en la página para continuar con la recuperación. Si no solicitaste este código, ignora este correo.");

        Transport.send(message);
    }
}
