import styled from '@emotion/styled';
import { breakpoints } from '../../../styles/breakpoints';

export const Nav = styled.nav`
  display: flex;
  padding: 5rem 10rem;
  margin-bottom: 12rem;
  align-items: center;
  justify-content: space-between;

  @media screen and (max-width: ${breakpoints.xsm}) {
    padding: 5rem 2rem;
  }

  h3 {
    letter-spacing: 0.5rem;
    font-size: 3.5rem;
    font-weight: 300;

    @media screen and (max-width: ${breakpoints.xsm}) {
    }
  }
`;

export const Container = styled.div`
  @media screen and (max-width: ${breakpoints.xsm}) {
    padding: 0rem 2rem;
  }
`;
