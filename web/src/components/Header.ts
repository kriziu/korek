import styled from '@emotion/styled';
import { breakpoints } from '../styles/breakpoints';

export const Header1 = styled.h1`
  font-weight: 500;
  font-size: 4rem;
  text-align: center;

  @media screen and (max-width: ${breakpoints.sm}) {
    font-size: 3rem;
  }
`;

export const Header2 = styled.h2`
  font-weight: 500;
  font-size: 3rem;
  text-align: center;

  @media screen and (max-width: ${breakpoints.sm}) {
    font-size: 2.5rem;
  }
`;

export const Header3 = styled.h1`
  font-weight: 500;
  font-size: 2rem;
  text-align: center;
`;

export const SmallHeader = styled.h5`
  color: var(--color-gray);
  font-weight: 500;
  font-size: 1.5rem;
  text-align: center;
`;
