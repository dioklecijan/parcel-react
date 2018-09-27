import React from 'react';
import ReactDOM from 'react-dom';

import Hello from './Hello';

// [√]  HMR
// [√]  production build
// [√]  CSS import
// [√]  CSS modules
// [√]  eslint

const App = () => (
  <div>
    <Hello name="Hello Parcel" />
  </div>
);

ReactDOM.render(<App />, document.getElementById('root'));
