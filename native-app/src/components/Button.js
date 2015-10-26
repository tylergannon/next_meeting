import React from 'react-native';

const {
  Component,
  StyleSheet,
  Text,
  TouchableHighlight,
  View,
} = React;

export default class Button extends Component {
  constructor() {
    super()
    this._onHighlight       = this._onHighlight.bind(this)
    this._onUnhighlight     = this._onUnhighlight.bind(this)
    this.state = {
      active: false,
    }
  }

  _onHighlight() {
    this.setState({active: true});
  }

  _onUnhighlight() {
    this.setState({active: false});
  }

  render() {
    var colorStyle = {
      color: this.state.active ? '#fff' : '#000',
    };
    return (
      <TouchableHighlight
        onHideUnderlay={this._onUnhighlight}
        onPress={this.props.onPress}
        onShowUnderlay={this._onHighlight}
        style={[styles.button, this.props.style]}
        underlayColor="#a9d9d4">
          <Text style={[styles.buttonText, colorStyle]}>{this.props.children}</Text>
      </TouchableHighlight>
    );
  }
}

var styles = StyleSheet.create({
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
