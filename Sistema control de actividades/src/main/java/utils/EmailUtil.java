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
    private static final String USERNAME = "francisco.carrasco@inegi.org.mx";
    private static final String PASSWORD = "Ingenieria Civil_85";

    public static void sendEmail(String to, String subject, String messageText) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.office365.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2"); // Forzar TLS 1.2
        props.put("mail.debug", "true"); // Para ver logs de depuración

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setContent(messageText, "text/html; charset=utf-8"); // Permitir HTML en los correos

            Transport.send(message);
            System.out.println("✅ Correo enviado exitosamente a " + to);

        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("❌ ERROR al enviar correo: " + e.getMessage());
        }
    }
}