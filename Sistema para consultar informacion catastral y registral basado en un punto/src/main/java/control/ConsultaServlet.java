package control;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.io.IOException;
import java.sql.*;
import java.util.concurrent.*;
import java.util.*;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.postgis.PGgeometry;
import java.io.*;
import java.net.*;
import org.json.JSONObject;

// ---- Clase cliente del API de Catastro ----
class CatastroApiClient {
    public static JSONObject consultarCatastro(double x, double y) throws IOException {
        String apiUrl = String.format("http://10.210.140.70:9070/catastro/api/info?x=%f&y=%f", x, y);
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");

        int status = conn.getResponseCode();
        if (status != 200) {
            throw new IOException("Error HTTP: " + status);
        }

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        String inputLine;
        StringBuilder content = new StringBuilder();
        while ((inputLine = in.readLine()) != null) {
            content.append(inputLine);
        }
        in.close();
        conn.disconnect();

        return new JSONObject(content.toString());
    }
}





public class ConsultaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Configuración de HikariCP
    private HikariDataSource dataSource;
    private ExecutorService executorService;
    
    // Mapa para las definiciones de edafología
    private static final Map<String, String> edafologiaDefinitions = new HashMap<>();
    
    // Mapa para las definiciones de geología
    private static final Map<String, String> geologiaDefinitions = new HashMap<>();

    static {
        // Agregamos todas las definiciones de edafología
        edafologiaDefinitions.put("ACRISOL", "Suelos con arcillas de baja actividad y que no son fértiles en general para la agricultura. "
            + "Muy susceptibles a la erosión por deforestación. Los Acrisoles son representativos de zonas muy lluviosas como las sierras del sur "
            + "de Chiapas, los bosques mesófilos y selvas altas de Oaxaca, así como las cumbres de la sierra de Nayarit. Se caracterizan por "
            + "sus colores rojos o amarillos claros con manchas rojas y por ser muy ácidos, pH generalmente debajo de 5.5 donde la "
            + "mayoría de los nutrientes no son disponibles para la mayoría de los cultivos tradicionales, salvo el cacao, café y piña; por ello su uso más adecuado es forestal.");
        edafologiaDefinitions.put("ALISOL", "Son suelos tóxicos por su alto contenido de aluminio, pobres en calcio, magnesio y potasio; tienen mayor contenido "
            + "de arcilla en el subsuelo que en la capa superior del suelo, como resultado de procesos edafogenéticos (especialmente migración de arcilla) "
            + "que conducen a la formación de un subhorizonte árgico. Se producen en regiones de clima húmedo tropical subtropical y regiones templadas húmedas. "
            + "Los Alisoles predominan en topografía montañosa u ondulada. Como consecuencia, muchos Alisoles sólo permiten cultivos de raíces poco profundas y éstos "
            + "sufren de estrés por la sequía. Un porcentaje significativo de Alisoles son improductivos para una amplia variedad de cultivos.");
        edafologiaDefinitions.put("ANDOSOL", "Suelos de origen volcánico reciente, muy ligeros en peso debido al abundante alófano o complejos de aluminio-humus en los "
            + "primeros 30 cm de profundidad. Tienen una consistencia resbaladiza. Si bien los Andosoles son fáciles de cultivar y tienen buenas propiedades de "
            + "enraizamiento y almacenamiento de agua, cuando están situados en ladera es preferible conservarlos con su vegetación original. "
            + "Presentan frecuentemente valores superiores a 3.0% de carbono orgánico y se erosionan rápidamente por deforestación y remoción de raíces. "
            + "Los Andosoles mexicanos son particularmente frágiles ya que la mayoría están situados en regiones con cambios drásticos en el uso del suelo, "
            + "por ejemplo, antiguos bosques de pino, oyamel o incluso mesófilos, que hoy son terrenos agrícolas de regular o baja productividad. "
            + "Se localizan básicamente en 5 regiones fisiográficas, de oeste a este, la Neovolcánica Nayarita, Neovolcánica Tarasca y Mil Cumbres en Michoacán, los Lagos y "
            + "Volcanes del Anáhuac, Chiconquiaco y la Sierra de los Tuxtlas. La mayor parte de los Andosoles en México están situados sobre depósitos de basalto, andesitas, "
            + "brechas volcánicas básicas, brechas sedimentarias y estructuras volcanoclásticas");
        edafologiaDefinitions.put("ANTHROSOL", "Suelos que han sido modificados profundamente por actividades humanas, tales como: la adición de material orgánico mineral, "
            + "carbón vegetal, residuos domésticos, el riego y el cultivo. Se encuentran en muchas regiones en las cuales la gente ha practicado la agricultura "
            + "por largos periodos. La influencia de los seres humanos está normalmente restringida a los horizontes superficiales. El horizonte de diferenciación "
            + "puede estar sepultado e intacto a cierta profundidad. De acuerdo al tipo de horizonte es el resultado del cultivo que obtendrá, por ejemplo los "
            + "horizontes plágicos tienen propiedades físicas favorables como la porosidad, penetración de raíces y la disponibilidad de humedad, pero muchos de "
            + "ellos también tienen características químicas menos satisfactorias como acidez y deficiencia de nutrientes. "
            + "Los Antrosoles con horizonte plágico se utilizan favorablemente para viveros y la horticultura.");
        edafologiaDefinitions.put("ARENOSOL", "Suelos con más del 85% de arena. Incluyen arenas depositadas en dunas o playas y también arenas residuales formadas por meteorización de "
            + "sedimentos o rocas ricas en cuarzo. No tienen buenas propiedades de almacenamiento de agua y nutrientes, pero ofrecen facilidad de labranza y enraizamiento. "
            + "Los Arenosoles más susceptibles a la degradación por cambio de uso son los de clima húmedo. La superficie más importante de Arenosoles se encuentra en los "
            + "desiertos de Sonora, Baja California y Baja California Sur. En la zona seca son usados para pastizales, pueden usarse para cultivos rentables en caso de "
            + "contar con sistemas de riego. En los trópicos húmedos están químicamente agotados y son altamente sensibles a la erosión.");
        edafologiaDefinitions.put("CALCISOL", "Suelos con más del 15% de carbonato de calcio en por lo menos una capa de 15 cm de espesor, pueden presentar una capa cementada (petrocálcico). "
            + "Muchos cultivos en Calcisoles tienen éxito si son fertilizados con nitrógeno, fósforo, hierro y zinc. Es uno de los grupos de suelo más extendidos en el país. "
            + "Están situados principalmente en zonas áridas de origen sedimentario (calizas y lutitas-areniscas) en los estados de Chihuahua, Coahuila, Sonora, Nuevo León, "
            + "Zacatecas y San Luis Potosí, irrigados, drenados (para prevenir la salinización) y fertilizados, pueden ser altamente productivos bajo una amplia variedad de cultivos.");
        edafologiaDefinitions.put("CAMBISOL", "Suelos jóvenes con algún cambio apreciable en el contenido de arcilla o color entre sus capas u horizontes. No tienen un patrón climático definido, "
            + "pero pueden encontrarse en alguna posición geomorfológica intermedia entre cualquiera de dos grupos de suelo considerados por la WRB. Tienen en el subsuelo una capa "
            + "más parecida a suelo que a roca y con acumulaciones moderadas de calcio, hierro, manganeso y arcilla. Son de moderada a alta susceptibilidad a la erosión. "
            + "Por lo general, estos suelos son buenos con fines agrícolas y son usados intensamente. Los Cambisoles éutricos de la zona templada son muy productivos.");
        edafologiaDefinitions.put("CHERNOZEM", "Suelos de clima árido o semiárido, con una capa superficial gruesa, negra o muy oscura y rica en carbono orgánico, fértiles en magnesio, "
            + "potasio y carbonatos en el subsuelo. La mayor extensión de Chernozems se encuentra en tres regiones: las sierras y llanuras de Durango, las llanuras de San Luis Potosí, "
            + "Zacatecas y la Llanura Costera Tamaulipeca. Se emplean en la agricultura de riego o temporal y en el cultivo de pastizales.");
        edafologiaDefinitions.put("CRYOSOL", "Suelos afectados por el hielo, los minerales de este suelo están formados en un ambiente de permafrost. Las capas subsuperficiales (horizonte críico) "
            + "se congelan de forma permanente, el agua ocurre en forma de hielo. Los procesos criogénicos son los procesos dominantes formadores de suelos en la mayoría "
            + "de los Cryosoles. En México únicamente pueden localizarse en las montañas más elevadas.");
        edafologiaDefinitions.put("DURISOL", "Suelos con acumulación aluvial o coluvial de sílice, en México presentan una capa endurecida conocida regionalmente como ‘tepetate’. "
            + "Son muy susceptibles a la erosión hídrica. Algunas veces están afectados por sales y normalmente impiden el paso de las raíces después del medio metro de profundidad. "
            + "Su distribución está en los Altos de Jalisco, las llanuras Tarahumara y de Ojuelos, así como en zonas erosionadas del estado de México y Tlaxcala. "
            + "El uso más frecuente de estos suelos es el aprovechamiento de pastizales naturales o inducidos y eventualmente la agricultura de temporal.");
        edafologiaDefinitions.put("FERRALSOL", "Suelos tropicales rojos y amarillos con un alto contenido de sesquióxidos; tienen material fuertemente intemperizado sobre geoformas "
            + "viejas pero estables; su desarrollo es más rápido sobre material intemperizado de rocas básicas que sobre material silíceo. Presentan buena profundidad, "
            + "permeabilidad y microestructura estable, lo cual hace a los Ferralsoles menos susceptibles a la erosión que la mayoría de los suelos tropicales intensamente degradados.");
        edafologiaDefinitions.put("FLUVISOL", "Suelos con abundantes sedimentos fluviales, marinos o lacustres en periodos recientes y que están tradicionalmente sobre planicies de inundación, "
            + "abanicos de ríos o marismas costeras. Tienen buena fertilidad natural y son atractivos históricamente para los asentamientos humanos de nuestro país. "
            + "Los Fluvisoles con influencia de marea son suelos ecológicamente valiosos en los que la vegetación original debe preservarse. Se localizan principalmente en las "
            + "llanuras intermontanas y valles abiertos o ramificados de Coahuila, Nuevo León, Sonora y la Península de Baja California, así como en el área de influencia de los "
            + "principales ríos de Sinaloa, Veracruz y Chiapas.");
        edafologiaDefinitions.put("GLEYSOL", "Suelos propios de humedales y que bajo condiciones naturales están afectados por agua subterránea en los primeros 50 cm de profundidad. "
            + "Presentan manchas azulverdosas o negruzcas que denotan presencia de sulfuro de hierro o metano. También presentan manchas rojas en el periodo seco cuando los "
            + "agregados son expuestos al aire y el hierro es oxidado. El encalado y el drenaje combinados son prácticas que aumentan la disponibilidad de nutrientes y "
            + "carbono orgánico, así como disminuyen la toxicidad por aluminio en el suelo. El área más extensa de Gleysoles se encuentra en los pantanos tabasqueños, "
            + "la llanura costera veracruzana y hondonadas del estado de Campeche. Los Gleysoles son aprovechados en México como pastizales cultivados y por su extensión "
            + "constituyen una fuente importante de carbono especialmente en la vegetación de tular, manglar y popal.");
        edafologiaDefinitions.put("GYPSISOL", "Suelos con más del 5% de yeso (sulfato de calcio) en por lo menos una capa de 15 cm de espesor. Se encuentran en las zonas más secas de los "
            + "climas áridos. Los Gypsisoles situados en depósitos aluviales y coluviales jóvenes son mejor aprovechados para la agricultura por su contenido de yeso "
            + "relativamente menor. Grandes áreas de estos suelos se usan para pastizales de bajo volumen. El agua de riego y el drenaje combinado son prácticas regularmente "
            + "favorables. De lo contrario el riego provoca corrosión, formación de cuevas y subsidencia irregular de la superficie de la tierra. "
            + "Estos suelos son representativos en el Bolsón de Mapimí y en llanuras desérticas en Coahuila, Nuevo León y San Luis Potosí. "
            + "El campo de dunas de yeso más famoso en México se ubica en Cuatro Ciénegas, Coahuila.");
        edafologiaDefinitions.put("HISTOSOL", "Suelos con capas orgánicas de espesor mayor a 10 cm. Los restos orgánicos son acumulados en cualquier condición de humedad y presentan una "
            + "concentración mayor al 18% de carbono orgánico. Son suelos de alto valor ecológico debido a sus propiedades de absorción de humedad. "
            + "Se localizan en las llanuras costeras inundables o con ciénegas de la península de Yucatán, especialmente bajo vegetación hidrófila, de petén y algunas "
            + "selvas medianas subperennifolias. También pueden encontrarse como relictos en algunas regiones lacustres de Michoacán, Estado de México y Distrito Federal, "
            + "soportando agricultura bajo sistema de riego. Se caracterizan por tener altas cantidades de hojarasca, fibras, madera o humus. Ocasionalmente huelen a podrido y "
            + "presentan acumulación de salitre.");
        edafologiaDefinitions.put("KASTAÑOZEM", "Suelos de clima árido o semiárido, con una capa superficial gruesa de color pardo oscuro y rica en carbono orgánico, ricos en magnesio, "
            + "potasio y carbonatos en el subsuelo. Requieren fertilizantes fosfatados y un buen programa de riego que evite riesgos de salinización. "
            + "Son susceptibles a la erosión hídrica y eólica especialmente si son terrenos agrícolas en descanso o tierras de sobrepastoreo. Los Kastanozems se "
            + "encuentran situados principalmente en el Bolsón de Mapimí, las llanuras de Coahuila, Nuevo León, San Luis Potosí y Zacatecas. Tanto el "
            + "clima como el uso principal de este suelo son similares al del Chernozem, aunque con una mayor proporción de matorrales desérticos de tipo micrófilo, "
            + "tamaulipeco y rosetófilo.");
        edafologiaDefinitions.put("LEPTOSOL", "Actualmente representan suelos con menos de 25 cm de espesor o con más de 80% de su volumen ocupado por piedras o gravas. "
            + "Son muy susceptibles a la erosión. Se localizan generalmente en las zonas montañosas con más de 40% de pendiente como la sierra La Giganta, Del Burro, "
            + "La Paila, San Carlos, del Pinacate y la Sierra Lacandona. También son abundantes en la Mixteca Alta Oaxaqueña, el Carso Huasteco, "
            + "al pie de la Sierra Madre Occidental y en todos los sistemas de cañones. Un caso particular son los extensos afloramientos calizos encontrados en la Península de Yucatán. "
            + "Los tipos de vegetación más relacionados con los afloramientos rocosos son el matorral desértico rosetófilo, la selva baja caducifolia y el bosque de encino. "
            + "El uso principal de este suelo es para agostadero.");
        edafologiaDefinitions.put("LIXISOL", "Suelos con arcillas de baja actividad que son fuertemente susceptibles a la erosión por deforestación. "
            + "Requieren aplicación continua de fertilizantes cuando son destinados a la actividad agrícola. Los Lixisoles se encuentran en regiones cálidas templadas, "
            + "tropicales y subtropicales, estacionalmente secas. Dichas áreas son comúnmente usadas para pastizales de bajo volumen. En México se encuentran en una zona "
            + "transicional entre los Luvisoles y los Acrisoles.");
        edafologiaDefinitions.put("LUVISOL", "Suelos rojos, grises o pardos claros, susceptibles a la erosión especialmente aquellos con alto contenido de arcilla y los situados en pendientes fuertes. "
            + "Los Luvisoles son generalmente fértiles para la agricultura. Son el quinto grupo de suelos más extendido sobre nuestro país y su distribución abarca superficies de "
            + "bosques de pino en la Sierra Madre Occidental, extensas áreas de profundidad limitada en la Mesa del Centro, así como importantes superficies de pastizal en la "
            + "llanura costera del Golfo.");
        edafologiaDefinitions.put("NITISOL", "Suelos tropicales profundos, intensamente rojos o amarillos, con arcillas de alta capacidad de retención de humedad y con "
            + "agregados brillantes fuertemente estructurados. Pueden ser los suelos más productivos de los trópicos húmedos por su profundidad y capacidad de enraizamiento, "
            + "son moderadamente estables frente a la erosión. Los Nitisoles se cultivan con éxito en plantaciones como: cacao, tabaco, café y caucho, especialmente "
            + "aquellos fertilizados adicionalmente con fósforo. Su distribución en México está restringida a la zona volcánica nayarita y a las zonas más profundas del "
            + "norte de Campeche y sur de Yucatán.");
        edafologiaDefinitions.put("PHAEOZEM", "Suelos de clima semiseco y subhúmedo, de color superficial pardo a negro, fértiles en magnesio, potasio y sin carbonatos en el subsuelo. "
            + "El relieve donde se desarrollan estos suelos es generalmente plano o ligeramente ondulado. En México constituyen los suelos más importantes para la agricultura, "
            + "por ejemplo, en los Altos de Jalisco, las llanuras de Querétaro, Hidalgo y norte de Guanajuato, en la Gran Meseta Chihuahuense, al pie de la Sierra Madre Occidental "
            + "y en numerosos valles del sur y sureste de México.");
        edafologiaDefinitions.put("PLANOSOL", "Suelos con un horizonte de textura gruesa abruptamente sobre un subsuelo denso y de textura más fina. Se encuentran típicamente en tierras planas de "
            + "pastizales que durante algún periodo del año están cubiertas por agua. Presentan manchas rojas en la época de sequía. Son poco fértiles, comúnmente con arbustos "
            + "dispersos y sistemas de raíces someros. Se distribuyen principalmente en las llanuras de piso cementado, llanuras de aluvión antiguo y extensas mesetas basálticas o "
            + "escalonadas del estado de Jalisco y Aguascalientes. En México se utilizan con rendimientos moderados en la ganadería de bovinos, ovinos y "
            + "caprinos del centro y norte del país. Son muy susceptibles a la erosión.");
        edafologiaDefinitions.put("PLINTHOSOL", "Suelos ricos en plintita. La plintita es una mezcla rica en óxidos de hierro y arcilla caolinítica que generalmente es pobre en humus "
            + "y que en ambientes de humedad y sequía repetida forma nódulos, concreciones o cementaciones difíciles de romper. Su ubicación geográfica está enfocada al límite "
            + "entre el trópico húmedo y subhúmedo. Presentan considerables problemas de manejo, son poco fértiles y limitan fuertemente el volumen de enraizamiento "
            + "cuando están endurecidos en el subsuelo. Desde el punto de vista económico son suelos valiosos para la cerámica y la industria de la construcción. "
            + "Ocasionalmente constituyen reservas valiosas de hierro, aluminio, manganeso y titanio. En México se encuentran identificados en los estados de Chiapas y Tabasco.");
        edafologiaDefinitions.put("PODZOL", "Suelos con un horizonte eluvial que tiene la apariencia de ceniza, con materiales intemperizados de roca silícea, depósitos aluviales "
            + "y eólicos de arenas de cuarzo. Se encuentran principalmente en las zonas templadas y boreales del hemisferio Norte de tierras planas a montañosas y bosques de "
            + "coníferas; en los trópicos húmedos bajo bosque ligero. Los Podzoles en regiones de latitudes altas tienen condiciones climáticas poco atractivas "
            + "para la mayoría de usos de suelo agrícolas, en regiones templadas éstos se recuperan con mayor frecuencia para el uso cultivable. "
            + "En México se han localizado de forma puntual únicamente en la sierra norte de Oaxaca, donde la precipitación supera los 4 000 mm anuales.");
        edafologiaDefinitions.put("REGOSOL", "Suelos con propiedades físicas o químicas insuficientes para colocarlos en otro grupo de suelos. Son pedregosos, de color claro "
            + "en general y se parecen bastante a la roca que les ha dado origen cuando no son profundos. Son comunes en las regiones montañosas o áridas de México, "
            + "asociados frecuentemente con Leptosoles.");
        edafologiaDefinitions.put("RETISOL", "Suelos de llanuras planas a onduladas bajo bosque de coníferas o bosque mixto. La capacidad agrícola de los Retisoles es limitada "
            + "debido a su acidez, bajos niveles de nutrientes, problemas de labranza y drenaje; para muchos además, su posición típica en zonas "
            + "con heladas severas durante un largo invierno. La ganadería es el principal uso de la tierra agrícola (producción de leche y cría de ganado); "
            + "cultivos herbáceos (cereales, patatas, remolacha y maíz forrajero) desempeñan un papel menor. En México no existen registros.");
        edafologiaDefinitions.put("SOLONCHAK", "Suelos con enriquecimiento en sales fácilmente solubles en algún momento del año, formadas en ambientes de elevada evapotranspiración. "
            + "Las sales son apreciables cuando el suelo está seco y en la mayoría de las veces precipitan en la superficie formando una costra de sal. Las sales afectan la "
            + "absorción de agua por las plantas y afectan el metabolismo del nitrógeno. Algunos métodos de control son el riego y uso de yeso combinado. "
            + "Existen dos patrones de distribución principal: los Solonchaks de influencia marina, especialmente en los deltas del río grande de Santiago, Altar y "
            + "San Sebastián Vizcaíno, diversos deltas de Sonora y Sinaloa. Los Solonchaks continentales con extrema evapotranspiración, por ejemplo: en la Laguna de Mayrán y "
            + "las Sierras Transversales de la Sierra Madre Oriental; además de compartir los mismos tipos de vegetación que los Solonetz.");
        edafologiaDefinitions.put("SOLONETZ", "Suelos fuertemente alcalinos, que presentan en el subsuelo capas endurecidas con estructura columnar o prismática y alto "
            + "contenido de arcilla unido a niveles de sodio o magnesio intercambiable muy elevados para la mayoría de los cultivos agrícolas. "
            + "Están relacionados con clima seco caluroso y con depósitos costeros con alta concentración de sodio. En México existen registros de Solonetz profundos "
            + "asistidos por riego que tienen éxito agrícola; para ello ha sido necesario mejorar la estructura y porosidad a través de la aplicación de residuos orgánicos y "
            + "riego con agua rica en calcio. Suelos representativos de las llanuras y médanos del norte de Chihuahua y de la Laguna de Mayrán en Coahuila, donde el clima seco "
            + "y la vegetación de tipo halófilo o áreas sin vegetación son dominantes.");
        edafologiaDefinitions.put("STAGNOSOL", "Suelos con agua retenida periódicamente, tienen una amplia variedad de materiales no consolidados incluyendo glaciar, depósitos aluviales, coluviales, "
            + "materiales intemperizados; son más comunes en tierras planas, de regiones de climas templados o subtropicales con condiciones climáticas húmedas. "
            + "El potencial agrícola de los Stagnosoles está limitado debido a su falta de oxígeno, resultante del estancamiento del agua por encima de un denso subsuelo. "
            + "En la temporada de lluvias estos suelos son demasiado húmedos o bien pueden ser demasiados secos para la producción de cultivos en la estación seca. "
            + "En México se identifican en algunas áreas de Tabasco.");
        edafologiaDefinitions.put("TECHNOSOL", "Suelos dominados o fuertemente influenciados por todo tipo de material hecho o expuesto por la actividad humana que de otro modo no se "
            + "produciría en la superficie de la tierra; la edafogénesis en estos suelos se ve fuertemente afectada por los materiales y su organización, se encuentra "
            + "principalmente en áreas urbanas e industriales, donde la actividad humana ha propiciado la construcción de suelo artificial, sellado del suelo natural o "
            + "la extracción de material. De este modo, las ciudades, carreteras, minas, basureros, derrames de petróleo, el carbón de depósito de cenizas y similares "
            + "está incluido en Technosoles. Se ven fuertemente afectados por la naturaleza del material o de la actividad humana. Es probable que éstos contengan "
            + "más sustancias tóxicas que otros grupos de suelos y deben ser tratados con cuidado.");
        edafologiaDefinitions.put("UMBRISOL", "Suelos oscuros y ácidos en la superficie, de clima húmedo o subhúmedo, en ambiente montañoso. Son susceptibles a la erosión "
            + "por efecto de la deforestación del bosque o selva. Estos suelos se encuentran usualmente en dos grandes regiones: altas de bosques templados y bajas en las llanuras "
            + "costeras donde la precipitación es abundante.");
        edafologiaDefinitions.put("VERTISOL", "Suelos llamados pesados, se crean bajo condiciones alternadas de saturación-sequía, se forman grietas anchas, abundantes y profundas cuando están secos y con "
            + "más de 30% de arcillas expandibles. Mediante un buen programa de labranza y drenaje son bastante fértiles para la agricultura por "
            + "su alta capacidad de retención de humedad y sus propiedades de intercambio mineral con las plantas. Las obras de construcción "
            + "asentadas sobre estos suelos deben tener especificaciones especiales para evitar daños por movimiento o inundación. Son bastante estables frente a la erosión y tienen "
            + "buen amortiguamiento contra sustancias tóxicas. Se encuentran frecuentemente en las zonas agrícolas de regadío del país, "
            + "como los bajíos de Michoacán, Guanajuato y Campeche, la región de Chapala, la depresión de Tepalcatepec y las fértiles llanuras "
            + "costeras de Sonora, Sinaloa, Tamaulipas y Veracruz así como en llanuras intermontanas de San Luis Potosí y Tamaulipas.");
    }

    @Override
    public void init() {
        // Registra el controlador de PostgreSQL
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("No se pudo cargar el controlador de PostgreSQL", e);
        }

        // Configuración de HikariCP
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:postgresql://10.153.3.25:5434/db_seguimientos");
        config.setUsername("us_seguimientos");
        config.setPassword("normAcAt");
        config.addDataSourceProperty("cachePrepStmts", "true");
        config.addDataSourceProperty("prepStmtCacheSize", "250");
        config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
        dataSource = new HikariDataSource(config);

        // Inicializar el ExecutorService
        executorService = Executors.newFixedThreadPool(10); // Puedes ajustar el tamaño del pool
    }

    @Override
    public void destroy() {
        if (dataSource != null) {
            dataSource.close();
        }
        if (executorService != null) {
            executorService.shutdown();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Establecer la codificación a UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Captura de la información del formulario
        String originalCurt = request.getParameter("curt"); // Guardar CURT original
        String curt = originalCurt;
        
        String distanceStr = request.getParameter("distance");
        int distance = 0;
        try {
            distance = Integer.parseInt(distanceStr);
        } catch (NumberFormatException e) {
            distance = 0; // Manejo adecuado según contexto
        }
        
        // Si la CURT termina en 'P', quítala
        if (curt.endsWith("P")) {
            curt = curt.substring(0, curt.length() - 1);  // Remover la 'P'
        }
        
        // Validar que el CURT tenga 21 dígitos
        if (curt == null || curt.length() != 21 || !curt.matches("\\d{21}")) {
            HttpSession session = request.getSession();
            session.setAttribute("error", "El CURT debe contener exactamente 21 dígitos numéricos.");
            response.sendRedirect("index.jsp");
            return;
        }
        
        // Procesar CURT para obtener y (latitud) y x (longitud)
        String ys = curt.substring(0, 10); // Índices 0 a 9 (10 dígitos)
        String xs = curt.substring(10, 21); // Índices 10 a 20 (11 dígitos)
        
        String ysg = ys.substring(0, 2); // Índices 0 a 1
        String ysm = ys.substring(2, 4); // Índices 2 a 3
        String yss = ys.substring(4, 10); // Índices 4 a 9 (6 dígitos)
        
        int latyyg = Integer.parseInt(ysg);
        int latyym = Integer.parseInt(ysm);
        int latyys = Integer.parseInt(yss);
        
        float latyg = latyyg;
        float latym = latyym;
        
        float latys = latyys;
        float latyss = latys / 10000f;
        float rlatyss = latyss / 60f;
        float sumrlatyss = latyym + rlatyss;
        float divrlatyss = sumrlatyss / 60f;
        
        float y = latyg + divrlatyss;
        
        String xsg = xs.substring(0, 3); // Índices 0 a 2
        String xsm = xs.substring(3, 5); // Índices 3 a 4
        String xss = xs.substring(5, 11); // Índices 5 a 10 (6 dígitos)
        
        int lonxxg = Integer.parseInt(xsg);
        int lonxxm = Integer.parseInt(xsm);
        int lonxxs = Integer.parseInt(xss);
        
        float lonxg = lonxxg;
        float lonxm = lonxxm;
        
        float lonxs = lonxxs;
        float lonxss = lonxs / 10000f;
        float rlonxss = lonxss / 60f;
        float sumrlonxss = lonxm + rlonxss;
        float divrlonxss = sumrlonxss / 60f;
        
        float xp = lonxg + divrlonxss;
        float x = -1 * xp;
        
        System.out.println("x: " + x + ", y: " + y);
        
        
 //llamamos al webservice      
try {
    HttpSession session = request.getSession();

    // ----- CATRASTRO -----
    JSONObject catastroJson = CatastroApiClient.consultarCatastro(x, y);
    String catastroCurt  = catastroJson.optString("curt");
    String catastroGeom  = catastroJson.optString("geom");
    String fuente        = catastroJson.optString("fuente");

    System.out.println("Respuesta del servicio Catastro:");
    System.out.println(catastroJson.toString(2));
    System.out.println("Campo 'geom' obtenido:");
    System.out.println(catastroGeom);

    session.setAttribute("catastroCurtResult", catastroCurt != null ? catastroCurt.trim() : "");
    session.setAttribute("catastroGeomResult", catastroGeom != null ? catastroGeom.trim() : "");

    String fuenteNombre = (fuente == null || fuente.trim().isEmpty()) ? "BANOBRAS/SEDESOL" : fuente.trim().toUpperCase();
    String label = "CURT de predio de " + fuenteNombre;
    session.setAttribute("banobras_sedesol_label", label);

   
} catch(Exception e) {
    e.printStackTrace();
    request.getSession().setAttribute("catastro_error", e.getMessage());
}


        
        // Definir las consultas para cada checkbox
        Map<String, LinkedHashMap<String, String>> checkboxQueries = new HashMap<>();
        
        // Ubicación
        LinkedHashMap<String, String> ubicacionQueries = new LinkedHashMap<>();
        ubicacionQueries.put("Entidad", "SELECT nomgeo FROM consulta_curt.entgeo WHERE ST_Intersects(geom, ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326));");
        ubicacionQueries.put("Municipio", "SELECT nomgeo FROM consulta_curt.mungeo WHERE ST_Intersects(geom, ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326));");
        ubicacionQueries.put("Localidad", "SELECT nomgeo, ambito FROM consulta_curt.locgeo WHERE ST_Intersects(geom, ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326));");
        
        // Consulta para Vialidad y Entre Vialidad (subconsulta corregida)
        String queryVialidad = "WITH vialidades_cercanas_sin_repeticiones AS ( " +
                "  SELECT STRING_AGG(vialidad, ', ' ORDER BY st_distance) AS vialidades_cercanas, " +
                "         MIN(primer_nomvial) AS primer_nomvial " +
                "  FROM ( " +
                "    SELECT DISTINCT ON (vialidad) vialidad, primer_nomvial, st_distance " +
                "    FROM ( " +
                "      SELECT l.tipovial, l.nomvial, " +
                "             l.tipovial || ' ' || l.nomvial AS vialidad, " +
                "             FIRST_VALUE(l.tipovial || ' ' || l.nomvial) OVER (ORDER BY ST_Distance(ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326), l.geom)) AS primer_nomvial, " +
                "             ST_Distance(ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326), l.geom) AS st_distance " +
                "      FROM consulta_curt.ejes_de_vialidad AS l " +
                "      WHERE l.nomvial NOT IN ('Ninguno', 'S/N') " +
                "        AND l.tipovial || ' ' || l.nomvial NOT IN ('Calle Ninguno', 'Calle S/N') " +
                "      ORDER BY ST_Distance(ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326), l.geom) ASC " +
                "      LIMIT 10 " +
                "    ) sub_interno " +
                "    WHERE primer_nomvial IS NOT NULL " +
                "  ) sub_intermedio " +
                "  WHERE vialidad <> primer_nomvial OR primer_nomvial IS NULL " +
                ") " +
                "SELECT v.primer_nomvial AS vialidad, v.vialidades_cercanas AS entre_vial " +
                "FROM vialidades_cercanas_sin_repeticiones v;";
        
        ubicacionQueries.put("Vialidad o vía de comunicación", queryVialidad);
        ubicacionQueries.put("Vialidades o vías de comunicación cercanas", queryVialidad);
        
        // Agregar consulta para Asentamiento y Código Postal
        String queryAsentamiento = "SELECT INITCAP(asentamientogeo.tipo || ' ' || asentamientogeo.nom_asen) AS asentamiento, " +
                "       asentamientogeo.cp AS cp " +
                "FROM consulta_curt.asentamientogeo " +
                "WHERE ST_Intersects(ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326), asentamientogeo.geom);";
        ubicacionQueries.put("Colonia o Fraccionamiento", queryAsentamiento);
        ubicacionQueries.put("Código postal", queryAsentamiento);
        ubicacionQueries.put("Nomenclatura Cartográfica Urbana", "SELECT clave FROM consulta_curt.carta1_500 WHERE ST_Intersects(geometry, ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326));");
        ubicacionQueries.put("Nomenclatura Cartográfica Rural", "SELECT clave FROM consulta_curt.carta1_5000 WHERE ST_Intersects(geometry, ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326));");
        checkboxQueries.put("ubicacion", ubicacionQueries);
        
        // Sociodemográficas
        LinkedHashMap<String, String> sociodemograficasQueries = new LinkedHashMap<>();
        String querySociodemograficas = "WITH punto AS (" +
                "    SELECT ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326) AS geom" +
                "), resultado AS (" +
                "    SELECT mza1.pob1, mza1.pob42, mza1.pob84, mza1.pob8, mza1.pob11, mza1.pob14, mza1.pob15, mza1.pob23, mza1.cvegeo " +
                "    FROM consulta_curt.mza_since_part_1 AS mza1, punto " +
                "    WHERE ST_Intersects(punto.geom, mza1.geometry) " +
                "    UNION ALL " +
                "    SELECT mza2.pob1, mza2.pob42, mza2.pob84, mza2.pob8, mza2.pob11, mza2.pob14, mza2.pob15, mza2.pob23, mza2.cvegeo " +
                "    FROM consulta_curt.mza_since_part_2 AS mza2, punto " +
                "    WHERE ST_Intersects(punto.geom, mza2.geometry) " +
                "    UNION ALL " +
                "    SELECT mza3.pob1, mza3.pob42, mza3.pob84, mza3.pob8, mza3.pob11, mza3.pob14, mza3.pob15, mza3.pob23, mza3.cvegeo " +
                "    FROM consulta_curt.mza_since_part_3 AS mza3, punto " +
                "    WHERE ST_Intersects(punto.geom, mza3.geometry) " +
                "    UNION ALL " +
                "    SELECT mza4.pob1, mza4.pob42, mza4.pob84, mza4.pob8, mza4.pob11, mza4.pob14, mza4.pob15, mza4.pob23, mza4.cvegeo " +
                "    FROM consulta_curt.mza_since_part_4 AS mza4, punto " +
                "    WHERE ST_Intersects(punto.geom, mza4.geometry) " +
                ") SELECT * FROM resultado LIMIT 1;";
        sociodemograficasQueries.put("Sociodemográficas", querySociodemograficas);
        checkboxQueries.put("sociodemograficas", sociodemograficasQueries);
        
        // Usos de Suelo
        LinkedHashMap<String, String> usosSueloQueries = new LinkedHashMap<>();
        String queryUsoSuelo = "SELECT INITCAP(usodesuelogeo.descripcio) AS uso_suelo " +
                "FROM consulta_curt.usodesuelogeo " +
                "WHERE ST_Intersects(ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326), usodesuelogeo.geom);";
        usosSueloQueries.put("Uso de Suelo", queryUsoSuelo);
        checkboxQueries.put("usosSuelo", usosSueloQueries);
        
        // Unidades Económicas
        LinkedHashMap<String, String> unidadesEconomicasQueries = new LinkedHashMap<>();
        Map<String, String> tablasUnidadesEconomicas = new LinkedHashMap<>();
        tablasUnidadesEconomicas.put("Instituciones Gubernamentales", "actividad_legislativa_de_imparticion_justicia");
        tablasUnidadesEconomicas.put("Establecimientos con Ventas al por Mayor", "comercio_al_por_mayor");
        tablasUnidadesEconomicas.put("Establecimientos con Ventas al por Menor", "comercio_al_por_menor");
        tablasUnidadesEconomicas.put("Establecimientos Dedicados a la Venta de Material para la Construcción", "construccion");
        tablasUnidadesEconomicas.put("Lugares Dedicados a la Generación, Transmisión y Distribución de Energía Electrica", "distrib_ener_elect");
        tablasUnidadesEconomicas.put("Industrias Manufactureras", "industrias_manufactureras");
        tablasUnidadesEconomicas.put("Medios de Comunicación", "inf_med_mas");
        tablasUnidadesEconomicas.put("Minas", "mineria");
        tablasUnidadesEconomicas.put("Otros Establecimientos de Servicios", "otros_serv");
        tablasUnidadesEconomicas.put("Establecimientos Dedicados a los Servicios de Alojamiento y Alimentos", "serv_aloja");
        tablasUnidadesEconomicas.put("Lugares Dedicados a los Servicios de Apoyo a los Negocios", "serv_apoyo");
        tablasUnidadesEconomicas.put("Lugares Dedicados a los Servicios de Salud y Asistencia Social", "serv_salud");
        tablasUnidadesEconomicas.put("Lugares Dedicados a los Servicios Educativos", "serv_edu");
        tablasUnidadesEconomicas.put("Lugares Dedicados a los Servicios Culturales, Deportivos y Recreativos", "serv_dep");
        tablasUnidadesEconomicas.put("Establecimientos Dedicados a los Servicios Financieros y de Seguros", "serv_finan");
        tablasUnidadesEconomicas.put("Establecimientos Dedicados a los Servicios Inmobiliarios y de Alquiler de Bienes", "serv_inmob");
        tablasUnidadesEconomicas.put("Lugares Dedicados a los Servicios Profesionales, Científicos y Técnicos", "serv_prof");
        tablasUnidadesEconomicas.put("Lugares Dedicados a los Servicios de Transporte, Correos y Almacenamiento", "serv_trans");
        for (Map.Entry<String, String> entry : tablasUnidadesEconomicas.entrySet()) {
            String descripcion = entry.getKey();
            String nombreTabla = entry.getValue();
            String queryEcon = "WITH punto AS (" +
                    "    SELECT ST_Transform(ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326), 32614) AS geom" +
                    ") " +
                    "SELECT " +
                    "    INITCAP(" + nombreTabla + ".nom_estab) AS nom_estab_capitalizado, " +
                    "    INITCAP(" + nombreTabla + ".nombre_act) AS nombre_act_capitalizado, " +
                    "    ST_Distance(ST_Transform(" + nombreTabla + ".geometry, 32614), punto.geom) AS distancia " +
                    "FROM consulta_curt." + nombreTabla + ", punto " +
                    "WHERE ST_DWithin(ST_Transform(" + nombreTabla + ".geometry, 32614), punto.geom, " + distance + ") " +
                    "  AND " + nombreTabla + ".nom_estab NOT ILIKE '%ninguno%' " +
                    "  AND " + nombreTabla + ".nom_estab NOT ILIKE '%S/N%' " +
                    "ORDER BY distancia;";
            unidadesEconomicasQueries.put(descripcion, queryEcon);
        }
        checkboxQueries.put("unidadesEconomicas", unidadesEconomicasQueries);
        
        // Edafología
        LinkedHashMap<String, String> edafologiaQueries = new LinkedHashMap<>();
        String queryEdafologia = "SELECT n_g1, n_g2, n_g3 FROM consulta_curt.unidad_edafologica WHERE ST_Intersects(geometry, ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326));";
        edafologiaQueries.put("Edafología", queryEdafologia);
        checkboxQueries.put("edafologia", edafologiaQueries);
        
        // Clima
        LinkedHashMap<String, String> climaQueries = new LinkedHashMap<>();
        String queryClima = "SELECT tipo_c FROM consulta_curt.climageo WHERE ST_Intersects(geom, ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326));";
        climaQueries.put("Tipo de Clima", queryClima);
        checkboxQueries.put("clima", climaQueries);
        
        // Cuerpos de Agua
        LinkedHashMap<String, String> cuerposAguaQueries = new LinkedHashMap<>();
        Map<String, String> tablasCuerposAgua = new LinkedHashMap<>();
        tablasCuerposAgua.put("Arroyos", "arroyo");
        tablasCuerposAgua.put("Estanques", "estanque");
        tablasCuerposAgua.put("Lagos", "lago");
        tablasCuerposAgua.put("Lagunas", "laguna");
        tablasCuerposAgua.put("Ríos", "rio");
        tablasCuerposAgua.put("Presas", "presa");
        tablasCuerposAgua.put("Bordos", "bordo");
        for (Map.Entry<String, String> entry : tablasCuerposAgua.entrySet()) {
            String descripcion = entry.getKey();
            String nombreTabla = entry.getValue();
            String queryAgua = "WITH punto AS (" +
                    "    SELECT ST_Transform(ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326), 32614) AS geom" +
                    ") " +
                    "SELECT " +
                    "    " + nombreTabla + ".nombre AS nombre, " +
                    "    ST_Distance(ST_Transform(" + nombreTabla + ".geometry, 32614), punto.geom) AS distancia " +
                    "FROM consulta_curt." + nombreTabla + ", punto " +
                    "WHERE ST_DWithin(ST_Transform(" + nombreTabla + ".geometry, 32614), punto.geom, " + distance + ") " +
                    "  AND " + nombreTabla + ".nombre NOT ILIKE '%ninguno%' " +
                    "  AND " + nombreTabla + ".nombre NOT ILIKE '%NINGUNO%' " +
                    "  AND " + nombreTabla + ".nombre NOT ILIKE '%S/N%' " +
                    "ORDER BY distancia;";
            cuerposAguaQueries.put(descripcion, queryAgua);
        }
        checkboxQueries.put("cuerposAgua", cuerposAguaQueries);
        
        // Geología
        LinkedHashMap<String, String> geologiaQueries = new LinkedHashMap<>();
        String queryUnidadRoca = "SELECT tipo, descripcion FROM consulta_curt.unidad_de_roca WHERE ST_Intersects(geometry, ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326));";
        geologiaQueries.put("Unidad de roca", queryUnidadRoca);
        String queryFallasCercanas = "WITH punto AS (" +
                "    SELECT ST_Transform(ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326), 32614) AS geom" +
                ") " +
                "SELECT COUNT(*) AS num_fallas FROM consulta_curt.fallas_geo, punto " +
                "WHERE ST_DWithin(ST_Transform(fallas_geo.geometry, 32614), punto.geom, " + distance + ");";
        geologiaQueries.put("Número de fallas cercanas", queryFallasCercanas);
        checkboxQueries.put("geologia", geologiaQueries);
        
        // Gestión de Tierras
        LinkedHashMap<String, String> gestionTierrasQueries = new LinkedHashMap<>();
        String queryAreasProtegidas = "SELECT nombre, cat_decret FROM consulta_curt.areas_protegidas WHERE ST_Intersects(geometry, ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326));";
        gestionTierrasQueries.put("Áreas Protegidas", queryAreasProtegidas);
        String queryFronteras = "SELECT control FROM consulta_curt.fronteras WHERE ST_Intersects(geometry, ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326));";
        gestionTierrasQueries.put("Frontera", queryFronteras);
        String[] parcelasTablas = {
            "parcelas_ags", "parcelas_bc", "parcelas_bcs", "parcelas_campeche", "parcelas_cdmx",
            "parcelas_chiapas", "parcelas_chihuahua", "parcelas_coahuila", "parcelas_colima", "parcelas_durango",
            "parcelas_edomex", "parcelas_guanajuato", "parcelas_guerrero", "parcelas_hidalgo", "parcelas_jalisco",
            "parcelas_michoacan", "parcelas_morelos", "parcelas_nayarit", "parcelas_nl", "parcelas_oaxaca",
            "parcelas_puebla", "parcelas_qroo", "parcelas_queretaro", "parcelas_sinaloa", "parcelas_slp",
            "parcelas_sonora", "parcelas_tabasco", "parcelas_tamaulipas", "parcelas_tlaxcala", "parcelas_veracruz",
            "parcelas_yucatan", "parcelas_zacatecas"
        };
        for (String tabla : parcelasTablas) {
            String campoGeometria = "geometry";
            if (tabla.equals("parcelas_ags")) {
                campoGeometria = "geom";
            }
            String queryParcelas = "SELECT des_tcerti, curt AS curt_parcela, ST_AsGeoJSON(" + campoGeometria + ") AS geom_json FROM consulta_curt." + tabla + " " +
                                   "WHERE ST_Intersects(" + campoGeometria + ", ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326));";
            gestionTierrasQueries.put(tabla, queryParcelas);
        }
        
String queryPrediosProcesados =
    "SELECT curt AS curt_procesada, " +
    "       idue, " +
    "       nombre_unidad_estatal, " +
    "       anio_generacion, " +
    "       ST_AsGeoJSON(geom) AS geom_json " +
    "FROM dblink(" +
    "    'host=10.153.3.21 port=5433 dbname=curt user=user_prod_consulta password=Us3r_C0ns', " +
    "    $$" +
    "    SELECT p.curt, p.idue, u.nombre AS nombre_unidad_estatal, " +
    "           substring(p.fecha_generacion from 1 for 4) AS anio_generacion, " +
    "           ST_Transform(p.the_geom_3857, 4326) AS geom " +
    "    FROM registrocurt.tr_predios_procesados p " +
    "    LEFT JOIN registrocurt.tr_ue u ON p.idue = u.idue " +
    "    WHERE ST_Intersects(ST_Transform(p.the_geom_3857, 4326), ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326)) " +
    "    $$" +
    ") AS resultado(curt VARCHAR, idue INTEGER, nombre_unidad_estatal VARCHAR, anio_generacion VARCHAR, geom geometry);";


gestionTierrasQueries.put("Intersección con predios procesados", queryPrediosProcesados);


String queryRnig =
    "SELECT curt AS curt_rnig, " +
    "       anio_exporta, " +
    "       institucion, " +
    "       ST_AsGeoJSON(geometria) AS geometria_json " +
    "FROM dblink(" +
    "  'host=10.153.3.25 port=5434 dbname=db_directorio user=serv_wms password=serv_2025', " +
    "  $$ " +
    "    SELECT \"CURT\" AS curt, " +
    "           anio_exporta, " +
    "           institucion, " +
    "           geometria " +
    "    FROM inf_vec_cat.predios_temp " +
    "    WHERE ST_Contains(geometria, ST_Transform(ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326), ST_SRID(geometria))) " +
    "    LIMIT 1 " +
    "  $$" +
    ") AS resultado(curt VARCHAR, anio_exporta INTEGER, institucion VARCHAR, geometria geometry);";

gestionTierrasQueries.put("CURT_RNIG", queryRnig);



        
        String queryTierraUsoComun = "SELECT 'Tierra de uso común' AS tipo, curt AS curt_tierra, ST_AsGeoJSON(geometry) AS geom_json " +
                             "FROM consulta_curt.tierras_uso_comun " +
                             "WHERE ST_Intersects(geometry, ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326));";
        gestionTierrasQueries.put("Tierras de uso común", queryTierraUsoComun);

        checkboxQueries.put("gestionTierras", gestionTierrasQueries);
        
        
        LinkedHashMap<String, String> geodesiaQueries = new LinkedHashMap<>();
        String queryGeodesia = "WITH punto AS (" +
                "    SELECT ST_Transform(ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326), 32614) AS geom" +
                ") " +
                "SELECT ST_Y(ST_Transform(bancos_de_nivel.geometry, 4326)) AS latitud_banco, " +
                "       ST_X(ST_Transform(bancos_de_nivel.geometry, 4326)) AS longitud_banco, " +
                "       bancos_de_nivel.alt_ortom, " +
                "       ST_Distance(ST_Transform(punto.geom, 32614), ST_Transform(bancos_de_nivel.geometry, 32614)) AS distancia " +
                "FROM consulta_curt.bancos_de_nivel, punto " +
                "ORDER BY distancia ASC " +
                "LIMIT 1;";
        geodesiaQueries.put("Banco de Nivel más cercano", queryGeodesia);
        String queryGeodesiaEstacionGravimetrica = "WITH punto AS ( " +
                "    SELECT ST_Transform(ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326), 32614) AS geom " +
                ") " +
                "SELECT ST_Y(ST_Transform(estaciones_gravimetricas.geometry, 4326)) AS latitud_estacion, " +
                "       ST_X(ST_Transform(estaciones_gravimetricas.geometry, 4326)) AS longitud_estacion, " +
                "       estaciones_gravimetricas.gravedad, " +
                "       ST_Distance(ST_Transform(punto.geom, 32614), ST_Transform(estaciones_gravimetricas.geometry, 32614)) AS distancia " +
                "FROM consulta_curt.estaciones_gravimetricas, punto " +
                "ORDER BY distancia ASC " +
                "LIMIT 1;";
        geodesiaQueries.put("Estación Gravimétrica más cercana", queryGeodesiaEstacionGravimetrica);
        String queryGeodesiaVertice = "WITH punto AS ( " +
                "    SELECT ST_Transform(ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326), 32614) AS geom " +
                ") " +
                "SELECT ST_Y(ST_Transform(vertices_de_posicionamiento.geometry, 4326)) AS latitud_vertice, " +
                "       ST_X(ST_Transform(vertices_de_posicionamiento.geometry, 4326)) AS longitud_vertice, " +
                "       ST_Distance(ST_Transform(punto.geom, 32614), ST_Transform(vertices_de_posicionamiento.geometry, 32614)) AS distancia " +
                "FROM consulta_curt.vertices_de_posicionamiento, punto " +
                "ORDER BY distancia ASC " +
                "LIMIT 1;";
        geodesiaQueries.put("Vértice de posicionamiento más cercano", queryGeodesiaVertice);
        checkboxQueries.put("geodesia", geodesiaQueries);
        LinkedHashMap<String, String> configuracionterrenoQueries = new LinkedHashMap<>();
        String[] pendientesTablas = {
            "pendientes_ags", "pendientes_bc", "pendientes_bcs", "pendientes_cam", "pendientes_cdmx", 
            "pendientes_chiapas", "pendientes_chihuahua", "pendientes_coahuila", "pendientes_colima", 
            "pendientes_durango", "pendientes_edomx", "pendientes_guanajuato", "pendientes_guerrero", 
            "pendientes_hidalgo", "pendientes_jalisco", "pendientes_michoacan", "pendientes_morelos", 
            "pendientes_nayarit", "pendientes_nl", "pendientes_oaxaca", "pendientes_puebla", 
            "pendientes_qroo", "pendientes_queretaro", "pendientes_sinaloa", "pendientes_slp", 
            "pendientes_sonora", "pendientes_tabasco", "pendientes_tamaulipas", "pendientes_tlaxcala", 
            "pendientes_veracruz", "pendientes_yucatan", "pendientes_zacatecas"
        };
        for (String tabla : pendientesTablas) {
            String campoGeometria = "geometry";
            String queryPendientes = "SELECT porcentaje FROM consulta_curt." + tabla + " " +
                                   "WHERE ST_Intersects(" + campoGeometria + ", ST_SetSRID(ST_MakePoint(" + x + ", " + y + "), 4326));";
            configuracionterrenoQueries.put(tabla, queryPendientes);
        }
        checkboxQueries.put("configuracionTerreno", configuracionterrenoQueries);
        Map<String, Map<String, List<String>>> resultsMap = new ConcurrentHashMap<>();
        Set<String> selectedCheckboxes = new HashSet<>();
        for (String checkboxName : checkboxQueries.keySet()) {
            String param = request.getParameter(checkboxName);
            if (param != null && param.equalsIgnoreCase("on")) {
                selectedCheckboxes.add(checkboxName);
            }
        }

        
        List<Future<Void>> futuresList = new ArrayList<>();
        HttpSession session = request.getSession();
        for (String checkbox : selectedCheckboxes) {
            Map<String, String> queries = checkboxQueries.get(checkbox);
            if (queries != null) {
                Map<String, List<String>> categoryResults = new ConcurrentHashMap<>();
                for (Map.Entry<String, String> entry : queries.entrySet()) {
                    String subcategory = entry.getKey();
                    String sql = entry.getValue();
                    Future<Void> future = executorService.submit(() -> {
                        try (Connection connection = dataSource.getConnection();
                             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                            ResultSet resultSet = preparedStatement.executeQuery();
                            List<String> dataList = new ArrayList<>();
                            if (checkbox.equals("ubicacion")) {
                                if (subcategory.equals("Localidad")) {
                                    if (resultSet.next()) {
                                        String nomgeo = resultSet.getString("nomgeo");
                                        String ambito = resultSet.getString("ambito");
                                        if (nomgeo != null && !nomgeo.trim().isEmpty()) {
                                            categoryResults.put("Localidad", Collections.singletonList(nomgeo));
                                        }
                                        if (ambito != null && !ambito.trim().isEmpty()) {
                                            categoryResults.put("Ámbito", Collections.singletonList(ambito));
                                        }
                                    }
                                } else if (subcategory.equals("Vialidad o vía de comunicación")) {
                                    if (resultSet.next()) {
                                        String vialidad = resultSet.getString("vialidad");
                                        if (vialidad != null && !vialidad.trim().isEmpty()) {
                                            categoryResults.put("Vialidad o vía de comunicación", Collections.singletonList(vialidad));
                                        }
                                    }
                                } else if (subcategory.equals("Vialidades o vías de comunicación cercanas")) {
                                    if (resultSet.next()) {
                                        String entreVial = resultSet.getString("entre_vial");
                                        if (entreVial != null && !entreVial.trim().isEmpty()) {
                                            categoryResults.put("Vialidades o vías de comunicación cercanas", Collections.singletonList(entreVial));
                                        }
                                    }
                                } else if (subcategory.equals("Colonia o Fraccionamiento")) {
                                    if (resultSet.next()) {
                                        String asentamiento = resultSet.getString("asentamiento");
                                        if (asentamiento != null && !asentamiento.trim().isEmpty()) {
                                            categoryResults.put("Colonia o Fraccionamiento", Collections.singletonList(asentamiento));
                                        }
                                    }
                                } else if (subcategory.equals("Código postal")) {
                                    if (resultSet.next()) {
                                        String cp = resultSet.getString("cp");
                                        if (cp != null && !cp.trim().isEmpty() && !cp.equals("00000")) {
                                            categoryResults.put("Código postal", Collections.singletonList(cp));
                                        }
                                    }
                                } else if (subcategory.equals("Nomenclatura Cartográfica Urbana") || subcategory.equals("Nomenclatura Cartográfica Rural")) {
                                    if (resultSet.next()) {
                                        String clave = resultSet.getString("clave");
                                        if (clave != null && !clave.trim().isEmpty()) {
                                            categoryResults.put(subcategory, Collections.singletonList(clave));
                                        }
                                    }
                                } else if (subcategory.equals("Entidad") || subcategory.equals("Municipio")) {
                                    if (resultSet.next()) {
                                        String nomgeo = resultSet.getString("nomgeo");
                                        if (nomgeo != null && !nomgeo.trim().isEmpty()) {
                                            categoryResults.put(subcategory, Collections.singletonList(nomgeo));
                                        }
                                    }
                                }
                            } else if (checkbox.equals("sociodemograficas")) {
                                if (resultSet.next()) {
                                    String pob1 = resultSet.getString("pob1");
                                    String pob42 = resultSet.getString("pob42");
                                    String pob84 = resultSet.getString("pob84");
                                    String pob8 = resultSet.getString("pob8");
                                    String pob11 = resultSet.getString("pob11");
                                    String pob14 = resultSet.getString("pob14");
                                    String pob15 = resultSet.getString("pob15");
                                    String pob23 = resultSet.getString("pob23");
                                    if (pob1 != null && !pob1.trim().isEmpty()) {
                                        categoryResults.put("Población total", Collections.singletonList(pob1));
                                    }
                                    if (pob42 != null && !pob42.trim().isEmpty()) {
                                        categoryResults.put("Población femenina", Collections.singletonList(pob42));
                                    }
                                    if (pob84 != null && !pob84.trim().isEmpty()) {
                                        categoryResults.put("Población masculina", Collections.singletonList(pob84));
                                    }
                                    if (pob8 != null && !pob8.trim().isEmpty()) {
                                        categoryResults.put("Población de 0 a 14 años", Collections.singletonList(pob8));
                                    }
                                    if (pob11 != null && !pob11.trim().isEmpty()) {
                                        categoryResults.put("Población de 15 a 29 años", Collections.singletonList(pob11));
                                    }
                                    if (pob14 != null && !pob14.trim().isEmpty()) {
                                        categoryResults.put("Población de 30 a 49 años", Collections.singletonList(pob14));
                                    }
                                    if (pob15 != null && !pob15.trim().isEmpty()) {
                                        categoryResults.put("Población de 50 a 59 años", Collections.singletonList(pob15));
                                    }
                                    if (pob23 != null && !pob23.trim().isEmpty()) {
                                        categoryResults.put("Población de 60 años y más", Collections.singletonList(pob23));
                                    }
                                }
                            } else if (checkbox.equals("usosSuelo")) {
                                while (resultSet.next()) {
                                    String usoSuelo = resultSet.getString("uso_suelo");
                                    if (usoSuelo != null && !usoSuelo.trim().isEmpty()) {
                                        dataList.add(usoSuelo);
                                    }
                                }
                                if (!dataList.isEmpty()) {
                                    categoryResults.put(subcategory, dataList);
                                }
                            } else if (checkbox.equals("unidadesEconomicas")) {
                                List<String> establecimientoList = new ArrayList<>();
                                while (resultSet.next()) {
                                    String nomEstab = resultSet.getString("nom_estab_capitalizado");
                                    String nombreAct = resultSet.getString("nombre_act_capitalizado");
                                    String resultado = nomEstab;
                                    if (nombreAct != null && !nombreAct.trim().isEmpty()) {
                                        resultado += " (" + nombreAct + ")";
                                    }
                                    if (nomEstab != null && !nomEstab.trim().isEmpty()) {
                                        establecimientoList.add(resultado);
                                    }
                                }
                                if (!establecimientoList.isEmpty()) {
                                    categoryResults.put(subcategory, establecimientoList);
                                }
                            } else if (checkbox.equals("edafologia")) {
                                if (resultSet.next()) {
                                    String nG1 = resultSet.getString("n_g1");
                                    String nG2 = resultSet.getString("n_g2");
                                    String nG3 = resultSet.getString("n_g3");
                                    System.out.println("Valores obtenidos - nG1: '" + nG1 + "', nG2: '" + nG2 + "', nG3: '" + nG3 + "'");
                                    if (nG1 != null && !nG1.trim().isEmpty()) {
                                        String nG1Key = nG1.trim();
                                        System.out.println("nG1Key: '" + nG1Key + "'");
                                        String definition = edafologiaDefinitions.get(nG1Key);
                                        if (definition != null) {
                                            System.out.println("Definición encontrada para '" + nG1Key + "'");
                                        } else {
                                            System.out.println("No se encontró definición para '" + nG1Key + "'");
                                        }
                                        List<String> codeDefList = new ArrayList<>();
                                        codeDefList.add(nG1Key);
                                        codeDefList.add("Definición: " + (definition != null ? definition : "No hay definición disponible para este tipo de suelo."));
                                        categoryResults.put("Suelo dominante", codeDefList);
                                    }
                                    if (nG2 != null && !nG2.trim().isEmpty()) {
                                        String nG2Key = nG2.trim();
                                        System.out.println("nG2Key: '" + nG2Key + "'");
                                        String definition = edafologiaDefinitions.get(nG2Key);
                                        if (definition != null) {
                                            System.out.println("Definición encontrada para '" + nG2Key + "'");
                                        } else {
                                            System.out.println("No se encontró definición para '" + nG2Key + "'");
                                        }
                                        List<String> codeDefList = new ArrayList<>();
                                        codeDefList.add(nG2Key);
                                        codeDefList.add("Definición: " + (definition != null ? definition : "No hay definición disponible para este tipo de suelo."));
                                        categoryResults.put("Suelo secundario", codeDefList);
                                    }
                                    if (nG3 != null && !nG3.trim().isEmpty()) {
                                        String nG3Key = nG3.trim();
                                        System.out.println("nG3Key: '" + nG3Key + "'");
                                        String definition = edafologiaDefinitions.get(nG3Key);
                                        if (definition != null) {
                                            System.out.println("Definición encontrada para '" + nG3Key + "'");
                                        } else {
                                            System.out.println("No se encontró definición para '" + nG3Key + "'");
                                        }
                                        List<String> codeDefList = new ArrayList<>();
                                        codeDefList.add(nG3Key);
                                        codeDefList.add("Definición: " + (definition != null ? definition : "No hay definición disponible para este tipo de suelo."));
                                        categoryResults.put("Suelo terciario", codeDefList);
                                    }
                                }
                            } else if (checkbox.equals("clima")) {
                                if (resultSet.next()) {
                                    String tipoC = resultSet.getString("tipo_c");
                                    if (tipoC != null && !tipoC.trim().isEmpty()) {
                                        dataList.add(tipoC.trim());
                                        categoryResults.put(subcategory, dataList);
                                    }
                                }
                            } else if (checkbox.equals("cuerposAgua")) {
                                while (resultSet.next()) {
                                    String nombre = resultSet.getString("nombre");
                                    if (nombre != null && !nombre.trim().isEmpty()) {
                                        dataList.add(nombre.trim());
                                    }
                                }
                                if (!dataList.isEmpty()) {
                                    categoryResults.put(subcategory, dataList);
                                }
                            } else if (checkbox.equals("geologia")){
                                if (subcategory.equals("Número de fallas cercanas")) {
                                    if (resultSet.next()) {
                                        int numFallas = resultSet.getInt("num_fallas");
                                        System.out.println("numero de fallas: '" + numFallas + "'");
                                        if (numFallas > 0) {
                                            dataList.add(String.valueOf(numFallas));
                                            categoryResults.put(subcategory, dataList);
                                        }
                                    } else {
                                        System.out.println("El ResultSet está vacío para 'Número de fallas cercanas'.");
                                    }
                                } else if (subcategory.equals("Unidad de roca")) {
                                    if (resultSet.next()) {
                                        String tipo = resultSet.getString("tipo");
                                        String descripcion = resultSet.getString("descripcion");
                                        if (tipo != null && !tipo.trim().isEmpty()) {
                                            List<String> codeDefList = new ArrayList<>();
                                            codeDefList.add(tipo.trim());
                                            codeDefList.add("Definición: " + (descripcion != null ? descripcion.trim() : "No hay definición disponible."));
                                            categoryResults.put(subcategory, codeDefList);
                                        }
                                    }
                                }
                            } /* ============================================================== */
/*  GESTIÓN DE TIERRAS                                            */
/* ============================================================== */
else if (checkbox.equals("gestionTierras")) {
    // 1. Áreas protegidas
    if (subcategory.equals("Áreas Protegidas")) {
        while (resultSet.next()) {
            String nombre    = resultSet.getString("nombre");
            String catDecret = resultSet.getString("cat_decret");
            if (nombre != null && !nombre.trim().isEmpty()) {
                String texto = (catDecret == null || catDecret.trim().isEmpty())
                        ? nombre.trim()
                        : nombre.trim() + " (" + catDecret.trim() + ")";
                dataList.add(texto);
            }
        }
        if (!dataList.isEmpty()) {
            categoryResults.put(subcategory, dataList);
        }

    // 2. Frontera
    } else if (subcategory.equals("Frontera")) {
        while (resultSet.next()) {
            String control = resultSet.getString("control");
            if (control != null && !control.trim().isEmpty()) {
                if (control.toLowerCase().contains("frontera")) {
                    dataList.add(
                        "Art. 27 Constitución: "
                      + "En una faja de 100 km a lo largo de las fronteras y 50 km en las playas "
                      + "los extranjeros no pueden adquirir el dominio directo sobre tierras y aguas."
                    );
                } else {
                    dataList.add(control.trim());
                }
            }
        }
        if (!dataList.isEmpty()) {
            categoryResults.put("Frontera", dataList);
        }

    // 3. Predios procesados
    } else if (subcategory.equals("Intersección con predios procesados")) {
    String geomJson = null;
    String nombreUnidad = null;
    String anioGeneracion = null; // <-- Nuevo campo
    while (resultSet.next()) {
        String curtProc = resultSet.getString("curt_procesada");
        System.out.println("curtProc " + curtProc);
        geomJson        = resultSet.getString("geom_json");
        nombreUnidad    = resultSet.getString("nombre_unidad_estatal");
        anioGeneracion  = resultSet.getString("anio_generacion"); // <-- Lee el año
        if (curtProc != null && !curtProc.trim().isEmpty()) {
            dataList.add(curtProc.trim());
        }
    }
    if (!dataList.isEmpty()) {
        categoryResults.put("Derechos_CURT", dataList);
    }
    if (nombreUnidad != null && !nombreUnidad.trim().isEmpty()) {
        List<String> unidadList = new ArrayList<>();
        unidadList.add(nombreUnidad.trim());
        categoryResults.put("NombreUnidadEstatal", unidadList);
    }
    if (anioGeneracion != null && !anioGeneracion.trim().isEmpty()) {
        List<String> anioList = new ArrayList<>();
        anioList.add(anioGeneracion.trim());
        categoryResults.put("Anio_Generacion", anioList); // O el nombre que prefieras
    }
    if (geomJson != null && !geomJson.trim().isEmpty()) {
        session.setAttribute("processedParcelGeometryJson", geomJson);
    }
} else if (subcategory.equals("Tierras de uso común")) {
        String geometryJson = null;
        while (resultSet.next()) {
            String curtTierra = resultSet.getString("curt_tierra");
            geometryJson      = resultSet.getString("geom_json");
            if (curtTierra != null && !curtTierra.trim().isEmpty()) {
                dataList.add(curtTierra.trim());
            }
        }
        if (!dataList.isEmpty()) {
            dataList.add("Tierra de uso común");
            categoryResults.put("Tierras de uso común", dataList);
        }
        if (geometryJson != null && !geometryJson.trim().isEmpty()) {
            session.setAttribute("commonLandGeometryJson", geometryJson);
        }

    // 5. CURT_RNIG (consulta dblink)
    } else if (subcategory.equals("CURT_RNIG")) {
String rnigGeom = null;
    String curtRnig = null, anioExporta = null, institucion = null;
    while (resultSet.next()) {
        curtRnig    = resultSet.getString("curt_rnig");
        anioExporta = resultSet.getString("anio_exporta");
        institucion = resultSet.getString("institucion");
        rnigGeom    = resultSet.getString("geometria_json");
        
        System.out.println("curtRnig " + curtRnig);
    }
    // Guarda el CURT igual que los procesados para que el JSP lo lea igual
    if (curtRnig != null && !curtRnig.trim().isEmpty()) {
        // Clave estándar para derechos
        categoryResults.put("Derechos_CURT_RNIG", Collections.singletonList(curtRnig.trim()));
        // Guarda detalles de RNIG en claves separadas
        categoryResults.put("RNIG_AnioExporta", anioExporta != null ? Collections.singletonList(anioExporta.trim()) : Collections.emptyList());
        categoryResults.put("RNIG_Institucion", institucion != null ? Collections.singletonList(institucion.trim()) : Collections.emptyList());
    }
    if (rnigGeom != null && !rnigGeom.trim().isEmpty()) {
        session.setAttribute("rnigGeometryJson", rnigGeom);
    }

    // 6. Resto de parcelas (derechos/titularidad) — sólo si es tabla de parcelas
    } else if (Arrays.asList(parcelasTablas).contains(subcategory)) {
        List<String> titularidadList = new ArrayList<>();
        List<String> curtParcelaList = new ArrayList<>();
        String parcelGeometryJson    = null;
        while (resultSet.next()) {
            String desTcerti   = resultSet.getString("des_tcerti");
            String curtParcela = resultSet.getString("curt_parcela");
            String geomJson    = resultSet.getString("geom_json");
            if (geomJson != null && !geomJson.trim().isEmpty()) {
                parcelGeometryJson = geomJson.replace("\\", "");
            }
            if (desTcerti != null && !desTcerti.trim().isEmpty()) {
                titularidadList.add(desTcerti.trim());
            }
            if (curtParcela != null && !curtParcela.trim().isEmpty()) {
                curtParcelaList.add(curtParcela.trim());
            }
        }
        if (!titularidadList.isEmpty()) {
            categoryResults.put("Derechos_Titularidad", titularidadList);
        }
        if (!curtParcelaList.isEmpty()) {
            categoryResults.put("CURT_Parcela", curtParcelaList);
        }
        if (parcelGeometryJson != null) {
            session.setAttribute("parcelGeometryJson", parcelGeometryJson);
        }
    }
}


else if (checkbox.equals("geodesia")) {
                                if (subcategory.equals("Banco de Nivel más cercano")) {
                                    if (resultSet.next()) {
        double latitud = resultSet.getDouble("latitud_banco");
        double longitud = resultSet.getDouble("longitud_banco");
        String altOrtom = resultSet.getString("alt_ortom");
        double distancia = resultSet.getDouble("distancia");

        // Imprime para depuración
        System.out.println("latitud: " + latitud);
        System.out.println("longitud: " + longitud);
        System.out.println("altOrtom: " + altOrtom);
        System.out.println("distancia: " + distancia);

        // Formatear la distancia
        String distanciaFormateada = (distancia < 1000)
            ? String.format("%.0f metros", distancia)
            : String.format("%.1f km", distancia / 1000.0);

        // URL para Google Maps
        String googleMapsUrl = "https://www.google.com/maps?q=" + latitud + "," + longitud;

        dataList.add("Ubicación: <a href='" + googleMapsUrl + "' target='_blank'>" + latitud + ", " + longitud + "</a>");
        dataList.add("Altura ortométrica: " + altOrtom + " m");
        dataList.add("Distancia al punto CURT: " + distanciaFormateada);

        categoryResults.put(subcategory, dataList); // ✅ ¡No olvides esto!
    }
                                } else if (subcategory.equals("Estación Gravimétrica más cercana")) {
                                    if (resultSet.next()) {
    double latitud = resultSet.getDouble("latitud_estacion");
    double longitud = resultSet.getDouble("longitud_estacion");
    String gravedad = resultSet.getString("gravedad");
    double distancia = resultSet.getDouble("distancia"); // en metros

    System.out.println("latitud " + latitud);
    System.out.println("longitud " + longitud);
    System.out.println("gravedad " + gravedad);
    System.out.println("distancia (m) " + distancia);

    String googleMapsUrl = "https://www.google.com/maps?q=" + latitud + "," + longitud;
    dataList.add("<a href='" + googleMapsUrl + "' target='_blank'>" + latitud + ", " + longitud + "</a>");
    dataList.add(gravedad + " mGal");
    dataList.add("Distancia al punto CURT: " + String.format("%.1f km", distancia / 1000.0));
}

                                } else if (subcategory.equals("Vértice de posicionamiento más cercano")) {
                                    if (resultSet.next()) {
    double latitud = resultSet.getDouble("latitud_vertice");
    double longitud = resultSet.getDouble("longitud_vertice");
    double distancia = resultSet.getDouble("distancia");

    String distanciaTexto;
    if (distancia >= 1000) {
        distanciaTexto = String.format("%.2f km", distancia / 1000);
    } else {
        distanciaTexto = String.format("%.0f m", distancia);
    }

    System.out.println("latitud " + latitud);
    System.out.println("longitud " + longitud);
    System.out.println("distancia " + distanciaTexto);

    String googleMapsUrl = "https://www.google.com/maps?q=" + latitud + "," + longitud;
    dataList.add("<a href='" + googleMapsUrl + "' target='_blank'>" + latitud + ", " + longitud + "</a>");
    dataList.add(""); // segunda celda vacía para mantener estructura
    dataList.add(distanciaTexto); // tercera posición: distancia como texto legible
}

                                }
                                if (!dataList.isEmpty()) {
                                    categoryResults.put(subcategory, dataList);
                                }
                            } else if (checkbox.equals("configuracionTerreno")) {
                                while (resultSet.next()) {
                                    String porcentaje = resultSet.getString("porcentaje");
                                    System.out.println("Porcentaje de pendientes: " + porcentaje);
                                    if (porcentaje != null && !porcentaje.trim().isEmpty()) {
                                        dataList.add("Porcentaje de pendiente: " + porcentaje);
                                    }
                                }
                                if (!dataList.isEmpty()) {
                                    categoryResults.put(subcategory != null ? subcategory : "Pendiente de terreno", dataList);
                                }
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        return null;
                    });
                    futuresList.add(future);
                }
                try {
                    for (Future<Void> future : futuresList) {
                        future.get();
                    }
                } catch (InterruptedException | ExecutionException e) {
                    e.printStackTrace();
                }
                if (!categoryResults.isEmpty()) {
                    resultsMap.put(checkbox, categoryResults);
                }
            }
        }
        
      
        session.setAttribute("resultsMap", resultsMap);
        session.setAttribute("consultedCURT", originalCurt);
        session.setAttribute("lat", Double.valueOf(y));
        session.setAttribute("lon", Double.valueOf(x));
        response.sendRedirect("index.jsp");
    }
}
