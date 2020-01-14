-- part 1: can be applied on archive running archive 5.20
alter table retrieve_task
    add scheduled_time timestamp;

alter table export_task
    alter scheduled_time drop not null;

create index UK_rqp93vxrhyg09x3ck7vc1mawp on retrieve_task (scheduled_time);
