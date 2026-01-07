package com.mycompany.webservice_rnig;

// CAMBIO: Se regresa a 'javax' para ser compatible con Tomcat 9
import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

@ApplicationPath("api")
public class JakartaRestConfiguration extends Application {
}