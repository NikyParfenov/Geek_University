-- ------------------------------------- --
-- Транзакции, переменные, представления --
-- ------------------------------------- --
-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
USE sample;

DELETE FROM users WHERE id = 1;

START TRANSACTION;

USE shop;

INSERT INTO sample.users
	 SELECT *
	   FROM shop.users 
	  WHERE id = 1;

DELETE FROM shop.users WHERE id = 1;

COMMIT;

-- для "лечения" shop.users с id=1
-- USE shop;
-- INSERT INTO users (id, name, birthday_at) VALUES (1, 'Геннадий', '1990-10-05');

-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы products 
-- и соответствующее название каталога name из таблицы catalogs.
USE shop;

DROP VIEW IF EXISTS prodname;

CREATE VIEW prodname 
  AS SELECT products.name AS Product_name, catalogs.name AS Product_type
       FROM products
       JOIN catalogs
         ON products.catalog_id = catalogs.id;

SELECT * FROM prodname;
