import styled from '@emotion/styled';

export const Button = styled.button<{ secondary?: boolean }>`
  background-color: ${props =>
    props.secondary ? 'var(--color-white)' : 'var(--color-yellow)'};
  border-radius: 0.5rem;
  border: 2px solid var(--color-yellow);
  padding: 0.7rem 2rem;
  font-size: 1.7rem;
  color: ${props =>
    !props.secondary ? 'var(--color-white)' : 'var(--color-yellow)'};

  transition: var(--trans-default);

  :disabled {
    opacity: 0.3;
    :hover {
      cursor: not-allowed;
    }
  }

  :hover :not(:disabled) {
    cursor: pointer;

    background-color: ${props =>
      !props.secondary ? 'var(--color-white)' : 'var(--color-yellow)'};

    color: ${props =>
      props.secondary ? 'var(--color-white)' : 'var(--color-yellow)'};
  }

  :active {
    background-color: ${props =>
      props.secondary ? 'var(--color-white)' : 'var(--color-yellow)'};

    color: ${props =>
      !props.secondary ? 'var(--color-white)' : 'var(--color-yellow)'};
  }
`;
