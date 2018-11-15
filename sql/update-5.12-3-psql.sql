-- part 3: can be applied on already running archive 5.12
alter table queue_msg alter device_name set not null;
alter table series
  alter sop_cuid set not null,
  alter tsuid set not null;
alter table retrieve_task drop device_name;
