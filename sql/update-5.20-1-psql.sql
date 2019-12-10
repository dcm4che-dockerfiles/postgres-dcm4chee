-- part 1: can be applied on archive running archive 5.19
alter table export_task
    add batch_id varchar(255);

create index UK_mt8p2iqcmkoxodkjtfcw1635v on export_task (batch_id);
