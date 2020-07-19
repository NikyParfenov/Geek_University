-- 1. Создайте двух пользователей которые имеют доступ к базе данных shop.
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных,
-- второму пользователю shop — любые операции в пределах базы данных shop.
USE shop;

CREATE USER 'shop_read'@'localhost';
CREATE USER 'shop'@'localhost';

GRANT ALL ON shop.* TO 'shop'@'localhost'; 
GRANT SELECT ON shop.* TO 'shop_read'@'localhost'; 

DROP USER 'shop_read'@'localhost';
DROP USER 'shop'@'localhost';;

-- 2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password,
-- содержащие первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts,
-- предоставляющий доступ к столбца id и name. Создайте пользователя user_read, который бы не имел доступа
-- к таблице accounts, однако, мог бы извлекать записи из представления username.
USE shop;

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  `password` VARCHAR(255)
);

INSERT INTO accounts (name, `password`) VALUES
	('user1', 'qwerty1'),
	('user2', 'qwerty2'),
	('user3', 'qwerty3'),
	('user4', 'qwerty4'),
	('user5', 'qwerty5');
	
SELECT * FROM accounts;	
	
CREATE VIEW username AS SELECT id, name FROM accounts;

SELECT * FROM username;

CREATE USER 'user_read'@'localhost';
GRANT SELECT ON shop.username TO 'user_read'@'localhost';
	