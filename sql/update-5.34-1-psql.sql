-- part 1: can be applied on archive running archive 5.33
alter table ups add perf_name_fk bigint unique;
alter table if exists ups add constraint FKhy3cd5se2avt08upapu19y1g6 foreign key (perf_name_fk) references person_name;
create index FKhy3cd5se2avt08upapu19y1g6 on ups (perf_name_fk) ;

alter table patient_id add pat_name varchar(255);
update patient_id set pat_name = (
    select rtrim(concat(
        rtrim(person_name.alphabetic_name, '^'), '=',
        rtrim(person_name.ideographic_name, '^'), '=',
        rtrim(person_name.phonetic_name, '^')), '=')
    from person_name
        join patient on person_name.pk = patient.pat_name_fk
        where patient.pk = patient_id.patient_fk );
update patient_id set pat_name = '*'
    where pat_name is null;
