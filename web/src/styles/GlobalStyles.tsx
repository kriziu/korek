import { css, Global } from '@emotion/react';

export const GlobalStyles = () => (
  <Global
    styles={css`
      *,
      *::after,
      *::before {
        margin: 0;
        padding: 0;
        box-sizing: inherit;
        font-family: 'Montserrat', sans-serif;
        transition: var(---trans-default);
      }

      body {
        margin: 0;
        padding: 0;
        font-size: 1.6rem;
        font-family: 'Montserrat', sans-serif;
        box-sizing: border-box;
        transition: all 0.3s;

        ::-webkit-scrollbar {
          width: 1rem;
          border: none;
        }

        ::-webkit-scrollbar-thumb {
          background-color: var(--color-gray-dark);
          border-radius: 5rem;
        }
      }

      html {
        font-size: 62.5%;
      }

      :root {
        // COLORS
        --color-yellow: #ffc526;
        --color-gray: #cbd5e0;
        --color-gray-lighter: #fafafa;
        --color-gray-light: #fcfcfc;
        --color-gray-dark: #343434;
        --color-black: #222;
        --color-white: #fff;
        --color-red: #e53e3e;

        // TRANSITIONS
        --trans-default: all 0.2s ease;
        --trans-long: all 0.7s ease;

        // SHADOWS
        --shadow-default: 0px 5px 30px 2px rgba(0, 0, 0, 0.2);
      }
    `}
  />
);
