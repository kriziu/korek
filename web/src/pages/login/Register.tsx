import React, { FC } from 'react';

import { FiAtSign } from 'react-icons/fi';
import { MdLockOutline, MdPersonOutline } from 'react-icons/md';
import { Link } from 'react-router-dom';

import { Button } from '../../components/Button';
import { Header1 } from '../../components/Header';
import { Input, InputIcon } from '../../components/Input';
import useForm from '../../hooks/useForm';
import { validateEmail } from '../../utils/functions';
import { Double } from './Elements';
import Template from './Template';

const Register: FC = () => {
  const [
    formData,
    setFormData,
    toggleChecked,
    handleInputChange,
    checkValidity,
  ] = useForm({
    email: { value: '', required: true },
    fName: { value: '', required: true },
    lName: { value: '', required: true },
    pass: { value: '', required: true },
    confPass: { value: '', required: true },
  });

  const { email, fName, lName, pass, confPass } = formData;

  const makeBigLetter = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (!e.target.value) {
      handleInputChange(e);
      return;
    }

    const oldString = e.target.value;

    setFormData({
      ...formData,
      [e.target.name]: {
        ...formData[e.target.name],
        value: oldString[0].toUpperCase() + oldString.substr(1),
        checked: true,
      },
    });
  };

  const handleSubmitForm = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (!checkValidity()) return;
    if (!validateEmail(email.value)) {
      toggleChecked('email');
      return;
    }
    console.log('e');
  };

  return (
    <Template>
      <form onSubmit={handleSubmitForm} noValidate>
        <div style={{ textAlign: 'center' }}>
          <Header1>Create Account</Header1>
          <div className="flex">
            Already have an account? <Link to="/login">Log in here</Link>
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
        <Double>
          <InputIcon>
            <MdPersonOutline />
            <Input
              placeholder="First Name"
              name="fName"
              onChange={makeBigLetter}
              value={fName.value}
              warn={!fName.checked}
            />
          </InputIcon>
          <InputIcon>
            <MdPersonOutline />
            <Input
              placeholder="Last Name"
              name="lName"
              onChange={makeBigLetter}
              value={lName.value}
              warn={!lName.checked}
            />
          </InputIcon>
        </Double>
        <Double>
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
          <InputIcon>
            <MdLockOutline />
            <Input
              placeholder="Confirm"
              type="password"
              name="confPass"
              onChange={handleInputChange}
              value={confPass.value}
              warn={!confPass.checked}
            />
          </InputIcon>
        </Double>
        <Button style={{ width: '100%' }}>Register</Button>
      </form>
    </Template>
  );
};

export default Register;
