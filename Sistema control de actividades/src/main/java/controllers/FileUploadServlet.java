/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import utils.DBConnection;
import java.io.*;
import java.sql.*;
import java.nio.file.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.*;
import javax.servlet.http.*;


/**
 *
 * @author IOSHIMAR.RODRIGUEZ
 */
@MultipartConfig
public class FileUploadServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Part filePart = request.getPart("file");
        String activityIdStr = request.getParameter("activity_id");
        int activityId = Integer.parseInt(activityIdStr);

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Ruta de uploads
            String uploadsDir = getServletContext().getRealPath("/uploads");
            File uploadFolder = new File(uploadsDir);
            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs();
            }

            String filePath = uploadsDir + File.separator + fileName;
            try (InputStream is = filePart.getInputStream()) {
                Files.copy(is, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
            }

            // Guardar en BD
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "INSERT INTO seguimiento_actividades.attachments (activity_id, file_path) VALUES (?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, activityId);
                ps.setString(2, fileName);
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("dashboard.jsp");
    }
}
