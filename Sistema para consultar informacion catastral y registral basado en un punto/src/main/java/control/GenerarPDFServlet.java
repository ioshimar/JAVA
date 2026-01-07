package control;

import com.lowagie.text.Anchor;
import java.util.Base64;
import java.io.ByteArrayInputStream;
import com.lowagie.text.Image;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Image;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.common.BitMatrix;
import com.lowagie.text.BadElementException;
import com.lowagie.text.Chunk;
import com.lowagie.text.Phrase;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Hashtable;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.util.LinkedHashMap;


public class GenerarPDFServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("application/pdf");
        request.setCharacterEncoding("UTF-8");

        // Obtener los datos enviados desde el JSP
        String curt = request.getParameter("curt");
        String lat = request.getParameter("latitud");
        String lon = request.getParameter("longitud");
        
        String tempImagePath = request.getParameter("tempImagePath");
      
        String googleMapsURL = request.getParameter("googleMapsURL");

        // Ubicación
        String entidad = request.getParameter("Entidad");
        String municipio = request.getParameter("Municipio");
        String localidad = request.getParameter("Localidad");
        String ambito = request.getParameter("Ambito");
        
        System.out.println("Ambito" + ambito);
        String vialidad = request.getParameter("Vialidad");
        String vialidadesCercanas = request.getParameter("VialidadesCercanas");
        String colonia = request.getParameter("Colonia");
        String codigoPostal = request.getParameter("CodigoPostal");
        String NomUrb = request.getParameter("NomUrb");
        String NomRu = request.getParameter("NomRu");

        // Características Sociodemográficas
        String poblacionTotal = request.getParameter("PoblacionTotal");
        String poblacionFemenina = request.getParameter("PoblacionFemenina");
        String poblacionMasculina = request.getParameter("PoblacionMasculina");
        String poblacion0a14 = request.getParameter("Poblacion0a14");
        String poblacion15a29 = request.getParameter("Poblacion15a29");
        String poblacion30a49 = request.getParameter("Poblacion30a49");
        String poblacion50a59 = request.getParameter("Poblacion50a59");
        String poblacion60mas = request.getParameter("Poblacion60mas");

        // Unidades Económicas
        String institucionesGubernamentales = request.getParameter("InstitucionesGubernamentales");
        String ventasMayor = request.getParameter("VentasMayor");
        String ventasMenor = request.getParameter("VentasMenor");
        String materialConstruccion = request.getParameter("MaterialConstruccion");
        String generacionEnergia = request.getParameter("GeneracionEnergia");
        String industriasManufactureras = request.getParameter("IndustriasManufactureras");
        String mediosComunicacion = request.getParameter("MediosComunicacion");
        String minas = request.getParameter("Minas");
        String servicios = request.getParameter("Servicios");
        String alojamientoAlimentos = request.getParameter("AlojamientoAlimentos");
        String apoyoNegocios = request.getParameter("ApoyoNegocios");
        String saludAsistenciaSocial = request.getParameter("SaludAsistenciaSocial");
        String educativos = request.getParameter("Educativos");
        String culturalesDeportivos = request.getParameter("CulturalesDeportivos");
        String financierosSeguros = request.getParameter("FinancierosSeguros");
        String inmobiliarios = request.getParameter("Inmobiliarios");
        String cientificosTecnicos = request.getParameter("CientificosTecnicos");
        String transporte = request.getParameter("Transporte");

        // Usos de Suelo
        String usoSuelo = request.getParameter("UsoSuelo");

        // Edafología
        String sueloDominante = request.getParameter("SueloDominante");
        String sueloSecundario = request.getParameter("SueloSecundario");
        String sueloTerciario = request.getParameter("SueloTerciario");

        // Clima
        String tipoClima = request.getParameter("TipoClima");

        // Cuerpos de Agua
        String[] cuerposAguaCercanos = request.getParameterValues("CuerposAguaCercanos");
        
        
        
        
        
        // Procesar los cuerpos de agua en un mapa para mantenerlos organizados por tipo
        Map<String, List<String>> cuerposAguaMap = new LinkedHashMap<>();
        if (cuerposAguaCercanos != null) {
            for (String cuerpo : cuerposAguaCercanos) {
                // Separar el tipo de cuerpo de agua y su nombre
                String[] parts = cuerpo.split("=");
                if (parts.length == 2) {
                    String tipo = parts[0].trim();
                    String nombre = parts[1].trim();

                    // Añadir el nombre al tipo correspondiente en el mapa
                    cuerposAguaMap.putIfAbsent(tipo, new ArrayList<>());
                    cuerposAguaMap.get(tipo).add(nombre);
                }
            }
        }

        // Geología
        String unidadRocaTipo = request.getParameter("UnidadRocaTipo");
        String unidadRocaDefinicion = request.getParameter("UnidadRocaDefinicion");
        String numeroFallasCercanas = request.getParameter("NumeroFallasCercanas");

        // Gestión de Tierras
