-- part 3: can be applied on already running archive 5.11
alter table study alter study_size set not null;
alter table series alter series_size set not null;
alter table queue_msg alter priority set not null;
