<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <title>Visor WMTS SIDAISAR + Marcador</title>
  <link rel="stylesheet" href="https://openlayers.org/en/v6.15.1/css/ol.css">
  <style>
    html, body, #map {
      margin: 0; padding: 0; width: 100%; height: 100%;
    }
  </style>
</head>
<body>
  <div id="map"></div>
  <script src="https://openlayers.org/en/v6.15.1/build/ol.js"></script>
  <script>
    // 1) Creamos el mapa en EPSG:3857
    const map = new ol.Map({
      target: 'map',
      view: new ol.View({
        projection: 'EPSG:3857',
        center: ol.proj.fromLonLat([-116.57108306884766, 31.861661911010742]),
        zoom: 13
      })
    });

    // 2) Cargamos el WMTS desde el XML local (evitamos CORS)
    fetch('SIDAISAR_GetCapabilities.xml')
      .then(r => r.text())
      .then(text => {
        const caps = new ol.format.WMTSCapabilities().read(text);
        const wmtsOptions = ol.source.WMTS.optionsFromCapabilities(caps, {
          layer:     'SIDAISAR',
          matrixSet: 'EPSG:3857'
        });
        const wmtsLayer = new ol.layer.Tile({
          source: new ol.source.WMTS(wmtsOptions)
        });
        map.addLayer(wmtsLayer);

        // 3) Una vez añadida la capa WMTS, creamos y añadimos el marcador
        const lon = -116.57108306884766;
        const lat = 31.861661911010742;
        const coord3857 = ol.proj.fromLonLat([lon, lat], 'EPSG:3857');

        const marker = new ol.Feature({
          geometry: new ol.geom.Point(coord3857)
        });
        marker.setStyle(new ol.style.Style({
          image: new ol.style.Icon({
            src:   'https://cdn-icons-png.flaticon.com/512/684/684908.png',
            scale: 0.05,
            anchor: [0.5, 1]
          })
        }));

        const markerLayer = new ol.layer.Vector({
          source: new ol.source.Vector({ features: [marker] })
        });
        // forzamos que el vector quede por encima:
        markerLayer.setZIndex(100);
        map.addLayer(markerLayer);
      })
      .catch(err => console.error('Error cargando WMTS Capabilities:', err));
  </script>
</body>
</html>
