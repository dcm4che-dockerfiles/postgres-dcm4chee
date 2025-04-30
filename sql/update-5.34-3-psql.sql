-- part 3: can be applied on already running archive 5.34
alter table patient_id
    alter pat_name set not null;

alter table series
    alter metadata_update_load_objects set not null;
