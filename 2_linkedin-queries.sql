-- Make the DB is current
USE linkedin;

-- The 20 most popular vacancies
SELECT companies.name AS company_name,
	   jobs.name AS jobs_title,
       jobs.views_counter AS total_views 
  FROM companies
  LEFT JOIN jobs
         ON companies.id = jobs.company_id
ORDER BY total_views DESC LIMIT 20;

-- The most active posts-maker gender statistics
SELECT
    CASE (profiles.gender)                       
  	  WHEN 'm' THEN 'male'
      WHEN 'f' THEN 'female'
     END AS user_gender,
    COUNT(*) AS posts_amount
 FROM posts
 JOIN profiles
   ON posts.user_id = profiles.user_id
GROUP BY user_gender
ORDER BY posts_amount DESC;

-- Analysis of companies total open vacancies and the last vacancy
SELECT DISTINCT companies.name AS company_name,
       COUNT(jobs.id) OVER (PARTITION BY companies.id) AS total_vacancies,
       FIRST_VALUE(jobs.name) OVER latest_vacancy AS newest_vacancy,
       FIRST_VALUE(jobs.created_at) OVER latest_vacancy AS last_posted
  FROM companies
  LEFT JOIN jobs
    ON companies.id = jobs.company_id
WINDOW latest_vacancy AS (PARTITION BY companies.id ORDER BY jobs.created_at DESC);   



