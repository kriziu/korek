import styled from '@emotion/styled';
import { Center } from '../../../components/Center';
import { breakpoints } from '../../../styles/breakpoints';
import { scrollY } from '../../../styles/scroll';

export const List = styled.ul`
  list-style: none;
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10rem;
  max-height: 60vh;
  overflow-y: scroll;
  margin-bottom: 4rem;

  ${scrollY}
`;

export const Img = styled.img`
  @media screen and (max-width: ${breakpoints.lg}) {
    width: 60rem;
    height: 60rem;
  }
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

  @media screen and (max-width: ${breakpoints.lg}) {
    width: 50%;
  }

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

export const NotFound = styled(Center)`
  height: 60vh;
  flex-direction: column;
  margin-bottom: 4rem;

  img {
    padding-top: 5rem;
    height: 60rem;
  }
`;
