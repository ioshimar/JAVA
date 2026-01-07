package com.mycompany.webservice_rnig;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@Path("/predios")
public class PrediosResource {

    // --- Constantes de Conexión ---
    private static final String DB_URL      = "jdbc:postgresql://10.153.3.25:5434/db_directorio";
    private static final String DB_USER     = "serv_wms";
    private static final String DB_PASSWORD = "serv_2025";
    private static final String DB_SCHEMA   = "inf_vec_cat";
    private static final String DB_TABLE    = "predios_temp";

@GET
@Path("/buscar")
@Produces(MediaType.APPLICATION_JSON)
public Response buscarPorCoordenada(@QueryParam("x") Double lon,
                                    @QueryParam("y") Double lat) {

    if (lon == null || lat == null) {
        return Response.status(Response.Status.BAD_REQUEST)
                       .entity("{\"error\":\"Los parámetros 'x' (longitud) y 'y' (latitud) son requeridos.\"}")
                       .build();
    }

    String sql = "SELECT \"CURT\", "
               + "ST_X(ST_Centroid(geometria)) AS lon_cent, "
               + "ST_Y(ST_Centroid(geometria)) AS lat_cent, "
               + "ST_AsGeoJSON(geometria) AS geometria_geojson, "
               + "anio_exporta, "
               + "institucion "
               + "FROM " + DB_SCHEMA + "." + DB_TABLE + " "
               + "WHERE ST_Contains(geometria, "
               + "  ST_Transform(ST_SetSRID(ST_MakePoint(?, ?), 4326), "
               + "               ST_SRID(geometria)))";

    try {
        Class.forName("org.postgresql.Driver");
    } catch (ClassNotFoundException e) {
        return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                .entity("{\"error\":\"Driver de PostgreSQL no encontrado.\"}")
                .build();
    }

    try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setDouble(1, lon);
        ps.setDouble(2, lat);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                String curt = rs.getString("CURT");
                double lonCent = rs.getDouble("lon_cent");
                double latCent = rs.getDouble("lat_cent");
                String geojson = rs.getString("geometria_geojson");
                Integer anioExporta = rs.getObject("anio_exporta") != null ? rs.getInt("anio_exporta") : null;
                String institucion = rs.getString("institucion");

                StringBuilder sb = new StringBuilder();
                sb.append("{");
                sb.append("\"curt\": \"").append(curt != null ? curt : "").append("\"");
                sb.append(", \"lat_cent\": ").append(latCent);
                sb.append(", \"lon_cent\": ").append(lonCent);

                if (geojson != null) {
                    sb.append(", \"geometria\": ").append(geojson); // GeoJSON ya es JSON
                } else {
                    sb.append(", \"geometria\": null");
                }

                if (anioExporta != null) {
                    sb.append(", \"anio_exporta\": ").append(anioExporta);
                } else {
                    sb.append(", \"anio_exporta\": null");
                }

                if (institucion != null) {
                    sb.append(", \"institucion\": \"").append(escapeJson(institucion)).append("\"");
                } else {
                    sb.append(", \"institucion\": null");
                }
                sb.append("}");

                return Response.ok(sb.toString(), MediaType.APPLICATION_JSON).build();

            } else {
                return Response.status(Response.Status.NOT_FOUND)
                               .entity("{\"mensaje\":\"No se encontró ningún predio en las coordenadas proporcionadas.\"}")
                               .build();
            }
        }

    } catch (SQLException ex) {
        ex.printStackTrace();
        return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                .entity("{\"error\":\"Error de base de datos: " + escapeJson(ex.getMessage()) + "\"}")
                .build();
    }
}


    // Escapa comillas para campos de texto JSON simples
    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\"", "\\\"");
    }
}
