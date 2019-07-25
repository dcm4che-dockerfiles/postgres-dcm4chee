-- part 2: shall be applied on stopped archive before starting 5.18
insert into rejected_instance (pk, created_time, sop_cuid, sop_iuid, reject_code_fk, series_iuid, study_iuid)
    (select nextval('rejected_instance_pk_seq'), i.updated_time, i.sop_cuid, i.sop_iuid, i.reject_code_fk, se.series_iuid, st.study_iuid
     from instance i join series se on i.series_fk = se.pk join study st on se.study_fk = st.pk
     where i.reject_code_fk notnull and i.updated_time > current_date and not exists (
         select 1 from rejected_instance ri
         where ri.study_iuid = st.study_iuid and ri.series_iuid = se.series_iuid and ri.sop_iuid = i.sop_iuid));
