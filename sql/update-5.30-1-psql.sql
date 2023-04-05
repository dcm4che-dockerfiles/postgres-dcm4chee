-- can be applied on archive running archive 5.29
alter table mwl_item
    add worklist_label varchar(255);

update mwl_item set worklist_label=local_aet;

create index UK_88bqeff7thxsmgcmtrg5l3td on mwl_item (worklist_label);