// --- Siempre llegan estos:
String areasProtegidas  = request.getParameter("AreasProtegidas");
String frontera         = request.getParameter("Frontera");

// --- Pueden llegar arreglos si los incluyes en el formulario:
String[] derechosCURT   = request.getParameterValues("DerechosCURT");      // Lista de CURT de predios procesados (tabla)
String[] titularidades  = request.getParameterValues("Titularidad");       // Lista de Titularidades (tabla)
String[] curtParcelas   = request.getParameterValues("CURTParcela");       // Lista de CURT de parcelas (tabla)

// --- Tierras de uso común (pueden estar vacíos):
String curtTierra       = request.getParameter("TierrasUsoComunCURT");     // CURT de tierra de uso común (puede ser null)
String tipoTierra       = request.getParameter("TierrasUsoComunTipo");     // Tipo de tierra

// --- Principal (siempre llega uno según prioridad, los name NO cambian):
String curtPredio       = request.getParameter("curt_predio");             // CURT principal (según prioridad RNIG, Procesado, Banobras, Parcela, Uso común)
String curtPredioFuente = request.getParameter("curt_predio_fuente");      // Fuente principal
//String curtPredioAnio   = request.getParameter("curt_predio_anio");        // Año (siempre ponlo aunque venga null)
//String anioProcesado = request.getParameter("curt_predio_anio_procesado");
String curtPredioTipo = request.getParameter("curt_predio_tipo");

//System.out.println("curtPredioAnio "+ curtPredioAnio);




        // Geodesia
        String bancoNivelUbicacion = request.getParameter("BancoNivelUbicacion");
        String bancoNivelAltura = request.getParameter("BancoNivelAltura");
        String estacionGravimetricaUbicacion = request.getParameter("EstacionGravimetricaUbicacion");
        String estacionGravimetricaGravedad = request.getParameter("EstacionGravimetricaGravedad");
        String verticeUbicacion = request.getParameter("VerticeUbicacion");
        String bancoNivelDistancia = request.getParameter("BancoNivelDistancia");
        String estacionGravimetricaDistancia = request.getParameter("EstacionGravimetricaDistancia");
        String verticeDistancia = request.getParameter("VerticeDistancia");

        // Configuración del Terreno
        String pendiente = request.getParameter("Pendiente");
        System.out.println("Pendiente recibido en GenerarPDFServlet: " + pendiente);

        // Configurar el nombre del archivo
        String fileName = "Reporte_CURT_" + curt + ".pdf";
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        

        // Crear el documento PDF
        Document document = new Document();
        try {
            OutputStream out = response.getOutputStream();
            PdfWriter.getInstance(document, out);
            document.open();

            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16);
            Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
            Font textFont = FontFactory.getFont(FontFactory.HELVETICA, 12);
            
            
            // 1. Agrega aquí el LOGO DE INEGI
            try {
                String logoPath = getServletContext().getRealPath("/images/Logo_INEGI_a.jpg");
                Image logo = Image.getInstance(logoPath);
                logo.scaleToFit(140, 60);
                logo.setAlignment(Image.ALIGN_CENTER);
                document.add(logo);
                document.add(new Paragraph(" "));
            } catch (Exception e) {
                e.printStackTrace();
            }


            // Encabezado con CURT
            Paragraph curtParagraph = new Paragraph("CURT consultada: " + curt, titleFont);
            curtParagraph.setAlignment(Element.ALIGN_LEFT);
            document.add(curtParagraph);
            document.add(new Paragraph(" ")); // Espacio en blanco
            
