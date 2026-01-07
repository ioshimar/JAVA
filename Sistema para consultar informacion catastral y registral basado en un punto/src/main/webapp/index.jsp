<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>

<%@ page import="java.util.List,java.util.Map" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
Map<String, Map<String, List<String>>> resultsMap =
    (Map<String, Map<String, List<String>>>) session.getAttribute("resultsMap");

%>
<%
    // Si NO está logueado, redirige a login.jsp
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return; // MUY IMPORTANTE, evita que siga cargando el resto del JSP
    }
%>
<%
    

    
String rnigCurtResult = (String) session.getAttribute("rnigCurtResult");



%>




<!DOCTYPE html>
<html lang="es">
<head>
    <!-- Metadatos y títulos -->
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="images/inegi.png" sizes="16x16">
    <title>Sistema de Consulta CURT</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome para iconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- OpenLayers CSS -->
<link rel="stylesheet" href="https://openlayers.org/en/v6.15.1/css/ol.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.11.0/proj4.js"></script>


<!-- OpenLayers JS -->
<script src="https://openlayers.org/en/v6.15.1/build/ol.js"></script>
    
    
    <!-- Estilos personalizados -->
    <style>
        body {
            background-color: #f8f9fa;
        }
        .header-img {
            width: 200px;
            height: auto;
            display: block;
            margin-left: 0;
        }
        .header-container {
            display: flex;
            align-items: center;
            padding: 10px 0;
            background-color: white;
        }
        .logo-system-container {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        .logo-img {
            width: 80px;
            height: auto;
        }
        .system-title {
            font-size: 24px;
            font-weight: bold;
            margin: 0;
            text-align: center;
        }
        .form-container {
            margin: 30px auto;
            padding: 20px;
            max-width: 800px;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
        }
        .btn-primary {
            width: 100%;
        }
        .error-msg {
            color: red;
            font-size: 12px;
        }
        /* Estilos para los checkboxes */
        .checkbox-container {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .checkbox-container input[type="checkbox"] {
            margin-right: 10px;
            transform: scale(1.2);
        }
        .checkbox-container label {
            font-size: 16px;
            cursor: pointer;
        }
        @media (max-width: 576px) {
            .logo-system-container {
                flex-direction: column;
            }
            .system-title {
                font-size: 20px;
            }
        }
        /* Estilos personalizados para las tablas */
        .table-responsive {
            margin-top: 60px;
        }
        .table thead th {
            vertical-align: middle;
            text-align: left;
            background-color: #343a40;
            color: white;
            font-size: 18px;
        }
        .table tbody th {
            width: 30%;
            background-color: #f9f9f9;
        }
        .table tbody td {
            vertical-align: middle;
        }
        .table-hover tbody tr:hover {
            background-color: rgba(0,0,0,.075);
        }
        .table-category-header {
            background-color: #343a40;
            color: white;
            font-weight: bold;
            font-size: 20px;
            border-bottom: 2px solid #dee2e6;
            text-align: left;
        }
        .category-icon {
            color: white;
            margin-right: 10px;
            vertical-align: middle;
        }
        /* Estilos para el overlay de carga */
        #loadingOverlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.8);
            z-index: 9999;
            display: none;
            align-items: center;
            justify-content: center;
        }
        #loadingOverlay .spinner-border {
            width: 3rem;
            height: 3rem;
        }
        #loadingOverlay span {
            font-size: 1.2rem;
            color: #343a40;
        }
        
        /* Estilos para los subtítulos de las categorías */
        .table-subheader {
            background-color: #007bff !important; /* Fondo azul sólido con alta prioridad */
            color: white !important; /* Texto en blanco con alta prioridad */
            font-weight: bold;
            font-size: 18px;
            border-bottom: 2px solid #dee2e6;
            text-align: left;
            padding: 10px;
        }
        
        #map {
            width: 100%;
            height: 400px;
        }
/* Estilos para el botón personalizado */
 @media (min-width: 768px) {
    .ol-custom-control {
        position: absolute;
        top: 70px; /* Coloca el botón justo debajo del control de zoom en pantallas grandes */
        left: 9px;
        z-index: 1000;
    }
}

@media (max-width: 767px) {
    .ol-custom-control {
        position: absolute;
        top: 70px; /* Ajuste para pantallas pequeñas */
        left: 9px;
        z-index: 1000;
    }
}

.my-extent-button {
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: white;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
    cursor: pointer;
    font-size: 20px;
    color: #333;
}


.my-extent-button i {
    margin: 0;
}

/* Estilos específicos para el mapa de resultados */
#resultMap {
    width: 100%;
    height: 400px;
    border: 2px solid #007bff; /* Borde azul */
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.result-map .result-map-control {
    position: absolute;
    top: 10px;
    left: 10px;
    background-color: rgba(255, 255, 255, 0.8);
    padding: 5px;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
    font-size: 14px;
}

.result-map .result-map-button {
    display: block;
    margin-bottom: 5px;
    padding: 8px;
    background-color: #007bff;
    color: #fff;
    border: none;
    cursor: pointer;
    border-radius: 3px;
}

.result-map .result-map-button:hover {
    background-color: #0056b3;
}

/* Eliminar el borde de enfoque del mapa y del botón */
#resultMap, .layer-toggle-button {
    outline: none;
}

/* Estilo del contenedor del botón de capas */
.layer-control {
    position: absolute; /* Cambia a absoluto para posicionarlo relativo al contenedor del mapa */
    bottom: 20px;
    right: 20px;
    z-index: 1000; /* Asegura que esté por encima del mapa */
}

/* Estilo del botón */
.layer-toggle-button {
    background-color: #007bff;
    border: none;
    color: white;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    cursor: pointer;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.layer-toggle-button:hover {
    transform: scale(1.1);
    box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.3);
}

.layer-toggle-button i {
    font-size: 24px;
}

/* Estilo del menú emergente */
.layer-menu {
   
    position: absolute;
    bottom: 70px; /* Ajusta para que quede sobre el botón */
    right: 0;
    width: 250px;
    background: white;
    border-radius: 8px;
    box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.2);
    overflow: hidden;
    transform: translateY(20px);
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
    z-index: 1000;
}

.layer-menu.show {
    transform: translateY(0);
    opacity: 1;
    visibility: visible;
}

/* Opciones dentro del menú */
.layer-menu label {
    display: flex;
    align-items: center;
    padding: 10px;
    font-size: 16px;
    color: #333;
    cursor: pointer;
    border-bottom: 1px solid #f0f0f0;
    transition: background-color 0.2s ease;
}

.layer-menu label:hover {
    background-color: #f9f9f9;
}

/* Estilo de los radios */
.layer-menu input[type="radio"] {
    margin-right: 10px;
}

/* Ícono adicional para cada capa */
.layer-menu .layer-icon {
    margin-right: 10px;
    width: 24px;
    height: 24px;
    background-color: #e0e0e0;
    border-radius: 4px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    font-weight: bold;
    color: #007bff;
}


#popup {
    font-size: 14px;
    max-width: 200px;
    text-align: center;
    z-index: 1000;
}

.td-fuente {
    font-size: 13px;
    color: #595959;
    font-style: italic;
    white-space: nowrap;
}


    </style>
</head>
<body>

<!-- Evitar el almacenamiento en caché -->
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>

<div class="container-fluid p-0">
<div class="header-container">
    <img src="images/Logo_INEGI_a.jpg" alt="Encabezado" class="header-img">
    <div style="margin-left:auto; padding-right:20px;">
      <b>
        <i class="fa fa-user"></i>
        <%= session.getAttribute("nombre_completo") %>
      </b>
      &nbsp;
      <a href="LogoutServlet" class="btn btn-outline-danger btn-sm" style="vertical-align:middle;">
        <i class="fa fa-sign-out-alt"></i> Cerrar sesión
      </a>
    </div>
</div>

</div>

<div class="container">
    <div class="logo-system-container">
        <img src="images/Logo_CURT.png" alt="Logo del sistema" class="logo-img">
        <h2 class="system-title">SIIT CURT</h2>
    </div>
</div>

<!-- Botón para abrir el mapa interactivo -->
<div class="container my-4">
    <div class="text-center">
        <h5>¿No conoces tu CURT? Selecciona una ubicación aproximada en el mapa:</h5>
        <button class="btn btn-info" onclick="openMapModal()">Buscar CURT Aproximada</button>
    </div>
</div>

