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

public class ProxyServlet extends HttpServlet {
    
    private static final String MAPSERVER_URL = "http://10.153.3.20:88/cgi-bin/mapserv.exe";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        System.out.println("ProxyServlet received request: " + request.getQueryString());
        // Construir la URL del MapServer con los parámetros de la solicitud
        String queryString = request.getQueryString();
        String targetUrl = MAPSERVER_URL + "?" + queryString;

        System.out.println("ProxyServlet forwarding to: " + targetUrl);

        try {
            // Conectar al MapServer
            URL url = new URL(targetUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setDoInput(true);

            System.out.println("MapServer response code: " + connection.getResponseCode());
            System.out.println("MapServer response content type: " + connection.getContentType());

            // Configurar encabezados en la respuesta del servlet
            response.setContentType(connection.getContentType());
            response.setStatus(connection.getResponseCode());
            
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
            System.out.println("ProxyServlet successfully forwarded the response.");
        } catch (IOException e) {
            System.err.println("ProxyServlet encountered an error: " + e.getMessage());
            e.printStackTrace();
            // Configurar una respuesta de error con encabezados CORS
            response.setContentType("text/plain");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setHeader("Access-Control-Allow-Origin", "*");
            response.getWriter().write("Error al procesar la solicitud proxy.");
        }
    }
}
