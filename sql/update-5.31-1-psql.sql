-- can be applied on archive running archive 5.30
alter table patient_id
    add patient_fk int8;

alter table patient_id
    add constraint FK_hba9466n4re9re8id3c8abmnv foreign key (patient_fk) references patient;

update patient_id set patient_fk = (
    select patient.pk from patient where patient_id_fk = patient_id.pk );

create index FK_hba9466n4re9re8id3c8abmnv on patient_id (patient_fk) ;
