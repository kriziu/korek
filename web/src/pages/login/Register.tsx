import React, { FC, useState } from 'react';

import { FiAtSign } from 'react-icons/fi';
import { MdLockOutline, MdPersonOutline } from 'react-icons/md';
import { Link } from 'react-router-dom';
import { MultiValue } from 'react-select';
import { CSSTransition, SwitchTransition } from 'react-transition-group';
import axios from 'axios';
import { IoReturnUpBack } from 'react-icons/io5';
import { toast } from 'react-toastify';
import { useHistory } from 'react-router';

import '../../styles/animations.css';
import { Button } from '../../components/Button';
import { Header1, Header3 } from '../../components/Header';
import { Input, InputIcon } from '../../components/Input';
import useForm from '../../hooks/useForm';
import { validateEmail } from '../../utils/functions';
import { BackBtnSm, Double, Price, SelectContainer } from './Elements';
import Template from './Template';
import { StyledSelect } from '../../components/StyledSelect';
import { SelectSubjects, SubjectType } from '../../types/Subjects';
import { Avatar, AvatarSelector } from '../../components/Avatar';
import { Avatars } from '../../types/Avatars';
import { Center } from '../../components/Center';

const { REACT_APP_SERVER_URL } = process.env;

const imAoptions = [
  { value: 'student', label: 'Student' },
  { value: 'teacher', label: 'Teacher' },
];

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

  const [imA, setImA] = useState(imAoptions[0]);
  const [help, setHelp] = useState<MultiValue<SubjectType>>([]);
  const [avatarId, setAvatarId] = useState<Avatars>(Avatars.female_1);
  const [avatarSetter, setAvatarSetter] = useState(false);
  const [valid, setValid] = useState(0);
  const [price, setPrice] = useState('0');

  const { email, fName, lName, pass, confPass } = formData;

  const history = useHistory();

  // TOASTS
  const emailFound = () =>
    toast.error('Account with that email found!', {
      position: 'top-center',
      autoClose: 10000,
      hideProgressBar: false,
      closeOnClick: true,
      pauseOnHover: true,
      draggable: true,
      progress: undefined,
    });

  const success = () =>
    toast.success('Account created!', {
      position: 'top-center',
      autoClose: 10000,
      hideProgressBar: false,
      closeOnClick: true,
      pauseOnHover: true,
      draggable: true,
      progress: undefined,
    });

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
    if (pass.value !== confPass.value) {
      toggleChecked('confPass');
      return;
    }
    if (!checkValidity()) return;
    if (!validateEmail(email.value)) {
      toggleChecked('email');
      return;
    }

    setValid(1);
  };

  const handleAvatarSelect = (id: Avatars) => {
    setAvatarSetter(false);
    setAvatarId(id);
  };

  const handleRegister = () => {
    const subjects = help.map(subject => {
      return subject.value;
    });

    REACT_APP_SERVER_URL &&
      axios
        .post<{ error?: string }>(`${REACT_APP_SERVER_URL}/users`, {
          firstName: fName.value,
          lastName: lName.value,
          email: email.value,
          password: pass.value,
          price,
          avatarId,
          userType: imA.value,
          subjects: subjects,
          connected: [],
        })
        .then(res => {
          res.data.error === 'Found user with that email.'
            ? emailFound()
            : success();

          history.push('/discover');
        })
        .catch(err => console.log(err));
  };

  const renderRegistration = (): JSX.Element => {
    return (
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
    );
  };

  const renderCompletion = (): JSX.Element => {
    return (
      <div>
        <BackBtnSm onClick={() => setValid(0)}>
          <IoReturnUpBack />
        </BackBtnSm>

        <Header1>Complete registration</Header1>
        <SelectContainer>
          <Header3 style={{ marginRight: '2rem' }}>I'm a</Header3>

          <div style={{ flex: 1 }}>
            <StyledSelect
              options={imAoptions}
              value={imA}
              onChange={e => e && setImA(e)}
            />
          </div>
        </SelectContainer>
        {imA === imAoptions[1] && (
          <SelectContainer>
            <label htmlFor="price">
              <Header3 style={{ marginRight: '2rem', textAlign: 'left' }}>
                Price / h
              </Header3>
            </label>
            <div style={{ flex: 1 }}>
              <Price
                id="price"
                value={price}
                type="number"
                onChange={e => {
                  (parseFloat(e.target.value) > 0 || e.target.value === '') &&
                    setPrice(e.target.value);
                }}
              />
            </div>
          </SelectContainer>
        )}

        <div style={{ marginTop: '2rem' }}>
          <Header3 style={{ marginRight: '2rem', textAlign: 'left' }}>
            {imA === imAoptions[0] ? 'I need help with' : 'I can help with'}
          </Header3>

          <StyledSelect
            options={SelectSubjects}
            value={help}
            onChange={e => e && setHelp(e)}
            isMulti
          />
        </div>
        <Center style={{ margin: '2rem 0' }}>
          <Header3 style={{ marginRight: '2rem', textAlign: 'left' }}>
            My avatar
          </Header3>
          <div
            onClick={() => setAvatarSetter(true)}
            style={{ width: 'min-content' }}
          >
            <Avatar id={avatarId} />
          </div>
          <CSSTransition
            in={avatarSetter}
            timeout={200}
            classNames="fade-fast"
            unmountOnExit
          >
            <AvatarSelector
              id={avatarId}
              avatarSelect={handleAvatarSelect}
              close={() => setAvatarSetter(false)}
            />
          </CSSTransition>
        </Center>
        <Button
          style={{ width: '100%' }}
          onClick={() => help.length && handleRegister()}
          disabled={help.length ? false : true}
        >
          Complete
        </Button>
      </div>
    );
  };

  return (
    <Template>
      <SwitchTransition mode="out-in">
        <CSSTransition timeout={200} classNames="fade-fast" key={valid}>
          {!valid ? renderRegistration() : renderCompletion()}
        </CSSTransition>
      </SwitchTransition>
    </Template>
  );
};

export default Register;
