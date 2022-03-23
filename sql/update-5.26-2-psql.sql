-- part 2: shall be applied on stopped archive before starting 5.25
update mpps
set (accno_entity_id, accno_entity_uid, accno_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where accno_issuer_fk = issuer.pk)
where accno_issuer_fk is not null;

update mwl_item
set (accno_entity_id, accno_entity_uid, accno_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where accno_issuer_fk = issuer.pk)
where accno_issuer_fk is not null;

update mwl_item
set (admid_entity_id, admid_entity_uid, admid_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where admid_issuer_fk = issuer.pk)
where admid_issuer_fk is not null;

update patient_id
set (entity_id, entity_uid, entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where issuer_fk = issuer.pk)
where issuer_fk is not null
  and entity_id is null
  and entity_uid is null;

update series_req
set (accno_entity_id, accno_entity_uid, accno_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where accno_issuer_fk = issuer.pk)
where accno_issuer_fk is not null;

update study
set (accno_entity_id, accno_entity_uid, accno_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where accno_issuer_fk = issuer.pk)
where accno_issuer_fk is not null;

update study
set (admid_entity_id, admid_entity_uid, admid_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where admid_issuer_fk = issuer.pk)
where admid_issuer_fk is not null;

update ups
set (admid_entity_id, admid_entity_uid, admid_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where ups.admission_issuer_fk = issuer.pk)
where admission_issuer_fk is not null;

update ups_req
set (accno_entity_id, accno_entity_uid, accno_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where accno_issuer_fk = issuer.pk)
where accno_issuer_fk is not null;

insert into rel_ups_station_name_code
select ups.pk, ups.station_name_fk from ups where ups.station_name_fk is not null;

insert into rel_ups_station_class_code
select ups.pk, ups.station_class_fk from ups where ups.station_class_fk is not null;

insert into rel_ups_station_location_code
select ups.pk, ups.station_location_fk from ups where ups.station_location_fk is not null;

update mpps
set (accno_entity_id, accno_entity_uid, accno_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where accno_issuer_fk = issuer.pk)
where accno_issuer_fk is not null
  and accno_entity_id is null
  and accno_entity_uid is null;

update mwl_item
set (accno_entity_id, accno_entity_uid, accno_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where accno_issuer_fk = issuer.pk)
where accno_issuer_fk is not null
  and accno_entity_id is null
  and accno_entity_uid is null;

update mwl_item
set (admid_entity_id, admid_entity_uid, admid_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where admid_issuer_fk = issuer.pk)
where admid_issuer_fk is not null
  and admid_entity_id is null
  and admid_entity_uid is null;

update series_req
set (accno_entity_id, accno_entity_uid, accno_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where accno_issuer_fk = issuer.pk)
where accno_issuer_fk is not null
  and accno_entity_id is null
  and accno_entity_uid is null;

update study
set (accno_entity_id, accno_entity_uid, accno_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where accno_issuer_fk = issuer.pk)
where accno_issuer_fk is not null
  and accno_entity_id is null
  and accno_entity_uid is null;

update study
set (admid_entity_id, admid_entity_uid, admid_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where admid_issuer_fk = issuer.pk)
where admid_issuer_fk is not null
  and admid_entity_id is null
  and admid_entity_uid is null;

update ups
set (admid_entity_id, admid_entity_uid, admid_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where ups.admission_issuer_fk = issuer.pk)
where admission_issuer_fk is not null
  and admid_entity_id is null
  and admid_entity_uid is null;

update ups_req
set (accno_entity_id, accno_entity_uid, accno_entity_uid_type) =
        (select issuer.entity_id, issuer.entity_uid, issuer.entity_uid_type
         from issuer where accno_issuer_fk = issuer.pk)
where accno_issuer_fk is not null
  and accno_entity_id is null
  and accno_entity_uid is null;
