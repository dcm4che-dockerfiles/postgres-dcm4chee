-- part 2: shall be applied on stopped archive before starting 5.12
update queue_msg set device_name = retrieve_task.device_name
  from retrieve_task
  where queue_msg_fk = queue_msg.pk and device_name is null;
update queue_msg set device_name = export_task.device_name
  from export_task
  where queue_msg_fk = queue_msg.pk and device_name is null;
update queue_msg set device_name = 'dcm4chee-arc'
  where device_name is null;

update series set sop_cuid = (
  select sop_cuid
  from instance
  where series_fk = series.pk limit 1)
  where sop_cuid is null;

update series set tsuid = (
  select tsuid
  from instance join location on instance_fk = instance.pk
  where series_fk = series.pk and object_type = 0 limit 1)
  where tsuid is null;
