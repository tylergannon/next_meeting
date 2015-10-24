import React from 'react';
import { resolve } from 'react-resolver';
import resolveLocation from '../decorators/resolve_location'
import Http from '../utils/http'
import querystring from 'querystring';
import { Well, ListGroup, ListGroupItem } from 'react-bootstrap';
window.querystring = querystring;

@resolveLocation
@resolve("meetings", function(props) {
  var params = {}
  if (props.location.coords) {
    params = {
      latitude: props.location.coords.latitude,
      longitude: props.location.coords.longitude
    }
  }

  return new Promise((resolve, reject) => {
    fetch(`/meetings/search.json?${querystring.stringify(params)}`).then(
      function(response) {
        if (response.status != 200) {
          reject()
        } else {
          response.json().then(function(data) {
            resolve(data)
          })
        }
      }
    );
  });
})
export default class NextMeeting extends React.Component {

  render() {
    return (
    <Well>
      <ListGroup>
        {this.props.meetings.map(function(meeting) {
          return(<ListGroupItem key={meeting.id}>
            { meeting.name }
          </ListGroupItem>);
        })}
      </ListGroup>
    </Well>);
  }
}
