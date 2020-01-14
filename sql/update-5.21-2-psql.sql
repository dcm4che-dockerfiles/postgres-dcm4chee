-- part 2: shall be applied on stopped archive before starting 5.21
update retrieve_task set scheduled_time=queue_msg.scheduled_time from queue_msg where queue_msg_fk=queue_msg.pk;
