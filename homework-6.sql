-- 1. Создать все необходимые внешние ключи и диаграмму отношений.
-- 2. Создать и заполнить таблицы лайков и постов.
-- !!! Задания 1 и 2 представлены в дампе !!!

USE vk;
SHOW TABLES;

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
FROM likes GROUP BY user_gender;


-- 4. Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).
SELECT COUNT(*) FROM likes WHERE target_id IN
	(SELECT id FROM posts WHERE user_id IN
		-- увы IN напрямую с LIMIT работать отказывается, пришлось изголяться
		(SELECT user_id FROM (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) temptable)
	);

-- проверочные функции
SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10; -- 87, 81, 88, 19, 35, 50, 46, 73, 23, 83 // 10
SELECT id, user_id FROM posts WHERE user_id IN (87, 81, 88, 19, 35, 50, 46, 73, 23,83); -- 115, 124, 157, 138, 131, 194, 94, 22, 43, 117, 170, 3 // 12
SELECT id, user_id, target_id FROM likes WHERE target_id IN (115, 124, 157, 138, 131, 194, 94, 22, 43, 117, 170, 3); -- id: 7, 99, 66, 70, 88 // 5

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


