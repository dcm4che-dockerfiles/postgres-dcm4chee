-- part 3: can be applied on already running archive 5.14
alter table series
  alter stgver_failures set not null,
  alter compress_failures set not null;
