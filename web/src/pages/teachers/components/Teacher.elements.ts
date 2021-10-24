import styled from '@emotion/styled';

export const Container = styled.div`
  background-color: var(--color-gray-light);
  border-radius: 0.5rem;
  padding: 2rem;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
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
  cursor: pointer;

  svg {
    color: var(--color-yellow);
    width: 3rem;
    height: 3rem;
  }
`;

export const ModalHeading = styled.div`
  display: flex;
  align-items: center;
  flex-direction: column;
  justify-content: center;
`;

export const Invite = styled.textarea`
  resize: none;
  background-color: var(--color-gray-lighter);
  border: none;
  height: 15rem;
  margin: 1rem 0;
  padding: 1.5rem 3rem;
  color: var(--color-gray-dark);
  font-weight: 500;
  width: 100%;
  font-size: 1.5rem;
  border-radius: 0.5rem;
  display: block;

  ::-webkit-scrollbar {
    width: 1rem;
    border: none;
  }

  ::-webkit-scrollbar-thumb {
    background-color: var(--color-gray-dark);
    border-radius: 5rem;
  }
`;
