-- part 1: can be applied on archive running archive 5.34
create table study_access_control_id (study_fk bigint not null, access_control_id varchar(255));
alter table if exists study_access_control_id add constraint FKluah7q5kdwqidu6uwlrsndd7k foreign key (study_fk) references study;

create table series_access_control_id (series_fk bigint not null, access_control_id varchar(255));
alter table if exists series_access_control_id add constraint FKt7uu3btv6pro4wuxspq0pom8y foreign key (series_fk) references series;

alter table series add num_instances integer;
