-- part 3: can be applied on already running archive 5.24
alter table stgcmt_result drop msg_id;

drop table diff_task;
drop table export_task;
drop table retrieve_task;
drop table stgver_task;
drop table queue_msg;
drop table diff_task_attrs;

drop sequence diff_task_pk_seq;
drop sequence export_task_pk_seq;
drop sequence retrieve_task_pk_seq;
drop sequence stgver_task_pk_seq;
drop sequence queue_msg_pk_seq;
