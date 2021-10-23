import { FC, useContext } from 'react';

import { Link, useHistory } from 'react-router-dom';

import { Nav } from './NavBar.elements';
import { Button } from '../Button';
import { loggedUserContext } from '../../context/loggedUser';

const NavBar: FC = () => {
  const { user } = useContext(loggedUserContext);

  const history = useHistory();

  return (
    <Nav>
      <h3 onClick={() => history.push('/')}>KOREK</h3>
      <ul>
        <li>
          <Link to="/">Chats</Link>
        </li>
        <li>
          <Link to="/discover">
            Discover {user?.userType === 'student' && 'teachers'}
          </Link>
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
