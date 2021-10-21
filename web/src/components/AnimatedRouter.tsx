import { FC, useContext, useEffect } from 'react';

import { Route, Switch, useHistory, useLocation } from 'react-router';
import { CSSTransition, TransitionGroup } from 'react-transition-group';
import { loggedUserContext } from '../context/loggedUser';
import Chats from '../pages/Chats/Chats';

import Hero from '../pages/hero/Hero';
import Login from '../pages/login/Login';
import Register from '../pages/login/Register';
import Teachers from '../pages/teachers/Teachers';

import '../styles/animations.css';

const AnimatedRouter: FC = (): JSX.Element => {
  const { user } = useContext(loggedUserContext);

  const location = useLocation();
  const history = useHistory();

  useEffect(() => {
    window.scrollTo({ top: 0, behavior: 'smooth' });

    if (
      location.pathname !== '/' &&
      location.pathname !== '/register' &&
      location.pathname !== '/login' &&
      !user
    ) {
      history.push('/');
    }
  }, [location, user, history]);

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
          unmountOnExit
        >
          <Switch location={location}>
            <Route exact path="/register">
              <Register />
            </Route>
            <Route exact path="/login">
              <Login />
            </Route>
            <Route exact path="/discover">
              <Teachers />
            </Route>
            <Route exact path="/chats">
              <Chats />
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
