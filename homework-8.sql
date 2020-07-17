-- Д/з к уроку 8. Изменение вложенных запросов на JOIN
USE vk;

-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT 
	(SELECT
		-- переимонование полов для удобства отображения
		CASE (gender)                       
      		WHEN 'm' THEN 'male'
      		WHEN 'f' THEN 'female'
    	END
    FROM profiles WHERE likes.user_id = profiles.user_id GROUP BY gender
    ) as user_gender,
	COUNT(*) as likes_amount 
FROM likes
GROUP BY user_gender
ORDER BY likes_amount DESC LIMIT 1;


-- ---- --
-- JOIN --
-- ---- --
SELECT
  COUNT(*) as likes_amount, 
  CASE (profiles.gender)                       
  	WHEN 'm' THEN 'male'
    WHEN 'f' THEN 'female'
  END as user_gender
 FROM likes
  JOIN profiles
    ON likes.user_id = profiles.user_id
GROUP BY user_gender
ORDER BY likes_amount DESC LIMIT 1;


-- 4. Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).
SELECT COUNT(*) FROM likes
 WHERE target_type_id = 2
   -- увы IN напрямую с LIMIT работать отказывается, пришлось изголяться
   AND target_id IN (SELECT * FROM (
     SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10)
     AS sorted_profiles);

    
-- ---- --
-- JOIN --
-- ---- --
SELECT COUNT(*)
  FROM likes
  JOIN (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) AS sorted_profiles
    ON likes.target_type_id = 2
   AND likes.target_id IN(sorted_profiles.user_id);

  
-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети (критерии активности необходимо определить самостоятельно).
-- минимальная активность означаем минимум всех параметров: мало друзей, лайков, сообщений, файлов и т.д.
-- Для оценки сформировал комплексный параметр, равный сумме всех активностей. Проблемный NULL заменил на 0.
SELECT CONCAT(first_name, ' ', last_name) as user_name,
	COALESCE((SELECT COUNT(*) as like_number FROM likes WHERE users.id = likes.user_id GROUP BY user_id), 0) +
	COALESCE((SELECT COUNT(*) as message_number FROM messages WHERE users.id = messages.from_user_id GROUP BY from_user_id), 0) +
	COALESCE((SELECT COUNT(*) as posts_number FROM posts WHERE users.id = posts.user_id GROUP BY user_id), 0) +
	COALESCE((SELECT COUNT(*) as communities_number FROM communities_users WHERE users.id = communities_users.user_id GROUP BY user_id), 0) +
	COALESCE((SELECT COUNT(*) as friends_number FROM friendship WHERE users.id = friendship.user_id GROUP BY user_id), 0) +
	COALESCE((SELECT COUNT(*) as media_number FROM media WHERE users.id = media.user_id GROUP BY user_id), 0) +
	COALESCE((SELECT COUNT(*) as documents_number FROM documents WHERE users.id = documents.user_id GROUP BY user_id), 0)
as activity_summ FROM users ORDER BY activity_summ LIMIT 10;


-- ---- --
-- JOIN --
-- ---- --
-- Никак не получалось прикрутить свой GROUP BY к каждому JOIN без вложенного запроса, поэтому пришлось сделать франкенштейна.
-- Надеюсь хоть по времени реализации данная конструкция будет оптимальнее предыдущей, чего не скажешь о её написании и простоте чтения.
SELECT 
   CONCAT(first_name, ' ', last_name) AS user_name,
   COALESCE(like_number.counter, 0) +
   COALESCE(messages_number.counter, 0)  +
   COALESCE(posts_number.counter, 0) +
   COALESCE(communities_users_number.counter, 0) +
   COALESCE(friendship_number.counter, 0) +
   COALESCE(media_number.counter, 0) +
   COALESCE(documents_number.counter, 0) AS activity_summ
FROM users
LEFT JOIN 
	(SELECT user_id, COUNT(*) AS counter 
	 FROM likes GROUP BY user_id
	) AS like_number
  ON users.id = like_number.user_id
LEFT JOIN 
	(SELECT from_user_id, COUNT(*) AS counter 
	 FROM messages GROUP BY from_user_id
	) AS messages_number
  ON users.id = messages_number.from_user_id
LEFT JOIN 
	(SELECT user_id, COUNT(*) AS counter 
	 FROM posts GROUP BY user_id
	) AS posts_number
  ON users.id = posts_number.user_id
LEFT JOIN 
	(SELECT user_id, COUNT(*) AS counter
	 FROM communities_users GROUP BY user_id
	) AS communities_users_number 
  ON users.id = communities_users_number.user_id
LEFT JOIN 
	(SELECT user_id, COUNT(*) AS counter 
	 FROM friendship GROUP BY user_id
	) AS friendship_number
  ON users.id = friendship_number.user_id
LEFT JOIN 
	(SELECT user_id, COUNT(*) AS counter 
	 FROM media GROUP BY user_id
	) AS media_number
  ON users.id = media_number.user_id 
LEFT JOIN 
	(SELECT user_id, COUNT(*) AS counter 
	 FROM documents GROUP BY user_id
	) AS documents_number
  ON users.id = documents_number.user_id
ORDER BY activity_summ LIMIT 10;


-- Пробовал сделать через общий GROUP BY, но результат частично отличается
SELECT CONCAT(first_name, ' ', last_name) AS user_name,
	COALESCE(COUNT(DISTINCT(likes.id)), 0) +
	COALESCE(COUNT(DISTINCT(messages.id)), 0) +
	COALESCE(COUNT(DISTINCT(posts.id)), 0) +
	COALESCE(COUNT(DISTINCT(communities_users.user_id)), 0) +
	COALESCE(COUNT(DISTINCT(friendship.user_id)), 0) +
	COALESCE(COUNT(DISTINCT(media.id)), 0) +
	COALESCE(COUNT(DISTINCT(documents.id)), 0) AS activity_summ
	 FROM users
LEFT JOIN likes
	   ON users.id = likes.user_id
LEFT JOIN messages
	   ON users.id = messages.from_user_id
LEFT JOIN posts
	   ON users.id = posts.user_id
LEFT JOIN communities_users
	   ON users.id = communities_users.user_id
LEFT JOIN friendship
	   ON users.id = friendship.user_id
LEFT JOIN media
	   ON users.id = media.user_id
LEFT JOIN documents
	   ON users.id = documents.user_id
 GROUP BY users.id
 ORDER BY activity_summ 
	LIMIT 10;
