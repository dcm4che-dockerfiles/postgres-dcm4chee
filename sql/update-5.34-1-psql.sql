-- part 1: can be applied on archive running archive 5.33
alter table ups add perf_name_fk bigint unique;
alter table if exists ups add constraint FKhy3cd5se2avt08upapu19y1g6 foreign key (perf_name_fk) references person_name;
create index FKhy3cd5se2avt08upapu19y1g6 on ups (perf_name_fk) ;
update patient_id set entity_id = entity_uid
    where entity_id is null and entity_uid is not null;
update patient_id set entity_uid = concat('iss:', entity_id), entity_uid_type = 'URI'
    where entity_uid is null and entity_id is not null;
update patient_id set entity_id = 'unknown', entity_uid = 'iss:unknown', entity_uid_type = 'URI'
    where entity_id is null;
