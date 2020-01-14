-- part 2: shall be applied on stopped archive before starting 5.20
update export_task set batch_id=queue_msg.batch_id from queue_msg where queue_msg_fk=queue_msg.pk;
