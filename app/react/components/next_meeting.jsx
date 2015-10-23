import React from 'react';
import { resolve } from 'react-resolver';
import resolveLocation from '../decorators/resolve_location'


@resolveLocation
export default class NextMeeting extends React.Component {
  componentWillMount() {
    if (this.props.location.error) {
      this.setState({message: this.props.location.error})
    } else {
      this.setState({message: `Your location is: ${this.props.location.coords.latitude}, ${this.props.location.coords.longitude}`})
    }
  }
  render() {
    return <div>Next Meeting! {this.state.message}</div>;

  }
}
