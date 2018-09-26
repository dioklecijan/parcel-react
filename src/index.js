import React from 'react';
import ReactDOM from 'react-dom';
import cls from './index.css';

console.log(cls.title);
// [√]  HMR
// [√]  CSS import
// [√]  CSS modules
//      Must install postcss-modules and set modules:true in .postcssrc
// [√]  production build
const App = () => (
  <div>
    <h1 className={cls.title}>Hello Parcel</h1>
  </div>
);

ReactDOM.render(<App />, document.getElementById('root'));