<!-- Formulario -->
<div class="container">
    <div class="form-container">
        <h3>Ingresa la información requerida</h3>
        <form id="curtForm" action="ConsultaServlet" method="post">
            <div class="mb-3">
                <label for="curt" class="form-label">Escribe los 21 dígitos de tu CURT:</label>
                <input type="text" class="form-control" id="curt" name="curt" maxlength="22" required pattern="\d{21}P?" placeholder="CURT">
                <div class="error-msg" id="curtError">
                    <c:if test="${not empty error}">
                        <c:out value="${error}" />
                    </c:if>
                </div>
            </div>
            <div class="mb-3">
                <label for="distance" class="form-label">Especifica el radio de busqueda (en metros):</label>
                <input type="number" class="form-control" id="distance" name="distance" min="1" required placeholder="Distancia en metros">
                <div class="error-msg" id="distanceError"></div>
            </div>

            <!-- Checkboxes -->
            <h4>Selecciona las opciones relevantes que desas buscar:</h4>
            <!-- Checkbox para seleccionar todo -->
            <div class="checkbox-container mb-3">
                <input type="checkbox" id="selectAll">
                <label for="selectAll">Seleccionar todo</label>
            </div>
            <div class="checkbox-container mb-3">
                <input type="checkbox" name="ubicacion" class="rubroCheckbox" id="checkbox1">
                <label for="checkbox1">Ubicación</label>
            </div>
            <div class="checkbox-container mb-3">
                <input type="checkbox" name="sociodemograficas" class="rubroCheckbox" id="checkbox2">
                <label for="checkbox2">Características Sociodemográficas</label>
            </div>
            <div class="checkbox-container mb-3">
                <input type="checkbox" name="unidadesEconomicas" class="rubroCheckbox" id="checkbox3">
                <label for="checkbox3">Unidades Económicas</label>
            </div>
            <div class="checkbox-container mb-3">
                <input type="checkbox" name="usosSuelo" class="rubroCheckbox" id="checkbox4">
                <label for="checkbox4">Usos de Suelo</label>
            </div>
            <div class="checkbox-container mb-3">
                <input type="checkbox" name="edafologia" class="rubroCheckbox" id="checkbox5">
                <label for="checkbox5">Edafología</label>
            </div>
            <div class="checkbox-container mb-3">
                <input type="checkbox" name="clima" class="rubroCheckbox" id="checkbox6">
                <label for="checkbox6">Clima</label>
            </div>
            <div class="checkbox-container mb-3">
                <input type="checkbox" name="cuerposAgua" class="rubroCheckbox" id="checkbox7">
                <label for="checkbox7">Cuerpos de Agua</label>
            </div>
            <div class="checkbox-container mb-3">
                <input type="checkbox" name="geologia" class="rubroCheckbox" id="checkbox8">
                <label for="checkbox8">Geología</label>
            </div>
            <div class="checkbox-container mb-3">
                <input type="checkbox" name="gestionTierras" class="rubroCheckbox" id="checkbox9">
                <label for="checkbox9">Gestión de Tierras</label>
            </div>
            <div class="checkbox-container mb-3">
                <input type="checkbox" name="geodesia" class="rubroCheckbox" id="checkbox10">
                <label for="checkbox10">Geodesia</label>
            </div>
            <div class="checkbox-container mb-3">
                <input type="checkbox" name="configuracionTerreno" class="rubroCheckbox" id="checkbox11">
                <label for="checkbox11">Configuración del terreno</label>
            </div>

            <button type="submit" class="btn btn-primary">Consultar</button>
        </form>
    </div>
</div>



<!-- Modal del mapa interactivo -->
<div id="mapModal" class="modal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Mapa Interactivo - Acercate para seleccionar una CURT aproximada</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body">
                <div id="map" style="width: 100%; height: 400px;"></div>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Crear el mapa interactivo en un modal
    function openMapModal() {
        const modalElement = document.getElementById('mapModal');
        const modal = new bootstrap.Modal(modalElement);

        modalElement.addEventListener('shown.bs.modal', function () {
            // Configurar proyección y resoluciones
            const projection = ol.proj.get('EPSG:900913'); // Cambiar a EPSG:900913
            const projectionExtent = projection.getExtent();
            const size = ol.extent.getWidth(projectionExtent) / 256; // Tamaño base de los mosaicos
            const resolutions = [];
            const matrixIds = [];

            // Generar resoluciones y matrixIds para WMTS
            for (let z = 0; z <= 19; z++) {
                resolutions[z] = size / Math.pow(2, z);
                matrixIds[z] = z.toString();
            }

            // Crear la capa base Gaia Mapas WMTS
            const gaiaWMSResult = new ol.layer.Tile({
                opacity: 0.9,
                visible: true,
                source: new ol.source.WMTS({
                    url: 'https://gaiamapas3.inegi.org.mx/mdmCache/service/wmts?',
                    layer: 'MapaBaseTopograficov61_sinsombreado',
                    matrixSet: 'EPSG:900913',
                    format: 'image/jpeg',
                    tileGrid: new ol.tilegrid.WMTS({
                        origin: [-20037508.3428, 20037508.3428], // Coordenadas de origen
                        resolutions: [
                            156543.03392804097, 78271.51696402048, 39135.75848201024,
                            19567.87924100512, 9783.93962050256, 4891.96981025128,
                            2445.98490512564, 1222.99245256282, 611.49622628141,
                            305.748113140705, 152.8740565703525, 76.43702828517625,
                            38.21851414258813, 19.109257071294063, 9.554628535647032,
                            4.777314267823516, 2.388657133911758, 1.194328566955879,
                            0.5971642834779395, 0.29858214173896974
                        ],
                        matrixIds: [
                            'EPSG:900913:0', 'EPSG:900913:1', 'EPSG:900913:2',
                            'EPSG:900913:3', 'EPSG:900913:4', 'EPSG:900913:5',
                            'EPSG:900913:6', 'EPSG:900913:7', 'EPSG:900913:8',
                            'EPSG:900913:9', 'EPSG:900913:10', 'EPSG:900913:11',
                            'EPSG:900913:12', 'EPSG:900913:13', 'EPSG:900913:14',
                            'EPSG:900913:15', 'EPSG:900913:16', 'EPSG:900913:17',
                            'EPSG:900913:18', 'EPSG:900913:19'
                        ]
                    }),
                    wrapX: true
                }),
                title: 'Gaia Mapas WMTS',
                type: 'base'
            });

            // Configurar vista inicial del mapa
            const mapView = new ol.View({
                center: ol.proj.transform([-102.5528, 23.6345], 'EPSG:4326', 'EPSG:900913'), // Centro de México
                zoom: 5,
                projection: projection
            });

            // Crear el mapa
            const map = new ol.Map({
                target: 'map', // ID del contenedor HTML
                layers: [gaiaWMSResult], // Capa base
                view: mapView
            });

            // Botón para "Ver todo el país"
            const extentButton = document.createElement('button');
            extentButton.innerHTML = '<i class="fa fa-globe"></i>';
            extentButton.className = 'my-extent-button';
            extentButton.title = 'Ver todo el país';
            extentButton.addEventListener('click', function () {
                map.getView().animate({
                    center: ol.proj.transform([-102.5528, 23.6345], 'EPSG:4326', 'EPSG:900913'),
                    zoom: 5,
                    duration: 500
                });
            });

            // Contenedor del botón personalizado
            const extentControlDiv = document.createElement('div');
            extentControlDiv.className = 'ol-control ol-custom-control';
            extentControlDiv.appendChild(extentButton);

            // Crear y agregar el control personalizado al mapa
            const extentControl = new ol.control.Control({ element: extentControlDiv });
            map.addControl(extentControl);
            
            
             // Cambiar el cursor según el nivel de zoom
                map.getView().on('change:resolution', function () {
                    const zoomLevel = map.getView().getZoom();
                    const mapElement = map.getTargetElement();
                    if (zoomLevel >= 12) {
                        mapElement.style.cursor = 'pointer';
                        isCurtAvailable = true;
                    } else {
                        mapElement.style.cursor = '';
                        isCurtAvailable = false;
                    }
                });

            // Evento para capturar clics en el mapa y calcular CURT aproximada
            map.on('click', function (e) {
                const zoomLevel = map.getView().getZoom();
                if (zoomLevel >= 12) {
                    const coordinate = e.coordinate;
                    const lonLat = ol.proj.toLonLat(coordinate);
                    const curt = calculateCURT(lonLat[1], lonLat[0]);
                    alert("CURT Aproximada: " + curt);
                } else {
                    alert("Acerque más el mapa para generar una CURT aproximada.");
                }
            });
        });

        modal.show();
    }

    // Función para calcular CURT
    function calculateCURT(lat, lng) {
        let longi = (-1) * lng;
        let g = parseInt(lat), m = (lat - g) * 60, min = parseInt(m), s = ((m - min) * 60).toFixed(6);
        let seg = Math.round(parseFloat(s.slice(0, 8)) * 10000).toString().padStart(6, '0');
        let grados = g.toString().padStart(2, '0'), minutos = min.toString().padStart(2, '0');

        let gl = parseInt(longi), ml = (longi - gl) * 60, minlon = parseInt(ml);
        let s1 = ((ml - minlon) * 60).toFixed(6), seg1 = Math.round(parseFloat(s1.slice(0, 8)) * 10000).toString().padStart(6, '0');
        let grados_lon = gl.toString().padStart(3, '0'), minutos_lon = minlon.toString().padStart(2, '0');

        let latitud = grados + minutos + seg, longitud = grados_lon + minutos_lon + seg1;
        return latitud + longitud + "P";
    }
</script>


<!-- Recuperar y limpiar variables de la sesión -->
<c:if test="${not empty sessionScope.consultedCURT}">
    <c:set var="consultedCURT" value="${sessionScope.consultedCURT}" />
    <c:remove var="consultedCURT" scope="session" />
</c:if>
<c:if test="${not empty sessionScope.lat}">
    <c:set var="lat" value="${sessionScope.lat}" />
    <c:remove var="lat" scope="session" />
</c:if>
<c:if test="${not empty sessionScope.lon}">
    <c:set var="lon" value="${sessionScope.lon}" />
    <c:remove var="lon" scope="session" />
</c:if>
<c:if test="${not empty sessionScope.resultsMap}">
    <c:set var="resultsMap" value="${sessionScope.resultsMap}" />
    <c:remove var="resultsMap" scope="session" />
</c:if>
<br><!--espacio -->
<br><!-- espacio -->
<br><!-- espacio -->
<!-- Cintilla con el mensaje de la CURT consultada -->
<c:if test="${not empty consultedCURT}">
    <div class="container my-4">
        <div class="alert alert-info text-center" role="alert">
            <c:choose>
               
                <c:when test="${consultedCURT.endsWith('P')}">
                    CURT aproximada consultada: <strong>${consultedCURT}</strong>
                </c:when>
                
                <c:otherwise>
                    CURT consultada: <strong>${consultedCURT}</strong>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</c:if>



<!-- Mostrar el mapa y el QR si hay resultados y coordenadas -->
<c:if test="${not empty resultsMap && not empty lat && not empty lon}">
    

    
    <!-- Botón para generar el PDF -->
    <div class="container my-4">
        <div class="d-flex justify-content-end mb-4">
