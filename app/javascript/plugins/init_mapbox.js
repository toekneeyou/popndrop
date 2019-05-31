import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';



const initMapbox = (initCoord) => {
  const mapElement = document.getElementById('map');
  const addMarkersToMap = (map, markers) => {
    markers.forEach((marker) => {

      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

      // Create a HTML element for your custom marker
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '100px';
      element.style.height = '100px';

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(element)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(map);
    });
  };
  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 50, maxZoom: 16 });
  };

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/tylermcwilliam/cjw8rcrwg14np1cl6wm6pzumk',
      pitch: 55,
      bearing: 0,
      zoom: 10,
      center: {
        lng: initCoord.lng,
        lat: initCoord.lat
      },
    });
    function rotateCamera(timestamp) {
      // clamp the rotation between 0 -360 degrees
      // Divide timestamp by 100 to slow rotation to ~10 degrees / sec
      map.rotateTo((timestamp / 200) % 360, {duration: 0});
      // Request the next frame of the animation.
      requestAnimationFrame(rotateCamera);
    }

    map.on('load', function () {
    if(document.querySelector('#map')) {
    // Start the animation.
    rotateCamera(0);
    }
    // Add 3d buildings and remove label layers to enhance the map
    var layers = map.getStyle().layers;
    for (var i = 0; i < layers.length; i++) {
    if (layers[i].type === 'symbol' && layers[i].layout['text-field']) {
    // remove text labels
    map.removeLayer(layers[i].id);
    }
    }

    map.addLayer({
    'id': '3d-buildings',
    'source': 'composite',
    'source-layer': 'building',
    'filter': ['==', 'extrude', 'true'],
    'type': 'fill-extrusion',
    'minzoom': 15,
    'paint': {
    'fill-extrusion-color': '#aaa',

    // use an 'interpolate' expression to add a smooth transition effect to the
    // buildings as the user zooms in
    'fill-extrusion-height': [
    "interpolate", ["linear"], ["zoom"],
    15, 0,
    15.05, ["get", "height"]
    ],
    'fill-extrusion-base': [
    "interpolate", ["linear"], ["zoom"],
    15, 0,
    15.05, ["get", "min_height"]
    ],
    'fill-extrusion-opacity': .6
    }
    });
    })
    const markers = JSON.parse(mapElement.dataset.markers);

    if(document.querySelector('.home-map')) {
      markers.push(initCoord);
      const fitbox = [initCoord]
      fitMapToMarkers(map, fitbox)
      addMarkersToMap(map, markers);
      map.addControl(new mapboxgl.NavigationControl());
    } else {
      addMarkersToMap(map, markers)
      fitMapToMarkers(map, markers);
    }

    map.scrollZoom.disable();
  }
};




export { initMapbox };

