import React from 'react';
import { resolve } from 'react-resolver';
import resolveLocation from '../decorators/resolve_location'

console.log(resolveLocation);

@resolveLocation
export default class NextMeeting extends React.Component {
  constructorBar() {
    
    if (this.props.location && this.props.location.coords) {
      this.state = {
        location: this.props.location,
        searchNear: 'location'
      }
    }
  }
  componentWillMount() {
    if (this.props.location.error) {
      this.state.message = this.props.location.error;
    } else {
      this.state.message = `Your location is: ${this.props.location.coords.latitude}, ${this.props.location.coords.longitude}`
    }
  }
  render() {
    return <div>Next Meeting! {this.state.message}</div>;

  }
}
