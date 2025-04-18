-- part 2: shall be applied on stopped archive before starting 5.34
update patient_id set pat_name = (
    select rtrim(concat(
        rtrim(person_name.alphabetic_name, '^'), '=',
        rtrim(person_name.ideographic_name, '^'), '=',
        rtrim(person_name.phonetic_name, '^')), '=')
    from person_name
        join patient on person_name.pk = patient.pat_name_fk
        where patient.pk = patient_id.patient_fk)
    where pat_name is null;
update patient_id set pat_name = '*'
    where pat_name is null;
alter table patient_id add constraint patient_id_pat_id_pat_name_key
    unique (pat_id, pat_name);
