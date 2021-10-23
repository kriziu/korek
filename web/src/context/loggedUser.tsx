import { createContext, FC, useEffect, useState } from 'react';
import { decodeToken } from 'react-jwt';

export const loggedUserContext = createContext<{
  user: UserType | null;
  token: string | null;
  setUser: React.Dispatch<React.SetStateAction<UserType | null>>;
  setToken: React.Dispatch<React.SetStateAction<string | null>>;
}>({ user: null, token: null, setUser: () => {}, setToken: () => {} });

const LoggedUserProvider: FC = ({ children }) => {
  const [user, setUser] = useState<UserType | null>(null);
  const [token, setToken] = useState<string | null>(null);

  useEffect(() => {
    const localToken = localStorage.getItem('token');

    if (localToken) {
      const decoded = decodeToken(localToken) as {
        iat: number;
        user: UserType;
      };
      setToken(localToken);
      decoded && setUser(decoded.user);
    }
    // eslint-disable-next-line
  }, []);

  useEffect(() => {
    if (token) {
      localStorage.setItem('token', token);
      const decoded = decodeToken(token) as {
        iat: number;
        user: UserType;
      };
      decoded && setUser(decoded.user);
    }
  }, [token]);

  return (
    <loggedUserContext.Provider value={{ user, token, setUser, setToken }}>
      {children}
    </loggedUserContext.Provider>
  );
};

export default LoggedUserProvider;
