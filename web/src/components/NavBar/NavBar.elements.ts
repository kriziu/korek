import styled from '@emotion/styled';
import { breakpoints } from '../../styles/breakpoints';

export const Margin = styled.div`
  @media screen and (max-width: ${breakpoints.xsm}) {
    margin-bottom: 5rem;
  }
`;

export const NavBtn = styled.button<{ opened: boolean }>`
  display: none;

  @media screen and (max-width: ${breakpoints.xsm}) {
    display: block;
  }
  border: none;
  padding: 2.5rem;
  border-radius: 2rem;
  background-color: var(--color-yellow);
  position: fixed;
  top: 2rem;
  right: 2rem;
  transition: var(--trans-default);
  z-index: 11;

  ::after {
    transition: var(--trans-default);
    content: '';
    display: inline-block;
    position: absolute;
    width: 3rem;
    height: 0.3rem;
    top: ${({ opened }) => (opened ? '50%' : '35%')};
    left: 50%;
    transform: translateX(-50%)
      ${({ opened }) => `rotate(${opened ? '315deg' : '0deg'})`};
    background-color: var(--color-white);
  }
  ::before {
    content: '';

    transition: var(--trans-default);
    display: inline-block;
    position: absolute;
    width: 3rem;
    height: 0.3rem;
    top: ${({ opened }) => (opened ? '50%' : '64%')};
    left: 50%;
    transform: translateX(-50%)
      ${({ opened }) => `rotate(${opened ? '-315deg' : '0deg'})`};
    background-color: var(--color-white);
  }
`;

export const Icon = styled.div<{ opened: boolean }>`
  display: inline-block;
  position: absolute;
  width: 3rem;
  height: 0.3rem;
  top: 50%;
  left: 50%;
  transform: translateX(-50%);
  background-color: var(--color-white);
  transition: var(--trans-default);

  opacity: ${({ opened }) => (opened ? 0 : 1)};
`;

export const Nav = styled.nav<{ opened?: boolean }>`
  display: flex;
  padding: 5rem 10rem;
  margin-bottom: 0rem;
  align-items: center;
  justify-content: space-between;
  transition: var(--trans-default);

  @media screen and (max-width: ${breakpoints.sm}) {
    justify-content: flex-end;
  }

  @media screen and (max-width: ${breakpoints.xsm}) {
    z-index: 10;
    justify-content: center;
    position: fixed;
    width: 100%;
    background-color: var(--color-yellow);
    border-bottom-right-radius: 5rem;
    border-bottom-left-radius: 5rem;

    margin-top: ${({ opened }) => (opened ? '-35rem' : '-5rem')};
  }

  h3 {
    letter-spacing: 0.5rem;
    font-size: 3.5rem;
    font-weight: 300;
    cursor: pointer;

    @media screen and (max-width: ${breakpoints.sm}) {
      display: none;
    }
  }

  ul {
    list-style: none;
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 45rem;

    @media screen and (max-width: ${breakpoints.sm}) {
      width: 35rem;
    }

    @media screen and (max-width: ${breakpoints.xsm}) {
      flex-direction: column;
      height: 20rem;
    }

    a {
      text-decoration: underline;
      text-decoration-color: transparent;
      color: var(--color-black);
      transition: var(--trans-default);
      font-weight: 500;

      @media screen and (max-width: ${breakpoints.xsm}) {
        color: var(--color-white);
      }

      :hover {
        text-decoration-color: var(--color-black);

        @media screen and (max-width: ${breakpoints.xsm}) {
          text-decoration-color: var(--color-white);
        }
      }
    }
  }
`;
