-- part 3: can be applied on already running archive 5.17
alter table queue_msg drop batchID;
alter table retrieve_task
    alter device_name set not null,
    alter queue_name set not null;
alter table series alter metadata_update_failures set not null;
alter table metadata alter created_time set not null;