<form id="downloadForm" action="GenerarPDFServlet" method="post" target="_blank" >
    <input type="hidden" name="curt" value="${consultedCURT}" />
    
    <input type="hidden" id="mapImagePath" name="mapImagePath" />
    
     <!-- Coordenadas del mapa para la ubicación -->
    <input type="hidden" name="latitud" value="${lat}" />
    <input type="hidden" name="longitud" value="${lon}" />
    <input type="hidden" id="mapImage" name="mapImage" />
    
    <!-- URL para Google Maps a partir de las coordenadas -->
    <input type="hidden" name="googleMapsURL" value="https://www.google.com/maps/search/?api=1&query=${lat},${lon}" />

    <!-- Ubicación -->
    <c:if test="${resultsMap['ubicacion'] != null}">
        <input type="hidden" name="Entidad" value="${resultsMap['ubicacion']['Entidad'][0]}">
        <input type="hidden" name="Municipio" value="${resultsMap['ubicacion']['Municipio'][0]}">
        <input type="hidden" name="Localidad" value="${resultsMap['ubicacion']['Localidad'][0]}">
        <c:choose>
            <c:when test="${resultsMap['ubicacion']['Ámbito'] != null && resultsMap['ubicacion']['Ámbito'][0] == 'Urbana'}">
                <input type="hidden" name="Ambito" value="Urbana">
            </c:when>
            <c:otherwise>
                <input type="hidden" name="Ambito" value="Rural">
            </c:otherwise>
        </c:choose>

        <input type="hidden" name="Vialidad" value="${resultsMap['ubicacion']['Vialidad o vía de comunicación'][0]}">
        <input type="hidden" name="VialidadesCercanas" value="${resultsMap['ubicacion']['Vialidades o vías de comunicación cercanas'][0]}">
        <input type="hidden" name="Colonia" value="${resultsMap['ubicacion']['Colonia o Fraccionamiento'][0]}">
        <input type="hidden" name="CodigoPostal" value="${resultsMap['ubicacion']['Código postal'][0]}">
        <input type="hidden" name="NomUrb" value="${resultsMap['ubicacion']['Nomenclatura Cartográfica Urbana'][0]}">
        <input type="hidden" name="NomRu" value="${resultsMap['ubicacion']['Nomenclatura Cartográfica Rural'][0]}">
    </c:if>
        
    <!-- Bloque de Características Sociodemográficas -->
            <c:if test="${resultsMap['sociodemograficas'] != null}">
                <input type="hidden" name="PoblacionTotal" value="${resultsMap['sociodemograficas']['Población total'][0]}">
                <input type="hidden" name="PoblacionFemenina" value="${resultsMap['sociodemograficas']['Población femenina'][0]}">
                <input type="hidden" name="PoblacionMasculina" value="${resultsMap['sociodemograficas']['Población masculina'][0]}">
                <input type="hidden" name="Poblacion0a14" value="${resultsMap['sociodemograficas']['Población de 0 a 14 años'][0]}">
                <input type="hidden" name="Poblacion15a29" value="${resultsMap['sociodemograficas']['Población de 15 a 29 años'][0]}">
                <input type="hidden" name="Poblacion30a49" value="${resultsMap['sociodemograficas']['Población de 30 a 49 años'][0]}">
                <input type="hidden" name="Poblacion50a59" value="${resultsMap['sociodemograficas']['Población de 50 a 59 años'][0]}">
                <input type="hidden" name="Poblacion60mas" value="${resultsMap['sociodemograficas']['Población de 60 años y más'][0]}">
            </c:if>

            <!-- Bloque de Unidades Económicas -->
            <c:if test="${resultsMap['unidadesEconomicas'] != null}">
                <input type="hidden" name="InstitucionesGubernamentales" value="${resultsMap['unidadesEconomicas']['Instituciones Gubernamentales'][0]}">
                <input type="hidden" name="VentasMayor" value="${resultsMap['unidadesEconomicas']['Establecimientos con Ventas al por Mayor'][0]}">
                <input type="hidden" name="VentasMenor" value="${resultsMap['unidadesEconomicas']['Establecimientos con Ventas al por Menor'][0]}">
                <input type="hidden" name="MaterialConstruccion" value="${resultsMap['unidadesEconomicas']['Establecimientos Dedicados a la Venta de Material para la Construcción'][0]}">
                <input type="hidden" name="GeneracionEnergia" value="${resultsMap['unidadesEconomicas']['Lugares Dedicados a la Generación, Transmisión y Distribución de Energía Electrica'][0]}">
                <input type="hidden" name="IndustriasManufactureras" value="${resultsMap['unidadesEconomicas']['Industrias Manufactureras'][0]}">
                <input type="hidden" name="MediosComunicacion" value="${resultsMap['unidadesEconomicas']['Medios de Comunicación'][0]}">
                <input type="hidden" name="Minas" value="${resultsMap['unidadesEconomicas']['Minas'][0]}">
                <input type="hidden" name="Servicios" value="${resultsMap['unidadesEconomicas']['Otros Establecimientos de Servicios'][0]}">
                <input type="hidden" name="AlojamientoAlimentos" value="${resultsMap['unidadesEconomicas']['Establecimientos Dedicados a los Servicios de Alojamiento y Alimentos'][0]}">
                <input type="hidden" name="ApoyoNegocios" value="${resultsMap['unidadesEconomicas']['Lugares Dedicados a los Servicios de Apoyo a los Negocios'][0]}">
                <input type="hidden" name="SaludAsistenciaSocial" value="${resultsMap['unidadesEconomicas']['Lugares Dedicados a los Servicios de Salud y Asistencia Social'][0]}">
                <input type="hidden" name="Educativos" value="${resultsMap['unidadesEconomicas']['Lugares Dedicados a los Servicios Educativos'][0]}">
                <input type="hidden" name="CulturalesDeportivos" value="${resultsMap['unidadesEconomicas']['Lugares Dedicados a los Servicios Culturales, Deportivos y Recreativos'][0]}">
                <input type="hidden" name="FinancierosSeguros" value="${resultsMap['unidadesEconomicas']['Establecimientos Dedicados a los Servicios Financieros y de Seguros'][0]}">
                <input type="hidden" name="Inmobiliarios" value="${resultsMap['unidadesEconomicas']['Establecimientos Dedicados a los Servicios Inmobiliarios y de Alquiler de Bienes'][0]}">
                <input type="hidden" name="CientificosTecnicos" value="${resultsMap['unidadesEconomicas']['Lugares Dedicados a los Servicios Profesionales, Científicos y Técnicos'][0]}">
                <input type="hidden" name="Transporte" value="${resultsMap['unidadesEconomicas']['Lugares Dedicados a los Servicios de Transporte, Correos y Almacenamiento'][0]}">
            </c:if>
                
                

            <!-- Bloque de Usos de Suelo -->
            <c:if test="${resultsMap['usosSuelo'] != null}">
                <input type="hidden" name="UsoSuelo" value="${resultsMap['usosSuelo']['Uso de Suelo'][0]}">
                <!-- Agrega más subcategorías de Usos de Suelo según tus datos -->
            </c:if>

           <!-- Bloque de Edafología -->
            <c:if test="${resultsMap['edafologia'] != null}">
                <input type="hidden" name="SueloDominante" value="${resultsMap['edafologia']['Suelo dominante'][0]} - ${resultsMap['edafologia']['Suelo dominante'][1]}">
                <input type="hidden" name="SueloSecundario" value="${resultsMap['edafologia']['Suelo secundario'][0]} - ${resultsMap['edafologia']['Suelo secundario'][1]}">
                <input type="hidden" name="SueloTerciario" value="${resultsMap['edafologia']['Suelo terciario'][0]} - ${resultsMap['edafologia']['Suelo terciario'][1]}">
            </c:if>

            <!-- Bloque de Clima -->
            <c:if test="${resultsMap['clima'] != null}">
                <input type="hidden" name="TipoClima" value="${resultsMap['clima']['Tipo de Clima'][0]}">
            </c:if>

            <!-- Bloque de Cuerpos de Agua -->
            <c:if test="${resultsMap['cuerposAgua'] != null}">
                <c:forEach var="entry" items="${resultsMap['cuerposAgua']}">
                    <c:set var="tipoCuerpo" value="${entry.key}"/>
                    <c:forEach var="nombreCuerpo" items="${entry.value}">
                        <input type="hidden" name="CuerposAguaCercanos" value="${tipoCuerpo}=${nombreCuerpo}"/>
                    </c:forEach>
                </c:forEach>
            </c:if>



            <!-- Bloque de Geología -->
            <c:if test="${resultsMap['geologia'] != null}">
                <input type="hidden" name="UnidadRocaTipo" value="${resultsMap['geologia']['Unidad de roca'][0]}">
                <input type="hidden" name="UnidadRocaDefinicion" value="${resultsMap['geologia']['Unidad de roca'][1]}">
                <input type="hidden" name="NumeroFallasCercanas" value="${resultsMap['geologia']['Número de fallas cercanas'][0]}">
            </c:if>


           <!-- Bloque de Gestión de Tierras -->

<c:if test="${resultsMap['gestionTierras'] != null}">

  
    <input type="hidden" name="AreasProtegidas" value="${resultsMap['gestionTierras']['Áreas Protegidas'][0]}"/>
    <input type="hidden" name="Frontera" value="${resultsMap['gestionTierras']['Frontera'][0]}"/>


    <c:choose>
  
        <c:when test="${not empty resultsMap['gestionTierras']['Derechos_CURT_RNIG']}">
            <input type="hidden" name="curt_predio" value="${resultsMap['gestionTierras']['Derechos_CURT_RNIG'][0]}"/>
            <input type="hidden" name="curt_predio_fuente" value="${resultsMap['gestionTierras']['RNIG_Institucion'][0]}"/>
            <input type="hidden" name="curt_predio_anio" value="${resultsMap['gestionTierras']['RNIG_AnioExporta'][0]}"/>
            <input type="hidden" name="curt_predio_tipo" value="RNIG"/>
        </c:when>

        <c:when test="${not empty resultsMap['gestionTierras']['Derechos_CURT']}">
            <input type="hidden" name="curt_predio" value="${resultsMap['gestionTierras']['Derechos_CURT'][0]}"/>
            <input type="hidden" name="curt_predio_fuente" value="${resultsMap['gestionTierras']['NombreUnidadEstatal'][0]}"/>
            <input type="hidden" name="curt_predio_anio_procesado" value="${resultsMap['gestionTierras']['Anio_Generacion'][0]}"/>

        </c:when>
        
        <c:when test="${not empty sessionScope.catastroCurtResult}">
            <input type="hidden" name="curt_predio" value="${sessionScope.catastroCurtResult}"/>
            <input type="hidden" name="curt_predio_fuente" value="${sessionScope.banobras_sedesol_label}"/>
            <input type="hidden" name="curt_predio_anio" value="${sessionScope.banobras_sedesol_anio}"/>
        </c:when>
       
        <c:when test="${not empty resultsMap['gestionTierras']['CURT_Parcela']}">
            <input type="hidden" name="curt_predio" value="${resultsMap['gestionTierras']['CURT_Parcela'][0]}"/>
            <input type="hidden" name="curt_predio_fuente" value="RAN"/>
        </c:when>
     
        <c:when test="${not empty resultsMap['gestionTierras']['Tierras de uso común']}">
            <input type="hidden" name="curt_predio" value="${resultsMap['gestionTierras']['Tierras de uso común'][0]}"/>
            <input type="hidden" name="curt_predio_fuente" value="RAN"/>
        </c:when>
        <c:otherwise>
            <input type="hidden" name="curt_predio" value=""/>
            <input type="hidden" name="curt_predio_fuente" value=""/>
        </c:otherwise>
    </c:choose>


