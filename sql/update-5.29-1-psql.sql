-- can be applied on archive running archive 5.28
create table key_value2
(
    pk           int8          not null,
    content_type varchar(255)  not null,
    created_time timestamp     not null,
    key_name     varchar(255)  not null,
    updated_time timestamp     not null,
    username     varchar(255),
    key_value    varchar(4000) not null,
    primary key (pk)
);

alter table key_value2
    add constraint UK_4gq7ksl296rsm6ap9hjrogv3g  unique (key_name);

create index UK_hy6xxbt6wi79kbxt6wsqhv77p on key_value2 (username);
create index UK_5gcbr7nnck6dxrmml1s3arpna on key_value2 (updated_time);

create sequence key_value2_pk_seq;
