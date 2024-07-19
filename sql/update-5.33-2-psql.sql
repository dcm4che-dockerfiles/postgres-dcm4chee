-- part 2: shall be applied on stopped archive before starting 5.33
update series set access_control_id = '*' where access_control_id is null;