</c:if>





            <!-- Bloque de Geodesia -->
            <c:if test="${resultsMap['geodesia'] != null}">
                <!-- Banco de Nivel -->
    <input type="hidden" name="BancoNivelUbicacion" value="${resultsMap['geodesia']['Banco de Nivel más cercano'][0]}">
    <input type="hidden" name="BancoNivelAltura" value="${resultsMap['geodesia']['Banco de Nivel más cercano'][1]}">
    <c:if test="${fn:length(resultsMap['geodesia']['Banco de Nivel más cercano']) > 2}">
        <input type="hidden" name="BancoNivelDistancia" value="${resultsMap['geodesia']['Banco de Nivel más cercano'][2]}">
    </c:if>

    <!-- Estación Gravimétrica -->
    <input type="hidden" name="EstacionGravimetricaUbicacion" value="${resultsMap['geodesia']['Estación Gravimétrica más cercana'][0]}">
    <input type="hidden" name="EstacionGravimetricaGravedad" value="${resultsMap['geodesia']['Estación Gravimétrica más cercana'][1]}">
    <c:if test="${fn:length(resultsMap['geodesia']['Estación Gravimétrica más cercana']) > 2}">
        <input type="hidden" name="EstacionGravimetricaDistancia" value="${resultsMap['geodesia']['Estación Gravimétrica más cercana'][2]}">
    </c:if>

    <!-- Vértice de posicionamiento -->
    <input type="hidden" name="VerticeUbicacion" value="${resultsMap['geodesia']['Vértice de posicionamiento más cercano'][0]}">
    <c:if test="${fn:length(resultsMap['geodesia']['Vértice de posicionamiento más cercano']) > 2}">
        <input type="hidden" name="VerticeDistancia" value="${resultsMap['geodesia']['Vértice de posicionamiento más cercano'][2]}">
    </c:if>
            </c:if>


            <!-- Bloque de Configuración de Terreno -->
            <c:if test="${resultsMap['configuracionTerreno'] != null}">
    <c:forEach var="entry" items="${resultsMap['configuracionTerreno']}">
        <!-- Para cada elemento en configuracionTerreno, enviar el valor al servlet -->
        <input type="hidden" name="Pendiente" value="${entry.value[0]}">
    </c:forEach>
</c:if>


    <button type="submit" class="btn btn-danger" onclick="captureMapAndSendToServer()">
        <i class="fas fa-file-pdf"></i> Descargar PDF
    </button>
</form>

        </div>
    </div>


    <!-- Sección del Mapa y QR -->
    <div class="container my-4">
        <div class="row">
            <!-- Mapa -->
            <!-- Contenedor del mapa con el botón de capas moderno -->
<div class="col-lg-8 col-md-12 mb-4" style="position: relative;">
    <div id="resultMap" class="map-container result-map" style="width: 100%; height: 400px;">
        
        <!-- Botón de capas con diseño moderno -->
    <div id="layerControl" class="layer-control">
        <button id="layerToggle" class="layer-toggle-button" onclick="toggleLayerMenu()">
            <i class="fas fa-layer-group"></i>
        </button>
        <!-- Menú de capas emergente -->
    <div id="layerMenu" class="layer-menu hidden"></div>
        
    </div>
    </div>

    
    

</div>
            
            
            <!-- Código QR y opciones -->
            <div class="col-lg-4 col-md-12 mb-4 d-flex flex-column align-items-center justify-content-center">
                <div id="qrcode"></div>
                <div class="text-center mt-2">
                    <strong>ESCANEA EL CÓDIGO QR Y ENCUENTRA TU CURT</strong>
                </div>
                <button id="shareButton" class="btn btn-primary mt-3">
                    <i class="fas fa-share-alt"></i> Compartir
                </button>
            </div>
        </div>
    </div>
    <!-- Cintilla de Resultados encontrados -->
    <div class="container my-4">
        <div class="alert alert-info text-center" role="alert">
            Resultados encontrados
        </div>
    </div>
</c:if>
    


<!-- Mostrar la tabla de resultados si hay datos -->
<%



String catastroCurtResult = (String) session.getAttribute("catastroCurtResult");
String banobrasLabel = (String) session.getAttribute("banobras_sedesol_label");

