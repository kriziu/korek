import { FC, useEffect, useState } from 'react';

import axios from 'axios';
import styled from '@emotion/styled';

import Modal from '../Modal';
import Rate from './Rate';
import { Header2 } from '../Header';
import { Center } from '../Center';
import { scrollY } from '../../styles/scroll';

const { REACT_APP_SERVER_URL } = process.env;

const StyledCenter = styled(Center)`
  overflow-y: scroll;
  ${scrollY}
`;

const RatesPopup: FC<{ close: () => void; teacherId: string }> = ({
  close,
  teacherId,
}) => {
  const [rates, setRates] = useState<RateType[]>([]);

  useEffect(() => {
    teacherId &&
      axios
        .get<RateType[]>(`${REACT_APP_SERVER_URL}/rates/${teacherId}`)
        .then(res => {
          setRates(res.data);
        });
  });

  const renderRates = (): JSX.Element[] => {
    return rates.map((rate, index) => {
      return <Rate {...rate} key={index} />;
    });
  };

  return (
    <Modal close={close}>
      <>
        <Header2 style={{ marginBottom: '2rem' }}>Rates about teacher</Header2>
        <StyledCenter>{renderRates()}</StyledCenter>
      </>
    </Modal>
  );
};

export default RatesPopup;
