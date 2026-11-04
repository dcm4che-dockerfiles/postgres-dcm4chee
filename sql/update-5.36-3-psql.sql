-- part 3: can be applied on already running archive 5.36
alter table ups alter institution set not null;
alter table ups alter department set not null;

alter table patient_id alter created_time set not null;

alter table metadata alter num_instances set not null;
