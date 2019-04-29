-- part 2: shall be applied on stopped archive before starting 5.17
update queue_msg set batch_id = batchID where batch_id <> batchID;
update retrieve_task set batch_id = queue_msg.batch_id
  from queue_msg
  where queue_msg_fk = queue_msg.pk and retrieve_task.batch_id <> queue_msg.batch_id;
