'use strict';

import React from 'react-native';
import NextMeeting from './NextMeeting';

const {
  NavigatorIOS,
  View,
  Text,
  StyleSheet,
} = React;

export default class App extends React.Component {
  render() {
    return (
      <NavigatorIOS
        style={styles.container}
        initialRoute={{
          title: 'NextMeeting',
          component: NextMeeting,
        }}
      />
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f0f9fc',
  },
});
