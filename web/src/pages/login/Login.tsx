import { FC } from 'react';

import { MdLockOutline } from 'react-icons/md';
import { FiAtSign } from 'react-icons/fi';

import { Button } from '../../components/Button';
import { Header1 } from '../../components/Header';
import { Input, InputIcon } from '../../components/Input';
import Template from './Template';
import { Link } from 'react-router-dom';

const Login: FC = () => {
  return (
    <Template>
      <>
        <div style={{ textAlign: 'center' }}>
          <Header1>Log in</Header1>
          <div className="flex">
            Don't have an account? <Link to="/register">Register here</Link>
          </div>
        </div>
        <InputIcon style={{ marginBottom: '1.5rem' }}>
          <FiAtSign />
          <Input placeholder="Email Address" />
        </InputIcon>
        <InputIcon>
          <MdLockOutline />
          <Input placeholder="Password" />
        </InputIcon>

        <div className="help">Forgot password</div>
        <Button style={{ width: '100%' }}>Login</Button>
      </>
    </Template>
  );
};

export default Login;
