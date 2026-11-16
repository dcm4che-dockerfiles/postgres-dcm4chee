-- part 2: shall be applied on stopped archive before starting 5.36
update patient_id set created_time=(
    select patient.created_time
    from patient
    where patient.pk = patient_id.patient_fk)
where created_time is null;

update patient_id set updated_time = created_time where updated_time is null;

update metadata set num_instances = (
    select count(instance.pk)
    from instance join series on series_fk=series.pk
    where series.metadata_fk = metadata.pk)
where num_instances = 0
  and pk in (select series.metadata_fk from series where inst_purge_state <> 1);
