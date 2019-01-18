-- part 3: can be applied on already running archive 5.16
alter table study alter expiration_state set not null;
alter table series alter expiration_state set not null;
