-- part 2: shall be applied on stopped archive before starting 5.35
insert into study_access_control_id(study_fk, access_control_id)
select study.pk, study.access_control_id
from study where access_control_id != '*';
create index IDXl3g07pncx4agpayus50wn8u40 on study_access_control_id (access_control_id);
create index FKluah7q5kdwqidu6uwlrsndd7k on study_access_control_id (study_fk) ;

insert into series_access_control_id(series_fk, access_control_id)
select series.pk, series.access_control_id
from series where access_control_id != '*';
create index IDXmt8f5xaiqgiwps1j4riuge3lm on series_access_control_id (access_control_id);
create index FKt7uu3btv6pro4wuxspq0pom8y on series_access_control_id (series_fk) ;

alter table study alter access_control_id drop not null;
alter table series alter access_control_id drop not null;
