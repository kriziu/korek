import { FC, useContext, useEffect } from 'react';

import { Redirect, Route, Switch, useHistory, useLocation } from 'react-router';
import { CSSTransition, TransitionGroup } from 'react-transition-group';
import { loggedUserContext } from '../context/loggedUser';
import Chats from '../pages/chats/Chats';

import Hero from '../pages/hero/Hero';
import Login from '../pages/login/Login';
import Register from '../pages/login/Register';
import Profile from '../pages/profile/Profile';
import Teachers from '../pages/teachers/Teachers';

import '../styles/animations.css';

const AnimatedRouter: FC = (): JSX.Element => {
  const { user } = useContext(loggedUserContext);

  const location = useLocation();
  const history = useHistory();

  useEffect(() => {
    window.scrollTo({ top: 0, behavior: 'smooth' });

    const { pathname } = location;

    if (
      (pathname !== '/' &&
        pathname !== '/register' &&
        pathname !== '/login' &&
        !user) ||
      (user && (pathname === '/login' || pathname === '/register'))
    )
      history.push('/');
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
              ? user?._id
                ? 'fade'
                : 'left'
              : 'fade'
          }
          key={location.pathname}
          unmountOnExit
        >
          <Switch location={location}>
            <Route exact path="/profile">
              <Profile />
            </Route>
            <Route exact path="/register">
              <Register />
            </Route>
            <Route exact path="/login">
              <Login />
            </Route>
            <Route exact path="/discover">
              {user?.userType === 'teacher' ? <div>1</div> : <Teachers />}
            </Route>
            <Route exact path="/">
              {user?._id ? <Chats /> : <Hero />}
            </Route>
            <Route path="*">
              <Redirect to="/" />
            </Route>
          </Switch>
        </CSSTransition>
      </TransitionGroup>
    </div>
  );
};

export default AnimatedRouter;
