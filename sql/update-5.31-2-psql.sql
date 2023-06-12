-- part 2: shall be applied on stopped archive before starting 5.31
update patient_id set patient_fk = (
    select patient.pk from patient where patient_id_fk = patient_id.pk )
where patient_fk is null;
