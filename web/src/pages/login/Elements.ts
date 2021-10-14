import styled from '@emotion/styled';

export const Background = styled.div`
  position: absolute;
  width: 100vw;
  height: 100vh;
  background-color: var(--color-yellow);
`;

export const BackBtnSm = styled.button`
  border: none;
  padding: 1.5rem;
  background-color: transparent;
  position: absolute;
  top: 2rem;
  left: 2rem;
  transition: var(--trans-default);

  svg {
    width: 2rem;
    height: 2rem;
    transition: var(--trans-default);
  }

  :hover {
    cursor: pointer;
    padding: 1.5rem;

    svg {
      width: 2.5rem;
      height: 2.5rem;
    }
  }

  :active {
    padding: 1rem;
  }
`;

export const BackBtn = styled.button`
  border: none;
  padding: 2rem;
  background-color: var(--color-white);
  border-radius: 50%;
  position: absolute;
  top: 10rem;
  right: 10rem;
  transition: var(--trans-default);

  svg {
    width: 3rem;
    height: 3rem;
    transition: var(--trans-default);
  }

  :hover {
    cursor: pointer;
    padding: 2.5rem;

    svg {
      width: 4rem;
      height: 4rem;
    }
  }

  :active {
    padding: 2rem;
  }
`;

export const Price = styled.input`
  padding: 1rem;
  font-size: 1.6rem;
  width: 100%;
  border: 1px solid #ccc;
  border-radius: 0.5rem;
`;

export const Card = styled.div`
  padding: 5rem 7rem;
  width: 40%;
  height: max-content;
  border-radius: 5rem;
  position: relative;
  background-color: var(--color-white);

  .flex {
    display: flex;
    justify-content: center;
    margin-bottom: 3rem;
    margin-top: 1rem;

    a {
      margin-left: 0.5rem;
      color: var(--color-yellow);
      text-decoration: underline;
      text-decoration-color: transparent;
      transition: var(--trans-default);

      :hover {
        cursor: pointer;
        text-decoration-color: var(--color-yellow);
      }
    }
  }

  .help {
    display: flex;
    font-size: 1rem;
    font-weight: 500;
    justify-content: flex-end;
    margin-top: 1rem;
    margin-bottom: 1.5rem;
  }
`;

export const Double = styled.div`
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;

  div {
    width: 48%;
  }
`;

export const SelectContainer = styled.div`
  display: flex;
  width: 100%;
  justify-content: flex-start;
  align-items: center;
  margin-top: 2rem;
`;
