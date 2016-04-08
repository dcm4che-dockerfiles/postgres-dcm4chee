create table code (pk int8 not null, code_meaning varchar(255) not null, code_value varchar(255) not null, code_designator varchar(255) not null, code_version varchar(255), primary key (pk));
create table content_item (pk int8 not null, rel_type varchar(255) not null, text_value varchar(255), code_fk int8, name_fk int8 not null, instance_fk int8, primary key (pk));
create table dicomattrs (pk int8 not null, attrs bytea not null, primary key (pk));
create table export_task (pk int8 not null, device_name varchar(255) not null, exporter_id varchar(255) not null, scheduled_time timestamp not null, series_iuid varchar(255) not null, sop_iuid varchar(255) not null, study_iuid varchar(255) not null, version int8, primary key (pk));
create table ian_task (pk int8 not null, calling_aet varchar(255) not null, device_name varchar(255) not null, ian_dests varchar(255) not null, scheduled_time timestamp, study_iuid varchar(255), mpps_fk int8, primary key (pk));
create table instance (pk int8 not null, availability int4 not null, sr_complete varchar(255) not null, content_date varchar(255) not null, content_time varchar(255) not null, created_time timestamp not null, inst_custom1 varchar(255) not null, inst_custom2 varchar(255) not null, inst_custom3 varchar(255) not null, inst_no varchar(255) not null, retrieve_aets varchar(255), sop_cuid varchar(255) not null, sop_iuid varchar(255) not null, updated_time timestamp not null, sr_verified varchar(255) not null, version int8, dicomattrs_fk int8 not null, srcode_fk int8, reject_code_fk int8, series_fk int8 not null, primary key (pk));
create table issuer (pk int8 not null, entity_id varchar(255), entity_uid varchar(255), entity_uid_type varchar(255), primary key (pk));
create table location (pk int8 not null, created_time timestamp not null, digest varchar(255), object_size int8 not null, status int4 not null, storage_id varchar(255) not null, storage_path varchar(255) not null, tsuid varchar(255) not null, instance_fk int8, primary key (pk));
create table mpps (pk int8 not null, accession_no varchar(255) not null, created_time timestamp not null, pps_start_date varchar(255) not null, pps_start_time varchar(255) not null, sop_iuid varchar(255) not null, pps_status int4 not null, study_iuid varchar(255) not null, updated_time timestamp not null, version int8, dicomattrs_fk int8 not null, discreason_code_fk int8, accno_issuer_fk int8, patient_fk int8 not null, primary key (pk));
create table patient (pk int8 not null, created_time timestamp not null, pat_birthdate varchar(255) not null, pat_custom1 varchar(255) not null, pat_custom2 varchar(255) not null, pat_custom3 varchar(255) not null, pat_sex varchar(255) not null, updated_time timestamp not null, version int8, dicomattrs_fk int8 not null, merge_fk int8, patient_id_fk int8, pat_name_fk int8, primary key (pk));
create table patient_id (pk int8 not null, pat_id varchar(255) not null, pat_id_type_code varchar(255), version int8, issuer_fk int8, primary key (pk));
create table person_name (pk int8 not null, family_name varchar(255), given_name varchar(255), i_family_name varchar(255), i_given_name varchar(255), i_middle_name varchar(255), i_name_prefix varchar(255), i_name_suffix varchar(255), middle_name varchar(255), name_prefix varchar(255), name_suffix varchar(255), p_family_name varchar(255), p_given_name varchar(255), p_middle_name varchar(255), p_name_prefix varchar(255), p_name_suffix varchar(255), primary key (pk));
create table queue_msg (pk int8 not null, created_time timestamp not null, error_msg varchar(255), msg_body bytea not null, msg_id varchar(255) not null, msg_props varchar(4000) not null, num_failures int4 not null, outcome_msg varchar(255), proc_end_time timestamp, proc_start_time timestamp, queue_name varchar(255), scheduled_time timestamp not null, msg_status int4 not null, updated_time timestamp not null, version int8, primary key (pk));
create table rel_study_pcode (study_fk int8 not null, pcode_fk int8 not null);
create table series (pk int8 not null, body_part varchar(255) not null, created_time timestamp not null, institution varchar(255) not null, department varchar(255) not null, laterality varchar(255) not null, modality varchar(255) not null, pps_cuid varchar(255) not null, pps_iuid varchar(255) not null, pps_start_date varchar(255) not null, pps_start_time varchar(255) not null, series_custom1 varchar(255) not null, series_custom2 varchar(255) not null, series_custom3 varchar(255) not null, series_desc varchar(255) not null, series_iuid varchar(255) not null, series_no varchar(255) not null, src_aet varchar(255), station_name varchar(255) not null, updated_time timestamp not null, version int8, dicomattrs_fk int8 not null, inst_code_fk int8, perf_phys_name_fk int8, study_fk int8 not null, primary key (pk));
create table series_query_attrs (pk int8 not null, availability int4, num_instances int4, retrieve_aets varchar(255), view_id varchar(255), series_fk int8 not null, primary key (pk));
create table series_req (pk int8 not null, accession_no varchar(255) not null, req_proc_id varchar(255) not null, req_service varchar(255) not null, sps_id varchar(255) not null, study_iuid varchar(255) not null, accno_issuer_fk int8, req_phys_name_fk int8, series_fk int8, primary key (pk));
create table soundex_code (pk int8 not null, sx_code_value varchar(255) not null, sx_pn_comp_part int4 not null, sx_pn_comp int4 not null, person_name_fk int8 not null, primary key (pk));
create table study (pk int8 not null, access_control_id varchar(255) not null, access_time timestamp not null, accession_no varchar(255) not null, created_time timestamp not null, failed_retrieves int4 not null, failed_iuids varchar(4000), scattered_storage boolean not null, study_custom1 varchar(255) not null, study_custom2 varchar(255) not null, study_custom3 varchar(255) not null, study_date varchar(255) not null, study_desc varchar(255) not null, study_id varchar(255) not null, study_iuid varchar(255) not null, study_time varchar(255) not null, updated_time timestamp not null, version int8, dicomattrs_fk int8 not null, accno_issuer_fk int8, patient_fk int8 not null, ref_phys_name_fk int8, primary key (pk));
create table study_query_attrs (pk int8 not null, availability int4, mods_in_study varchar(255), num_instances int4, num_series int4, retrieve_aets varchar(255), cuids_in_study varchar(255), view_id varchar(255), study_fk int8 not null, primary key (pk));
create table verify_observer (pk int8 not null, verify_datetime varchar(255) not null, observer_name_fk int8, instance_fk int8, primary key (pk));
alter table code add constraint UK_l01jou0o1rohy7a9p933ndrxg  unique (code_value, code_designator);
create index UK_i715nk4mi378f9bxflvfroa5a on content_item (rel_type);
create index UK_6iism30y000w85v649ju968sv on content_item (text_value);
alter table export_task add constraint UK_aoqbyfnen6evu73ltc1osexfr  unique (exporter_id, study_iuid, series_iuid, sop_iuid);
create index UK_cxaqwh62doxvy1itpdi43c681 on export_task (device_name, scheduled_time);
alter table ian_task add constraint UK_dq88edcjjxh7h92f89y5ueast  unique (study_iuid);
create index UK_5shiir23exao1xpy2n5gvasrh on ian_task (device_name);
alter table instance add constraint UK_jxfu47kwjk3kkkyrwewjw8a4n  unique (dicomattrs_fk);
alter table instance add constraint UK_247lgirehl8i2vuanyfjnuyjb  unique (series_fk, sop_iuid);
create index UK_eg0khesxr81gdimwhjiyrylw7 on instance (sop_iuid);
create index UK_dglm8ndp9y9i0uo6fgaa5rhbb on instance (sop_cuid);
create index UK_ouh6caecancvsa05lknojy30j on instance (inst_no);
create index UK_5ikkfk17vijvsvtyied2xa225 on instance (content_date);
create index UK_pck1ovyd4t96mjkbbw6f8jiam on instance (content_time);
create index UK_qh8jqpe8ulsb5t7iv24scho00 on instance (sr_verified);
create index UK_gisd09x31lphi4437hwgh7ihg on instance (sr_complete);
create index UK_3tvtv5bjrpem0qjc3qo84bgsl on instance (availability);
create index UK_fncb1s641rrnoek7j47k0j06n on instance (inst_custom1);
create index UK_rr1ro1oxv6s4riib9hjkcuvuo on instance (inst_custom2);
create index UK_q5i0hxt1iyahxjiroux2h8imm on instance (inst_custom3);
alter table issuer add constraint UK_gknfxd1vh283cmbg8ymia9ms8  unique (entity_id);
alter table issuer add constraint UK_t1p7jajas0mu12sx8jvtp2y0f  unique (entity_uid, entity_uid_type);
create index UK_r3oh859i9osv3aluoc8dcx9wk on location (storage_id, status);
alter table mpps add constraint UK_o49fec996jvdo31o7ysmsn9s2  unique (dicomattrs_fk);
alter table mpps add constraint UK_cyqglxijg7kebbj6oj821yx4d  unique (sop_iuid);
alter table patient add constraint UK_5lgndn3gn7iug3kuewiy9q124  unique (dicomattrs_fk);
alter table patient add constraint UK_39gahcxyursxfxe2ucextr65s  unique (patient_id_fk);
create index UK_1ho1jyofty54ip8aqpuhi4mu1 on patient (pat_birthdate);
create index UK_545wp9un24fhgcy2lcfu1o04y on patient (pat_sex);
create index UK_9f2m2lkijm7wi0hpjsime069n on patient (pat_custom1);
create index UK_dwp6no1c4624yii6sbo59fedg on patient (pat_custom2);
create index UK_3ioui3yamjf01yny98bliqfgs on patient (pat_custom3);
alter table patient_id add constraint UK_31gvi9falc03xs94m8l3pgoid  unique (pat_id, issuer_fk);
create index UK_mgrwrswyrk02s1kn86cvpix3m on person_name (family_name);
create index UK_byvbmsx5w9jop12gdqldogbwm on person_name (given_name);
create index UK_hop27c6p2aiabl0ei6rj7oohi on person_name (middle_name);
create index UK_l3prcvmx90pdclj84s6uvbblm on person_name (i_family_name);
create index UK_tgh0ek52g7cpioire3qwdweoi on person_name (i_given_name);
create index UK_lwnfdvx2cknj9ravec592642d on person_name (i_middle_name);
create index UK_2189yvio0mae92hjhgbfwqgvc on person_name (p_family_name);
create index UK_6cn50unrp2u9xf6authiollrr on person_name (p_given_name);
create index UK_kungbb1r2qtt9aq0vsb1l68y6 on person_name (p_middle_name);
alter table queue_msg add constraint UK_k520j369nwx6rpbkvlp4kn623  unique (msg_id);
create index UK_b5mbe6jenklf1r5wp5csrvf67 on queue_msg (queue_name);
create index UK_o8pu8axwpcm4chqxy75y09gpo on queue_msg (msg_status);
create index UK_gsdfgth9kxjat98cmabtj8x1h on queue_msg (updated_time);
alter table series add constraint UK_bdj2kuutidekc2en6dckev7l6  unique (dicomattrs_fk);
alter table series add constraint UK_83y2fx8cou17h3xggxspgikna  unique (study_fk, series_iuid);
create index UK_75oc6w5ootkuwyvmrhe3tbown on series (series_no);
create index UK_b126hub0dc1o9dqp6awoispx2 on series (modality);
create index UK_pq1yi70ftxhh391lhcq3e08nf on series (station_name);
create index UK_rvlxc150uexwmr1l9ojp8fgd on series (pps_start_date);
create index UK_amr00xwlatxewgj1sjp5mnf76 on series (pps_start_time);
create index UK_gwp46ofa26am9ohhccq1ohdj on series (body_part);
create index UK_tbdrfrmkmifsqhpf43065jrbs on series (laterality);
create index UK_achxn1rtfm3fbkkswlsyr75t0 on series (series_desc);
create index UK_82qea56c0kdhod3b1wu8wbrny on series (institution);
create index UK_bqu32v5v76p4qi0etptnrm0pc on series (department);
create index UK_hm39592a9n7m54dgso17irlhv on series (series_custom1);
create index UK_q3wayt2ke25fdcghaohhrjiu7 on series (series_custom2);
create index UK_d8b8irasiw8eh9tsigmwkbvae on series (series_custom3);
alter table series_query_attrs add constraint UK_t1uhb1suiiqffhsv9eaopeevs  unique (view_id, series_fk);
create index UK_m4wanupyq3yldxgh3pbo7t68h on series_req (accession_no);
create index UK_l1fg3crmk6pjeu1x36e25h6p4 on series_req (req_service);
create index UK_p9w1wg4031w6y66w4xhx1ffay on series_req (req_proc_id);
create index UK_4uq79j30ind90jjs68gb24j6e on series_req (sps_id);
create index UK_crnpneoalwq25p795xtrhbx2 on series_req (study_iuid);
create index UK_fjwlo6vk0gxp78eh2i7j04a5t on soundex_code (sx_pn_comp);
create index UK_nlv8hnjxmb7pobdfl094ud14u on soundex_code (sx_pn_comp_part);
create index UK_3dxkqfajcytiwjjb5rgh4nu1l on soundex_code (sx_code_value);
alter table study add constraint UK_5w0oynbw061mwu1rr9mrb6kj4  unique (dicomattrs_fk);
alter table study add constraint UK_pt5qn20x278wb1f7p2t3lcxv  unique (study_iuid);
create index UK_q8k2sl3kjl18qg1nr19l47tl1 on study (access_time);
create index UK_24av2ewa70e7cykl340n63aqd on study (access_control_id);
create index UK_a1rewlmf8uxfgshk25f6uawx2 on study (study_date);
create index UK_16t2xvj9ttyvbwh1ijeve01ii on study (study_time);
create index UK_2ofn5q0fdfc6941e5j34bplmv on study (accession_no);
create index UK_j3q7fkhhiu4bolglyve3lv385 on study (study_desc);
create index UK_ksy103xef0hokd33y8ux7afxl on study (study_custom1);
create index UK_j63d3ip6x4xslkmyks1l89aay on study (study_custom2);
create index UK_8xolm3oljt08cuheepwq3fls7 on study (study_custom3);
alter table study_query_attrs add constraint UK_prn4qt6d42stw0gfi1yce1fap  unique (view_id, study_fk);
create index UK_5btv5autls384ulwues8lym4p on verify_observer (verify_datetime);
alter table content_item add constraint FK_gudw6viy7lrf5t5hetw7mbgh5 foreign key (code_fk) references code;
alter table content_item add constraint FK_pyrd1nhijag5ct0ee9xqq4h78 foreign key (name_fk) references code;
alter table content_item add constraint FK_9kpe6whsov3ur9rph4ih2vi5a foreign key (instance_fk) references instance;
alter table ian_task add constraint FK_1fuh251le2hid2byw90hd1mly foreign key (mpps_fk) references mpps;
alter table instance add constraint FK_jxfu47kwjk3kkkyrwewjw8a4n foreign key (dicomattrs_fk) references dicomattrs;
alter table instance add constraint FK_7w6f9bi2w91qr2abl6ddxnrwq foreign key (srcode_fk) references code;
alter table instance add constraint FK_6pnwsvi69g5ypye6gjo26vn7e foreign key (reject_code_fk) references code;
alter table instance add constraint FK_s4tgrew4sh4qxoupmk3gihtrk foreign key (series_fk) references series;
alter table location add constraint FK_hjtlcwsvwihs4khh961d423e7 foreign key (instance_fk) references instance;
alter table mpps add constraint FK_o49fec996jvdo31o7ysmsn9s2 foreign key (dicomattrs_fk) references dicomattrs;
alter table mpps add constraint FK_nrigpgue611m33rao03nnfe5l foreign key (discreason_code_fk) references code;
alter table mpps add constraint FK_grl2idmms10qq4lhmh909jxtj foreign key (accno_issuer_fk) references issuer;
alter table mpps add constraint FK_ofg0lvfxad6r5oigw3y6da27u foreign key (patient_fk) references patient;
alter table patient add constraint FK_5lgndn3gn7iug3kuewiy9q124 foreign key (dicomattrs_fk) references dicomattrs;
alter table patient add constraint FK_sk77bwjgaoetvy1pbcgqf08g foreign key (merge_fk) references patient;
alter table patient add constraint FK_39gahcxyursxfxe2ucextr65s foreign key (patient_id_fk) references patient_id;
alter table patient add constraint FK_rj42ffdtimnrcwmqqlvj24gi2 foreign key (pat_name_fk) references person_name;
alter table patient_id add constraint FK_oo232lt89k1b5h8mberi9v152 foreign key (issuer_fk) references issuer;
alter table rel_study_pcode add constraint FK_fryhnb2ppb6fcop3jrrfwvnfy foreign key (pcode_fk) references code;
alter table rel_study_pcode add constraint FK_mnahh8fh77d365m6w2x4x3f4q foreign key (study_fk) references study;
alter table series add constraint FK_bdj2kuutidekc2en6dckev7l6 foreign key (dicomattrs_fk) references dicomattrs;
alter table series add constraint FK_oiq81nulcmtg6p85iu31igtf5 foreign key (inst_code_fk) references code;
alter table series add constraint FK_5n4bxxb2xa7bvvq26ao7wihky foreign key (perf_phys_name_fk) references person_name;
alter table series add constraint FK_1og1krtgxfh207rtqjg0r7pbd foreign key (study_fk) references study;
alter table series_query_attrs add constraint FK_eiwosf6pcc97n6y282cv1n54k foreign key (series_fk) references series;
alter table series_req add constraint FK_se4n39as61wwf92ggbfc9yglo foreign key (accno_issuer_fk) references issuer;
alter table series_req add constraint FK_bcn0jtvurqutw865pwp34pejb foreign key (req_phys_name_fk) references person_name;
alter table series_req add constraint FK_bdkjk6ww0ulrb0nhf41c7liwt foreign key (series_fk) references series;
alter table soundex_code add constraint FK_dh7lahwi99hk6bttrk75x4ckc foreign key (person_name_fk) references person_name;
alter table study add constraint FK_5w0oynbw061mwu1rr9mrb6kj4 foreign key (dicomattrs_fk) references dicomattrs;
alter table study add constraint FK_lp0rdx659kewq8qrqg702yfyv foreign key (accno_issuer_fk) references issuer;
alter table study add constraint FK_e3fdaqhw7u60trs5aspf4sna9 foreign key (patient_fk) references patient;
alter table study add constraint FK_49eet5qgcsb32ktsqrf1mj3x2 foreign key (ref_phys_name_fk) references person_name;
alter table study_query_attrs add constraint FK_sxccj81423w8o6w2tsb7nshy9 foreign key (study_fk) references study;
alter table verify_observer add constraint FK_105wt9hglqsmtnoxgma9x18vj foreign key (observer_name_fk) references person_name;
alter table verify_observer add constraint FK_qjgrn9rfyyt6sv14utk9ijcfq foreign key (instance_fk) references instance;
create sequence code_pk_seq;
create sequence content_item_pk_seq;
create sequence dicomattrs_pk_seq;
create sequence export_task_pk_seq;
create sequence ian_task_pk_seq;
create sequence instance_pk_seq;
create sequence issuer_pk_seq;
create sequence location_pk_seq;
create sequence mpps_pk_seq;
create sequence patient_id_pk_seq;
create sequence patient_pk_seq;
create sequence person_name_pk_seq;
create sequence queue_msg_pk_seq;
create sequence series_pk_seq;
create sequence series_query_attrs_pk_seq;
create sequence series_req_pk_seq;
create sequence soundex_code_pk_seq;
create sequence study_pk_seq;
create sequence study_query_attrs_pk_seq;
create sequence verify_observer_pk_seq;
