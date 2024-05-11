
--INSERT INTO training_categories_tb VALUES (3, 'Recognizition of Prior Learning (RPL)');
--SELECT * FROM training_categories_tb;
--INSERT INTO pmkvy_scheme_tb VALUES (4, 'PMKVY 4.0', '01-08-2021', '31-07-2023');
--SELECT * FROM pmkvy_scheme_tb; -- [ scheme_code, scheme_name, start_date, end_date ]
--SELECT * FROM training_categories_tb; -- [ category_code, category_name ]
--SELECT * FROM state_tb; -- [ state_code, state_name ]
--SELECT * FROM district_tb; --  [ district_code, district_name, state_code(FK) ]
--SELECT * FROM industrial_sectors_tb; -- [ sector_code, sector_name ]
--SELECT * FROM job_roles_tb; -- [ job_role_code, job_role, nsqf_code, sector_code(FK)]
--SELECT * FROM caste_categories_tb; -- [ caste_code, caste_name ]
--SELECT * FROM training_partners_tb; -- [ tp_code, tp_id, tp_name, center_status, current_training_status, tp_SPOC, tp_contact, tp_email, state_code(FK), district_code(FK) ]
--SELECT * FROM training_final_tb;
-- [ record_id, scheme_code, category_code, state_code, district_code, tp_code, sector_code, job_role_code, caste_code, enrolled, trained, certified, placed, record_date]

do $$
declare
	record1_id int; --training_final_tb table
	scheme1_code int; --pmkvy_scheme_tb table
	category1_code int; --training_categories_tb table
	state1_code int; --state_tb table
	district1_code int; --district_tb table
	tp1_code int; --training_partners_tb table
	sector1_code int; --industrial_sectors_tb table
	job_role1_code int; --job_roles_tb table
	caste1_code int; --caste_categories_tb table
	enrolled numeric; --random(1,30)
	trained numeric;
	certified numeric;
	placed numeric; 
	record_date timestamp;
begin

/* Loop to insert training records in training_final_tb for PMKVY 1.0*/
   for i in 1..23 loop
   	record1_id = (select record_id from training_final_tb order by record_id desc Limit 1)+1; 
	--scheme1_code := (select scheme_code from pmkvy_scheme_tb order by random() Limit 1);
	scheme1_code := 1;
	category1_code := (select category_code from training_categories_tb order by random() Limit 1);
	--state1_code := (select state_code from state_tb order by random() Limit 1);
	state1_code := 17; -- 17
	district1_code := (select district_code from district_tb where state_code = state1_code order by random() Limit 1);
	tp1_code := (select tp_code from training_partners_tb where state_code = state1_code and district_code = district1_code order by random() Limit 1);
	
   	while tp1_code is null loop
		district1_code := (select district_code from district_tb where state_code = state1_code order by random() Limit 1);
		tp1_code := (select tp_code from training_partners_tb where state_code = state1_code and district_code = district1_code order by random() Limit 1);
	end loop;
	
	sector1_code := (select sector_code from industrial_sectors_tb order by random() Limit 1);
	job_role1_code = (select job_role_code from job_roles_tb where sector_code = sector1_code order by random() limit 1);
	caste1_code = (select caste_code from caste_categories_tb order by random() limit 1);
	
	enrolled := (select floor(random() * (15 - 8 + 1) + 8)::int);
	trained := enrolled - (select floor(random() * (2 - 1 + 1) + 1)::int);
	certified := trained - (select floor(random() * (2 - 1 + 1) + 1)::int);
	placed := certified - (select floor(random() * (4 - 3 + 1) + 3)::int);
	record_date := (select timestamp '2016-03-31 23:00:00' +
       random() * (timestamp '2015-01-01 01:00:00' -
                   timestamp '2016-03-31 01:00:00'));
	
	ALTER TABLE training_final_tb DISABLE TRIGGER ALL;
	INSERT INTO training_final_tb(record_id, scheme_code, category_code, state_code, district_code, tp_code, sector_code, job_role_code, caste_code, enrolled, trained, certified, placed, record_date)
	VALUES (record1_id, scheme1_code, category1_code, state1_code, district1_code, tp1_code, sector1_code, job_role1_code, caste1_code, enrolled, trained, certified, placed, record_date);

   end loop;
   
