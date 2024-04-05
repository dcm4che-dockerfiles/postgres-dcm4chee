-- part 1: can be applied on archive running archive 5.31
update instance set ext_retrieve_aet = '*' where ext_retrieve_aet is null;
update series set ext_retrieve_aet = '*' where ext_retrieve_aet is null;
alter table study add deleting boolean;
update study set deleting = false;

-- part 2: shall be applied on stopped archive before starting 5.32
update instance set ext_retrieve_aet = '*' where ext_retrieve_aet is null;
update series set ext_retrieve_aet = '*' where ext_retrieve_aet is null;
update study set deleting = false where deleting is null;

-- part 3: can be applied on already running archive 5.32
alter table instance alter ext_retrieve_aet set not null;
alter table series alter ext_retrieve_aet set not null;
alter table study alter deleting set not null;
