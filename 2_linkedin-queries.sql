-- Make the DB is current
USE linkedin;

-- 1. The 20 most popular vacancies
SELECT companies.name AS company_name,
	   jobs.name AS jobs_title,
       jobs.views_counter AS total_views 
  FROM companies
  LEFT JOIN jobs
         ON companies.id = jobs.company_id
ORDER BY total_views DESC LIMIT 20;

-- 2. The most active posts-maker gender statistics
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

-- 3. Total follows companies of 100 youngest users
SELECT COUNT(*) AS follows
  FROM companies_users
  JOIN (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 100) AS sorted_profiles
    ON companies_users.user_id IN(sorted_profiles.user_id);

-- 4. Analysis of companies total open vacancies and the last vacancy
SELECT DISTINCT companies.name AS company_name,
       COUNT(jobs.id) OVER (PARTITION BY companies.id) AS total_vacancies,
       FIRST_VALUE(jobs.name) OVER latest_vacancy AS newest_vacancy,
       FIRST_VALUE(jobs.created_at) OVER latest_vacancy AS last_posted
  FROM companies
  LEFT JOIN jobs
    ON companies.id = jobs.company_id
WINDOW latest_vacancy AS (PARTITION BY companies.id ORDER BY jobs.created_at DESC);   

-- 5. Analysis of 5 most active users (sum of different activities)
# EXPLAIN -- delete '#' for query analysis
SELECT users.id,
    CONCAT(first_name, ' ', last_name) AS user_name,
	COUNT(DISTINCT(likes.id)) +
	COUNT(DISTINCT(messages.id)) +
	COUNT(DISTINCT(posts.id)) +
	COUNT(DISTINCT(communities_users.user_id)) +
	COUNT(DISTINCT(companies_users.user_id)) +
	COUNT(DISTINCT(connections.user_id)) +
	COUNT(DISTINCT(content.id)) AS activity_summ
	 FROM users
LEFT JOIN likes
	   ON users.id = likes.user_id
LEFT JOIN messages
	   ON users.id = messages.from_user_id
LEFT JOIN posts
	   ON users.id = posts.user_id
LEFT JOIN communities_users
	   ON users.id = communities_users.user_id
LEFT JOIN companies_users
	   ON users.id = companies_users.user_id
LEFT JOIN connections
	   ON users.id = connections.user_id
LEFT JOIN content
	   ON users.id = content.user_id
 GROUP BY users.id
 ORDER BY activity_summ DESC 
	LIMIT 5;

