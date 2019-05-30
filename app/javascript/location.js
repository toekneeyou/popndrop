import { initMapbox } from './plugins/init_mapbox'

const setHomepageMap = () => {
  const button = document.querySelector('#nearby-toilets');

  if(document.querySelector('#map')) {
    navigator.geolocation.getCurrentPosition((data) => {
      const coords = {
        image_url: "https://thumbs.gfycat.com/LastingAptEagle-max-1mb.gif",
        infoWindow: "This is you!",
        lng: data.coords.longitude,
        lat: data.coords.latitude
      };
      initMapbox(coords)
    });
  }
}

export { setHomepageMap }

