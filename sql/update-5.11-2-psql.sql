-- part 2: shall be applied on stopped archive before starting 5.11
update study set study_size = -1 where study_size is null;
update series set series_size = -1 where series_size is null;
update queue_msg set priority = 4 where priority is null;
