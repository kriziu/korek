import styled from '@emotion/styled';
import { breakpoints } from '../../styles/breakpoints';

export const Img = styled.img`
  @media screen and (max-width: ${breakpoints.lg}) {
    width: 70rem;
    height: 70rem;
  }

  @media screen and (max-width: ${breakpoints.md}) {
    width: 60rem;
    height: 60rem;
    margin-left: 10rem;
  }
`;

export const Container = styled.div`
  display: flex;

  .center {
    flex: 1;
    height: auto;
    flex-direction: column;
    margin-left: -30rem;
    pointer-events: none;
  }

  @media screen and (max-width: ${breakpoints.sm}) {
    .list {
      display: none;
    }

    .center {
      margin-left: -10rem;
    }
  }
`;
