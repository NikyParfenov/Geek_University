-- Make the DB is current
USE linkedin;

-- ----- --
-- VIEWS --
-- ----- --

-- Create view of general users information
CREATE OR REPLACE VIEW general_users_info AS 
	 SELECT users.first_name,
	        users.last_name,
	        profiles.gender,
	        profiles.birthday, 
	        users.email, 
	        users.phone, 
	        profiles.city, 
	        profiles.country
	   FROM users
	   JOIN profiles
	     ON users.id = profiles.user_id;
	     
# SELECT * FROM general_users_info;

-- Create view of general companies information
CREATE OR REPLACE VIEW companies_jobs_info AS
     SELECT companies.name AS company_name,
            companies.work_field,
            jobs.name AS job_name,
            jobs.city,
            jobs.country,
            jobs.description 
       FROM companies
       JOIN jobs
         ON companies.id = jobs.company_id
   ORDER BY companies.id;

# SELECT * FROM companies_jobs_info;

-- ------- --
-- INDEXES --
-- ------- --

-- Create index for fast field of work (possible users search)
CREATE INDEX companies_work_field_idx ON companies(work_field);

-- Create index for fast jobs name (possible users search)
CREATE INDEX jobs_name_idx ON jobs(name);

-- Create index for city jobs (possible users search)
CREATE INDEX jobs_city_idx ON jobs(city);

-- Create index for users education (possible HR search)
CREATE INDEX education_field_of_study_idx ON education(field_of_study);

-- Create index for users work position (possible HR search)
CREATE INDEX work_experience_title_idx ON work_experience(title);



