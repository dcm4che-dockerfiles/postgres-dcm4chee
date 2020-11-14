-- part 2: shall be applied on stopped archive before starting 5.23
update person_name
set alphabetic_name = concat(family_name, '^', given_name, '^', middle_name, '^', name_prefix, '^', name_suffix, '^'),
    ideographic_name = concat(i_family_name, '^', i_given_name, '^', i_middle_name, '^', i_name_prefix, '^', i_name_suffix, '^'),
    phonetic_name = concat(p_family_name, '^', p_given_name, '^', p_middle_name, '^', p_name_prefix, '^', p_name_suffix, '^')
where alphabetic_name is null;
