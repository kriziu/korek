import styled from '@emotion/styled';

export const Input = styled.input`
  background-color: var(--color-gray-lighter);
  border: none;
  padding: 1.5rem 3rem;
  color: var(--color-gray-dark);
  font-weight: 500;
  width: 100%;
  font-size: 1.5rem;
  border-radius: 0.5rem;
  display: block;

  :focus {
  }
`;

export const InputIcon = styled.div`
  position: relative;

  svg {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    left: 2rem;
    width: 2rem;
    height: 2rem;
  }

  input {
    padding-left: 5rem;
  }
`;
