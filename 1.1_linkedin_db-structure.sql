-- Create DB LinkedIn
DROP DATABASE IF EXISTS linkedin;
CREATE DATABASE linkedin;

-- Make the DB is current
USE linkedin;

-- ----------------------------------------------- --
-- Block of users infromation (main page of users) --
-- ----------------------------------------------- --

-- 1. Table of users with the main information
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id            INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id", 
  first_name    VARCHAR(100) NOT NULL                            COMMENT "User's first name",
  last_name     VARCHAR(100) NOT NULL                            COMMENT "User's last name",
  email         VARCHAR(50) NOT NULL UNIQUE                      COMMENT "E-mail",
  phone         VARCHAR(100) UNIQUE                              COMMENT "Phone number",
  phone_type_id INT UNSIGNED                                     COMMENT "Link to phone type table",
  profile_url   VARCHAR(255) NOT NULL UNIQUE                     COMMENT "URL-address of linkedin profile page",
  created_at    DATETIME DEFAULT CURRENT_TIMESTAMP               COMMENT "Line creation time",  
  updated_at    DATETIME DEFAULT CURRENT_TIMESTAMP 
                       ON UPDATE CURRENT_TIMESTAMP               COMMENT "Line update time"
) COMMENT "Users (main information)";  

-- 2. Table of the phone types (home, work, mobile)
DROP TABLE IF EXISTS phone_types;
CREATE TABLE phone_types (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id",
  name       ENUM('home', 'work', 'mobile') NOT NULL UNIQUE   COMMENT "Phone type name"
) COMMENT "Phone types";

-- 3. Table of users profiles with additional information (separation for users table optimisation)
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  user_id             INT UNSIGNED NOT NULL PRIMARY KEY  COMMENT "Lind to users id", 
  gender              ENUM('m', 'f') NOT NULL            COMMENT "User's gender",
  birthday            DATE                               COMMENT "User's birthday",
  birthday_private_id INT UNSIGNED                       COMMENT "Link to birthday private table",
  photo_id            INT UNSIGNED                       COMMENT "Link to photo id content",
  address             VARCHAR(255)                       COMMENT "Current user's address",
  city                VARCHAR(130)                       COMMENT "Current user's city",
  country             VARCHAR(130) NOT NULL              COMMENT "Current user's country",
  headline            VARCHAR(100) NOT NULL              COMMENT "Headline in user's profile",
  industry            VARCHAR(100) NOT NULL              COMMENT "Industry of user's work",
  current_position_id INT UNSIGNED                       COMMENT "Link to the current position id",
  experience_id       INT UNSIGNED                       COMMENT "Link to the work experience id",
  education_id        INT UNSIGNED                       COMMENT "Link to the education id",
  about               TEXT                               COMMENT "Additional information about user",
  created_at          DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Line creation time",  
  updated_at          DATETIME DEFAULT CURRENT_TIMESTAMP 
                             ON UPDATE CURRENT_TIMESTAMP COMMENT "Line update time"
) COMMENT "Profiles (additional information)"; 

-- 4. Table of the birthday private (only you, your connections, your network, all linkedin members)
DROP TABLE IF EXISTS birthday_private;
CREATE TABLE birthday_private (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id",
  name       ENUM('only you',
                  'your connections',
                  'your network',
                  'all linkedin members') NOT NULL UNIQUE     COMMENT "birthday private"
) COMMENT "Birthday private";

-- 5. Table of users work experience
DROP TABLE IF EXISTS work_experience;
CREATE TABLE work_experience (
  id                 INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id", 
  title              VARCHAR(100) NOT NULL                            COMMENT "Work position",
  employment_type_id INT UNSIGNED                                     COMMENT "Link to employment type talbe",
  company            VARCHAR (255) NOT NULL                           COMMENT "Company name",
  location           VARCHAR (255)                                    COMMENT "Company location",
  is_current         BOOLEAN                                          COMMENT "Is it the current work place?",
  start_date         DATE NOT NULL                                    COMMENT "Date of start work in a company",
  end_date           DATE NOT NULL                                    COMMENT "Date of finish work in a company",
  description        TEXT                                             COMMENT "User's work description",
  created_at         DATETIME DEFAULT CURRENT_TIMESTAMP               COMMENT "Line creation time",  
  updated_at         DATETIME DEFAULT CURRENT_TIMESTAMP 
                            ON UPDATE CURRENT_TIMESTAMP               COMMENT "Line update time" 
) COMMENT "Work experience"; 
 
