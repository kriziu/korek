import styled from '@emotion/styled';
import { Input } from '../../../components/Input';
import { breakpoints } from '../../../styles/breakpoints';
import { scrollY } from '../../../styles/scroll';

export const Container = styled.div`
  flex: 1;
  @media screen and (max-width: ${breakpoints.sm}) {
    flex: initial;
    width: 80%;
  }
`;

export const Top = styled.div`
  display: flex;
  align-items: center;

  button {
    margin-left: 2rem;
  }
`;

export const SmContainer = styled.div`
  width: 80%;
  @media screen and (max-width: ${breakpoints.sm}) {
    width: 100%;
  }
`;

export const Messages = styled.ul`
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 60vh;
  padding-right: 2rem;
  margin-top: 5rem;
  overflow-y: scroll;

  ${scrollY}
`;

export const Message = styled.p<{ mine?: boolean }>`
  background-color: ${({ mine }) =>
    mine ? 'var(--color-yellow)' : 'var(--color-gray-lighter)'};
  color: ${({ mine }) => (mine ? 'var(--color-white)' : 'var(--color-black)')};
  border-radius: 2rem;
  min-width: 5rem;
  width: max-content;
  max-width: 50rem;
  height: fit-content;
  padding: 2rem;
  font-weight: 500;
  align-self: ${({ mine }) => (mine ? 'flex-end' : 'flex-start')};

  :not(:last-child) {
    margin-bottom: 2rem;
  }
`;

export const StyledInput = styled(Input)`
  border-radius: 2rem;
`;

export const Bottom = styled.form`
  display: flex;
  margin-top: 5rem;
  button {
    margin-left: 2rem;
    width: 15rem;
  }
`;
