-- part 3: can be applied on already running archive 5.23
alter table person_name
    alter alphabetic_name set not null,
    alter ideographic_name set not null,
    alter phonetic_name set not null;

alter table person_name
    drop family_name,
    drop given_name,
    drop middle_name,
    drop name_prefix,
    drop name_suffix,
    drop i_family_name,
    drop i_given_name,
    drop i_middle_name,
    drop i_name_prefix,
    drop i_name_suffix,
    drop p_family_name,
    drop p_given_name,
    drop p_middle_name,
    drop p_name_prefix,
    drop p_name_suffix;

alter table series
    drop src_aet;
