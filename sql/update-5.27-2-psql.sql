-- part 2: shall be applied on stopped archive before starting 5.27
update series set modified_time = updated_time where modified_time is null;
