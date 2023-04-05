-- part 3: can be applied on already running archive 5.30
alter table mwl_item alter worklist_label set not null;
alter table mwl_item drop local_aet;
