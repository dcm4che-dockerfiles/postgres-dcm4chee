-- part 2: have to be applied while archive is stopped
update series set stgver_failures = 0, compress_failures = 0 where stgver_failures is null;
