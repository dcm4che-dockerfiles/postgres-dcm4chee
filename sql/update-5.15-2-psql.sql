-- part 2: shall be applied on stopped archive before starting 5.15
update patient set verification_status = 0, failed_verifications = 0
  where verification_status is null;
