-- part 2: shall be applied on stopped archive before starting 5.10
update study set ext_retrieve_aet = '*' where ext_retrieve_aet is null;
update study set completeness = 0 where completeness is null and failed_retrieves = 0 and failed_iuids = '*';
update study set completeness = 1 where completeness is null and failed_retrieves > 0 and failed_iuids is not null;
update study set completeness = 2 where completeness is null;

update series set completeness = 0 where completeness is null and failed_retrieves = 0 and failed_iuids = '*';
update series set completeness = 1 where completeness is null and failed_retrieves > 0 and failed_iuids is not null;
update series set completeness = 2 where completeness is null;

update export_task set created_time = current_timestamp, updated_time = current_timestamp where created_time is null;