if (tempImagePath != null && !tempImagePath.isEmpty()) {
    try {
        // Cargar la imagen desde el archivo temporal
        Image mapImage = Image.getInstance(tempImagePath);
        mapImage.scaleToFit(450, 300); // Ajusta el tamaño según lo necesites
        mapImage.setAlignment(Element.ALIGN_CENTER);
        document.add(mapImage);
        document.add(new Paragraph(" ")); // Espacio después de la imagen
    } catch (BadElementException | IOException e) {
        e.printStackTrace();
    }
}           
            if (googleMapsURL != null) {
                // Generar el código QR
                Image qrImage = generateQRCodeImage(googleMapsURL, 150, 150);
                if (qrImage != null) {
                    qrImage.setAlignment(Image.ALIGN_CENTER);

                    // Crear un párrafo para centrar el QR y el texto
                    Paragraph qrParagraph = new Paragraph();
                    qrParagraph.setAlignment(Element.ALIGN_CENTER); // Alineación del párrafo

                    // Agregar la imagen del QR al párrafo
                    qrParagraph.add(qrImage);

                    // Crear texto centrado y añadirlo al párrafo
                    Paragraph textBelowQR = new Paragraph("ESCANEA EL CÓDIGO QR");
                    textBelowQR.setAlignment(Element.ALIGN_CENTER); // Alineación del texto
                    qrParagraph.add(textBelowQR);

                    // Agregar el párrafo al documento
                    document.add(qrParagraph);
                    
                    document.add(new Paragraph(" "));
                    
                    
                }
                
                
            }


            // Bloque de Ubicación
            if (entidad != null || municipio != null || localidad != null || ambito != null || vialidad != null || vialidadesCercanas != null || colonia != null || codigoPostal != null) {
                 PdfPTable tableUbicacion = createSectionTable("Ubicación", titleFont, headerFont, textFont);
    
    addTableRow(tableUbicacion, "Entidad", entidad, headerFont, textFont);
    addTableRow(tableUbicacion, "Municipio", municipio, headerFont, textFont);
    addTableRow(tableUbicacion, "Ámbito", ambito, headerFont, textFont);  // Se imprime debajo del municipio
    addTableRow(tableUbicacion, "Localidad", localidad, headerFont, textFont);

    // Solo si el ámbito NO es "Rural"
    if (ambito == null || !ambito.trim().equalsIgnoreCase("Rural")) {
        addTableRow(tableUbicacion, "Vialidad", vialidad, headerFont, textFont);
        addTableRow(tableUbicacion, "Vialidades Cercanas", vialidadesCercanas, headerFont, textFont);
        addTableRow(tableUbicacion, "Colonia o Fraccionamiento", colonia, headerFont, textFont);
        addTableRow(tableUbicacion, "Código Postal", codigoPostal, headerFont, textFont);
    }

    addTableRow(tableUbicacion, "Nomenclatura Cartográfica Urbana", NomUrb, headerFont, textFont);
    addTableRow(tableUbicacion, "Nomenclatura Cartográfica Rural", NomRu, headerFont, textFont);

    document.add(tableUbicacion);
            }

if (poblacionTotal != null || poblacionFemenina != null || poblacionMasculina != null ||
    poblacion0a14 != null || poblacion15a29 != null || poblacion30a49 != null ||
    poblacion50a59 != null || poblacion60mas != null) {

    PdfPTable tableSociodemograficas = createSectionTable("Características Sociodemográficas", titleFont, headerFont, textFont);

    // Agrega la celda de la fuente en la parte superior
    PdfPCell fuenteCell = new PdfPCell(new Paragraph("Fuente: Censo de Población", headerFont));
    fuenteCell.setColspan(2);
    fuenteCell.setHorizontalAlignment(Element.ALIGN_LEFT);
    fuenteCell.setPadding(8f);
    tableSociodemograficas.addCell(fuenteCell);

    // Ahora los datos de población
    addTableRow(tableSociodemograficas, "Población Total", poblacionTotal, headerFont, textFont);
    addTableRow(tableSociodemograficas, "Población Femenina", poblacionFemenina, headerFont, textFont);
    addTableRow(tableSociodemograficas, "Población Masculina", poblacionMasculina, headerFont, textFont);
    addTableRow(tableSociodemograficas, "Población de 0 a 14 años", poblacion0a14, headerFont, textFont);
    addTableRow(tableSociodemograficas, "Población de 15 a 29 años", poblacion15a29, headerFont, textFont);
    addTableRow(tableSociodemograficas, "Población de 30 a 49 años", poblacion30a49, headerFont, textFont);
    addTableRow(tableSociodemograficas, "Población de 50 a 59 años", poblacion50a59, headerFont, textFont);
    addTableRow(tableSociodemograficas, "Población de 60 años y más", poblacion60mas, headerFont, textFont);

    document.add(tableSociodemograficas);
}



            // Bloque de Unidades Económicas
            if (institucionesGubernamentales != null || ventasMayor != null || ventasMenor != null ||
    materialConstruccion != null || generacionEnergia != null || industriasManufactureras != null ||
    mediosComunicacion != null || minas != null || servicios != null || alojamientoAlimentos != null ||
    apoyoNegocios != null || saludAsistenciaSocial != null || educativos != null ||
    culturalesDeportivos != null || financierosSeguros != null || inmobiliarios != null ||
    cientificosTecnicos != null || transporte != null) {

    PdfPTable tableUnidadesEconomicas = createSectionTable("Unidades Económicas", titleFont, headerFont, textFont);

    // Celda de fuente en la parte superior
    PdfPCell fuenteCell = new PdfPCell(new Paragraph("Fuente: DENUE", headerFont));
    fuenteCell.setColspan(2);
    fuenteCell.setHorizontalAlignment(Element.ALIGN_LEFT);
    fuenteCell.setPadding(8f);
    tableUnidadesEconomicas.addCell(fuenteCell);

    addTableRow(tableUnidadesEconomicas, "Instituciones Gubernamentales", institucionesGubernamentales, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Establecimientos con Ventas al por Mayor", ventasMayor, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Establecimientos con Ventas al por Menor", ventasMenor, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Venta de Material para la Construcción", materialConstruccion, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Generación y Distribución de Energía Eléctrica", generacionEnergia, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Industrias Manufactureras", industriasManufactureras, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Medios de Comunicación", mediosComunicacion, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Minas", minas, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Otros Servicios", servicios, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Alojamiento y Alimentos", alojamientoAlimentos, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Apoyo a los Negocios", apoyoNegocios, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Salud y Asistencia Social", saludAsistenciaSocial, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Servicios Educativos", educativos, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Servicios Culturales y Deportivos", culturalesDeportivos, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Servicios Financieros y Seguros", financierosSeguros, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Servicios Inmobiliarios y Alquiler", inmobiliarios, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Servicios Científicos y Técnicos", cientificosTecnicos, headerFont, textFont);
    addTableRow(tableUnidadesEconomicas, "Transporte, Correos y Almacenamiento", transporte, headerFont, textFont);

    document.add(tableUnidadesEconomicas);
}



            // Bloque de Usos de Suelo
