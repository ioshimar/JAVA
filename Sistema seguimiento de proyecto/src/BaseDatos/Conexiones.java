/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package BaseDatos;

import java.io.Serializable;
import javax.sql.DataSource;
import org.apache.commons.dbcp.BasicDataSource;

public class Conexiones implements Serializable {

    private static DataSource dsp;

    protected static synchronized DataSource getDataSource() {
        if (dsp == null) {
            BasicDataSource bds = new BasicDataSource();
            bds.setDriverClassName("org.postgresql.Driver");
            bds.setUrl("jdbc:postgresql://10.153.3.25:5434/db_directorio");
            bds.setUsername("seg_curt_cons");
            bds.setPassword("CURT");
            bds.setTimeBetweenEvictionRunsMillis(10000);
            bds.setTestWhileIdle(true);
            bds.setValidationQuery("select 1 as uno;");
            //bds.setRemoveAbandonedTimeout(5);
            
            //bds.setRemoveAbandoned(true);
            bds.setMaxWait(5000);

            dsp = bds;
        }
        return dsp;
    }

}
