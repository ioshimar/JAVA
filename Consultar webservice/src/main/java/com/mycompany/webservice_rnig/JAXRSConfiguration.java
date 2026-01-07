/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.webservice_rnig;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Application;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@ApplicationPath("/api") // La URL base será /api
@Path("/") // Lo ponemos en la raíz del API para la prueba
public class JAXRSConfiguration extends Application {

    // --- MÉTODO DE PRUEBA PARA VERIFICAR QUE EL SERVICIO ESTÁ ACTIVO ---
    @GET
    @Path("/status")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getStatus() {
        // Usamos un mapa simple para la respuesta JSON
        java.util.Map<String, String> status = new java.util.HashMap<>();
        status.put("servicio", "operacional");
        status.put("mensaje", "El servicio REST está activo y respondiendo.");
        
        // Retornamos una respuesta 200 OK con el JSON
        return Response.ok(status).build();
    }
}
