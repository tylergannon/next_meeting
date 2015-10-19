import React from "react";
import {resolve} from 'react-resolver';

function locationResolutionFunction(props) {
  return new Promise((resolve, reject) => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition( (position) => {
        resolve({coords: position.coords})
      }, (error) => {
        var error_message;
        switch(error.code) {
            case error.PERMISSION_DENIED:
                error_message = "User denied the request for Geolocation."
                break;
            case error.POSITION_UNAVAILABLE:
                error_message = "Location information is unavailable."
                break;
            case error.TIMEOUT:
                error_message = "The request to get user location timed out."
                break;
            case error.UNKNOWN_ERROR:
                error_message = "An unknown error occurred."
                break;
        }
        resolve({error: error_message})
      })
    } else {
      resolve({error: 'Geolocation Unavailable'})
    }
  });
}
@resolve("location", locationResolutionFunction)
export default function(DecoratedComponent) {
  return class extends React.Component {
    render() {
      return(<DecoratedComponent {...this.props} />);
    }
  }
}



