-- part 2: shall be applied on stopped archive before starting 5.34
update patient_id set entity_id = entity_uid
    where entity_id is null and entity_uid is not null;
update patient_id set entity_uid = concat('iss:', entity_id), entity_uid_type = 'URI'
    where entity_uid is null and entity_id is not null;
update patient_id set entity_id = '*', entity_uid = 'iss:*', entity_uid_type = 'URI'
    where entity_id is null;
alter table patient_id add constraint patient_id_pat_id_entity_id_entity_uid_entity_uid_type_key
    unique (pat_id, entity_id, entity_uid, entity_uid_type);