if (usoSuelo != null) {
    PdfPTable tableUsosSuelo = createSectionTable("Usos de Suelo", titleFont, headerFont, textFont);

    // Celda de fuente en la parte superior
    PdfPCell fuenteCell = new PdfPCell(new Paragraph("Fuente: INEGI", headerFont));
    fuenteCell.setColspan(2);
    fuenteCell.setHorizontalAlignment(Element.ALIGN_LEFT);
    fuenteCell.setPadding(8f);
    tableUsosSuelo.addCell(fuenteCell);

    addTableRow(tableUsosSuelo, "Uso del Suelo", usoSuelo, headerFont, textFont);

    document.add(tableUsosSuelo);
}


            // Bloque de Edafología
if (sueloDominante != null || sueloSecundario != null || sueloTerciario != null) {
    PdfPTable tableEdafologia = createSectionTable("Edafología", titleFont, headerFont, textFont);

    // Fuente en la parte superior
    PdfPCell fuenteCell = new PdfPCell(new Paragraph("Fuente: INEGI", headerFont));
    fuenteCell.setColspan(2);
    fuenteCell.setHorizontalAlignment(Element.ALIGN_LEFT);
    fuenteCell.setPadding(8f);
    tableEdafologia.addCell(fuenteCell);

    addTableRow(tableEdafologia, "Suelo Dominante", formatEdafologiaValue(sueloDominante), headerFont, textFont);
    addTableRow(tableEdafologia, "Suelo Secundario", formatEdafologiaValue(sueloSecundario), headerFont, textFont);
    addTableRow(tableEdafologia, "Suelo Terciario", formatEdafologiaValue(sueloTerciario), headerFont, textFont);

    document.add(tableEdafologia);
}

            // Bloque de Clima
if (tipoClima != null) {
    PdfPTable tableClima = createSectionTable("Clima", titleFont, headerFont, textFont);

    // Fuente en la parte superior
    PdfPCell fuenteCell = new PdfPCell(new Paragraph("Fuente: INEGI", headerFont));
    fuenteCell.setColspan(2);
    fuenteCell.setHorizontalAlignment(Element.ALIGN_LEFT);
    fuenteCell.setPadding(8f);
    tableClima.addCell(fuenteCell);

    addTableRow(tableClima, "Tipo de Clima", tipoClima, headerFont, textFont);
    document.add(tableClima);
}

            // Bloque de Cuerpos de Agua
if (!cuerposAguaMap.isEmpty()) {
    PdfPTable tableCuerposAgua = createSectionTable("Cuerpos de Agua", titleFont, headerFont, textFont);

    // Fuente en la parte superior
    PdfPCell fuenteCell = new PdfPCell(new Paragraph("Fuente: INEGI", headerFont));
    fuenteCell.setColspan(2);
    fuenteCell.setHorizontalAlignment(Element.ALIGN_LEFT);
    fuenteCell.setPadding(8f);
    tableCuerposAgua.addCell(fuenteCell);

    // Añadir una fila por cada tipo de cuerpo de agua y su lista de nombres
    for (Map.Entry<String, List<String>> entry : cuerposAguaMap.entrySet()) {
        String tipo = entry.getKey();
        String nombres = String.join(", ", entry.getValue()); // Combinar nombres en una sola cadena

        addTableRow(tableCuerposAgua, tipo, nombres, headerFont, textFont);
    }
    document.add(tableCuerposAgua);
}


            // Bloque de Geología
