import { FC, useEffect } from 'react';

import { Route, Switch, useLocation } from 'react-router';
import { CSSTransition, TransitionGroup } from 'react-transition-group';

import Hero from '../pages/hero/Hero';
import Login from '../pages/login/Login';
import Register from '../pages/login/Register';

import '../styles/animations.css';

const AnimatedRouter: FC = (): JSX.Element => {
  const location = useLocation();

  useEffect(() => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }, [location]);

  return (
    <div style={{ position: 'relative' }}>
      <TransitionGroup component={null}>
        <CSSTransition
          timeout={700}
          classNames={
            location.pathname === '/login' || location.pathname === '/register'
              ? 'right'
              : location.pathname === '/'
              ? 'left'
              : 'fade'
          }
          key={location.pathname}
        >
          <Switch location={location}>
            <Route exact path="/register">
              <Register />
            </Route>
            <Route exact path="/login">
              <Login />
            </Route>
            <Route exact path="/">
              <Hero />
            </Route>
          </Switch>
        </CSSTransition>
      </TransitionGroup>
    </div>
  );
};

export default AnimatedRouter;
