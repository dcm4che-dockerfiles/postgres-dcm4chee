-- part 1: can be applied on archive running archive 5.11
alter table queue_msg add device_name varchar(255);
alter table series
  add sop_cuid varchar(255),
  add tsuid varchar(255);

update queue_msg set device_name = retrieve_task.device_name
  from retrieve_task
  where queue_msg_fk = queue_msg.pk;
update queue_msg set device_name = export_task.device_name
  from export_task
  where queue_msg_fk = queue_msg.pk;
update queue_msg set device_name = 'dcm4chee-arc'
  where device_name is null;

update series set sop_cuid = (
  select sop_cuid
  from instance
  where series_fk = series.pk limit 1);

update series set tsuid = (
  select tsuid
  from instance join location on instance_fk = instance.pk
  where series_fk = series.pk and object_type = 0 limit 1);

create index UK_kvtxqtdow67hcr2wv8irtdwqy on queue_msg (device_name);
create index UK_jfyulc3fo7cmn29sbha0l72m3 on queue_msg (created_time);
create index UK_7iil4v32vf234i75edsxkdr8f on export_task (created_time);
create index UK_sf2g7oi8cfx89olwch9095hx7 on retrieve_task (created_time);
create index UK_e2lo4ep4t4k07njc09anf6xkm on retrieve_task (updated_time);
create index UK_mrn00m45lkq1xbehmbw5d9jbl on series (sop_cuid);
create index UK_tahx0q1ejidnsam40ans7oecx on series (tsuid);
