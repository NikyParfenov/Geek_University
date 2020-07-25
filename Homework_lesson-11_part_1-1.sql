-- -------------------------------------------------------------------------------------------------------------------------------- --
-- 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products                    --
-- в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name. --
-- -------------------------------------------------------------------------------------------------------------------------------- --

USE shop;
 
-- чистим за собой
DELETE FROM users WHERE name = 'Ихтиандр_users';
ALTER TABLE users AUTO_INCREMENT = 6;
DELETE FROM catalogs WHERE name = 'Ихтиандр_catalogs';
ALTER TABLE catalogs AUTO_INCREMENT = 2;
DELETE FROM products WHERE name = 'Ихтиандр_products';
ALTER TABLE products AUTO_INCREMENT = 7;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  table_name VARCHAR(100) COMMENT 'Название таблицы',
  id_in_table INT UNSIGNED COMMENT 'ID таблицы',
  name VARCHAR(255) COMMENT 'содержимое таблицы name',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время и дата создания'
) COMMENT = 'Таблица логов записей в users, catalogs, products' ENGINE=ARCHIVE;

DROP TRIGGER IF EXISTS users_insert;
DROP TRIGGER IF EXISTS catalogs_insert;
DROP TRIGGER IF EXISTS products_insert;

DELIMITER //
-- триггер пользователей
CREATE TRIGGER users_insert AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (table_name, id_in_table, name, created_at)
		 VALUES ('users', NEW.id, NEW.name, NOW());
END//
-- триггер каталога
CREATE TRIGGER catalogs_insert AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (table_name, id_in_table, name, created_at)
		 VALUES ('catalogs', NEW.id, NEW.name, NOW());
END//
-- триггер продуктов
CREATE TRIGGER products_insert AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (table_name, id_in_table, name, created_at)
		 VALUES ('products', NEW.id, NEW.name, NOW());
END//
DELIMITER ;

-- проверочка
INSERT INTO users (name, birthday_at) VALUES ('Ихтиандр_users', '2002-02-02');
INSERT INTO catalogs (name) VALUES ('Ихтиандр_catalogs');
INSERT INTO products (name, description, price, catalog_id) VALUES ('Ихтиандр_products', 'Здесь могла бы быть ваша реклама', '100500', '3');

