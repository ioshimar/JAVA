package control;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;


public class ProxyServlet2 extends HttpServlet {

   private static final String MAPSERVER_URL = "http://10.153.3.20:86/cgi-bin/mapserv.exe";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("MAPSERVER_URL: " + MAPSERVER_URL);

        String queryString = request.getQueryString();
        String targetUrl = MAPSERVER_URL + "?" + queryString;

        System.out.println("Target URL: " + targetUrl);

        try {
            // Conectar al MapServer
            URL url = new URL(targetUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setDoInput(true);

            int responseCode = connection.getResponseCode();
            String contentType = connection.getContentType();

            System.out.println("Response Code: " + responseCode);
            System.out.println("Content Type: " + contentType);

            // Configurar encabezados en la respuesta del servlet
            response.setContentType(contentType);
            response.setStatus(responseCode);

            // Agregar encabezado CORS
            response.setHeader("Access-Control-Allow-Origin", "*");

            // Leer la respuesta del MapServer y escribirla en la salida del cliente
            try (InputStream inputStream = connection.getInputStream();
                 OutputStream outputStream = response.getOutputStream()) {
                byte[] buffer = new byte[8192];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            }

            connection.disconnect();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error al conectar con MapServer: " + e.getMessage());
        }
    }
}

