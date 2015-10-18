import React from 'react';
import {Navbar, NavBrand, Nav, NavItem, NavDropdown, MenuItem} from 'react-bootstrap'

window.bootstrap = require('react-bootstrap')

class App extends React.Component {
  render() {
    return <div>
      <Navbar>
        <NavBrand>Next Meeting</NavBrand>
        <Nav>
          <NavItem eventKey={1} href="#">Find the NEXTmeeting!</NavItem>
        </Nav>
      </Navbar>
      { this.props.children }
    </div>;
  }
}

export default App;
