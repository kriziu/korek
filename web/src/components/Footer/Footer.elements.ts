import styled from '@emotion/styled';
import { breakpoints } from '../../styles/breakpoints';

export const Container = styled.div`
  width: 100%;
  height: 20rem;
  background-color: var(--color-gray-light);
  padding: 3rem 15rem;

  @media screen and (max-width: ${breakpoints.sm}) {
    display: none;
  }

  .flex {
    display: flex;
    margin-right: 10rem;
    justify-content: space-between;
  }
`;
