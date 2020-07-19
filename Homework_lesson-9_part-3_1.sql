-- -------------------------------------- --
-- Хранимые процедуры и функции, триггеры --
-- -------------------------------------- --
-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер",
-- с 00:00 до 6:00 — "Доброй ночи".
DROP FUNCTION IF EXISTS hello;
DELIMITER //

CREATE FUNCTION hello()
RETURNS TEXT NO SQL
BEGIN
	CASE
		WHEN CURRENT_TIME() >= TIME_FORMAT('06:00:00', '%H:%i:%S')
		 AND CURRENT_TIME() < TIME_FORMAT('12:00:00', '%H:%i:%S')
		THEN RETURN 'Доброе утро';
			
		WHEN CURRENT_TIME() >= TIME_FORMAT('12:00:00', '%H:%i:%S')
		  AND CURRENT_TIME() < TIME_FORMAT('18:00:00', '%H:%i:%S')
		THEN RETURN 'Добрый день';
			
		WHEN CURRENT_TIME() >= TIME_FORMAT('18:00:00', '%H:%i:%S')
		  AND CURRENT_TIME() < TIME_FORMAT('24:00:00', '%H:%i:%S')
		THEN RETURN 'Добрый вечер';
			
		WHEN CURRENT_TIME() >= TIME_FORMAT('00:00:00', '%H:%i:%S')
		  AND CURRENT_TIME() < TIME_FORMAT('06:00:00', '%H:%i:%S')
		THEN RETURN 'Доброй ночи';
			
		ELSE
			 RETURN 'Что-то пошло не так';
				 
	END CASE;
END//

SELECT hello()//
