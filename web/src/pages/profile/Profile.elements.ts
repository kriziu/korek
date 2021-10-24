import styled from '@emotion/styled';
import { Center } from '../../components/Center';
import { breakpoints } from '../../styles/breakpoints';

export const Flex = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;

  button {
    height: 5.3rem;
  }
`;

export const Right = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  height: 80rem;
  width: 60%;
  padding-right: 40rem;

  @media screen and (max-width: ${breakpoints.xl}) {
    padding-right: 10rem;
  }

  @media screen and (max-width: ${breakpoints.lg}) {
    width: 50%;
    padding-right: 0;
    margin-left: 50%;
    transform: translateX(-50%);
  }
`;

export const StyledCenter = styled(Center)`
  @media screen and (max-width: ${breakpoints.lg}) {
    display: none;
  }
`;
