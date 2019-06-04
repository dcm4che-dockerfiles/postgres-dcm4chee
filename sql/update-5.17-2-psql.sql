-- part 2: shall be applied on stopped archive before starting 5.17
update queue_msg set batch_id = batchID where batch_id <> batchID;
update retrieve_task
    set device_name = queue_msg.device_name,
        queue_name  = queue_msg.queue_name,
        batch_id    = queue_msg.batch_id
    from queue_msg
    where queue_msg_fk = queue_msg.pk and retrieve_task.device_name is null;
update series set metadata_update_failures = 0 where metadata_update_failures is null;
update metadata
    set created_time = series.updated_time
    from series
    where metadata.pk = metadata_fk and metadata.created_time is null;
update metadata set created_time='2000-01-01 00:00:00' where status != 0 and created_time is null;