if (resultsMap != null && !resultsMap.isEmpty()) {
%>
<div class="container">
  <div class="table-responsive">
<%
for (String category : resultsMap.keySet()) {
    Map<String, List<String>> categoryData = resultsMap.get(category);

    // Definir ícono y título
    String iconClass = "fas fa-folder";
    String tituloCat = category;
    if ("ubicacion".equals(category)) { iconClass = "fas fa-map-marker-alt"; tituloCat = "Ubicación"; }
    else if ("sociodemograficas".equals(category)) { iconClass = "fas fa-users"; tituloCat = "Características Sociodemográficas (Información referente a la manzana de donde se encuentra la CURT)"; }
    else if ("unidadesEconomicas".equals(category)) { iconClass = "fas fa-industry"; tituloCat = "Unidades Económicas"; }
    else if ("usosSuelo".equals(category)) { iconClass = "fas fa-tractor"; tituloCat = "Usos de Suelo"; }
    else if ("edafologia".equals(category)) { iconClass = "fas fa-globe"; tituloCat = "Edafología"; }
    else if ("clima".equals(category)) { iconClass = "fas fa-cloud-sun"; tituloCat = "Clima"; }
    else if ("cuerposAgua".equals(category)) { iconClass = "fas fa-water"; tituloCat = "Cuerpos de Agua"; }
    else if ("geologia".equals(category)) { iconClass = "fas fa-mountain"; tituloCat = "Geología"; }
    else if ("gestionTierras".equals(category)) { iconClass = "fas fa-landmark"; tituloCat = "Gestión de Tierras"; }
    else if ("geodesia".equals(category)) { iconClass = "fas fa-compass"; tituloCat = "Geodesia"; }
    else if ("configuracionTerreno".equals(category)) { iconClass = "fas fa-map"; tituloCat = "Configuración del Terreno"; }

    // Verificar si hay datos
    int totalDataCount = 0;
    if (categoryData != null) {
        for (List<String> l : categoryData.values()) if (l != null) totalDataCount += l.size();
    }
    if (totalDataCount == 0) continue;
%>
    <table class="table table-striped table-hover table-bordered">
      <thead>
        <tr>
          <th colspan="2" class="table-category-header">
            <i class="<%= iconClass %> category-icon" aria-hidden="true"></i>
            <%= tituloCat %>
          </th>
        </tr>
      </thead>
      <tbody>
<%
    // CATEGORÍA: UBICACION
    if ("ubicacion".equals(category)) {
        String[] orderList = {"Entidad","Municipio","Localidad","Ámbito"};
        for (String subKey : orderList) {
            List<String> valores = categoryData.get(subKey);
            if (valores != null && !valores.isEmpty()) {
                for (String val : valores) {
                    String thText = subKey;
                    if ("Entidad".equals(subKey)) thText = "Área Geoestadística Estatal";
                    if ("Municipio".equals(subKey)) thText = "Área Geoestadística Municipal";
                    if ("Localidad".equals(subKey)) thText = "Localidad Geoestadística";
%>
        <tr>
            <th><%= thText %></th>
            <td><%= val %></td>
        </tr>
<%
                }
            }
        }
        // Si es Urbana, mostrar campos extra
        List<String> ambito = categoryData.get("Ámbito");
        if (ambito != null && !ambito.isEmpty() && "Urbana".equals(ambito.get(0))) {
            String[][] campos = {
                {"Vialidad o vía de comunicación", "Vialidad o vía de comunicación"},
                {"Vialidades o vías de comunicación cercanas", "Vialidades o vías de comunicación cercanas"},
                {"Colonia o Fraccionamiento", "Colonia o Fraccionamiento"},
                {"Código postal", "Código postal"}
            };
            for (String[] c : campos) {
                List<String> v = categoryData.get(c[0]);
                if (v != null && !v.isEmpty()) {
%>
        <tr>
            <th><%= c[1] %></th>
            <td><%= v.get(0) %></td>
        </tr>
<%
                }
            }
        } else {
%>
        <tr>
            <th>Ámbito</th>
            <td>Rural</td>
        </tr>
<%
        }
        // Nomenclatura
        if (categoryData.get("Nomenclatura Cartográfica Urbana") != null) {
%>
        <tr>
            <th>Nomenclatura Cartográfica Urbana</th>
            <td><%= categoryData.get("Nomenclatura Cartográfica Urbana").get(0) %></td>
        </tr>
<% }
        if (categoryData.get("Nomenclatura Cartográfica Rural") != null) {
%>
        <tr>
            <th>Nomenclatura Cartográfica Rural</th>
            <td><%= categoryData.get("Nomenclatura Cartográfica Rural").get(0) %></td>
        </tr>
<% }
    }

    // CATEGORÍA: sociodemograficas
    else if ("sociodemograficas".equals(category)) {
%>
        <tr><td colspan="2" class="td-fuente"><strong>Fuente:</strong> Censo de Población</td></tr>
<%
        String[] orden = {
            "Población total", "Población femenina", "Población masculina",
            "Población de 0 a 14 años", "Población de 15 a 29 años", "Población de 30 a 49 años",
            "Población de 50 a 59 años", "Población de 60 años y más"
        };
        for (String k : orden) {
            List<String> v = categoryData.get(k);
            if (v != null && !v.isEmpty()) {
%>
        <tr>
            <th><%= k %></th>
            <td><%= v.get(0) %></td>
        </tr>
<%
            }
        }
    }
    // CATEGORÍA: usosSuelo
    else if ("usosSuelo".equals(category)) {
%>
        <tr><td colspan="2" class="td-fuente"><strong>Fuente:</strong> INEGI</td></tr>
<%
        for (Map.Entry<String, List<String>> e : categoryData.entrySet()) {
            for (String item : e.getValue()) {
%>
        <tr>
            <th><%= e.getKey() %></th>
            <td><%= item %></td>
        </tr>
<%
            }
        }
    }
    // CATEGORÍA: unidadesEconomicas
    else if ("unidadesEconomicas".equals(category)) {
%>
        <tr><td colspan="2" class="td-fuente"><strong>Fuente:</strong> DENUE</td></tr>
<%
        String[] orden = {
            "Instituciones Gubernamentales", "Establecimientos con Ventas al por Mayor", "Establecimientos con Ventas al por Menor",
            "Establecimientos Dedicados a la Venta de Material para la Construcción", "Lugares Dedicados a la Generación, Transmisión y Distribución de Energía Electrica",
            "Industrias Manufactureras", "Medios de Comunicación", "Minas", "Otros Establecimientos de Servicios",
            "Establecimientos Dedicados a los Servicios de Alojamiento y Alimentos", "Lugares Dedicados a los Servicios de Apoyo a los Negocios",
            "Lugares Dedicados a los Servicios de Salud y Asistencia Social", "Lugares Dedicados a los Servicios Educativos",
            "Lugares Dedicados a los Servicios Culturales, Deportivos y Recreativos", "Establecimientos Dedicados a los Servicios Financieros y de Seguros",
            "Establecimientos Dedicados a los Servicios Inmobiliarios y de Alquiler de Bienes", "Lugares Dedicados a los Servicios Profesionales, Científicos y Técnicos",
            "Lugares Dedicados a los Servicios de Transporte, Correos y Almacenamiento"
        };
        for (String k : orden) {
            List<String> v = categoryData.get(k);
            if (v != null && !v.isEmpty()) {
%>
        <tr>
            <th><%= k %></th>
            <td>
                <ul>
<%
                for (String item : v) {
%>
                    <li><%= item %></li>
<%
                }
%>
                </ul>
            </td>
        </tr>
<%
            }
        }
    }
    // CATEGORÍA: edafologia
    else if ("edafologia".equals(category)) {
%>
        <tr><td colspan="2" class="td-fuente"><strong>Fuente:</strong> INEGI</td></tr>
<%
        String[] orden = {"Suelo dominante","Suelo secundario","Suelo terciario"};
        for (String k : orden) {
            List<String> v = categoryData.get(k);
            if (v != null && !v.isEmpty()) {
%>
        <tr>
            <th><%= k %></th>
            <td>
<%
                for (String item : v) {
%>
                <p><%= item %></p>
<%              }
%>
            </td>
        </tr>
<%
            }
        }
    }
    // CATEGORÍA: clima
    else if ("clima".equals(category)) {
%>
        <tr><td colspan="2" class="td-fuente"><strong>Fuente:</strong> INEGI</td></tr>
        <tr>
            <th>Tipo de Clima</th>
            <td><%= categoryData.get("Tipo de Clima") != null ? categoryData.get("Tipo de Clima").get(0) : "" %></td>
        </tr>
<%
    }
    // CATEGORÍA: cuerposAgua
    else if ("cuerposAgua".equals(category)) {
%>
        <tr><td colspan="2" class="td-fuente"><strong>Fuente: INEGI</strong></td></tr>
<%
        for (Map.Entry<String, List<String>> e : categoryData.entrySet()) {
%>
        <tr>
            <th><%= e.getKey() %></th>
            <td>
<%
            for (String item : e.getValue()) {
%>
                <p><%= item %></p>
<%
            }
%>
            </td>
        </tr>
<%
        }
    }
    // CATEGORÍA: geologia
    else if ("geologia".equals(category)) {
 System.out.println(">>> ENTRA AL BLOQUE geologia");
%>
        <tr><td colspan="2" class="td-fuente"><strong>Fuente: </strong> INEGI</td></tr>

<%
        for (Map.Entry<String, List<String>> e : categoryData.entrySet()) {
%>
        <tr>
            <th><%= e.getKey() %></th>
            <td>
<%
            for (String item : e.getValue()) {
%>
                <p><%= item %></p>
<%
            }
%>
            </td>
        </tr>
<%
        }
    }


// CATEGORÍA: gestionTierras (ESPECIAL)
else if ("gestionTierras".equals(category)) {
    // ============ 1. RESTRICCIONES ============
    boolean hayAreasProtegidas = categoryData.get("Áreas Protegidas") != null && !categoryData.get("Áreas Protegidas").isEmpty();
    boolean hayFrontera = categoryData.get("Frontera") != null && !categoryData.get("Frontera").isEmpty();
    if (hayAreasProtegidas || hayFrontera) {
%>
    <tr><th colspan="2" class="table-subheader">Restricciones</th></tr>
<%
        if (hayAreasProtegidas) {
%>
    <tr><td colspan="2" class="td-fuente"><strong>Fuente:</strong> CONANP</td></tr>
<%
            for (String item : categoryData.get("Áreas Protegidas")) {
%>
    <tr><th>Área Protegida</th><td><%= item %></td></tr>
<%
            }
        }
        if (hayFrontera) {
%>
    <tr><td colspan="2" class="td-fuente"><strong>Fuente:</strong> INEGI</td></tr>
<%
            for (String item : categoryData.get("Frontera")) {
%>
    <tr><th>Frontera</th><td><%= item %></td></tr>
<%
            }
        }
    }

    System.out.println("---- INICIO BLOQUE DERECHOS ----");
    System.out.println("categoryData.get('CURT_Parcela'): " + categoryData.get("CURT_Parcela"));
    System.out.println("categoryData.get('Tierras de uso común'): " + categoryData.get("Tierras de uso común"));
    System.out.println("categoryData.get('Derechos_CURT_RNIG'): " + categoryData.get("Derechos_CURT_RNIG"));
    System.out.println("categoryData.get('Derechos_CURT'): " + categoryData.get("Derechos_CURT"));
    System.out.println("catastroCurtResult: " + catastroCurtResult);

    // 1. Parcela
    boolean mostrarParcels = categoryData.get("CURT_Parcela") != null && !categoryData.get("CURT_Parcela").isEmpty();

    // 2. Tierras de uso común
    boolean mostrarTierrasComunes = !mostrarParcels &&
        categoryData.get("Tierras de uso común") != null && !categoryData.get("Tierras de uso común").isEmpty();

    // 3. RNIG
    String rnigCurt = null, rnigInstitucion = null, rnigAnio = null;
    boolean mostrarRnig = false;
    if (!mostrarParcels && !mostrarTierrasComunes &&
        categoryData.get("Derechos_CURT_RNIG") != null &&
        !categoryData.get("Derechos_CURT_RNIG").isEmpty() &&
        categoryData.get("RNIG_Institucion") != null &&
        !categoryData.get("RNIG_Institucion").isEmpty()
    ) {
        rnigCurt = categoryData.get("Derechos_CURT_RNIG").get(0);
        rnigInstitucion = categoryData.get("RNIG_Institucion").get(0);
        rnigAnio = (categoryData.get("RNIG_AnioExporta") != null && !categoryData.get("RNIG_AnioExporta").isEmpty()) ?
            categoryData.get("RNIG_AnioExporta").get(0) : "";
        mostrarRnig = true;
    }

    // 4. Predios procesados
    String procesadoCurt = null, nombreUnidadEstatal = null, anioGeneracion = null;
    boolean mostrarProcesado = !mostrarParcels && !mostrarTierrasComunes && !mostrarRnig &&
        categoryData.get("Derechos_CURT") != null && !categoryData.get("Derechos_CURT").isEmpty() &&
        categoryData.get("NombreUnidadEstatal") != null && !categoryData.get("NombreUnidadEstatal").isEmpty();

    if (mostrarProcesado) {
        procesadoCurt = categoryData.get("Derechos_CURT").get(0);
        nombreUnidadEstatal = categoryData.get("NombreUnidadEstatal").get(0);
        if (categoryData.get("Anio_Generacion") != null && !categoryData.get("Anio_Generacion").isEmpty()) {
            anioGeneracion = categoryData.get("Anio_Generacion").get(0);
        }
    }

    // 5. Banobras/Sedesol
    boolean mostrarBanobras = !mostrarParcels && !mostrarTierrasComunes && !mostrarRnig && !mostrarProcesado &&
        catastroCurtResult != null && !catastroCurtResult.isEmpty();
%>

<% if (mostrarParcels) { %>
    <tr><td colspan="2" class="td-fuente"><strong>Fuente:</strong> RAN</td></tr>
    <tr><th>CURT de la parcela</th><td><%= categoryData.get("CURT_Parcela").get(0) %></td></tr>
    <% if (categoryData.get("Derechos_Titularidad") != null && !categoryData.get("Derechos_Titularidad").isEmpty()) {
        for (String t : categoryData.get("Derechos_Titularidad")) { %>
            <tr><th>Titularidad</th><td><%= t %></td></tr>
    <%  } } %>
<% } else if (mostrarTierrasComunes) { %>
    <tr><td colspan="2" class="td-fuente"><strong>Fuente:</strong> RAN</td></tr>
    <%
        List<String> tierras = categoryData.get("Tierras de uso común");
        for (int i = 0; i < tierras.size(); i++) {
    %>
        <tr>
            <th><%= (i == 0 ? "CURT Tierra de Uso Común" : "Tipo de tierra") %></th>
            <td><%= tierras.get(i) %></td>
        </tr>
    <%
        }
    %>
<% } else if (mostrarRnig) { %>
    <tr>
        <td colspan="2" class="td-fuente">
            <strong>Fuente:</strong> <%= rnigInstitucion %><% if (rnigAnio != null && !rnigAnio.isEmpty()) { %>, <%= rnigAnio %><% } %>
        </td>
    </tr>
    <tr>
        <th>CURT del predio RNIG</th>
        <td><%= rnigCurt %></td>
    </tr>
<% } else if (mostrarProcesado) { %>
    <tr>
        <td colspan="2" class="td-fuente">
            <strong>Fuente:</strong> <%= nombreUnidadEstatal %>
            <% if (anioGeneracion != null && !anioGeneracion.isEmpty()) { %>
            , <%= anioGeneracion %>
            <% } %>
        </td>
    </tr>
    <tr>
        <th>CURT del predio</th>
        <td><%= procesadoCurt %></td>
    </tr>
<% } else if (mostrarBanobras) { %>
    <tr>
        <td colspan="2" class="td-fuente">
            <strong>Fuente:</strong>
            <%
                String banobrasFuente = "";
                if (banobrasLabel != null) {
                    if (banobrasLabel.toUpperCase().contains("BANOBRAS")) {
                        banobrasFuente = "Gobierno Estatal";
                    } else if (banobrasLabel.toUpperCase().contains("SEDESOL")) {
                        banobrasFuente = "Gobierno Municipal";
                    } else {
                        banobrasFuente = banobrasLabel; // fallback
                    }
                }
            %>
            <%= banobrasFuente %>
        </td>
    </tr>
    <tr>
        <th><%= banobrasLabel != null ? banobrasLabel : "" %></th>
        <td><%= catastroCurtResult %></td>
    </tr>
<% } %>
<%
System.out.println("---- FIN BLOQUE DERECHOS ----");
}





    // CATEGORÍA: geodesia
    else if ("geodesia".equals(category)) {
%>
        <tr><td colspan="2" class="td-fuente"><strong>Fuente:</strong> INEGI</td></tr>
<%
        // Banco de Nivel más cercano
        List<String> bancoNivel = categoryData.get("Banco de Nivel más cercano");
        if (bancoNivel != null) {
%>
        <tr><th colspan="2" class="table-subheader">
            Banco de Nivel más cercano
            <%= (bancoNivel.size() > 2 ? " (" + bancoNivel.get(2) + ")" : "") %>
        </th></tr>
<%
            if (bancoNivel.size() > 0) {
%>  <tr><th>Ubicación</th><td><%= bancoNivel.get(0) %></td></tr> <% }
            if (bancoNivel.size() > 1) {
%>  <tr><th>Altura ortométrica</th><td><%= bancoNivel.get(1) %></td></tr> <% }
        }
        // Estación Gravimétrica más cercana
        List<String> estacionGrav = categoryData.get("Estación Gravimétrica más cercana");
        if (estacionGrav != null) {
%>
        <tr><th colspan="2" class="table-subheader">
            Estación Gravimétrica más cercana
            <%= (estacionGrav.size() > 2 ? " (" + estacionGrav.get(2) + ")" : "") %>
        </th></tr>
<%
            if (estacionGrav.size() > 0) {
%>  <tr><th>Ubicación</th><td><%= estacionGrav.get(0) %></td></tr> <% }
            if (estacionGrav.size() > 1) {
%>  <tr><th>Gravedad</th><td><%= estacionGrav.get(1) %></td></tr> <% }
        }
        // Vértice de posicionamiento más cercano
        List<String> vertice = categoryData.get("Vértice de posicionamiento más cercano");
        if (vertice != null) {
%>
        <tr><th colspan="2" class="table-subheader">
            Vértice de posicionamiento más cercano
            <%= (vertice.size() > 2 ? " (" + vertice.get(2) + ")" : "") %>
        </th></tr>
<%
            if (vertice.size() > 0) {
%>  <tr><th>Ubicación</th><td><%= vertice.get(0) %></td></tr> <% }
        }
    }
    // CATEGORÍA: configuracionTerreno
    else if ("configuracionTerreno".equals(category)) {
%>
        <tr><td colspan="2" class="td-fuente"><strong>Fuente:</strong> INEGI</td></tr>
<%
        for (Map.Entry<String, List<String>> e : categoryData.entrySet()) {
            for (String item : e.getValue()) {
%>
        <tr>
            <th>Pendiente</th>
            <td><%= item %></td>
        </tr>
<%
            }
        }
%>
        <tr>
            <td colspan="2">
                <div class="alert alert-info mt-3" style="font-size: 14px; line-height: 1.5;">
                    <strong>Nota:</strong> Las pendientes del terreno se obtienen a partir del Continuo de Elevaciones Mexicano (CEM), del INEGI. Este modelo representa la altitud del terreno en formato raster, donde cada píxel tiene un valor de elevación.<br><br>
                    Las pendientes promedio para cada polígono, se clasificaron en tres rangos:
                    <ul style="margin-top: 10px; margin-bottom: 0;">
                        <li><strong>0 a 14%:</strong> Se consideran pendientes suaves o planas. Son ideales para actividades humanas como asentamientos, agricultura mecanizada o vialidades.</li>
                        <li><strong>15 a 36%:</strong> Son pendientes moderadas. Aquí se pueden realizar actividades con ciertas restricciones, ya que aumenta el riesgo de erosión.</li>
                        <li><strong>Mayor al 36%:</strong> Son pendientes fuertes o escarpadas. Son zonas con alto riesgo de erosión y deslizamientos, por lo que suelen ser poco aptas para actividades humanas.</li>
                    </ul>
                </div>
            </td>
        </tr>
<%
    }
    // CATEGORÍA: OTRAS
    else {
        for (Map.Entry<String, List<String>> e : categoryData.entrySet()) {
            for (String item : e.getValue()) {
%>
        <tr>
            <th><%= e.getKey() %></th>
            <td><%= item %></td>
        </tr>
<%
            }
        }
    }
%>
      </tbody>
    </table>
<%
} // for categories
%>
  </div>
</div>
<%
} // if resultsMap
%>

