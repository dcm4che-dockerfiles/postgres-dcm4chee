-- part 3: can be applied on already running archive 5.15
alter table patient alter verification_status set not null, alter failed_verifications set not null;
