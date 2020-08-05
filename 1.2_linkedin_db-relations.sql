-- Make the DB is current
USE linkedin;

-- Set relation: 'users.phone_type_id' with 'phone_types.id'
ALTER TABLE users
  ADD CONSTRAINT users_phone_type_id_fk
     FOREIGN KEY (phone_type_id) REFERENCES phone_types(id);

-- Set relations:
-- 'profiles.user_id' - 'users.id',
-- 'profiles.birthday_private_id' - 'birthday_private.id',
-- 'profiles.photo_id' - 'content.id'
-- 'profiles.current_position_id' - 'work_experience.id'
-- 'profiles.experience_id' - 'work_experience.id'
-- 'profiles.education_id' - 'education.id'
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk
     FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  ADD CONSTRAINT profiles_birthday_private_id_fk
     FOREIGN KEY (birthday_private_id) REFERENCES birthday_private(id),
  ADD CONSTRAINT profiles_photo_id_fk
     FOREIGN KEY (photo_id) REFERENCES content(id) ON DELETE SET NULL,
  ADD CONSTRAINT profiles_current_position_id_fk
     FOREIGN KEY (current_position_id) REFERENCES work_experience(id),
  ADD CONSTRAINT profiles_experience_id_fk
     FOREIGN KEY (experience_id) REFERENCES work_experience(id),
  ADD CONSTRAINT profiles_education_id_fk
     FOREIGN KEY (education_id) REFERENCES education(id);

-- Set relation: 'work_experience.employment_type_id' - 'employment_types.id'
ALTER TABLE work_experience 
  ADD CONSTRAINT work_experience_employment_type_id_fk
     FOREIGN KEY (employment_type_id) REFERENCES employment_types(id);
     
-- Set relations:
-- 'skills_endorsements.skill_id' - 'skills.id'
-- 'skills_endorsements.endorsed_user_id' - 'users.id'
ALTER TABLE skills_endorsements
  ADD CONSTRAINT skills_endorsements_skill_id_fk
     FOREIGN KEY (skill_id) REFERENCES skills(id),
  ADD CONSTRAINT skills_endorsements_endorsed_user_id_fk
     FOREIGN KEY (endorsed_user_id) REFERENCES users(id);

-- Set relations:
-- 'content.user_id' - 'users.id'
-- 'content.content_type_id' - 'content_types.id'
ALTER TABLE content 
  ADD CONSTRAINT content_user_id_fk
     FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT content_content_type_id_fk
     FOREIGN KEY (content_type_id) REFERENCES content_types(id);
 
-- Set relations:
-- 'connections.user_id' - 'users.id'
-- 'connections.connection_id' - 'users.id'
-- 'connections.status_id' - 'connections_statuses.id'
ALTER TABLE connections 
  ADD CONSTRAINT connections_user_id_fk
     FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT connections_connection_id_fk
     FOREIGN KEY (connection_id) REFERENCES users(id),
  ADD CONSTRAINT connections_status_id_fk
     FOREIGN KEY (status_id) REFERENCES connections_statuses(id);
    
-- Set relations:
-- 'messages.from_user_id' - 'users.id'
-- 'messages.to_user_id' - 'users.id'   
ALTER TABLE messages 
  ADD CONSTRAINT messages_from_user_id_fk
     FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk
     FOREIGN KEY (to_user_id) REFERENCES users(id);
 
-- Set relations:   
-- 'teammates.user_id' - 'users.id'
-- 'teammates.teammate_id' - 'users.id'    
-- 'teammates.teammate_status_id' - 'teammates_statuses.id'    
ALTER TABLE teammates 
  ADD CONSTRAINT teammates_user_id_fk
     FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT teammates_teammate_id_fk
     FOREIGN KEY (teammate_id) REFERENCES users(id),
  ADD CONSTRAINT teammates_teammate_status_id_fk
     FOREIGN KEY (teammate_status_id) REFERENCES teammates_statuses(id);

-- Set relations:
-- 'posts.user_id' - 'users.id'
-- 'posts.community_id' - 'communities.id'
-- 'posts.company_id' - 'companies.id'
-- 'posts.content_id' - 'content.id'
ALTER TABLE posts 
  ADD CONSTRAINT posts_user_id_fk
     FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT posts_community_id_fk
     FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT posts_company_id_fk
     FOREIGN KEY (company_id) REFERENCES companies(id),
  ADD CONSTRAINT posts_content_id_fk
     FOREIGN KEY (content_id) REFERENCES content(id);

-- Set relations:
-- 'likes.user_id' - 'users.id'    
-- 'likes.post_id' - 'posts.id'
ALTER TABLE likes 
  ADD CONSTRAINT likes_user_id_fk
     FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT likes_post_id_fk
     FOREIGN KEY (post_id) REFERENCES posts(id);
    
-- Set relations:
-- 'communities_users.community_id' - 'communities.id'
-- 'communities_users.user_id' - 'users.id'
ALTER TABLE communities_users 
  ADD CONSTRAINT communities_users_community_id_fk
     FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT communities_users_user_id_fk
     FOREIGN KEY (user_id) REFERENCES users(id);
 
-- Set relations:
-- 'companies_users.company_id' - 'companies.id'
-- 'companies_users.user_id' - 'users.id'
ALTER TABLE companies_users 
  ADD CONSTRAINT companies_users_company_id_fk
     FOREIGN KEY (company_id) REFERENCES companies(id),
  ADD CONSTRAINT companies_users_user_id_fk
     FOREIGN KEY (user_id) REFERENCES users(id);    
    
-- Set relations:
-- 'companies_info.company_id' - 'companies.id'
-- 'companies_info.content_id' - 'content.id'
ALTER TABLE companies_info 
  ADD CONSTRAINT companies_info_company_id_fk
     FOREIGN KEY (company_id) REFERENCES companies(id),
  ADD CONSTRAINT companies_info_content_id_fk
     FOREIGN KEY (content_id) REFERENCES content(id);

-- Set relations:
-- 'jobs.company_id' - 'companies.id'
ALTER TABLE jobs 
  ADD CONSTRAINT jobs_company_id_fk
     FOREIGN KEY (company_id) REFERENCES companies(id);
    
    
    