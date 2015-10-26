import React from 'react-native';
import Button from '../Button';

const {
  Component,
  ListView,
  Modal,
  PixelRatio,
  StyleSheet,
  SwitchIOS,
  Text,
  TouchableHighlight,
  View,
} = React;

export default class SearchModal extends Component {
  constructor() {
    super();
    this._toggleTransparent = this._toggleTransparent.bind(this)
    this._toggleAnimated    = this._toggleAnimated.bind(this)
    this._toggleVisible     = this._toggleVisible.bind(this)
    this.state = {
      animated:     true,
      modalVisible: false,
      transparent:  false,
    };
  }

  _toggleVisible() {
    this.setState({modalVisible: !this.state.modalVisible});
  }

  _toggleAnimated() {
    this.setState({animated: !this.state.animated});
  }

  _toggleTransparent() {
    this.setState({transparent: !this.state.transparent});
  }

  render() {
    var modalBackgroundStyle = {
      backgroundColor: this.state.transparent ? 'rgba(0, 0, 0, 0.5)' : '#f5fcff',
    };
    var innerContainerTransparentStyle = this.state.transparent
      ? {backgroundColor: '#fff', padding: 20}
      : null;

    return (
      <View>
        <Modal
          animated={this.state.animated}
          transparent={this.state.transparent}
          visible={this.state.modalVisible}>
          <View style={[styles.container, modalBackgroundStyle]}>
            <View style={[styles.innerContainer, innerContainerTransparentStyle]}>
              <Text>This modal was presented {this.state.animated ? 'with' : 'without'} animation.</Text>
              <Button
                onPress={this._toggleVisible}
                style={styles.modalButton}>
                Close
              </Button>
            </View>
          </View>
        </Modal>

        <View style={styles.row}>
          <Text style={styles.rowTitle}>Animated</Text>
          <SwitchIOS value={this.state.animated} onValueChange={this._toggleAnimated} />
        </View>

        <View style={styles.row}>
          <Text style={styles.rowTitle}>Transparent</Text>
          <SwitchIOS value={this.state.transparent} onValueChange={this._toggleTransparent} />
        </View>

        <Button onPress={this._toggleVisible}>
          Present
        </Button>
      </View>
    );
  }
}


var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    padding: 20,
  },
  innerContainer: {
    borderRadius: 10,
  },
  row: {
    alignItems: 'center',
    flex: 1,
    flexDirection: 'row',
    marginBottom: 20,
  },
  rowTitle: {
    flex: 1,
    fontWeight: 'bold',
  },
  button: {
    borderRadius: 6,
    backgroundColor: '#c1c1c1',
    flex: 1,
    height: 44,
    justifyContent: 'center',
    overflow: 'hidden',
  },
  buttonText: {
    fontSize: 18,
    margin: 5,
    textAlign: 'center',
  },
  modalButton: {
    marginTop: 10,
  },
});
