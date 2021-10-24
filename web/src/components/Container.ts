import styled from '@emotion/styled';
import { breakpoints } from '../styles/breakpoints';

export const PhoneContainer = styled.div`
  @media screen and (max-width: ${breakpoints.xsm}) {
    padding: 0 2rem;
  }
`;