-- 6. Table of employment types: full-time, part-time, self-employed, freelance, contract, internship, apprenticeship
DROP TABLE IF EXISTS employment_types;
CREATE TABLE employment_types (
  id   INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id", 
  name ENUM('full-time',
            'part-time',
            'self-employed',
            'freelance',
            'contract',
            'internship',
            'apprenticeship') NOT NULL                  COMMENT "Titles of employment types"
) COMMENT "Employment types"; 

-- 7. Table of users education
DROP TABLE IF EXISTS education;
CREATE TABLE education (
  id             INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id", 
  school         VARCHAR (255) NOT NULL                           COMMENT "Title of an education organization",
  `degree`       VARCHAR(100)                                     COMMENT "Degree of education",
  field_of_study VARCHAR(100)                                     COMMENT "The field/subject of a study",
  start_year     YEAR                                             COMMENT "Year of education start",
  graduate_year  YEAR                                             COMMENT "Gradution year",
  grade          VARCHAR(10)                                      COMMENT "Education grade",
  activities     TEXT                                             COMMENT "Society activities during the education",
  description    TEXT                                             COMMENT "Study description",
  created_at     DATETIME DEFAULT CURRENT_TIMESTAMP               COMMENT "Line creation time",  
  updated_at     DATETIME DEFAULT CURRENT_TIMESTAMP 
                        ON UPDATE CURRENT_TIMESTAMP               COMMENT "Line update time"
) COMMENT "Education"; 
  
-- 8. Table of users skills and endorsements by other users
DROP TABLE IF EXISTS skills;
CREATE TABLE skills (
  id               INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id",
  user_id          INT UNSIGNED NOT NULL                            COMMENT "User id",
  skill_name       VARCHAR(100)                                     COMMENT "Name of skills",
  created_at       DATETIME DEFAULT CURRENT_TIMESTAMP               COMMENT "Line creation time"
) COMMENT "Table of user's skills"; 

-- 9. Table of bonds between users skills and endorsed users
DROP TABLE IF EXISTS skills_endorsements;
CREATE TABLE skills_endorsements (
  skill_id         INT UNSIGNED NOT NULL              COMMENT "Link to the user's skill",
  endorsed_user_id INT UNSIGNED NOT NULL              COMMENT "Link to the endorsed user",
  created_at       DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Line creation time", 
  PRIMARY KEY (skill_id, endorsed_user_id)            COMMENT "Composit primary key"
) COMMENT "Table of bonds between users skills and endorsed users";

-- ------------------------------------------------------------- --
-- Block of users social interaction (friends, teammates, posts) --
-- ------------------------------------------------------------- --

-- 10. Table of user's and groups/companies content
DROP TABLE IF EXISTS content;
CREATE TABLE content (
  id               INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id",
  user_id          INT UNSIGNED NOT NULL                            COMMENT "Link to owner of the file",
  filename         VARCHAR(255) NOT NULL                            COMMENT "URL-adress to the file",
  file_size        INT NOT NULL                                     COMMENT "File size",
  metadata         JSON                                             COMMENT "File metadata",
  content_type_id  INT UNSIGNED NOT NULL                            COMMENT "Link to the content type",
  created_at       DATETIME DEFAULT CURRENT_TIMESTAMP               COMMENT "Line creation time", 
  updated_at       DATETIME DEFAULT CURRENT_TIMESTAMP
                          ON UPDATE CURRENT_TIMESTAMP               COMMENT "Line update time"
) COMMENT "Contents";

-- 11. Table of the content types (photo, video, document, article)
DROP TABLE IF EXISTS content_types;
CREATE TABLE content_types (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id",
  name       ENUM('photo',
                  'video',
                  'document',
                  'article') NOT NULL UNIQUE                  COMMENT "Content type name",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP               COMMENT "Line creation time", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
                    ON UPDATE CURRENT_TIMESTAMP               COMMENT "Line update time"
) COMMENT "Content types";

