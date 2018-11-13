-- part 2: have to be applied while archive is stopped
update patient set verification_status = 0, failed_verifications = 0
  where verification_status is null;
