-- part 2: shall be applied on stopped archive before starting 5.22
update mwl_item set admission_id = '*', institution = '*', department = '*' where admission_id is null;
update study set admission_id = '*' where admission_id is null;
