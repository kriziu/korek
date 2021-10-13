import { FC } from 'react';

import { HashRouter as Router } from 'react-router-dom';

import { GlobalStyles } from '../styles/GlobalStyles';
import AnimatedRouter from './AnimatedRouter';

const App: FC = () => {
  return (
    <>
      <GlobalStyles />
      <Router>
        <AnimatedRouter />
      </Router>
    </>
  );
};

export default App;
