import Select, { GroupBase, Props } from 'react-select';

export function StyledSelect<
  Option,
  IsMulti extends boolean = false,
  Group extends GroupBase<Option> = GroupBase<Option>
>(props: Props<Option, IsMulti, Group>) {
  return (
    <Select
      {...props}
      theme={theme => ({
        ...theme,
        colors: {
          ...theme.colors,
          primary: 'var(--color-black)',
          primary25: 'var(--color-yellow)',
        },
      })}
    />
  );
}
