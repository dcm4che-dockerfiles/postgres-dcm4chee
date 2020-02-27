-- part 2: shall be applied on stopped archive before starting 5.22
update mwl_item set local_aet = '*', admission_id = '*', institution = '*', department = '*' where local_aet is null;
update study set admission_id = '*' where admission_id is null;
