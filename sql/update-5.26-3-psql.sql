-- part 3: can be applied on already running archive 5.25
alter table mpps
    drop accno_issuer_fk;

alter table mwl_item
    drop accno_issuer_fk,
    drop admid_issuer_fk;

alter table patient_id
    drop issuer_fk;

alter table series_req
    drop accno_issuer_fk;

alter table study
    drop accno_issuer_fk,
    drop admid_issuer_fk;

alter table ups
    drop admission_issuer_fk,
    drop station_name_fk,
    drop station_class_fk,
    drop station_location_fk;

alter table ups_req
    drop accno_issuer_fk;

drop table issuer;
drop sequence issuer_pk_seq;
