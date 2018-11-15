-- part 2: shall be applied on stopped archive before starting 5.14
update series set stgver_failures = 0, compress_failures = 0 where stgver_failures is null;
