import { FC } from 'react';
import { Nav } from './NavBar.elements';
import { Link, useHistory } from 'react-router-dom';
import { Button } from '../Button';

const NavBar: FC = () => {
  const history = useHistory();

  return (
    <Nav>
      <h3 onClick={() => history.push('/')}>KOREK</h3>
      <ul>
        <li>
          <Link to="/">Chats</Link>
        </li>
        <li>
          <Link to="/discover">Discover Teachers</Link>
        </li>
        <li>
          <Link to="/wallet">Wallet</Link>
        </li>
        <li>
          <Button onClick={() => history.push('profile')}>Profile</Button>
        </li>
      </ul>
    </Nav>
  );
};

export default NavBar;