<!-- Loading Overlay -->
<div id="loadingOverlay">
    <div class="spinner-border text-primary" role="status">
        <span class="visually-hidden">Procesando...</span>
    </div>
    <span class="ms-2">Por favor, espere mientras se procesan sus consultas...</span>
</div>




<script src="https://openlayers.org/en/v6.15.1/build/ol.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.11.0/proj4.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>

<script>
    const form = document.getElementById('curtForm');
    const curtInput = document.getElementById('curt');
    const distanceInput = document.getElementById('distance');
    const curtError = document.getElementById('curtError');
    const distanceError = document.getElementById('distanceError');
    const loadingOverlay = document.getElementById('loadingOverlay');

    form.addEventListener('submit', function (event) {
        let valid = true;
        if (!/^\d{21}P?$/.test(curtInput.value)) {
            curtError.textContent = "La CURT debe contener exactamente 21 dígitos numéricos.";
            valid = false;
        } else {
            curtError.textContent = "";
        }
        if (distanceInput.value <= 0) {
            distanceError.textContent = "El perímetro debe ser un número positivo.";
            valid = false;
        } else {
            distanceError.textContent = "";
        }
        if (!valid) {
            event.preventDefault();
        } else {
            loadingOverlay.style.display = 'flex';
        }
    });

    // Inicializar el mapa en OpenLayers y generar QR si hay resultados y coordenadas
    <c:if test="${not empty resultsMap && not empty lat && not empty lon}">

    var lat = parseFloat('<c:out value="${lat}" escapeXml="false" />');
    var lon = parseFloat('<c:out value="${lon}" escapeXml="false" />');
    var consultedCURT = '<c:out value="${consultedCURT}" escapeXml="false" />';


    // Crear proyección y vista para el mapa de resultados
    const projection = ol.proj.get('EPSG:900913');
    const projectionExtent = projection.getExtent();
    const size = ol.extent.getWidth(projectionExtent) / 256;
    const resolutions = [];
    const matrixIds = [];

    for (let z = 0; z <= 19; z++) {
        resolutions[z] = size / Math.pow(2, z);
        matrixIds[z] = z.toString();
    }

    const resultView = new ol.View({
        center: ol.proj.transform([lon, lat], 'EPSG:4326', 'EPSG:900913'),
        zoom: 12
    });

    // --- Definición de todas las capas base ---

    const osmStandardResult = new ol.layer.Tile({
        source: new ol.source.OSM(),
        title: 'OpenStreetMap Estándar',
        type: 'base'
    });

    const gaiaWMSResult = new ol.layer.Tile({
        opacity: 0.9,
        source: new ol.source.WMTS({
            url: 'https://gaiamapas3.inegi.org.mx/mdmCache/service/wmts?',
            layer: 'MapaBaseTopograficov61_sinsombreado',
            matrixSet: 'EPSG:900913',
            format: 'image/jpeg',
            tileGrid: new ol.tilegrid.WMTS({
                origin: [-20037508.3428, 20037508.3428],
                resolutions: [
                    156543.03392804097, 78271.51696402048, 39135.75848201024,
                    19567.87924100512, 9783.93962050256, 4891.96981025128,
                    2445.98490512564, 1222.99245256282, 611.49622628141,
                    305.748113140705, 152.8740565703525, 76.43702828517625,
                    38.21851414258813, 19.109257071294063, 9.554628535647032,
                    4.777314267823516, 2.388657133911758, 1.194328566955879,
                    0.5971642834779395, 0.29858214173896974
                ],
                matrixIds: Array.from({length: 20}, (v, k) => 'EPSG:900913:' + k)
            }),
            wrapX: true
        }),
        title: 'Gaia Mapas WMTS',
        type: 'base'
    });

    const mapaBaseHipsografico = new ol.layer.Tile({
        opacity: 0.9,
        source: new ol.source.WMTS({
            url: 'https://gaiamapas3.inegi.org.mx/mdmCache/service/wmts?',
            layer: 'MapaBaseHipsografico',
            matrixSet: 'EPSG:900913',
            format: 'image/jpeg',
            tileGrid: new ol.tilegrid.WMTS({
                origin: [-20037508.3428, 20037508.3428],
                resolutions: [
                    156543.03392804097, 78271.51696402048, 39135.75848201024,
                    19567.87924100512, 9783.93962050256, 4891.96981025128,
                    2445.98490512564, 1222.99245256282, 611.49622628141,
                    305.748113140705, 152.8740565703525, 76.43702828517625,
                    38.21851414258813, 19.109257071294063, 9.554628535647032,
                    4.777314267823516, 2.388657133911758, 1.194328566955879,
                    0.5971642834779395, 0.29858214173896974
                ],
                matrixIds: Array.from({length: 20}, (v, k) => 'EPSG:900913:' + k)
            })
        }),
        title: 'Acervo de Información Geográfica (MDMv6)',
        type: 'base'
    });

    const mapaBaseOrtofoto = new ol.layer.Tile({
        opacity: 0.9,
        source: new ol.source.WMTS({
            url: 'https://gaiamapas3.inegi.org.mx/mdmCache/service/wmts?',
            layer: 'MapaBaseOrtofoto',
            matrixSet: 'EPSG:900913',
            format: 'image/jpeg',
            tileGrid: new ol.tilegrid.WMTS({
                origin: [-20037508.3428, 20037508.3428],
                resolutions: [
                    156543.03392804097, 78271.51696402048, 39135.75848201024,
                    19567.87924100512, 9783.93962050256, 4891.96981025128,
                    2445.98490512564, 1222.99245256282, 611.49622628141,
                    305.748113140705, 152.8740565703525, 76.43702828517625,
                    38.21851414258813, 19.109257071294063, 9.554628535647032,
                    4.777314267823516, 2.388657133911758, 1.194328566955879,
                    0.5971642834779395, 0.29858214173896974
                ],
                matrixIds: Array.from({length: 20}, (v, k) => 'EPSG:900913:' + k)
            })
        }),
        title: 'Mapa Base Ortofotos',
        type: 'base'
    });

    const esriWorldImageryResult = new ol.layer.Tile({
        source: new ol.source.XYZ({
            url: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
            attributions: 'Tiles © Esri, Maxar, Earthstar Geographics, y el GIS User Community'
        }),
        title: 'Esri World Imagery',
        type: 'base'
    });

    const cenAgroNacionalLayer = new ol.layer.Tile({
        opacity: 0.9,
        source: new ol.source.TileWMS({
            url: 'http://10.107.12.36:8080/consulta_de_informacion/proxy',
            params: {'LAYERS': 'cenAgro_nacional', 'MAP': '/ms4w/apps/cenAgro2022_nacional/cenAgro2022_nacional.map', 'FORMAT': 'image/png', 'TRANSPARENT': true, 'VERSION': '1.3.0'},
            serverType: 'mapserver'
        }),
        title: 'CenAgro Nacional'
    });

    // 1. Se crea la capa SIDAISAR como un "contenedor" vacío.
