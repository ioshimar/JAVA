<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mapa con Capas Base y WMS en OpenLayers</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ol@v7.3.0/ol.css">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f0f0f0;
        }
        #mapContainer {
            width: 800px;
            height: 600px;
            border: 2px solid #ccc;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: relative;
        }
        #map {
            width: 100%;
            height: 100%;
        }
        .map-overlay {
            position: absolute;
            top: 10px;
            left: 10px;
            background: rgba(255, 255, 255, 0.9);
            padding: 10px 15px;
            border-radius: 4px;
            z-index: 1000;
            max-height: 90%;
            overflow-y: auto;
        }
        .map-overlay button {
            margin-bottom: 10px;
            padding: 5px 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div id="mapContainer">
        <div id="map"></div>
        <div class="map-overlay">
            <button onclick="toggleLayerMenu()">Mostrar/Ocultar Capas</button>
            <div id="layerMenu" style="display: none;"></div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.8.0/proj4.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/ol@v7.3.0/dist/ol.js"></script>
    <script>
        // Registrar la proyección EPSG:6365
        proj4.defs("EPSG:6365", "+proj=longlat +ellps=GRS80 +no_defs");
        ol.proj.proj4.register(proj4);
        const projection = ol.proj.get('EPSG:6365');

        // Configurar el centro del mapa y la vista
        const center = ol.proj.transform([-100.0, 23.0], 'EPSG:4326', 'EPSG:6365');
        const mapView = new ol.View({
            projection: projection,
            center: center,
            zoom: 5
        });

        // Capas base
        const esriBaseLayer = new ol.layer.Tile({
            source: new ol.source.XYZ({
                url: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                attributions: 'Tiles &copy; Esri, Maxar, Earthstar Geographics, y el GIS User Community'
            }),
            title: 'Esri World Imagery',
            type: 'base',
            visible: true
        });

        const osmBaseLayer = new ol.layer.Tile({
            source: new ol.source.OSM(),
            title: 'OpenStreetMap Estándar',
            type: 'base',
            visible: false
        });

        const cenAgroBaseLayer = new ol.layer.Tile({
            source: new ol.source.TileWMS({
                url: 'http://10.107.12.36:8080/consulta_de_informacion/proxy',
                params: {
                    'SERVICE': 'WMS',
                    'VERSION': '1.3.0',
                    'REQUEST': 'GetMap',
                    'LAYERS': 'cenAgro_nacional',
                    'MAP': '/ms4w/apps/cenAgro2022_nacional/cenAgro2022_nacional.map',
                    'FORMAT': 'image/png',
                    'TRANSPARENT': true,
                    'CRS': 'EPSG:6365'
                },
                serverType: 'mapserver',
                crossOrigin: 'anonymous'
            }),
            title: 'CenAgro Nacional',
            type: 'base',
            visible: false
        });

        // Superposición
        const sidaisarLayer = new ol.layer.Image({
            source: new ol.source.ImageWMS({
                url: 'http://10.107.12.36:8081/consulta_de_informacion/proxy2',
                params: {
                    'SERVICE': 'WMS',
                    'VERSION': '1.1.1',
                    'REQUEST': 'GetMap',
                    'LAYERS': 'sidaisar_info_wms',
                    'MAP': '/ms4w/apps/sidaisar_nacional/sidaisar_nacional_info_wms.map',
                    'FORMAT': 'image/png',
                    'TRANSPARENT': true,
                    'SRS': 'EPSG:6365'
                },
                serverType: 'mapserver',
                crossOrigin: 'anonymous'
            }),
            title: 'SIDAISAR Nacional',
            opacity: 0.7,
            visible: true
        });

        // Crear el mapa
        const map = new ol.Map({
            target: 'map',
            view: mapView,
            layers: [esriBaseLayer, osmBaseLayer, cenAgroBaseLayer, sidaisarLayer]
        });

        // Ajustar la vista para cubrir la extensión
        const extent4326 = [-118.365, 14.5321, -86.7104, 32.7187];
        const extent6365 = ol.proj.transformExtent(extent4326, 'EPSG:4326', 'EPSG:6365');
        mapView.fit(extent6365, { size: map.getSize() });

        // Crear el menú de capas
        function initializeLayerMenu() {
            const layerMenu = document.getElementById('layerMenu');
            layerMenu.innerHTML = ''; // Limpiar contenido anterior

            const baseLayers = [
                { title: 'Esri World Imagery', layer: esriBaseLayer },
                { title: 'OpenStreetMap Estándar', layer: osmBaseLayer },
                { title: 'CenAgro Nacional', layer: cenAgroBaseLayer }
            ];

            const overlayLayers = [
                { title: 'SIDAISAR Nacional', layer: sidaisarLayer }
            ];

            const addRadioButton = (title, layer) => {
                const label = document.createElement('label');
                label.style.display = 'block';
                const radio = document.createElement('input');
                radio.type = 'radio';
                radio.name = 'baseLayer';
                radio.checked = layer.getVisible();
                radio.onchange = () => {
                    baseLayers.forEach(({ layer }) => layer.setVisible(false));
                    layer.setVisible(true);
                };
                label.appendChild(radio);
                label.appendChild(document.createTextNode(title));
                layerMenu.appendChild(label);
            };

            baseLayers.forEach(({ title, layer }) => addRadioButton(title, layer));

            const addCheckbox = (title, layer) => {
                const label = document.createElement('label');
                label.style.display = 'block';
                const checkbox = document.createElement('input');
                checkbox.type = 'checkbox';
                checkbox.checked = layer.getVisible();
                checkbox.onchange = () => layer.setVisible(checkbox.checked);
                label.appendChild(checkbox);
                label.appendChild(document.createTextNode(title));
                layerMenu.appendChild(label);
            };

            overlayLayers.forEach(({ title, layer }) => addCheckbox(title, layer));
        }

        initializeLayerMenu();

        // Función para alternar el menú
        function toggleLayerMenu() {
            const layerMenu = document.getElementById('layerMenu');
            layerMenu.style.display = layerMenu.style.display === 'none' ? 'block' : 'none';
        }

        // Listeners para errores
        cenAgroBaseLayer.getSource().on('tileloaderror', (event) => {
            console.error('Error cargando CenAgro:', event);
        });

        sidaisarLayer.getSource().on('imageloaderror', (event) => {
            console.error('Error cargando SIDAISAR:', event);
        });
    </script>
</body>
</html>
