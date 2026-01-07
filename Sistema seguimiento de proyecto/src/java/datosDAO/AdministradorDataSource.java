/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datosDAO;

import java.io.Serializable;
import javax.sql.DataSource;
import org.apache.commons.dbcp.BasicDataSource;


/*import org.apache.commons.dbcp.BasicDataSource;*/
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.Statement;
//import javax.sql.rowset.CachedRowSet;
//import com.sun.rowset.CachedRowSetImpl;


/**
 *
 * @author RICARDO.MACIAS
 */
public class AdministradorDataSource implements Serializable {

    private static DataSource dsp;

    protected static synchronized DataSource getDataSource() {
        if (dsp == null) {
            BasicDataSource bds = new BasicDataSource();
            bds.setDriverClassName("org.postgresql.Driver");
            bds.setUrl("jdbc:postgresql://10.153.3.25:5434/db_seguimientos");
            bds.setUsername("us_seguimientos");
            bds.setPassword("normAcAt");
            bds.setTimeBetweenEvictionRunsMillis(10000);
            bds.setTestWhileIdle(true);
            bds.setValidationQuery("select 1 as uno;");
            bds.setRemoveAbandonedTimeout(5);
            bds.setRemoveAbandoned(true);
            bds.setMaxWait(5000);

            dsp = bds;
        }
        return dsp;
    }

}

