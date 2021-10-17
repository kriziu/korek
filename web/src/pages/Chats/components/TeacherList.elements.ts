import styled from '@emotion/styled';

export const Container = styled.div`
  margin: 0 20rem;
`;

export const List = styled.ul`
  list-style: none;
  margin: 5rem 0;
  height: 65vh;
  overflow-y: scroll;

  ::-webkit-scrollbar {
    width: 1rem;
    border: none;
  }

  ::-webkit-scrollbar-thumb {
    background-color: var(--color-gray-dark);
    border-radius: 5rem;
  }

  .item:not(:first-child, :last-child) {
    margin: 3rem 0;
  }
`;
