alter table study add modified_time timestamp;
update study set modified_time = updated_time;
alter table study alter modified_time set not null;

alter table series add inst_purge_time timestamp, add inst_purge_state int4;
update series set inst_purge_state = 0;
alter table series alter inst_purge_state set not null;

delete from series_query_attrs;
alter table series_query_attrs add cuids_in_series varchar(255);

create index UK_a8vyikwd972jomyb3f6brcfh5 on series (inst_purge_time);
create index UK_er4ife08f6eaki91gt3hxt5e on series (inst_purge_state);