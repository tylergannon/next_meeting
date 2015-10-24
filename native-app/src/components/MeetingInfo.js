'use strict';

import React from 'react-native';

const {
  ListView,
  PixelRatio,
  StyleSheet,
  Text,
  TouchableHighlight,
  View,
  MapView
} = React;

export default class MeetingInfo extends React.Component {
  static propTypes = {
    meeting: React.PropTypes.object.isRequired,
  };

  buildAnnotations() {
    return ([{
      latitude: this.props.meeting.location.latitude,
      longitude: this.props.meeting.location.longitude,
      animateDrop: true,
      title: this.props.meeting.name,
      subtitle: this.props.meeting.location.name,
      hasLeftCallout: false,
      hasRightCallout: false,
      onLeftCalloutPress: function(){},
      onRightCalloutPress: function(){},
      id: `${this.props.meeting.id}`}]);
  }

  mapRegion() {
    return({
      latitude: this.props.meeting.location.latitude,
      longitude: this.props.meeting.location.longitude,
      latitudeDelta: 0.1,
      longitudeDelta: 0.1
    });
  }

  render() {
    return (
      <View style={styles.container} >
        <View>
          <MapView style={styles.map} mapType={'standard'} annotations={this.buildAnnotations()} region={this.mapRegion()}>

          </MapView>
        </View>
          <Text style={styles.container}>
            borderStyle is only supported on android for now.
          </Text>
          <Text>
            {this.props.meeting.name}
          </Text>
          <Text>
            {this.props.meeting.formatted_start_time}
          </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f8f8f8',
    fontSize: 16,
    color: '#000000'
  },
  webView: {
    flex: 1,
  },
  map: {
    height: 200,
    margin: 10,
    borderWidth: 1,
    borderColor: '#000000',
  },
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  textInput: {
    width: 150,
    height: 20,
    borderWidth: 0.5,
    borderColor: '#aaaaaa',
    fontSize: 13,
    padding: 4,
  },
  changeButton: {
    alignSelf: 'center',
    marginTop: 5,
    padding: 3,
    borderWidth: 0.5,
    borderColor: '#777777',
  },
});
