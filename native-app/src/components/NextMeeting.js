'use strict';

import React from 'react-native';
// import DocSection from './DocSection';
import meetingData from '../data/meetings';
import Transmit from 'react-transmit';
import MeetingInfo from './MeetingInfo';

const {
  ListView,
  PixelRatio,
  StyleSheet,
  Text,
  TouchableHighlight,
  View,
} = React;

class NextMeeting extends React.Component {
  componentWillMount() {
    const meetings = meetingData;
    // const foobaz   = this.props.meetings;

    var ids = meetings.map(meeting => meeting.id);

    var dataSource = new ListView.DataSource({
      rowHasChanged: (r1, r2) => r1 !== r2,
      getRowData: (data, sectionID, rowId) =>
        meetings[rowId]
    }).cloneWithRows(meetings);

    this.setState({dataSource: dataSource});
  }
  render() {

    return (
      <ListView
        style={styles.container}
        dataSource={this.state.dataSource}
        renderRow={row => this.renderRow(row)}
      />
    );
  }

  renderRow(row) {
    return (
      <View style={styles.row}>
        <TouchableHighlight
          underlayColor='#f7f7f7'
          onPress={() => this.selectRow(row)}>
          <Text style={styles.rowTitle}>
            {row.name} :: {row.formatted_days} at {row.formatted_start_time}
          </Text>
        </TouchableHighlight>
        <Text style={styles.rowTitle}>
        </Text>
        <View style={styles.rowDivider} />
      </View>
    );
  }

  selectRow(meeting) {
    this.props.navigator.push({
      title: meeting.name,
      component: MeetingInfo,
      passProps: {meeting},
    });
  }
}

export default Transmit.createContainer(NextMeeting, {
  fragments: {
    meetings () {
      var url = 'http://localhost:3000/meetings/search.json?latitude=40.7189962&longitude=-73.9629884'
      return fetch(url).then((res) => res.json());
      // return meetingData;
    }
  }
});

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  sectionHeader: {
    paddingTop: 6,
    paddingBottom: 6,
    paddingLeft: 14,
    paddingRight: 14,
    backgroundColor: '#eee',
  },
  sectionTitle: {
    fontSize: 13,
    fontWeight: 'bold',
    color: '#333',
  },
  row: {
    position: 'relative',
  },
  rowTitle: {
    padding: 14,
    fontSize: 16,
    color: '#333',
  },
  rowDivider: {
    position: 'absolute',
    left: 0,
    right: 0,
    bottom: 0,
    height: 1 / PixelRatio.get(),
    backgroundColor: '#ddd',
  },
});
