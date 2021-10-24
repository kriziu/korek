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
  width: 100%;

  @media screen and (max-width: ${breakpoints.lg}) {
    width: 60%;
  }

  @media screen and (max-width: ${breakpoints.sm}) {
    width: 75%;
  }
`;

export const CSCenter = styled.div`
  width: 60%;
  padding-right: 40rem;
  padding-bottom: 5rem;

  @media screen and (max-width: ${breakpoints.xl}) {
    padding-right: 10rem;
  }

  @media screen and (max-width: ${breakpoints.lg}) {
    width: 100%;
    padding-right: 0;
    display: flex;
    justify-content: center;
  }
`;

export const StyledCenter = styled(Center)`
  @media screen and (max-width: ${breakpoints.lg}) {
    display: none;
  }
`;