//    Esto permite que el resto de la aplicación la reconozca inmediatamente.
const sidaisarWmtsLayer = new ol.layer.Tile({
    title: 'Imagen Satelital (SIDAISAR)',
    type: 'base',
    visible: false, // Inicia oculta
    source: new ol.source.WMTS({}) // La fuente está vacía por ahora
});

// 2. Se lee el archivo XML para obtener la configuración correcta.
fetch('SIDAISAR_GetCapabilities.xml')
    .then(response => {
        if (!response.ok) {
            throw new Error(`Error HTTP: ${response.status}`);
        }
        return response.text();
    })
    .then(text => {
        const parser = new ol.format.WMTSCapabilities();
        const capabilities = parser.read(text);
        
        // Se extraen las opciones para la cuadrícula no-estándar EPSG:3857
        const options = ol.source.WMTS.optionsFromCapabilities(capabilities, {
            layer: 'SIDAISAR',
            matrixSet: 'EPSG:3857'
        });

        // 3. Se "rellena" la capa vacía con la configuración correcta.
        //    La capa se actualizará automáticamente en el mapa.
        sidaisarWmtsLayer.setSource(new ol.source.WMTS(options));
        
        console.log("Capa SIDAISAR configurada y lista.");
    })
    .catch(error => {
        console.error('Error Crítico al cargar o procesar SIDAISAR_GetCapabilities.xml:', error);
        alert('No se pudo cargar la configuración para la capa SIDAISAR. Verifique que el archivo SIDAISAR_GetCapabilities.xml esté en la misma carpeta.');
    });



    // Inicializar el mapa de resultados
    const resultMap = new ol.Map({
        target: 'resultMap',
        // ***** PASO 3: AÑADIR LA NUEVA CAPA A LA LISTA DEL MAPA *****
        layers: [
            mapaBaseOrtofoto, 
            mapaBaseHipsografico, 
            gaiaWMSResult, 
            osmStandardResult, 
            esriWorldImageryResult, 
            cenAgroNacionalLayer,
            sidaisarWmtsLayer // <-- ¡Aquí la agregamos!
        ],
        view: resultView
    });

    // Configuración de la visibilidad inicial de capas
    function setInitialVisibility() {
        osmStandardResult.setVisible(false);
        gaiaWMSResult.setVisible(true); // Esta es la capa que se ve al inicio
        mapaBaseHipsografico.setVisible(false);
        mapaBaseOrtofoto.setVisible(false);
        esriWorldImageryResult.setVisible(false);
        cenAgroNacionalLayer.setVisible(false);
        // ***** PASO 4: AGREGAR LA NUEVA CAPA A LA CONFIGURACIÓN INICIAL *****
        sidaisarWmtsLayer.setVisible(false); // La nueva capa inicia oculta
    }
    setInitialVisibility();


    // Función para cambiar la visibilidad de capas
    function setResultLayerVisibility(layerToShow) {
        // ***** PASO 5: AGREGAR LA NUEVA CAPA A LA FUNCIÓN QUE CAMBIA LA VISIBILIDAD *****
        [
            osmStandardResult, 
            gaiaWMSResult, 
            mapaBaseHipsografico, 
            mapaBaseOrtofoto, 
            esriWorldImageryResult, 
            cenAgroNacionalLayer, 
            sidaisarWmtsLayer // <-- ¡Aquí también!
        ].forEach(layer => layer.setVisible(layer === layerToShow));
    }

// Crear el marcador para la CURT
const marker = new ol.Feature({
    geometry: new ol.geom.Point(ol.proj.fromLonLat([lon, lat]))
});
marker.set("type", "CURT"); // Asignar un atributo único al marcador para identificarlo

const markerStyle = new ol.style.Style({
    image: new ol.style.Icon({
        src: 'https://cdn-icons-png.flaticon.com/512/684/684908.png',
        scale: 0.05
    })
});
marker.setStyle(markerStyle);

// Crear una capa de vectores para el marcador
const vectorSource = new ol.source.Vector({
    features: [marker]
});
const markerLayer = new ol.layer.Vector({
    source: vectorSource
});
resultMap.addLayer(markerLayer);

// Crear un elemento HTML para la etiqueta
const labelElement = document.createElement('div');
labelElement.id = 'marker-label';
labelElement.style.backgroundColor = 'white';
labelElement.style.padding = '5px 10px';
labelElement.style.border = '1px solid #ccc';
labelElement.style.borderRadius = '5px';
labelElement.style.boxShadow = '0 2px 10px rgba(0,0,0,0.2)';
labelElement.style.fontSize = '14px';
labelElement.style.color = '#333';
labelElement.style.whiteSpace = 'nowrap';
labelElement.innerHTML = `<strong>CURT:</strong> ${consultedCURT}`;

// Crear un overlay para la etiqueta
const labelOverlay = new ol.Overlay({
    element: labelElement,
    positioning: 'bottom-center',
    stopEvent: false,
    offset: [0, -25] // Ajustar la posición para que esté justo encima del marcador
});

// Añadir el overlay al mapa
resultMap.addOverlay(labelOverlay);

// Posicionar la etiqueta en el marcador
labelOverlay.setPosition(ol.proj.fromLonLat([lon, lat]));

// Depuración
console.log("Coordenadas del marcador (lon, lat):", [lon, lat]);
console.log("Valor de consultedCURT:", consultedCURT);




<%
/* =========================
   BLOQUE JSP DE BANDERAS
   ========================= */
String rnigGeometryJson        = (String) session.getAttribute("rnigGeometryJson");
String processedParcelJson     = (String) session.getAttribute("processedParcelGeometryJson");
String catastroGeomResult      = (String) session.getAttribute("catastroGeomResult");
String parcelJson              = (String) session.getAttribute("parcelGeometryJson");
String commonLandJson          = (String) session.getAttribute("commonLandGeometryJson");

// Extrae la info de campos de control (categoryData)
Map<String, List<String>> categoryData = null;
if (resultsMap != null && resultsMap.get("gestionTierras") != null) {
    categoryData = resultsMap.get("gestionTierras");
}

// ====== Nuevo orden de prioridad para geometría ======
boolean showParcelIndividual = categoryData != null
    && categoryData.get("CURT_Parcela") != null
    && !categoryData.get("CURT_Parcela").isEmpty()
    && categoryData.get("CURT_Parcela").get(0) != null
    && !categoryData.get("CURT_Parcela").get(0).trim().isEmpty();

boolean showCommonLand = !showParcelIndividual
    && categoryData != null
    && categoryData.get("Tierras de uso común") != null
    && !categoryData.get("Tierras de uso común").isEmpty()
    && categoryData.get("Tierras de uso común").get(0) != null
    && !categoryData.get("Tierras de uso común").get(0).trim().isEmpty();

