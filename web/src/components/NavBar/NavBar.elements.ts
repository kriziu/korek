import styled from '@emotion/styled';

export const Nav = styled.nav`
  display: flex;
  padding: 5rem 10rem;
  margin-bottom: 12rem;
  align-items: center;
  justify-content: space-between;

  h3 {
    letter-spacing: 0.5rem;
    font-size: 3.5rem;
    font-weight: 300;
    cursor: pointer;
  }

  ul {
    list-style: none;
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 45rem;

    a {
      text-decoration: underline;
      text-decoration-color: transparent;
      color: var(--color-black);
      transition: var(--trans-default);
      font-weight: 500;

      :hover {
        text-decoration-color: var(--color-black);
      }
    }
  }
`;
