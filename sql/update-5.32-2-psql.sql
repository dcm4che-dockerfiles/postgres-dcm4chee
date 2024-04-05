-- part 2: shall be applied on stopped archive before starting 5.32
update instance set ext_retrieve_aet = '*' where ext_retrieve_aet is null;
update series set ext_retrieve_aet = '*' where ext_retrieve_aet is null;
pdate study set deleting = false where deleting is null;
