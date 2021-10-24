import axios from 'axios';
import { FC, useContext, useEffect, useState } from 'react';
import { Center } from '../../components/Center';
import Footer from '../../components/Footer/Footer';
import { Header1, Header3 } from '../../components/Header';
import NavBar from '../../components/NavBar/NavBar';
import Rate from '../../components/Rate/Rate';
import { loggedUserContext } from '../../context/loggedUser';

const { REACT_APP_SERVER_URL } = process.env;

const Rates: FC = () => {
  const { user } = useContext(loggedUserContext);

  const [rates, setRates] = useState<RateType[]>([]);
  const [tempUser, setTempUser] = useState<UserType>();

  useEffect(() => {
    axios
      .get<RateType[]>(`${REACT_APP_SERVER_URL}/rates/${user?._id}`)
      .then(res => {
        setRates(res.data);
      });

    axios
      .get<UserType>(`${REACT_APP_SERVER_URL}/users/${user?._id}`)
      .then(res => {
        setTempUser(res.data);
      });
  }, [user?._id]);

  const renderRates = (): JSX.Element[] => {
    return rates.map((rate, index) => {
      return <Rate {...rate} key={index} />;
    });
  };

  return (
    <div>
      <div style={{ minHeight: '100vh' }}>
        <NavBar />
        <Header1 style={{ marginBottom: '2rem' }}>Rates about you</Header1>
        <Header3 style={{ marginBottom: '5rem' }}>
          Your average rate: {tempUser?.rate}
        </Header3>
        <Center>{renderRates()}</Center>
      </div>

      <Footer />
    </div>
  );
};

export default Rates;
