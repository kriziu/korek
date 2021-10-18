import styled from '@emotion/styled';

export const Container = styled.div``;

export const Top = styled.div`
  display: flex;
  align-items: center;

  button {
    margin-left: 2rem;
    width: 15rem;
  }
`;

export const Message = styled.p<{ mine?: boolean }>`
  background-color: ${({ mine }) =>
    mine ? 'var(--color-yellow)' : 'var(--color-gray)'};
`;
