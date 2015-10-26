import querystring from 'querystring';

export default class Geocoder {
  constructor(address) {
    this.latitude  = undefined
    this.longitude = undefined
    this.address   = address
  }

  geocode() {
    return(fetch(this._queryUri())
      .then(function(response) {
        return response.json();
      }).then((result) => {
        if (result && result.results && (result.results.length > 0)) {
          return({
            latitude: result.results[0].geometry.location.lat,
            longitude: result.results[0].geometry.location.lng
          });
        } else {
          return {};
        }
      })
      .catch((error) => {
        alert(error);
      }));
  }

  _queryUri() {
    return(
      "https://maps.googleapis.com/maps/api/geocode/json?" + querystring.stringify({address: this.address})
    );
  }
}

