-- part 1: can be applied on archive running archive 5.32
alter table series add access_control_id varchar(255);
update series set access_control_id = '*';
create index IDXdhohkk791t9yvrlt0lihik992 on patient (created_time);
create index IDXr9qbr5jv4ejclglvyvtsynuo9 on series (access_control_id);
