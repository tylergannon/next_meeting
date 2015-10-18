import React from 'react';
import { Router, Route, Link, PropTypes } from 'react-router';
import ReactDOM from 'react-dom';
import Users from './components/hello-world';

import HelloWorld from './components/hello-world';

registerComponent('hello-world', HelloWorld);
window.MyRoutes = (
  <Router>
    <Route path="/" component={Users} >

    </Route>
  </Router>
);


ReactDOM.render(MyRoutes, document.getElementById('application'));
