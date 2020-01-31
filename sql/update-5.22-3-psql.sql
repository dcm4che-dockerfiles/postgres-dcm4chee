-- part 3: can be applied on already running archive 5.22
alter table mwl_item
    alter admission_id set not null,
    alter institution set not null,
    alter department set not null;

alter table study
    alter admission_id set not null;
