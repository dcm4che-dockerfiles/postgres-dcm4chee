-- part 3: can be applied on already running archive 5.11
drop index UK_cxaqwh62doxvy1itpdi43c681;

alter table study alter ext_retrieve_aet set not null;
alter table study alter completeness set not null;
alter table study drop failed_iuids;

alter table series alter completeness set not null;
alter table series drop failed_iuids;

alter table export_task drop constraint UK_aoqbyfnen6evu73ltc1osexfr;
alter table export_task add constraint FK_g6atpiywpo2100kn6ovix7uet foreign key (queue_msg_fk) references queue_msg;
alter table export_task
  alter created_time set not null,
  alter updated_time set not null;

alter table queue_msg alter queue_name set not null;
