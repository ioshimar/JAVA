package controlador;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.SQLException;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.*;
import java.util.concurrent.locks.ReentrantLock;

@WebListener
public class CronActualizaCurtMun implements ServletContextListener {

    private ScheduledExecutorService scheduler;
    private final ReentrantLock lock = new ReentrantLock();

    // ===== Config =====
    private static final ZoneId ZONE = ZoneId.of("America/Mexico_City");
    private static final DateTimeFormatter TS = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss z");

    // Primera corrida HOY a las 14:35
    private static final LocalTime FIRST_AT = LocalTime.of(14, 35);
    // Después diario a las 11:00
    private static final LocalTime DAILY_AT = LocalTime.of(11, 0);

    // Producción: hace swap a mun_curt (NO deja mun_curt_new)
    private static final boolean TEST_MODE = false;

    // JDBC (igual que tu JSP)
    private static final String JDBC_URL  = "jdbc:postgresql://10.153.3.25:5434/db_seguimientos";
    private static final String JDBC_USER = "us_seguimientos";
    private static final String JDBC_PASS = "normAcAt";

    // dblink hacia la otra BD
    private static final String DBLINK_CONN =
        "dbname=curt port=5433 host=10.153.3.21 user=user_prod_consulta password=Us3r_C0ns";

    // Estado: si ya pasó la primera corrida
    private volatile boolean firstDone;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        scheduler = Executors.newSingleThreadScheduledExecutor(r -> {
            Thread t = new Thread(r, "cron-actualiza-curt-mun");
            t.setDaemon(true);
            return t;
        });

        // Si ya pasó la hora de la primera corrida hoy, la marcamos como hecha para saltar directo al horario diario.
        ZonedDateTime now = ZonedDateTime.now(ZONE);
        ZonedDateTime firstToday = now.with(FIRST_AT);
        firstDone = !firstToday.isAfter(now); // true si ya pasó (o es igual)

        scheduleNextRun(); // programa la primera
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null) scheduler.shutdownNow();
    }

    /** Siguiente ejecución según estado: si falta primera → hoy 14:35; si no → próximo 11:00. */
    private ZonedDateTime nextTriggerAfter(ZonedDateTime now) {
        if (!firstDone) {
            ZonedDateTime target = now.with(FIRST_AT);
            // aquí suponemos que solo queremos la PRIMERA hoy; si ya pasó, firstDone=true en init
            return target;
        } else {
            ZonedDateTime target = now.with(DAILY_AT);
            if (!target.isAfter(now)) target = target.plusDays(1); // si ya pasó hoy, mañana 11:00
            return target;
        }
    }

    /** Agenda UNA corrida; al terminar, reprograma la siguiente exacta. */
    private void scheduleNextRun() {
        ZonedDateTime now = ZonedDateTime.now(ZONE);
        ZonedDateTime next = nextTriggerAfter(now);
        long delayMs = Duration.between(now, next).toMillis();

        System.out.println("[CronActualizaCurtMun] now=" + now.format(TS) +
                " | next=" + next.format(TS) + " | delayMs=" + delayMs);

        scheduler.schedule(() -> {
            runJobSafe();
            // Tras la primera ejecución, pasamos a diario 11:00
            if (!firstDone) {
                firstDone = true;
                System.out.println("[CronActualizaCurtMun] Primera corrida completada; de ahora en adelante diario 11:00.");
            }
            scheduleNextRun();
        }, delayMs, TimeUnit.MILLISECONDS);
    }

    /** Evita traslapes si una corrida se alarga. */
    private void runJobSafe() {
        if (!lock.tryLock()) {
            System.out.println("[CronActualizaCurtMun] Otra ejecución en curso; se omite.");
            return;
        }
        System.out.println("[CronActualizaCurtMun] INICIO @ " + ZonedDateTime.now(ZONE).format(TS));
        try {
            runJob();
            System.out.println("[CronActualizaCurtMun] FIN OK @ " + ZonedDateTime.now(ZONE).format(TS));
        } catch (Throwable ex) {
            System.err.println("[CronActualizaCurtMun] FIN con ERROR @ " +
                    ZonedDateTime.now(ZONE).format(TS) + " :: " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            lock.unlock();
        }
    }

    /** Lógica principal: construye mun_curt_new, hace swap a mun_curt y elimina la vieja. */
    private void runJob() throws SQLException, ClassNotFoundException {
        // Asegúrate de tener postgresql-*.jar en WEB-INF/lib
        Class.forName("org.postgresql.Driver");

        try (Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS)) {
            con.setAutoCommit(false);

            try (Statement st = con.createStatement()) {
                // 1) preparar tabla nueva
                st.executeUpdate("DROP TABLE IF EXISTS \"seguim_CURT\".mun_curt_new");

                st.executeUpdate(
                    "CREATE TABLE \"seguim_CURT\".mun_curt_new (" +
                    "  cve_ent varchar(2)," +
                    "  cve_mun varchar(3)," +
                    "  curt numeric" +
                    ")"
                );

                // 2) llenar desde dblink con dollar-quoting
                String connLit = DBLINK_CONN.replace("'", "''");
                String inner =
                        "SELECT cve_ent, cve_mun, COUNT(curt) AS curt " +
                        "FROM registrocurt.tr_predios_procesados " +
                        "WHERE curt <> '' " +
                        "GROUP BY cve_ent, cve_mun " +
                        "ORDER BY cve_ent ASC";

                String sql =
                        "INSERT INTO \"seguim_CURT\".mun_curt_new " +
                        "SELECT cve_ent, cve_mun, curt " +
                        "FROM dblink('" + connLit + "', $$" + inner + "$$) " +
                        "AS demo(cve_ent varchar, cve_mun varchar, curt integer)";

                st.executeUpdate(sql);

                if (TEST_MODE) {
                    // (no se usará en producción, pero lo dejo por si quieres volver a probar)
                    con.commit();
                    System.out.println("[CronActualizaCurtMun] TEST_MODE: mun_curt_new creada.");
                } else {
                    // 3) swap atómico a mun_curt y limpieza
                    // evitar choque si quedó una vieja por algún error previo
                    st.executeUpdate("DROP TABLE IF EXISTS \"seguim_CURT\".mun_curt_old");
                    // renombrar actual a *_old (si existe)
                    st.executeUpdate("ALTER TABLE IF EXISTS \"seguim_CURT\".mun_curt RENAME TO mun_curt_old");
                    // renombrar la nueva como definitiva
                    st.executeUpdate("ALTER TABLE \"seguim_CURT\".mun_curt_new RENAME TO mun_curt");
                    // eliminar la vieja
                    st.executeUpdate("DROP TABLE IF EXISTS \"seguim_CURT\".mun_curt_old");

                    con.commit();
                    System.out.println("[CronActualizaCurtMun] Producción: swap a mun_curt completado.");
                }

            } catch (SQLException e) {
                con.rollback();
                System.err.println("[CronActualizaCurtMun] Error, rollback: " + e.getMessage());
                throw e;
            }
        }
    }
}
