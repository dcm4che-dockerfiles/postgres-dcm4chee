-- part 3: can be applied on already running archive 5.32
alter table instance alter ext_retrieve_aet set not null;
alter table series alter ext_retrieve_aet set not null;
alter table study alter study_deleting set not null;
