-- can be applied on archive running archive 5.25
alter table series
    add receiving_hl7_app varchar(255),
    add receiving_hl7_facility varchar(255),
    add sending_hl7_app varchar(255),
    add sending_hl7_facility varchar(255);

alter table mpps
    add accno_entity_id       varchar(255),
    add accno_entity_uid      varchar(255),
    add accno_entity_uid_type varchar(255);

alter table mwl_item
    add accno_entity_id       varchar(255),
    add accno_entity_uid      varchar(255),
    add accno_entity_uid_type varchar(255),
    add admid_entity_id       varchar(255),
    add admid_entity_uid      varchar(255),
    add admid_entity_uid_type varchar(255);

alter table patient_id
    add entity_id       varchar(255),
    add entity_uid      varchar(255),
    add entity_uid_type varchar(255);

alter table series_req
    add accno_entity_id       varchar(255),
    add accno_entity_uid      varchar(255),
    add accno_entity_uid_type varchar(255);

alter table study
    add accno_entity_id       varchar(255),
    add accno_entity_uid      varchar(255),
    add accno_entity_uid_type varchar(255),
    add admid_entity_id       varchar(255),
    add admid_entity_uid      varchar(255),
    add admid_entity_uid_type varchar(255);

alter table ups
    add admid_entity_id       varchar(255),
    add admid_entity_uid      varchar(255),
    add admid_entity_uid_type varchar(255);

alter table ups_req
    add accno_entity_id       varchar(255),
    add accno_entity_uid      varchar(255),
    add accno_entity_uid_type varchar(255);

create table rel_ups_station_class_code (ups_fk int8 not null, station_class_code_fk int8 not null);
create table rel_ups_station_location_code (ups_fk int8 not null, station_location_code_fk int8 not null);
create table rel_ups_station_name_code (ups_fk int8 not null, station_name_code_fk int8 not null);

alter table rel_ups_station_class_code
    add constraint FK_q26e06qk9gwviwe2ug0f86doa foreign key (station_class_code_fk) references code;
alter table rel_ups_station_class_code
    add constraint FK_e1ioaswm010jlsq6kl7y3um1c foreign key (ups_fk) references ups;

alter table rel_ups_station_location_code
    add constraint FK_kl60ab0k5c1p8qii9ya16424x foreign key (station_location_code_fk) references code;
alter table rel_ups_station_location_code
    add constraint FK_9f0l4glqwpq12d11w9osd475m foreign key (ups_fk) references ups;

alter table rel_ups_station_name_code
    add constraint FK_jtv4r8f88f6gfte0fa36w5y9o foreign key (station_name_code_fk) references code;
alter table rel_ups_station_name_code
    add constraint FK_8jf5xe8ot2yammv3ksd5xrgif foreign key (ups_fk) references ups;

update patient_id
set (entity_id, entity_uid, entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where issuer_fk = issuer.pk)
where issuer_fk is not null;

create index UK_ffpftwfkijejj09tlbxr7u5g8 on series (sending_hl7_app);
create index UK_1e4aqxc5w1557hr3fb3lqm2qb on series (sending_hl7_facility);
create index UK_gj0bxgi55bhjic9s3i4dp2aee on series (receiving_hl7_app);
create index UK_pbay159cdhwbtjvlmel6d6em2 on series (receiving_hl7_facility);

create index UK_tkyjkkxxhnr0fem7m0h3844jk on patient_id (pat_id);
create index UK_d1sdyupb0vwvx23jownjnyy72 on patient_id (entity_id);
create index UK_m2jq6xe87vegohf6g10t5ptew on patient_id (entity_uid, entity_uid_type);

create index FK_q26e06qk9gwviwe2ug0f86doa on rel_ups_station_class_code (station_class_code_fk) ;
create index FK_e1ioaswm010jlsq6kl7y3um1c on rel_ups_station_class_code (ups_fk) ;
create index FK_kl60ab0k5c1p8qii9ya16424x on rel_ups_station_location_code (station_location_code_fk) ;
create index FK_9f0l4glqwpq12d11w9osd475m on rel_ups_station_location_code (ups_fk) ;
create index FK_jtv4r8f88f6gfte0fa36w5y9o on rel_ups_station_name_code (station_name_code_fk) ;
create index FK_8jf5xe8ot2yammv3ksd5xrgif on rel_ups_station_name_code (ups_fk) ;
