-- -------------------------------------------------------------------------------------- --
-- 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей. --
-- -------------------------------------------------------------------------------------- --

USE shop;
DESC users;
DROP PROCEDURE multiple_users; 

DELIMITER //
CREATE PROCEDURE multiple_users ()
BEGIN
  DECLARE i INT DEFAULT 1000000;
  WHILE i>0 DO
	INSERT INTO users (name, birthday_at)
		 VALUES (
		 CASE CEIL(10 * RAND())
		 	WHEN 1 THEN "Ольга"
		 	WHEN 2 THEN "Николай"
		 	WHEN 3 THEN "Наталья"
		 	WHEN 4 THEN "Олег"
		 	WHEN 5 THEN "Геннадий"
		 	WHEN 6 THEN "Ксения"
		 	WHEN 7 THEN "Марк"
		 	WHEN 8 THEN "Александр"
		 	WHEN 9 THEN "Алина"
		 	WHEN 10 THEN "Галина"
		 END,
		 DATE(FROM_UNIXTIME(UNIX_TIMESTAMP('1900-01-01 00:00:00') + FLOOR((RAND() * 1550000000))))
		 );
    SET i=i-1;
  END WHILE;
END//
DELIMITER ;

CALL multiple_users();
SELECT COUNT(*) FROM users;