/* Loop to insert training records in training_final_tb for PMKVY 2.0*/
   for i in 1..129 loop
   	record1_id = (select record_id from training_final_tb order by record_id desc Limit 1)+1; 
	--scheme1_code := (select scheme_code from pmkvy_scheme_tb order by random() Limit 1);
	scheme1_code := 2;
	category1_code := (select category_code from training_categories_tb order by random() Limit 1);
	--state1_code := (select state_code from state_tb order by random() Limit 1);
	state1_code := 17;
	district1_code := (select district_code from district_tb where state_code = state1_code order by random() Limit 1);
	tp1_code := (select tp_code from training_partners_tb where state_code = state1_code and district_code = district1_code order by random() Limit 1);
	
   	while tp1_code is null loop
		district1_code := (select district_code from district_tb where state_code = state1_code order by random() Limit 1);
		tp1_code := (select tp_code from training_partners_tb where state_code = state1_code and district_code = district1_code order by random() Limit 1);
	end loop;
	
	sector1_code := (select sector_code from industrial_sectors_tb order by random() Limit 1);
	job_role1_code = (select job_role_code from job_roles_tb where sector_code = sector1_code order by random() limit 1);
	caste1_code = (select caste_code from caste_categories_tb order by random() limit 1);
	
	enrolled := (select floor(random() * (50 - 30 + 1) + 30)::int);
	trained := enrolled - (select floor(random() * (10 - 5 + 1) + 5)::int);
	certified := trained - (select floor(random() * (10 - 5 + 1) + 5)::int);
	placed := certified - (select floor(random() * (10 - 5 + 1) + 5)::int);
	record_date := (select timestamp '2020-03-31 23:00:00' +
       random() * (timestamp '2016-04-01 01:00:00' -
                   timestamp '2020-03-31 01:00:00'));
	
	ALTER TABLE training_final_tb DISABLE TRIGGER ALL;
	INSERT INTO training_final_tb(record_id, scheme_code, category_code, state_code, district_code, tp_code, sector_code, job_role_code, caste_code, enrolled, trained, certified, placed, record_date)
	VALUES (record1_id, scheme1_code, category1_code, state1_code, district1_code, tp1_code, sector1_code, job_role1_code, caste1_code, enrolled, trained, certified, placed, record_date);

   end loop;
   
/* Loop to insert training records in training_final_tb for PMKVY 3.0*/
   for i in 1..19 loop
   	record1_id = (select record_id from training_final_tb order by record_id desc Limit 1)+1; 
	--scheme1_code := (select scheme_code from pmkvy_scheme_tb order by random() Limit 1);
	scheme1_code := 3;
	category1_code := (select category_code from training_categories_tb order by random() Limit 1);
	--state1_code := (select state_code from state_tb order by random() Limit 1);
	state1_code := 17;
	district1_code := (select district_code from district_tb where state_code = state1_code order by random() Limit 1);
	tp1_code := (select tp_code from training_partners_tb where state_code = state1_code and district_code = district1_code order by random() Limit 1);
	
   	while tp1_code is null loop
		district1_code := (select district_code from district_tb where state_code = state1_code order by random() Limit 1);
		tp1_code := (select tp_code from training_partners_tb where state_code = state1_code and district_code = district1_code order by random() Limit 1);
	end loop;
	
	sector1_code := (select sector_code from industrial_sectors_tb order by random() Limit 1);
	job_role1_code = (select job_role_code from job_roles_tb where sector_code = sector1_code order by random() limit 1);
	caste1_code = (select caste_code from caste_categories_tb order by random() limit 1);
	
	enrolled := (select floor(random() * (140 - 100 + 1) + 100)::int);
	trained := enrolled - (select floor(random() * (25 - 10 + 1) + 10)::int);
	certified := trained - (select floor(random() * (25 - 10 + 1) + 10)::int);
	placed := certified - (select floor(random() * (40 - 30 + 1) + 30)::int);
	record_date := (select timestamp '2021-07-31 23:00:00' +
       random() * (timestamp '2020-04-01 01:00:00' -
                   timestamp '2021-07-31 01:00:00'));
	
	ALTER TABLE training_final_tb DISABLE TRIGGER ALL;
	INSERT INTO training_final_tb(record_id, scheme_code, category_code, state_code, district_code, tp_code, sector_code, job_role_code, caste_code, enrolled, trained, certified, placed, record_date)
	VALUES (record1_id, scheme1_code, category1_code, state1_code, district1_code, tp1_code, sector1_code, job_role1_code, caste1_code, enrolled, trained, certified, placed, record_date);

   end loop;

