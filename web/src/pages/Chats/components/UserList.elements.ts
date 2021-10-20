import styled from '@emotion/styled';
import { scrollY } from '../../../styles/scroll';

export const Container = styled.div`
  margin: 0 20rem;
`;

export const List = styled.ul`
  list-style: none;
  margin: 5rem 0;
  height: 65vh;
  overflow-y: scroll;

  ${scrollY}

  .item:not(:first-of-type, :last-child) {
    margin: 3rem 0;
  }
`;
