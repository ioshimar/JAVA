package control;

import java.io.*;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GuardarMapaImagenServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Leer el cuerpo de la solicitud JSON
        StringBuilder jsonBuilder = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }
        }

        // Convertir el cuerpo de la solicitud en String
        String json = jsonBuilder.toString();

        // Extraer la cadena de imagen base64 manualmente
        String base64Image = null;
        if (json.contains("\"image\":\"")) {
            base64Image = json.substring(json.indexOf("\"image\":\"") + 9, json.lastIndexOf("\""));
            base64Image = base64Image.replace("\\\"", ""); // Eliminar comillas escapadas si están presentes
        }

        if (base64Image != null && !base64Image.isEmpty()) {
            try {
                // Eliminar prefijo data:image/png;base64, si está presente
                base64Image = base64Image.replaceFirst("^data:image/\\w+;base64,", "");

                // Decodificar la imagen en base64
                byte[] imageBytes = Base64.getDecoder().decode(base64Image);

                // Definir la ruta de la carpeta `temp_images`
                String imageDirPath = getServletContext().getRealPath("/") + "temp_images";
                File imageDir = new File(imageDirPath);

                // Crear la carpeta si no existe
                if (!imageDir.exists()) {
                    imageDir.mkdirs();
                }

                // Definir la ruta completa para guardar la imagen
                String imagePath = imageDirPath + File.separator + "temp_map.png";

                // Escribir los bytes de la imagen en el archivo
                try (FileOutputStream fos = new FileOutputStream(imagePath)) {
                    fos.write(imageBytes);
                }

                // Responder con éxito y la ruta de la imagen
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"path\": \"" + imagePath + "\"}");
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"error\": \"Error al decodificar la imagen Base64\"}");
            }
        } else {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"error\": \"No se proporcionó ninguna imagen\"}");
        }
    }
}