boolean showRnigParcel = !showParcelIndividual && !showCommonLand
    && categoryData != null
    && categoryData.get("Derechos_CURT_RNIG") != null
    && !categoryData.get("Derechos_CURT_RNIG").isEmpty()
    && categoryData.get("Derechos_CURT_RNIG").get(0) != null
    && !categoryData.get("Derechos_CURT_RNIG").get(0).trim().isEmpty();

boolean showProcessedParcel = !showParcelIndividual && !showCommonLand && !showRnigParcel
    && categoryData != null
    && categoryData.get("Derechos_CURT") != null
    && !categoryData.get("Derechos_CURT").isEmpty()
    && categoryData.get("Derechos_CURT").get(0) != null
    && !categoryData.get("Derechos_CURT").get(0).trim().isEmpty()
    && categoryData.get("NombreUnidadEstatal") != null
    && !categoryData.get("NombreUnidadEstatal").isEmpty()
    && categoryData.get("NombreUnidadEstatal").get(0) != null
    && !categoryData.get("NombreUnidadEstatal").get(0).trim().isEmpty();

boolean showBanobrasParcel = !showParcelIndividual && !showCommonLand && !showRnigParcel && !showProcessedParcel
    && catastroCurtResult != null
    && !catastroCurtResult.trim().isEmpty();

// LOGS para depuración completa
System.out.println("parcelJson:              " + parcelJson);
System.out.println("commonLandJson:          " + commonLandJson);
System.out.println("rnigGeometryJson:        " + rnigGeometryJson);
System.out.println("processedParcelJson:     " + processedParcelJson);
System.out.println("catastroGeomResult:      " + catastroGeomResult);

System.out.println("showParcelIndividual: " + showParcelIndividual);
System.out.println("showCommonLand: " + showCommonLand);
System.out.println("showRnigParcel: " + showRnigParcel);
System.out.println("showProcessedParcel: " + showProcessedParcel);
System.out.println("showBanobrasParcel: " + showBanobrasParcel);
%>

<% if (showParcelIndividual) { %>
    // Parcela individual
    try {
        let parcelaGeom = JSON.parse('<c:out value="${parcelGeometryJson}" escapeXml="false" />');
        const parcelaFeatures = new ol.format.GeoJSON().readFeatures(parcelaGeom, { featureProjection: projection });
        const parcelaLayer = new ol.layer.Vector({
            source: new ol.source.Vector({ features: parcelaFeatures }),
            style: new ol.style.Style({
                stroke: new ol.style.Stroke({ color: 'blue', width: 2 }),
                fill: new ol.style.Fill({ color: 'rgba(0,0,255,0.3)' })
            })
        });
        resultMap.addLayer(parcelaLayer);
        console.log("PARCELA geometry added");
    } catch (err) {
        console.error("Error pintando Parcela:", err);
    }
<% } else if (showCommonLand) { %>
    // Tierras de uso común
    try {
        let commonLandGeom = JSON.parse('<c:out value="${commonLandJson}" escapeXml="false" />');
        const commonLandFeatures = new ol.format.GeoJSON().readFeatures(commonLandGeom, { featureProjection: projection });
        const commonLandLayer = new ol.layer.Vector({
            source: new ol.source.Vector({ features: commonLandFeatures }),
            style: new ol.style.Style({
                stroke: new ol.style.Stroke({ color: 'orange', width: 2, lineDash: [4,4] }),
                fill: new ol.style.Fill({ color: 'rgba(255,165,0,0.25)' })
            })
        });
        resultMap.addLayer(commonLandLayer);
        console.log("COMMON LAND geometry added");
    } catch (err) {
        console.error("Error pintando Tierras de uso común:", err);
    }
<% } else if (showRnigParcel) { %>
    // RNIG
    try {
        let rnigGeom = JSON.parse('<c:out value="${rnigGeometryJson}" escapeXml="false" />');
        if (rnigGeom && rnigGeom.crs) { delete rnigGeom.crs; }
        const rnigFeatures = new ol.format.GeoJSON().readFeatures(rnigGeom, { featureProjection: projection });
        const rnigLayer = new ol.layer.Vector({
            source: new ol.source.Vector({ features: rnigFeatures }),
            style : new ol.style.Style({
                stroke: new ol.style.Stroke({ color: 'red', width: 3 }),
                fill  : new ol.style.Fill({ color: 'rgba(255,0,0,0.13)' })
            })
        });
        resultMap.addLayer(rnigLayer);
        console.log("RNIG geometry added");
    } catch (err) {
        console.error("Error pintando RNIG:", err);
    }
<% } else if (showProcessedParcel) { %>
      // Predio Procesado
    try {
        let procGeom = JSON.parse('<c:out value="${processedParcelGeometryJson}" escapeXml="false" />');
        const procFeatures = new ol.format.GeoJSON().readFeatures(procGeom, { featureProjection: projection });
        const procLayer = new ol.layer.Vector({
            source: new ol.source.Vector({ features: procFeatures }),
            style: new ol.style.Style({
                stroke: new ol.style.Stroke({ color: 'green', width: 2 }),
                fill: new ol.style.Fill({ color: 'rgba(0,255,0,0.3)' })
            })
        });
        resultMap.addLayer(procLayer);
        console.log("PROCESADO geometry added");
    } catch (err) {
        console.error("Error pintando PROCESADO:", err);
    }
<% } else if (showBanobrasParcel) { %>
    // Banobras/Sedesol
    try {
        let banobrasGeom = JSON.parse('<c:out value="${catastroGeomResult}" escapeXml="false" />');
        const banobrasFeatures = new ol.format.GeoJSON().readFeatures(banobrasGeom, { featureProjection: projection });
        const banobrasLayer = new ol.layer.Vector({
            source: new ol.source.Vector({ features: banobrasFeatures }),
            style: new ol.style.Style({
                stroke: new ol.style.Stroke({ color: 'purple', width: 3 }),
                fill: new ol.style.Fill({ color: 'rgba(128,0,128,0.18)' })
            })
        });
        resultMap.addLayer(banobrasLayer);
        console.log("BANOBRAS/SEDESOL geometry added");
    } catch (err) {
        console.error("Error pintando Banobras/Sedesol:", err);
    }
<% } %>





    

    
    
    
function toggleLayerMenu() {
        const layerMenu = document.getElementById('layerMenu');
        layerMenu.classList.toggle('show');
    }

    window.addEventListener('click', function (event) {
        const layerToggleButton = document.getElementById('layerToggle');
        const layerMenu = document.getElementById('layerMenu');
        if (layerToggleButton && layerMenu && !layerToggleButton.contains(event.target) && !layerMenu.contains(event.target)) {
            layerMenu.classList.remove('show');
        }
    });

    // Crear radios dinámicamente para las capas
    function initializeLayerMenu() {
        const layerMenu = document.getElementById('layerMenu');
        if (!layerMenu) return; // Salir si el menú no existe
        layerMenu.innerHTML = ''; 

        // ***** PASO 6: AÑADIR LA NUEVA CAPA A LA LISTA DEL MENÚ DINÁMICO *****
        const layers = [
            { title: 'Mapa Base INEGI', layer: gaiaWMSResult },
            { title: 'Hipsográfico INEGI', layer: mapaBaseHipsografico },
            { title: 'Ortofotos INEGI', layer: mapaBaseOrtofoto },
            { title: 'Imagen Satelital (SIDAISAR)', layer: sidaisarWmtsLayer }, // <-- ¡La agregamos aquí!
            { title: 'Censo Agropecuario', layer: cenAgroNacionalLayer },
            { title: 'OpenStreetMap Estándar', layer: osmStandardResult },
            { title: 'Esri World Imagery', layer: esriWorldImageryResult }
        ];

        layers.forEach(({ title, layer }) => {
            const label = document.createElement('label');
            label.className = 'layer-option';
            label.style.display = 'flex';
            label.style.alignItems = 'center';

            const radio = document.createElement('input');
            radio.type = 'radio';
            radio.name = 'layer';
            radio.value = title;
            radio.checked = layer.getVisible(); 

            radio.addEventListener('change', () => {
                setResultLayerVisibility(layer);
                // No es necesario llamar a initializeLayerMenu() de nuevo, 
                // ya que solo cambia la visibilidad, no la estructura del menú.
            });

            const span = document.createElement('span');
            span.textContent = title;
            span.style.marginLeft = '8px';

            label.appendChild(radio);
            label.appendChild(span);
            layerMenu.appendChild(label);
        });
    }

    initializeLayerMenu();

        // Generar QR de Google Maps con la ubicación de la CURT
        const googleMapsURL = "https://www.google.com/maps/search/?api=1&query=" + lat + "," + lon;
        new QRCode(document.getElementById("qrcode"), {
            text: googleMapsURL,
            width: 250,
            height: 250,
            colorDark : "#343a40",
            colorLight : "#ffffff",
            correctLevel : QRCode.CorrectLevel.H
        });
    </c:if>

    // Función para capturar y enviar la imagen del mapa
    function captureMapAndSendToServer() {
        const mapContainer = document.getElementById("resultMap");
        html2canvas(mapContainer, { useCORS: true }).then(canvas => {
            const mapImageBase64 = canvas.toDataURL("image/png");
            fetch("GuardarMapaImagenServlet", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({ image: mapImageBase64 })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log("Imagen guardada correctamente en el servidor");
                } else {
                    console.error("Error al guardar la imagen en el servidor");
                }
            })
            .catch(error => console.error("Error en la solicitud AJAX:", error));
        }).catch(error => console.error("Error al capturar el mapa:", error));
    }
</script>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const selectAll = document.getElementById("selectAll");
    const checkboxes = document.querySelectorAll(".rubroCheckbox");

    selectAll.addEventListener("change", function () {
      checkboxes.forEach(cb => {
        cb.checked = selectAll.checked;
      });
    });

    // Desmarcar "Seleccionar todo" si se desmarca alguno manualmente
    checkboxes.forEach(cb => {
      cb.addEventListener("change", function () {
        if (!cb.checked) {
          selectAll.checked = false;
        } else {
          const allChecked = Array.from(checkboxes).every(c => c.checked);
          selectAll.checked = allChecked;
        }
      });
    });
  });
</script>

</body>
</html>
