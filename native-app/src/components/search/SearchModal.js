import React from 'react-native';
import Button from '../Button';
import moment from 'moment';
import querystring from 'querystring';
import Geocoder from '../../utils/geocoder';

const {
  Component,
  DatePickerIOS,
  ListView,
  Modal,
  PixelRatio,
  StyleSheet,
  SwitchIOS,
  Text,
  TextInput,
  TouchableHighlight,
  View,
} = React;

export default class SearchModal extends Component {
  constructor() {
    super();
    this._toggleVisible        = this._toggleVisible.bind(this)
    this._startingAfterChanged = this._startingAfterChanged.bind(this)
    this._toggleSearchByCurrentLocation = this._toggleSearchByCurrentLocation.bind(this)
    this._handleAddressChanged = this._handleAddressChanged.bind(this)
    this._closeModal           = this._closeModal.bind(this)
    this._doGeocode            = this._doGeocode.bind(this)
    this._respondToGeocodeResult = this._respondToGeocodeResult.bind(this)
    this.state = {
      searchByCurrentLocation: true,
      modalVisible: false,
      startingAfter: moment().toDate(),
      latitude: null,
      longitude: null,
      address: ""
    };
  }

  componentWillMountblah() {
    navigator.geolocation.getCurrentPosition(
      (initialPosition) => this._setLocation(initialPosition),
      (error) => alert(error.message),
      {enableHighAccuracy: true, timeout: 20000, maximumAge: 1000}
    );
  }

  componentWillMount() {
    // Fake geolocation
    var location = {latitude: 40.7189962, longitude: -73.9629884}
    this.setState(location)
    if (this.props.onChange) {
      this.props.onChange({
        latitude: location.latitude,
        longitude: location.longitude,
        searchByCurrentLocation: this.state.searchByCurrentLocation,
        address: this.state.address,
        startingAfter: this.state.startingAfter.toUTCString()
      });
    }
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
        <Modal style={styles.modal} animated={true} transparent={true} visible={this.state.modalVisible}>
          <View style={[styles.container, modalBackgroundStyle]}>
            <View style={[styles.innerContainer, innerContainerTransparentStyle]}>
              <View>
                <Text>
                  Search Settings
                </Text>
              </View>
              <View style={styles.toolbar}>
                <SwitchIOS value={this.state.searchByCurrentLocation}
                  onChange={this._toggleSearchByCurrentLocation} />
                <Text>
                  Search near current location
                </Text>
              </View>
              <TextInput onChangeText={this._handleAddressChanged} autoCorrect={false}
                placeholder="address or postal code" value={this.state.address}
                editable={!this.state.searchByCurrentLocation} style={styles.textInput}
                clearButtonMode="always" />
              <DatePickerIOS
                date={this.state.startingAfter}
                minuteInterval={15} mode="datetime" onDateChange={this._startingAfterChanged} />

              <Button
                onPress={this._closeModal}
                style={styles.modalButton}>
                Close
              </Button>
            </View>
          </View>
        </Modal>
        <Button onPress={this._toggleVisible}>
          Search Settings
        </Button>
      </View>
    );
  }

  _toggleSearchByCurrentLocation() {
    this.setState({
      searchByCurrentLocation: !this.state.searchByCurrentLocation
    });
  }

  _handleAddressChanged(text) {
    this.setState({address: text})
  }

  _toggleVisible() {
    this.setState({modalVisible: !this.state.modalVisible});
  }

  _startingAfterChanged(date) {
    this.setState({startingAfter: date})
  }

  _doGeocode(address) {
    var geo = new Geocoder(this.state.address)
    geo.geocode().then(this._respondToGeocodeResult);
  }

  _respondToGeocodeResult(location) {
    if (location.latitude) {
      alert(querystring.stringify(location))
      this.setState(location)
      this.props.onChange({
        searchByCurrentLocation: this.state.searchByCurrentLocation,
        startingAfter: this.state.startingAfter.toUTCString(),
        latitude: location.latitude,
        longitude: location.longitude,
        address: this.state.address
      })
      this.setState({modalVisible: false});
    } else {
      alert("No results found")
    }
  }

  _closeModal() {
    var latitude
    var longitude
    if (this.state.searchByCurrentLocation) {
      this.props.onChange({
        searchByCurrentLocation: this.state.searchByCurrentLocation,
        startingAfter: this.state.startingAfter.toUTCString(),
        latitude: this.state.latitude,
        longitude: this.state.longitude,
        address: this.state.address
      })
      this.setState({modalVisible: false})
      return
    } else {
      if (this.state.address && this.state.address.length >= 5) {
        this._doGeocode(this.state.address);
        return
      }
    }

    alert("I don't know where you want to go")
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
  textInput: {
    fontSize: 14,
    height: 30,
    borderRadius: 6,
    borderColor: 'black',
    borderWidth: 1,
    flex: 1,
    color: 'black',
    backgroundColor: 'white'
  },
  buttonText: {
    fontSize: 18,
    margin: 5,
    textAlign: 'center',
  },
  modalButton: {
    marginTop: 10,
  },
  toolbar:{
      paddingTop: 0,
      paddingBottom: 0,
      flexDirection:'row'    //Step 1
  },
  toolbarButton:{
      width: 50,            //Step 2
      color:'#000',
      textAlign:'center'
  },
  toolbarTitle:{
      color:'#fff',
      textAlign:'center',
      fontWeight:'bold',
      flex:1                //Step 3
  },
  modal: {
  }

});