if (unidadRocaTipo != null || numeroFallasCercanas != null) {
    PdfPTable tableGeologia = createSectionTable("Geología", titleFont, headerFont, textFont);

    // Fuente en la parte superior
    PdfPCell fuenteCell = new PdfPCell(new Paragraph("Fuente: INEGI", headerFont));
    fuenteCell.setColspan(2);
    fuenteCell.setHorizontalAlignment(Element.ALIGN_LEFT);
    fuenteCell.setPadding(8f);
    tableGeologia.addCell(fuenteCell);

    // Concatenar el tipo y la definición en una sola celda
    String tipoYDefinicion = unidadRocaTipo;
    if (unidadRocaDefinicion != null && !unidadRocaDefinicion.isEmpty()) {
        tipoYDefinicion += "\n" + unidadRocaDefinicion;
    }

    addTableRow(tableGeologia, "Unidad de Roca", tipoYDefinicion, headerFont, textFont);
    addTableRow(tableGeologia, "Número de Fallas Cercanas", numeroFallasCercanas, headerFont, textFont);
    document.add(tableGeologia);
}


// ---------- BLOQUE GESTIÓN DE TIERRAS ----------
if (
    (areasProtegidas != null && !areasProtegidas.isEmpty()) ||
    (frontera != null && !frontera.isEmpty()) ||
    (derechosCURT != null && derechosCURT.length > 0) ||
    (titularidades != null && titularidades.length > 0) ||
    (curtParcelas != null && curtParcelas.length > 0) ||
    (curtTierra != null && !curtTierra.isEmpty()) ||
    (tipoTierra != null && !tipoTierra.isEmpty()) ||
    (curtPredio != null && !curtPredio.isEmpty())
) {
    PdfPTable tableGestionTierras = createSectionTable("Gestión de Tierras", titleFont, headerFont, textFont);

    if (areasProtegidas != null && !areasProtegidas.isEmpty()) {
    PdfPTable tableAreasProtegidas = createSectionTable("Áreas Protegidas", titleFont, headerFont, textFont);

    // Fuente CONANP en la parte superior
    PdfPCell fuenteCell = new PdfPCell(new Paragraph("Fuente: CONANP", headerFont));
    fuenteCell.setColspan(2);
    fuenteCell.setHorizontalAlignment(Element.ALIGN_LEFT);
    fuenteCell.setPadding(8f);
    tableAreasProtegidas.addCell(fuenteCell);

    addTableRow(tableAreasProtegidas, "Áreas Protegidas", areasProtegidas, headerFont, textFont);
    document.add(tableAreasProtegidas);
}
    // Frontera
if (frontera != null && !frontera.isEmpty()) {
    // Fuente INEGI en la parte superior (ocupa dos columnas)
    PdfPCell fuenteCell = new PdfPCell(new Paragraph("Fuente: INEGI", headerFont));
    fuenteCell.setColspan(2);
    fuenteCell.setHorizontalAlignment(Element.ALIGN_LEFT);
    fuenteCell.setPadding(8f);
    tableGestionTierras.addCell(fuenteCell);

    addTableRow(tableGestionTierras, "Frontera", frontera, headerFont, textFont);
}

    // Intersección con Predios Procesados (CURT)
    if (derechosCURT != null && derechosCURT.length > 0) {
        for (String predio : derechosCURT) {
            addTableRow(tableGestionTierras, "Intersección con Predios Procesados (CURT)", predio, headerFont, textFont);
        }
    }
    // Derechos de Titularidad
    if (titularidades != null && titularidades.length > 0) {
        for (String titularidad : titularidades) {
            addTableRow(tableGestionTierras, "Derechos de Titularidad", titularidad, headerFont, textFont);
        }
    }
    // CURT de la Parcela
    if (curtParcelas != null && curtParcelas.length > 0) {
        for (String curtParcela : curtParcelas) {
            addTableRow(tableGestionTierras, "CURT de la Parcela", curtParcela, headerFont, textFont);
        }
    }
    // Tierras de uso común
    if ((curtTierra != null && !curtTierra.isEmpty()) || (tipoTierra != null && !tipoTierra.isEmpty())) {
        PdfPCell header = new PdfPCell(new Paragraph("Tierras de uso común", headerFont));
        header.setColspan(2);
        header.setBackgroundColor(new Color(230,230,250));
        header.setHorizontalAlignment(Element.ALIGN_CENTER);
        header.setPadding(6f);
        tableGestionTierras.addCell(header);

        addTableRow(tableGestionTierras, "CURT", curtTierra, headerFont, textFont);
        addTableRow(tableGestionTierras, "Tipo de tierra", tipoTierra, headerFont, textFont);
    }

// ---------- CURT PRINCIPAL Y FUENTE (PRIORIDAD) ----------
String fuente = (curtPredioFuente != null) ? curtPredioFuente.trim() : "";
String anio = request.getParameter("curt_predio_anio"); // RNIG
if (anio != null) anio = anio.trim();

String anioProcesado = request.getParameter("curt_predio_anio_procesado"); // Procesado
if (anioProcesado != null) anioProcesado = anioProcesado.trim();

String fuenteLabel = "";
String curtLabel = "";
boolean fuenteTieneAnio = (anio != null && !anio.isEmpty());
boolean fuenteTieneAnioProcesado = (anioProcesado != null && !anioProcesado.isEmpty());

// --- Prioridad RNIG ---
if ("RNIG".equalsIgnoreCase(curtPredioTipo)) {
    fuenteLabel = "Fuente: " + fuente;
    if (fuenteTieneAnio) fuenteLabel += ", " + anio;
    curtLabel = "CURT del predio RNIG";
}
// --- Prioridad BANOBRAS ---
else if (fuente.toUpperCase().contains("BANOBRAS")) {
    fuenteLabel = "Fuente: Gobierno Estatal";
    curtLabel = "CURT del predio BANOBRAS";
}
// --- Prioridad SEDESOL ---
else if (fuente.toUpperCase().contains("SEDESOL")) {
    fuenteLabel = "Fuente: Gobierno Municipal";
    curtLabel = "CURT del predio SEDESOL";
}
// --- Prioridad RAN ---
else if (fuente.equalsIgnoreCase("RAN")) {
    fuenteLabel = "Fuente: RAN";
    if ((curtTierra != null && !curtTierra.isEmpty())) {
        curtLabel = "CURT de tierra de uso común";
    } else {
        curtLabel = "CURT de la parcela";
    }
}
// --- Prioridad Procesado ---
else if (fuenteTieneAnioProcesado) {
    fuenteLabel = "Fuente: " + fuente + ", " + anioProcesado;
    curtLabel = "CURT del predio";
}
// --- Cualquier otro caso ---
else if (!fuente.isEmpty()) {
    fuenteLabel = "Fuente: " + fuente;
    if (fuenteTieneAnio) fuenteLabel += ", " + anio;
    curtLabel = "CURT del predio";
}

if (curtPredio != null && !curtPredio.isEmpty()) {
    // Fila de fuente (colspan=2)
    PdfPCell fuenteCell = new PdfPCell();
    fuenteCell.setColspan(2);
    Paragraph fuentePar = new Paragraph();
    Font boldFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
    fuentePar.add(new Chunk("Fuente: ", boldFont));
    if ("RNIG".equalsIgnoreCase(curtPredioTipo)) {
        fuentePar.add(new Chunk(fuente));
        if (fuenteTieneAnio) fuentePar.add(new Chunk(", " + anio));
    } else if (fuente.toUpperCase().contains("BANOBRAS")) {
        fuentePar.add(new Chunk("Gobierno Estatal"));
    } else if (fuente.toUpperCase().contains("SEDESOL")) {
        fuentePar.add(new Chunk("Gobierno Municipal"));
    } else if (fuente.equalsIgnoreCase("RAN")) {
        fuentePar.add(new Chunk("RAN"));
    } else if (fuenteTieneAnioProcesado) {
        fuentePar.add(new Chunk(fuente));
        fuentePar.add(new Chunk(", " + anioProcesado));
    } else {
        fuentePar.add(new Chunk(fuente));
        if (fuenteTieneAnio) fuentePar.add(new Chunk(", " + anio));
    }
    fuenteCell.setPhrase(fuentePar);
    fuenteCell.setPadding(8f);
    fuenteCell.setBackgroundColor(new Color(240, 240, 240));
    tableGestionTierras.addCell(fuenteCell);

    // Fila normal de CURT del predio con label dinámico
    addTableRow(tableGestionTierras, curtLabel, curtPredio, headerFont, textFont);
}

// Agregar la tabla de Gestión de Tierras al documento si contiene datos
document.add(tableGestionTierras);

}




            // Bloque de Geodesia
