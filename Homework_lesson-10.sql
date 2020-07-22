USE vk;

-- ------------------------------------------------------------------ --
-- 1. Проанализировать какие запросы могут выполняться наиболее часто --
-- в процессе работы приложения и добавить необходимые индексы.       --
-- ------------------------------------------------------------------ --

-- часто может быть нужна статистика по возрасту пользователей
CREATE INDEX profiles_birthday_idx ON profiles(birthday);

-- часто может быть нужна статистика по полу пользователей
CREATE INDEX profiles_gender_idx ON profiles(gender);

-- часто может быть нужна статистика по полу пользователей
CREATE INDEX profiles_gender_idx ON profiles(gender);

-- часто может быть нужна статистика по месту проживания пользователей
-- в ВК достаточно города, если говорить про Facebook, то еще страна
CREATE INDEX profiles_city_idx ON profiles(city);

-- часто может быть нужна статистика по популярным постам
CREATE INDEX likes_target_id_idx ON likes(targe_id);

-- часто может быть нужна статистика по активным группам (как часто они выкладывают посты в группу)
CREATE INDEX communities_updated_at_idx ON communities(updated_at);

-- есть еще 2 индекса, которые могут быть востребованы, но пока не уверен,
-- что они нужны (статистика имен и время создания аккаунта)
CREATE INDEX users_first_name_idx ON users(first_name);
CREATE INDEX users_created_at_idx ON users(created_at);

-- ----------------------------------------------------------------------------------------------------- --
-- 2. Задание на оконные функции                                                                         --
-- Построить запрос, который будет выводить следующие столбцы:                                           --
-- имя группы																							 --
-- среднее количество пользователей в группах															 --
-- самый молодой пользователь в группе																	 --
-- самый старший пользователь в группе																	 --
-- общее количество пользователей в группе																 --
-- всего пользователей в системе																		 --
-- отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100 --
-- ----------------------------------------------------------------------------------------------------- --

 SELECT DISTINCT communities.name AS Group_Name,
	   -- среднее число пользователей в группах
	   ROUND(AVG(tbl1.Sum_in_Group) OVER(), 0) AS Avg_Users,
	   -- самый молодой пользователь
	   Youngest_User,
	   -- самый старший пользователь
	   Oldest_User,
	   -- число пользователей в группах
	   COUNT(users.id) OVER(PARTITION BY communities_users.community_id) AS Users_in_Group,
	   -- общее число пользователей в системе
	   COUNT(users.id) OVER() AS Total_Users,
	   -- доля пользователей в группе
	   COUNT(users.id) OVER(PARTITION BY communities_users.community_id) / COUNT(users.id) OVER() * 100 AS `Percentage %`
  FROM users
  JOIN communities_users
 	ON users.id = communities_users.user_id
  JOIN communities
    ON communities.id = communities_users.community_id
  -- расчет среднего числа пользователей в группе
  JOIN (SELECT communities_users.community_id AS id, COUNT(communities_users.user_id) AS Sum_in_Group FROM communities_users GROUP BY communities_users.community_id) AS tbl1
    ON tbl1.id = communities.id
  -- поиск самого молодого пользователя группы
  JOIN (SELECT communities_users.community_id AS id, CONCAT(users.first_name, ' ', users.last_name) AS Youngest_User
  		FROM communities_users
  		JOIN users ON users.id = communities_users.user_id
 		WHERE communities_users.created_at IN (SELECT MIN(communities_users.created_at) FROM communities_users
 				     				    	   WHERE communities_users.community_id IN 
 				     				                 (SELECT DISTINCT communities_users.community_id FROM communities_users)
 				      						   GROUP BY communities_users.community_id)) as tbl2
    ON tbl2.id = communities.id
 -- поиск самого старшего пользователя группы
  JOIN (SELECT communities_users.community_id AS id, CONCAT(users.first_name, ' ', users.last_name) AS Oldest_User
  	    FROM communities_users
  		JOIN users ON users.id = communities_users.user_id
 		WHERE communities_users.created_at IN (SELECT MAX(communities_users.created_at) FROM communities_users
 				     				    	   WHERE communities_users.community_id IN 
 				     				                 (SELECT DISTINCT communities_users.community_id FROM communities_users)
 				      						   GROUP BY communities_users.community_id)) as tbl3
    ON tbl3.id = communities.id; 
 
-- -------------------------------------------------------------------- --
-- 3. (по желанию) Задание на денормализацию							--
-- Разобраться как построен и работает следующий запрос:				--
-- Найти 10 пользователей, которые проявляют наименьшую активность		--
-- в использовании социальной сети.										--														
-- Правильно-ли он построен?											--
-- Какие изменения, включая денормализацию, можно внести в структуру БД	--
-- чтобы существенно повысить скорость работы этого запроса?			--
-- -------------------------------------------------------------------- --

-- можно объединить likes с users, а также добавить число сообщений к таблице users						      
   SELECT users.id,
	  	  COUNT(DISTINCT messages.id) +	
	 	  COUNT(DISTINCT likes.id) +					
	 	  COUNT(DISTINCT media.id) AS activity			
	 FROM users										
LEFT JOIN messages												
	   ON users.id = messages.from_user_id				
LEFT JOIN likes										
	   ON users.id = likes.user_id								
LEFT JOIN media								
	   ON users.id = media.user_id							
 GROUP BY users.id										
 ORDER BY activity									
    LIMIT 10;	

