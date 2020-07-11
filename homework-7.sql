-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
USE shop;

-- заполним чем-нибудь orders
INSERT INTO orders
  (user_id)
VALUES
  (4),
  (4),
  (3); 
 
 SELECT
  id, name
FROM
  users
WHERE
  users.id IN (SELECT user_id FROM orders);
  
-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.
USE shop;

SELECT
   products.name, products.description, catalogs.name
FROM 
  products
JOIN
  catalogs
WHERE 
  products.catalog_id = catalogs.id;

-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское.
-- Выведите список рейсов flights с русскими названиями городов.
DROP DATABASE IF EXISTS flight_hw_7;
CREATE DATABASE flight_hw_7;

USE flight_hw_7;

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(255) COMMENT 'Город вылета',
  `to` VARCHAR(255) COMMENT 'Город прилета'
 );
 
INSERT INTO flights
  (`from`, `to`)
VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');
  
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(255) COMMENT 'Таблица английских имен городов',
  name VARCHAR(255) COMMENT 'Таблица русских имен городов'
 ); 
 
INSERT INTO cities
  (label, name)
VALUES
  ('moscow', 'Москва'),
  ('irkutsk', 'Иркутск'),
  ('novgorod', 'Новгород'),
  ('kazan', 'Казань'),
  ('omsk', 'Омск');
  
SELECT
  id,
  (SELECT CASE `from` WHEN cities.label THEN cities.name END FROM cities WHERE `from` = cities.label) as `from`,
  (SELECT CASE `to` WHEN cities.label THEN cities.name END FROM cities WHERE `to` = cities.label) as `to`
FROM flights;
 