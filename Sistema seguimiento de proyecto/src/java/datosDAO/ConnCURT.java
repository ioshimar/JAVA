/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datosDAO;

import javax.sql.DataSource;
import org.apache.commons.dbcp.BasicDataSource;

/**
 *
 * @author RICARDO.MACIAS
 */
public class ConnCURT {
    
       private static DataSource dsp;

    protected static synchronized DataSource getDataSource() {
        if (dsp == null) {
            BasicDataSource bds = new BasicDataSource();
            bds.setDriverClassName("org.postgresql.Driver");
            bds.setUrl("jdbc:postgresql://10.153.3.21:5433/curt");
            bds.setUsername("user_prod_consulta");
            bds.setPassword("Us3r_C0ns");
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