-- 12. Table of users contacts
DROP TABLE IF EXISTS connections;
CREATE TABLE connections (
  user_id       INT UNSIGNED NOT NULL              COMMENT "Link to user-initiator",
  connection_id INT UNSIGNED NOT NULL              COMMENT "Link to user-target",
  status_id     INT UNSIGNED NOT NULL              COMMENT "Link to connection status",
  teammate_id   INT UNSIGNED                       COMMENT "Link to teammate table",
  requested_at  DATETIME DEFAULT NOW()             COMMENT "Time of connection request",
  confirmed_at  DATETIME                           COMMENT "Confirmation time of requested connection",
  created_at    DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Line creation time",  
  updated_at    DATETIME DEFAULT CURRENT_TIMESTAMP
                       ON UPDATE CURRENT_TIMESTAMP COMMENT "Line update time",  
  PRIMARY KEY (user_id, connection_id)             COMMENT "Composite primary key"
) COMMENT "Teble of contacts";

-- 13. Table of contacts statuses: Requested, Confirmed, Rejected
DROP TABLE IF EXISTS connections_statuses;
CREATE TABLE connections_statuses (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id",
  name       VARCHAR(150) NOT NULL UNIQUE                     COMMENT "Status names",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP               COMMENT "Line creation time",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
                    ON UPDATE CURRENT_TIMESTAMP               COMMENT "Line update time" 
) COMMENT "Table of contacts statuses";
           
-- 14. Table of users messages
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
  id           INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id", 
  from_user_id INT UNSIGNED NOT NULL                            COMMENT "Lind to user-sender",
  to_user_id   INT UNSIGNED NOT NULL                            COMMENT "Link to user-target",
  message_body TEXT NOT NULL                                    COMMENT "Message body",
  is_delivered BOOLEAN                                          COMMENT "Delivered or not",
  created_at   DATETIME DEFAULT CURRENT_TIMESTAMP               COMMENT "Line creation time", 
  updated_at   DATETIME DEFAULT CURRENT_TIMESTAMP
                      ON UPDATE CURRENT_TIMESTAMP               COMMENT "Line update time"
) COMMENT "Messages";

-- 15. Table of teammates
DROP TABLE IF EXISTS teammates;
CREATE TABLE teammates (
  id                 INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id", 
  user_id            INT UNSIGNED NOT NULL                            COMMENT "User id",
  teammate_id		 INT UNSIGNED NOT NULL                            COMMENT "Teammate id",
  teammate_status_id INT UNSIGNED NOT NULL                            COMMENT "Link to teammate status",
  is_current         BOOLEAN                                          COMMENT "Current or past teammate",
  created_at         DATETIME DEFAULT CURRENT_TIMESTAMP               COMMENT "Line creation time",  
  updated_at         DATETIME DEFAULT CURRENT_TIMESTAMP
                            ON UPDATE CURRENT_TIMESTAMP               COMMENT "Line update time" 
) COMMENT "Table of teammates";

-- 16. Table of teammates statuses: Manager, Teammates reporting to your manager, Direct reports, Other teammates
DROP TABLE IF EXISTS teammates_statuses;
CREATE TABLE teammates_statuses (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id",
  name       VARCHAR(150) NOT NULL UNIQUE                     COMMENT "Status names",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP               COMMENT "Line creation time",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
                    ON UPDATE CURRENT_TIMESTAMP               COMMENT "Line update time" 
) COMMENT "Table of teammates statuses";

-- 17. Table of likes (only posts can be liked in linkedin)
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id",
  user_id    INT UNSIGNED NOT NULL                            COMMENT "User, who likes post",
  post_id  INT UNSIGNED NOT NULL                            COMMENT "Link to posts",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP               COMMENT "Line creation time"
) COMMENT "Table of likes";

