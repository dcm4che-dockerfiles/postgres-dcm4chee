create index alphabetic_name_upper_idx on person_name (upper(alphabetic_name));
create index ideographic_name_upper_idx on person_name (upper(ideographic_name));
create index phonetic_name_upper_idx on person_name (upper(phonetic_name));

create index family_name_upper_idx on person_name (upper(family_name));
create index given_name_upper_idx on person_name (upper(given_name));
create index middle_name_upper_idx on person_name (upper(middle_name));

create index series_desc_upper_idx on series (upper(series_desc));
create index study_desc_upper_idx on study (upper(study_desc));