if ((bancoNivelUbicacion != null && bancoNivelAltura != null) ||
    (estacionGravimetricaUbicacion != null && estacionGravimetricaGravedad != null) ||
    verticeUbicacion != null) {

    PdfPTable tableGeodesia = createSectionTable("Geodesia", titleFont, headerFont, textFont);

    // Fuente INEGI en la parte superior
    PdfPCell fuenteCell = new PdfPCell(new Paragraph("Fuente: INEGI", headerFont));
    fuenteCell.setColspan(2);
    fuenteCell.setHorizontalAlignment(Element.ALIGN_LEFT);
    fuenteCell.setPadding(8f);
    tableGeodesia.addCell(fuenteCell);

    // Banco de Nivel más cercano
    if (bancoNivelUbicacion != null && bancoNivelAltura != null) {
        String titulo = "Banco de Nivel más cercano";
        if (bancoNivelDistancia != null && !bancoNivelDistancia.isEmpty()) {
            titulo += " (" + bancoNivelDistancia + ")";
        }
        addColoredHeaderRow(tableGeodesia, titulo, headerFont, new Color(0, 102, 204));
        addTableRow(tableGeodesia, "Ubicación", extractCoordinates(bancoNivelUbicacion), headerFont, textFont);
        addTableRow(tableGeodesia, "Altura ortométrica", bancoNivelAltura, headerFont, textFont);
    }

    // Estación Gravimétrica más cercana
    if (estacionGravimetricaUbicacion != null && estacionGravimetricaGravedad != null) {
        String titulo = "Estación Gravimétrica más cercana";
        if (estacionGravimetricaDistancia != null && !estacionGravimetricaDistancia.isEmpty()) {
            titulo += " (" + estacionGravimetricaDistancia + ")";
        }
        addColoredHeaderRow(tableGeodesia, titulo, headerFont, new Color(0, 102, 204));
        addTableRow(tableGeodesia, "Ubicación", extractCoordinates(estacionGravimetricaUbicacion), headerFont, textFont);
        addTableRow(tableGeodesia, "Gravedad", estacionGravimetricaGravedad, headerFont, textFont);
    }

    // Vértice de posicionamiento más cercano
    if (verticeUbicacion != null) {
        String titulo = "Vértice de posicionamiento más cercano";
        if (verticeDistancia != null && !verticeDistancia.isEmpty()) {
            titulo += " (" + verticeDistancia + ")";
        }
        addColoredHeaderRow(tableGeodesia, titulo, headerFont, new Color(0, 102, 204));
        addTableRow(tableGeodesia, "Ubicación", extractCoordinates(verticeUbicacion), headerFont, textFont);
    }

    document.add(tableGeodesia);
}


            // Bloque de Configuración de Terreno
