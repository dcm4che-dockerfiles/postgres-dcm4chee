-- part 3: can be applied on already running archive 5.36
alter table ups alter institution drop default;
alter table ups alter department drop default;

alter table patient_id alter created_time set not null;
alter table patient_id alter updated_time set not null;
alter table patient_id drop pat_id_type_code;

alter table metadata alter num_instances drop default;