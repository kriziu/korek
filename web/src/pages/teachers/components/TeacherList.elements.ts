import styled from '@emotion/styled';
import { Center } from '../../../components/Center';

export const List = styled.ul`
  list-style: none;
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10rem;
`;

export const SubjectList = styled.ul`
  list-style: none;
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  justify-content: center;
  width: 30%;
  margin-left: 50%;
  transform: translateX(-50%);
  transition: var(--trans-default);
  padding: 1rem 0;
  margin-bottom: 5rem;

  .active,
  li:hover {
    color: var(--color-yellow);
    cursor: pointer;
  }

  li {
    color: var(--color-gray);
    transition: var(--trans-default);
    margin-top: 1rem;
    text-align: center;

    :not(:last-child) {
      margin-right: 3rem;
    }
  }
`;

export const Pages = styled.div`
  display: flex;
  justify-content: space-between;
  width: 10rem;
  margin: 2rem 0;

  button {
    color: var(--color-gray-dark);
    border: none;
    background-color: transparent;
    padding: 0;
    margin: 0;
    text-decoration: underline;
    text-decoration-color: transparent;
    font-size: 1.6rem;
    font-weight: 500;
    transition: var(--trans-default);

    :hover {
      text-decoration-color: var(--color-gray-dark);
      cursor: pointer;
    }

    .disabled {
      color: var(--color-gray);

      :focus {
        text-decoration-color: transparent;
      }
    }
  }
`;
