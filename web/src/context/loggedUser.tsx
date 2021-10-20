import { createContext, FC, useState } from 'react';

export const loggedUserContext = createContext<{
  user: UserType | null;
  setUser: React.Dispatch<React.SetStateAction<UserType | null>>;
}>({ user: null, setUser: () => {} });

const LoggedUserProvider: FC = ({ children }) => {
  const [user, setUser] = useState<UserType | null>(null);

  return (
    <loggedUserContext.Provider value={{ user, setUser }}>
      {children}
    </loggedUserContext.Provider>
  );
};

export default LoggedUserProvider;
