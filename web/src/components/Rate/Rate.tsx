import { FC } from 'react';

import { AiFillStar } from 'react-icons/ai';

import { Avatar } from '../Avatar';
import { Header3 } from '../Header';
import { Flex, Message } from './Rate.elements';

const Rate: FC<RateType> = ({ from, stars, message }) => {
  const renderStars = (): JSX.Element[] => {
    const arr = Array.from(Array(stars).keys());

    return arr.map((e, index) => {
      return <AiFillStar key={index} />;
    });
  };

  return (
    <div style={{ width: '30rem' }}>
      <Flex>
        <Avatar id={from.avatarId} />
        <div>
          <Header3>
            {from.firstName} {from.lastName}
          </Header3>
          {renderStars()}
        </div>
      </Flex>
      <Message>{message}</Message>
    </div>
  );
};

export default Rate;
