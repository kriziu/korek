import { FC } from 'react';

import { FiAtSign } from 'react-icons/fi';
import { MdLockOutline, MdPersonOutline } from 'react-icons/md';
import { Link } from 'react-router-dom';

import { Button } from '../../components/Button';
import { Header1 } from '../../components/Header';
import { Input, InputIcon } from '../../components/Input';
import { Double } from './Elements';
import Template from './Template';

const Register: FC = () => {
  return (
    <Template>
      <>
        <div style={{ textAlign: 'center' }}>
          <Header1>Create Account</Header1>
          <div className="flex">
            Already have an account? <Link to="/login">Log in here</Link>
          </div>
        </div>
        <InputIcon style={{ marginBottom: '1.5rem' }}>
          <FiAtSign />
          <Input placeholder="Email Address" />
        </InputIcon>
        <Double>
          <InputIcon>
            <MdPersonOutline />
            <Input placeholder="First Name" />
          </InputIcon>
          <InputIcon>
            <MdPersonOutline />
            <Input placeholder="Last Name" />
          </InputIcon>
        </Double>
        <Double>
          <InputIcon>
            <MdLockOutline />
            <Input placeholder="Password" />
          </InputIcon>
          <InputIcon>
            <MdLockOutline />
            <Input placeholder="Confirm" />
          </InputIcon>
        </Double>
        <Button style={{ width: '100%' }}>Login</Button>
      </>
    </Template>
  );
};

export default Register;
