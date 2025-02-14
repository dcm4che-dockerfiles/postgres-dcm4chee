-- part 3: can be applied on already running archive 5.34
alter table patient_id
    alter entity_id set not null,
    alter entity_uid set not null,
    alter entity_uid_type set not null;
