import styled from '@emotion/styled';

export const Container = styled.div`
  background-color: var(--color-gray-light);
  border-radius: 0.5rem;
  padding: 2rem;
  display: flex;
  flex-direction: column;
  align-items: center;
`;

export const SubjectList = styled.ul`
  list-style: none;
  display: flex;
  flex-wrap: wrap;
  width: 18rem;
  margin-top: 1rem;
  align-items: center;
  justify-content: center;

  li {
    color: var(--color-gray);

    :not(:last-child)::after {
      content: ', ';
      white-space: pre;
    }
  }
`;

export const Rating = styled.div`
  display: flex;
  margin: 2rem 0;
  align-items: center;

  svg {
    color: var(--color-yellow);
    width: 3rem;
    height: 3rem;
  }
`;