if (pendiente != null && !pendiente.isEmpty()) {
    PdfPTable tableConfiguracionTerreno = createSectionTable("Configuración del Terreno", titleFont, headerFont, textFont);

    // Fuente INEGI en la parte superior
    PdfPCell fuenteCell = new PdfPCell(new Paragraph("Fuente: INEGI", headerFont));
    fuenteCell.setColspan(2);
    fuenteCell.setHorizontalAlignment(Element.ALIGN_LEFT);
    fuenteCell.setPadding(8f);
    tableConfiguracionTerreno.addCell(fuenteCell);

    // Estilos
    Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL, Color.BLACK);
    Font boldFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9, Font.BOLD, Color.BLACK);

    // Celda título
    PdfPCell headerCell = new PdfPCell(new Phrase("Pendiente", headerFont));
    headerCell.setBackgroundColor(new Color(230, 230, 250));
    headerCell.setVerticalAlignment(Element.ALIGN_TOP);
    headerCell.setPadding(6f);
    tableConfiguracionTerreno.addCell(headerCell);

    // Celda con valor y explicación
    Paragraph contenido = new Paragraph();
    contenido.setFont(textFont);
    contenido.setSpacingAfter(5f);
    contenido.add(new Phrase(pendiente + "\n\n", textFont));
    
    contenido.add(new Chunk("NOTA: ", boldFont));
    contenido.add(new Phrase("Las pendientes del terreno se obtienen a partir del Continuo de Elevaciones Mexicanos (CEM), del INEGI. Este modelo representa la altitud del terreno en formato raster, donde cada píxel tiene un valor de elevación.\n\n", normalFont));
    contenido.add(new Phrase("Las pendientes promedio para cada polígono se clasificaron en tres rangos:\n", normalFont));

    contenido.add(new Chunk("• 0 a 14%: ", boldFont));
    contenido.add(new Chunk("Se consideran pendientes suaves o planas. Son ideales para actividades humanas como asentamientos, agricultura mecanizada o vialidades.\n", normalFont));

    contenido.add(new Chunk("• 15 a 36%: ", boldFont));
    contenido.add(new Chunk("Son pendientes moderadas. Aquí se pueden realizar actividades con ciertas restricciones, ya que aumenta el riesgo de erosión.\n", normalFont));

    contenido.add(new Chunk("• Mayor al 36%: ", boldFont));
    contenido.add(new Chunk("Son pendientes fuertes o escarpadas. Son zonas con alto riesgo de erosión y deslizamientos, por lo que suelen ser poco aptas para actividades humanas.", normalFont));

    PdfPCell contenidoCell = new PdfPCell(contenido);
    contenidoCell.setPadding(6f);
    contenidoCell.setUseAscender(true);
    contenidoCell.setUseDescender(true);

    tableConfiguracionTerreno.addCell(contenidoCell);

    document.add(tableConfiguracionTerreno);
}

