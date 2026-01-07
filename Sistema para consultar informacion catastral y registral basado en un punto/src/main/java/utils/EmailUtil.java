/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author IOSHIMAR.RODRIGUEZ
 */
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {
    public static void enviarCorreoRecuperacion(String destinatario, String token) throws Exception {
        final String remitente = "ioshimar.rodriguez@inegi.org.mx";
        final String password  = "IoSimino198419@";
        final String host      = "smtp.office365.com"; // SMTP de INEGI
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(remitente, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(remitente, "Sistema CURT"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
        message.setSubject("Recuperación de contraseña - CURT");
        String url = "http://10.107.12.36:8080/restore_password.jsp?token=" + token;
        String cuerpo = "<b>Hola,</b><br><br>" +
            "Has solicitado recuperar tu contraseña.<br>" +
            "Haz clic en el siguiente enlace para restablecerla:<br><br>" +
            "<a href='" + url + "'>Restablecer contraseña</a><br><br>" +
            "Si no lo solicitaste, ignora este correo.<br><br>Gracias.";
        message.setContent(cuerpo, "text/html; charset=utf-8");
        Transport.send(message);
    }
}
