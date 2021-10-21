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

  .item:not(:last-child) {
    margin-bottom: 6rem;
  }
`;
