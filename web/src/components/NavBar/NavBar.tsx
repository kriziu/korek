import { FC, useLayoutEffect, useState } from 'react';

import { Link, useHistory } from 'react-router-dom';

import { Icon, Margin, Nav, NavBtn } from './NavBar.elements';
import { Button } from '../Button';

const NavBar: FC = () => {
  const history = useHistory();

  const [opened, setOpened] = useState(false);
  const [remWidth, setRemWidth] = useState(document.body.clientWidth);

  useLayoutEffect(() => {
    window.addEventListener('resize', () => {
      setRemWidth(document.body.clientWidth / 16);
    });

    return () => {
      window.removeEventListener('resize', () => {
        setRemWidth(document.body.clientWidth / 16);
      });
    };
  }, []);

  return (
    <>
      <NavBtn opened={!opened} onClick={() => setOpened(!opened)}>
        <Icon opened={!opened} />
      </NavBtn>
      <Nav opened={opened}>
        <h3 onClick={() => history.push('/')}>KOREK</h3>
        <ul>
          <li>
            <Link to="/">Chats</Link>
          </li>
          <li>
            <Link to="/discover">Discover</Link>
          </li>
          <li>
            <Link to="/wallet">Wallet</Link>
          </li>
          <li>
            {remWidth >= 39.375 ? (
              <Button onClick={() => history.push('profile')}>Profile</Button>
            ) : (
              <Link to="/profile">Profile</Link>
            )}
          </li>
        </ul>
      </Nav>
      <Margin></Margin>
    </>
  );
};

export default NavBar;
