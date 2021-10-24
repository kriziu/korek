import { FC, useContext, useEffect, useState } from 'react';

import { MdPersonOutline } from 'react-icons/md';
import { FiAtSign } from 'react-icons/fi';
import { Avatar, AvatarSelector } from '../../components/Avatar';
import { GroupBase, MultiValue, OptionsOrGroups } from 'react-select';
import axios from 'axios';
import { CSSTransition } from 'react-transition-group';
import { toast } from 'react-toastify';

import { Button } from '../../components/Button';
import Footer from '../../components/Footer/Footer';
import { Input, InputIcon } from '../../components/Input';
import NavBar from '../../components/NavBar/NavBar';
import { AVATARS, SUBJECTS } from '../../contants';
import { loggedUserContext } from '../../context/loggedUser';
import { Flex, Right, StyledCenter } from './Profile.elements';
import { StyledSelect } from '../../components/StyledSelect';
import { Header2, Header3 } from '../../components/Header';
import { validateEmail } from '../../utils/functions';

const SelectSubjects: OptionsOrGroups<SubjectType, GroupBase<any>> = [
  { value: SUBJECTS.MATH, label: 'Math' },
  { value: SUBJECTS.CHEMISTRY, label: 'Chemistry' },
  { value: SUBJECTS.PHYSICS, label: 'Physics' },
  { value: SUBJECTS.POLISH, label: 'Polish' },
  { value: SUBJECTS.ENGLISH, label: 'English' },
  { value: SUBJECTS.BIOLOGY, label: 'Biology' },
  { value: SUBJECTS.FRENCH, label: 'French' },
  { value: SUBJECTS.INFORMATIC, label: 'Informatic' },
  { value: SUBJECTS.SPANISH, label: 'Spanish' },
  { value: SUBJECTS.GERMAN, label: 'German' },
  { value: SUBJECTS.HISTORY, label: 'History' },
  { value: SUBJECTS.GEOGRAPHIC, label: 'Geographic' },
];

const { REACT_APP_SERVER_URL } = process.env;

const Profile: FC = () => {
  const { setToken, token, user } = useContext(loggedUserContext);

  const [help, setHelp] = useState<MultiValue<SubjectType>>([]);
  const [avatarSetter, setAvatarSetter] = useState(false);
  const [fName, setFName] = useState('');
  const [lName, setLName] = useState('');
  const [email, setEmail] = useState('');
  const [emailWarn, setEmailWarn] = useState(false);
  const [fWarn, setFWarn] = useState(false);
  const [lWarn, setLWarn] = useState(false);

  const success = () =>
    toast.success('Account updated!', {
      position: 'top-center',
      autoClose: 10000,
      hideProgressBar: false,
      closeOnClick: true,
      pauseOnHover: true,
      draggable: true,
      progress: undefined,
    });

  const error = () =>
    toast.error('Account update error!', {
      position: 'top-center',
      autoClose: 10000,
      hideProgressBar: false,
      closeOnClick: true,
      pauseOnHover: true,
      draggable: true,
      progress: undefined,
    });

  const updateUser = (data: UserType) => {
    token &&
      axios
        .patch<{ token: string }>(`${REACT_APP_SERVER_URL}/users`, data, {
          headers: {
            Authorization: token,
          },
        })
        .then(res => {
          setToken(res.data.token);
          success();
        })
        .catch(err => {
          error();
        });
  };

  useEffect(() => {
    if (user) {
      const subjects = user.subjects.map(subject => {
        return {
          value: subject,
          label: subject[0].toUpperCase() + subject.slice(1),
        };
      });

      setHelp(subjects);
    }
  }, [user]);

  const handleSelectAvatar = (id: AVATARS) => {
    user && updateUser({ ...user, avatarId: id });
    setAvatarSetter(false);
  };

  const handleFNameUpd = () => {
    if (user && fName.length > 2) {
      updateUser({ ...user, firstName: fName });
      setFName('');
    } else {
      setFWarn(true);
    }
  };

  const handleLNameUpd = () => {
    if (user && lName.length > 2) {
      updateUser({ ...user, lastName: lName });
      setLName('');
    } else {
      setLWarn(true);
    }
  };

  const handleEmailUpd = () => {
    if (user && validateEmail(email)) {
      updateUser({ ...user, email: email });
      setEmail('');
    } else {
      setEmailWarn(true);
    }
  };

  const handleSubjectsUpd = () => {
    if (user && help.length) {
      const subjectsUpd = help.map(subject => {
        return subject.value;
      });

      updateUser({ ...user, subjects: subjectsUpd as SUBJECTS[] });
    }
  };

  return (
    <div>
      <div style={{ minHeight: '100vh' }}>
        <NavBar />
        <Flex>
          <StyledCenter style={{ marginLeft: '-30rem', marginRight: '-30rem' }}>
            <img
              src="./images/hero_profile.svg"
              alt="Account edit"
              width="500rem"
            />
          </StyledCenter>
          <Right>
            <Flex style={{ justifyContent: 'flex-end' }}>
              <Header2 style={{ marginRight: '2rem' }}>
                {user?.firstName} {user?.lastName}
              </Header2>
              <div onClick={() => setAvatarSetter(true)}>
                <Avatar id={user?.avatarId as AVATARS} size="lg" />
              </div>
            </Flex>

            <Flex>
              <InputIcon style={{ width: '85%' }}>
                <MdPersonOutline />
                <Input
                  placeholder="First Name"
                  value={fName}
                  onChange={e => {
                    const val = !fName.length
                      ? e.target.value.toUpperCase()
                      : e.target.value;
                    setFWarn(false);
                    setFName(val);
                  }}
                  warn={fWarn}
                />
              </InputIcon>
              <Button onClick={handleFNameUpd}>Save</Button>
            </Flex>
            <Flex>
              <InputIcon style={{ width: '85%' }}>
                <MdPersonOutline />
                <Input
                  placeholder="Last Name"
                  value={lName}
                  onChange={e => {
                    const val = !lName.length
                      ? e.target.value.toUpperCase()
                      : e.target.value;
                    setLWarn(false);
                    setLName(val);
                  }}
                  warn={lWarn}
                />
              </InputIcon>
              <Button onClick={handleLNameUpd}>Save</Button>
            </Flex>
            <Flex>
              <InputIcon style={{ width: '85%' }}>
                <FiAtSign />
                <Input
                  placeholder="Email"
                  value={email}
                  onChange={e => {
                    setEmail(e.target.value);
                    setEmailWarn(false);
                  }}
                  warn={emailWarn}
                />
              </InputIcon>
              <Button onClick={handleEmailUpd}>Save</Button>
            </Flex>
            <div>
              <Header3 style={{ marginTop: '3rem', marginBottom: '1rem' }}>
                Your subjects
              </Header3>
              <StyledSelect
                options={SelectSubjects}
                value={help}
                onChange={e => e && setHelp(e)}
                isMulti
              />
              <Button
                style={{ width: '100%', marginTop: '1rem' }}
                onClick={handleSubjectsUpd}
              >
                Save
              </Button>
            </div>

            <Button onClick={() => setToken(null)} secondary>
              Logout
            </Button>
          </Right>
        </Flex>
      </div>
      <Footer />
      <CSSTransition
        in={avatarSetter}
        timeout={200}
        classNames="fade-fast"
        unmountOnExit
      >
        <AvatarSelector
          id={user?.avatarId as AVATARS}
          avatarSelect={handleSelectAvatar}
          close={() => setAvatarSetter(false)}
        />
      </CSSTransition>
    </div>
  );
};

export default Profile;
