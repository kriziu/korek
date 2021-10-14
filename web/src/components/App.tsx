import { FC } from 'react';

import { HashRouter as Router } from 'react-router-dom';
import 'react-toastify/dist/ReactToastify.css';
import { ToastContainer } from 'react-toastify';

import { GlobalStyles } from '../styles/GlobalStyles';
import AnimatedRouter from './AnimatedRouter';

const App: FC = () => {
  return (
    <>
      <GlobalStyles />
      <ToastContainer />
      <Router>
        <AnimatedRouter />
      </Router>
    </>
  );
};

export default App;