-- 18. Table of posts
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id            INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id",
  user_id       INT UNSIGNED NOT NULL                            COMMENT "Owner user id",
  community_id  INT UNSIGNED                                     COMMENT "Link to owner group/community, if aceptable",
  company_id    INT UNSIGNED                                     COMMENT "Link to owner company, if acceptable",
  head          VARCHAR(255)                                     COMMENT "Head of the post",
  body          TEXT NOT NULL                                    COMMENT "Body of the post",
  content_id    INT UNSIGNED                                     COMMENT "Additional content, if acceptable",
  views_counter INT UNSIGNED DEFAULT 0                           COMMENT "Counter of views",
  created_at    DATETIME DEFAULT CURRENT_TIMESTAMP               COMMENT "Line creation time",
  updated_at    DATETIME DEFAULT CURRENT_TIMESTAMP
                       ON UPDATE CURRENT_TIMESTAMP               COMMENT "Line update time"
) COMMENT "Table of posts";

-- ----------------------------------------- --
-- Block of groups and companies informtaion --
-- ----------------------------------------- --

-- 19. Table of groups and communities
DROP TABLE IF EXISTS communities;
CREATE TABLE communities (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id",
  name       VARCHAR(150) NOT NULL UNIQUE                     COMMENT "Group name",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP               COMMENT "Line creation time",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
                    ON UPDATE CURRENT_TIMESTAMP               COMMENT "Line update time"
) COMMENT "Communities";

-- 20. Table of connections between users and groups
DROP TABLE IF EXISTS communities_users;
CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL              COMMENT "Link id",
  user_id      INT UNSIGNED NOT NULL              COMMENT "User id",
  created_at   DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Line creation time",
  PRIMARY KEY (community_id, user_id)             COMMENT "Composite primary key"
) COMMENT "Table of bonds between users and communities";

-- 21. Table of companies
DROP TABLE IF EXISTS companies;
CREATE TABLE companies (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id",
  name       VARCHAR(255) NOT NULL UNIQUE                     COMMENT "Name of the company",
  work_field VARCHAR(255) NOT NULL UNIQUE                     COMMENT "Field of the company",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP               COMMENT "Line creation time",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
                    ON UPDATE CURRENT_TIMESTAMP               COMMENT "Line update time"
) COMMENT "Companies table";

-- 22. Table of companies information (separation for companies table optimisation like users & profiles)
DROP TABLE IF EXISTS companies_info;
CREATE TABLE companies_info (
  company_id      INT UNSIGNED NOT NULL PRIMARY KEY  COMMENT "Lind to users id", 
  about_company   TEXT NOT NULL                      COMMENT "Краткое описание комании",
  life_in_company TEXT NOT NULL                      COMMENT "Полное описание комании и жизни в ней",
  content_id      INT UNSIGNED                       COMMENT "Ссылка на контент компании в разделе Life",
  created_at      DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Line creation time",
  updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP
                         ON UPDATE CURRENT_TIMESTAMP COMMENT "Line update time"
) COMMENT "Table of companies information";

-- 23. Table of jobs
DROP TABLE IF EXISTS jobs;
CREATE TABLE jobs (
  id            INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Line id",
  company_id    INT UNSIGNED NOT NULL                            COMMENT "Link to the company", 
  name          VARCHAR(100) NOT NULL UNIQUE                     COMMENT "Job title",
  city          VARCHAR(130)                                     COMMENT "City of a job",
  country       VARCHAR(130) NOT NULL                            COMMENT "Country of a job",
  description   TEXT NOT NULL                                    COMMENT "Job description",
  views_counter INT UNSIGNED DEFAULT 0                           COMMENT "Counter of views",
  created_at    DATETIME DEFAULT CURRENT_TIMESTAMP               COMMENT "Line creation time",  
  updated_at    DATETIME DEFAULT CURRENT_TIMESTAMP
                       ON UPDATE CURRENT_TIMESTAMP               COMMENT "Line update time"
) COMMENT "Table of jobs";

-- 24. Table of bonds between companies and users (followers)
DROP TABLE IF EXISTS companies_users;
CREATE TABLE companies_users (
  company_id INT UNSIGNED NOT NULL              COMMENT "Link to the company",
  user_id    INT UNSIGNED NOT NULL              COMMENT "Link to the user",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Line creation time", 
  PRIMARY KEY (company_id, user_id)             COMMENT "Composit primary key"
) COMMENT "Table of bonds between users and companies";
