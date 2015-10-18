import React from 'react';
import { Router, Route, Link, PropTypes } from 'react_router';
import ReactDOM from 'react-dom';
import App from './components/hello-world';

window.MyRoutes = (
  <Router>
    <Route path="/" component={App} >

    </Route>
  </Router>
);

ReactDOM.render(MyRoutes, document.getElementById('application'));
