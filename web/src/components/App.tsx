import { FC } from 'react';

import { Global, css } from '@emotion/react';
import { HashRouter as Router, Switch, Route } from 'react-router-dom';

import Hero from '../pages/hero/Hero';
import Footer from './Footer/Footer';
import Login from '../pages/login/Login';
import Register from '../pages/login/Register';

const GlobalStyles = () => (
  <Global
    styles={css`
      *,
      *::after,
      *::before {
        margin: 0;
        padding: 0;
        box-sizing: inherit;
        font-family: 'Montserrat', sans-serif;
        transition: var(---trans-default);
      }

      body {
        margin: 0;
        padding: 0;
        font-size: 1.6rem;
        font-family: 'Montserrat', sans-serif;
        box-sizing: border-box;
        transition: all 0.3s;
      }

      html {
        font-size: 62.5%;
      }

      :root {
        // COLORS
        --color-yellow: #ffc526;
        --color-gray: #cbd5e0;
        --color-gray-lighter: #fafafa;
        --color-gray-light: #fcfcfc;
        --color-gray-dark: #343434;
        --color-black: #222;
        --color-white: #fff;

        // TRANSITIONS
        --trans-default: all 0.2s ease;

        // SHADOWS
        --shadow-default: 0px 5px 30px 2px rgba(0, 0, 0, 0.2);
      }
    `}
  />
);

const App: FC = () => {
  return (
    <>
      <GlobalStyles />
      <Router>
        <Switch>
          <Route path="/login">
            <Login />
          </Route>
          <Route path="/register">
            <Register />
          </Route>
          <Route path="/">
            <Hero />
            <Footer />
          </Route>
        </Switch>
      </Router>
    </>
  );
};

export default App;