else {
                System.out.println("No se recibió el valor de Pendiente para el PDF.");
            }

            document.close();
        } catch (DocumentException e) {
            throw new IOException(e.getMessage());
        }
    }
    
    // Método auxiliar para dar formato a la información de edafología
    private String formatEdafologiaValue(String value) {
        if (value != null && value.contains("-")) {
            String[] parts = value.split("-", 2); // Separar en dos partes
            return parts[0].trim() + "\n " + parts[1].trim();
        }
        return value; // Si no hay definición, devolver el valor tal cual
    }
 
    
    private void addColoredHeaderRow(PdfPTable table, String title, Font font, Color backgroundColor) {
        // Crear una fuente blanca específica para el encabezado
        Font whiteFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Color.WHITE);

        PdfPCell cell = new PdfPCell(new Paragraph(title, whiteFont));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setBackgroundColor(backgroundColor);
        cell.setPadding(10);
        cell.setColspan(2);
        table.addCell(cell);
    }
    
    // Método para generar el código QR como una imagen de iText
    private Image generateQRCodeImage(String text, int width, int height) {
        try {
            Hashtable<EncodeHintType, Object> hintMap = new Hashtable<>();
            hintMap.put(EncodeHintType.CHARACTER_SET, "UTF-8");
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix byteMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height, hintMap);
            int matrixWidth = byteMatrix.getWidth();
            BufferedImage image = new BufferedImage(matrixWidth, matrixWidth, BufferedImage.TYPE_INT_RGB);
            image.createGraphics();

            // Rellenar el código QR con color negro y el fondo en blanco
            for (int i = 0; i < matrixWidth; i++) {
                for (int j = 0; j < matrixWidth; j++) {
                    image.setRGB(i, j, byteMatrix.get(i, j) ? Color.BLACK.getRGB() : Color.WHITE.getRGB());
                }
            }

            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            ImageIO.write(image, "png", byteArrayOutputStream);
            return Image.getInstance(byteArrayOutputStream.toByteArray());
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Métodos auxiliares para simplificar la creación de tablas
    private PdfPTable createSectionTable(String title, Font titleFont, Font headerFont, Font textFont) {
        PdfPTable table = new PdfPTable(2);
        PdfPCell cellTitle = new PdfPCell(new Paragraph(title, titleFont));
        cellTitle.setHorizontalAlignment(Element.ALIGN_CENTER);
        cellTitle.setColspan(2);
        cellTitle.setBackgroundColor(new Color(0xC6C9C6));
        table.addCell(cellTitle);
        return table;
    }
    
    // Método auxiliar para extraer solo las coordenadas de un enlace HTML
private String extractCoordinates(String html) {
    if (html != null && html.contains("maps?q=")) {
        int start = html.indexOf("maps?q=") + 7; // Buscar el inicio después de "maps?q="
        int end = html.indexOf("'", start); // Encontrar el final antes del siguiente apóstrofe
        if (end > start) {
            return html.substring(start, end);
        }
    }
    return html; // Devuelve el contenido sin cambios si no coincide
}


    private void addTableRow(PdfPTable table, String header, String value, Font headerFont, Font textFont) {
        if (value != null && !value.isEmpty()) {
            table.addCell(createHeaderCell(header, headerFont));
            table.addCell(createValueCell(value, textFont));
        }
    }

    private PdfPCell createHeaderCell(String text, Font headerFont) {
        PdfPCell cell = new PdfPCell(new Paragraph(text, headerFont));
        cell.setPadding(10);
        cell.setBackgroundColor(new Color(0xEDEDED));
        return cell;
    }

    private PdfPCell createValueCell(String text, Font textFont) {
        PdfPCell cell = new PdfPCell(new Paragraph(text, textFont));
        cell.setPadding(10);
        return cell;
    }
}


