import React, { FC } from 'react';

import { MdLockOutline } from 'react-icons/md';
import { FiAtSign } from 'react-icons/fi';
import axios from 'axios';

import { Button } from '../../components/Button';
import { Header1 } from '../../components/Header';
import { Input, InputIcon } from '../../components/Input';
import Template from './Template';
import { Link } from 'react-router-dom';
import useForm from '../../hooks/useForm';
import { validateEmail } from '../../utils/functions';
import { toast } from 'react-toastify';

const { REACT_APP_SERVER_URL } = process.env;

const Login: FC = () => {
  const [formData, , toggleChecked, handleInputChange, checkValidity] = useForm(
    {
      email: { value: '', required: true },
      pass: { value: '', required: true },
    }
  );

  const { email, pass } = formData;

  // TOASTS
  const emailErr = () =>
    toast.error('Account with that email not found!', {
      position: 'top-center',
      autoClose: 10000,
      hideProgressBar: false,
      closeOnClick: true,
      pauseOnHover: true,
      draggable: true,
      progress: undefined,
    });

  const passErr = () =>
    toast.error('Password is wrong!', {
      position: 'top-center',
      autoClose: 10000,
      hideProgressBar: false,
      closeOnClick: true,
      pauseOnHover: true,
      draggable: true,
      progress: undefined,
    });

  const handleFormSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (!checkValidity()) return;
    if (!validateEmail(email.value)) {
      toggleChecked('email');
      return;
    }

    axios
      .post<{ error?: string }>(`${REACT_APP_SERVER_URL}/users/login`, {
        email: email.value,
        password: pass.value,
      })
      .then(res => {
        const { error } = res.data;
        error === 'Cannot find user with that email' && emailErr();
        error === 'Bad password' && passErr();
      });
  };

  return (
    <Template>
      <form noValidate onSubmit={handleFormSubmit}>
        <div style={{ textAlign: 'center' }}>
          <Header1>Log in</Header1>
          <div className="flex">
            Don't have an account? <Link to="/register">Register here</Link>
          </div>
        </div>
        <InputIcon style={{ marginBottom: '1.5rem' }}>
          <FiAtSign />
          <Input
            placeholder="Email Address"
            type="email"
            name="email"
            onChange={handleInputChange}
            value={email.value}
            warn={!email.checked}
          />
        </InputIcon>
        <InputIcon>
          <MdLockOutline />
          <Input
            placeholder="Password"
            type="password"
            name="pass"
            onChange={handleInputChange}
            value={pass.value}
            warn={!pass.checked}
          />
        </InputIcon>

        <div className="help">Forgot password</div>
        <Button style={{ width: '100%' }}>Login</Button>
      </form>
    </Template>
  );
};

export default Login;
