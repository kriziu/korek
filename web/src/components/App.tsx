import { FC } from 'react';

import { HashRouter as Router } from 'react-router-dom';
import 'react-toastify/dist/ReactToastify.css';
import { ToastContainer } from 'react-toastify';

import { GlobalStyles } from '../styles/GlobalStyles';
import AnimatedRouter from './AnimatedRouter';
import LoggedUserProvider from '../context/loggedUser';

const App: FC = () => {
  return (
    <LoggedUserProvider>
      <GlobalStyles />
      <ToastContainer />
      <Router>
        <AnimatedRouter />
      </Router>
    </LoggedUserProvider>
  );
};

export default App;