/* Loop to insert training records in training_final_tb for PMKVY 4.0*/

   for i in 1..40 loop
   	record1_id = (select record_id from training_final_tb order by record_id desc Limit 1)+1; 
	--scheme1_code := (select scheme_code from pmkvy_scheme_tb order by random() Limit 1);
	scheme1_code := 4;
	category1_code := (select category_code from training_categories_tb order by random() Limit 1);
	--state1_code := (select state_code from state_tb order by random() Limit 1);
	state1_code := 17;
	district1_code := (select district_code from district_tb where state_code = state1_code order by random() Limit 1);
	tp1_code := (select tp_code from training_partners_tb where state_code = state1_code and district_code = district1_code order by random() Limit 1);
	
   	while tp1_code is null loop
		district1_code := (select district_code from district_tb where state_code = state1_code order by random() Limit 1);
		tp1_code := (select tp_code from training_partners_tb where state_code = state1_code and district_code = district1_code order by random() Limit 1);
	end loop;
	
	sector1_code := (select sector_code from industrial_sectors_tb order by random() Limit 1);
	job_role1_code = (select job_role_code from job_roles_tb where sector_code = sector1_code order by random() limit 1);
	caste1_code = (select caste_code from caste_categories_tb order by random() limit 1);
	
	enrolled := (select floor(random() * (180 - 160 + 1) + 160)::int);
	trained := enrolled - (select floor(random() * (60 - 40 + 1) + 40)::int);
	certified := trained - (select floor(random() * (50 - 20 + 1) + 20)::int);
	placed := certified - (select floor(random() * (50 - 30 + 1) + 30)::int);
	record_date := (select timestamp '2023-07-31 23:00:00' +
       random() * (timestamp '2021-08-01 01:00:00' -
                   timestamp '2023-07-31 01:00:00'));
	
	ALTER TABLE training_final_tb DISABLE TRIGGER ALL;
	INSERT INTO training_final_tb(record_id, scheme_code, category_code, state_code, district_code, tp_code, sector_code, job_role_code, caste_code, enrolled, trained, certified, placed, record_date)
	VALUES (record1_id, scheme1_code, category1_code, state1_code, district1_code, tp1_code, sector1_code, job_role1_code, caste1_code, enrolled, trained, certified, placed, record_date);

   end loop;

end; $$

/*
		   
do $$
declare
	record1_id int; --training_final_tb table
	scheme1_code int; --pmkvy_scheme_tb table
	record1_date timestamp;
begin

/* Loop to insert training records in training_final_tb for PMKVY 1.0*/
   for i in 1..31212 loop
		record1_id = i;
		scheme1_code := (select scheme_code from training_final_tb where record_id = i);

			if scheme1_code = 1 then
				record1_date := (select timestamp '2016-03-31 23:00:00' +
				   random() * (timestamp '2015-01-01 01:00:00' -
							   timestamp '2016-03-31 01:00:00'));
			elsif scheme1_code = 2 then
				record1_date := (select timestamp '2020-03-31 23:00:00' +
				   random() * (timestamp '2016-04-01 01:00:00' -
							   timestamp '2020-03-31 01:00:00'));
			elsif scheme1_code = 3 then
				record1_date := (select timestamp '2021-07-31 23:00:00' +
				   random() * (timestamp '2020-04-01 01:00:00' -
							   timestamp '2021-07-31 01:00:00'));
			else
				record1_date := (select timestamp '2023-07-31 23:00:00' +
				   random() * (timestamp '2021-08-01 01:00:00' -
							   timestamp '2023-07-31 01:00:00'));
			end if;

		update training_final_tb set record_date = record1_date where record_id = record1_id;

   end loop;
end; $$
*/

