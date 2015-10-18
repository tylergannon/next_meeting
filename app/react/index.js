import React from 'react';
import { Router, Route, Link, PropTypes } from 'react-router';
import ReactDOM from 'react-dom';
import App from './components/hello-world';


registerComponent('hello-world', App);
window.MyRoutes = (
  <Router>
    <Route path="/" component={App} >

    </Route>
  </Router>
);


ReactDOM.render(MyRoutes, document.getElementById('application'));
