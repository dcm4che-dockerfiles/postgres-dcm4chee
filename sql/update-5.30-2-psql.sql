-- part 2: shall be applied on stopped archive before starting 5.30
update mwl_item set worklist_label=local_aet where worklist_label is null;
alter table mwl_item alter local_aet drop not null;
