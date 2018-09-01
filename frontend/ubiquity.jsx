import React from 'react';
import ReactDOM from 'react-dom';

import configureStore from './store/store';
import Root from './components/root';

const Modal = require('react-modal');

document.addEventListener('DOMContentLoaded', () => {
    Modal.setAppElement(document.body);

    let store;
    let currentUser = JSON.parse(localStorage.getItem('currentUser'));
    if (currentUser) {
      const preloadedState = { session: { currentUser: currentUser } };
      store = configureStore(preloadedState);
    } else {
      store = configureStore();
    }

    const root = document.getElementById('root');
    ReactDOM.render(<Root store={ store }/>,root);
});
