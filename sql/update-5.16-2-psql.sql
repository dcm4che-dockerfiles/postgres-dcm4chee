-- part 2: shall be applied on stopped archive before starting 5.16
update study set expiration_state = 0 where expiration_state is null;
update series set expiration_state = 0 where expiration_state is null;
