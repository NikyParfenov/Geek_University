DROP DATABASE IF EXISTS Homework_lesson_five;
CREATE DATABASE Homework_lesson_five;
USE Homework_lesson_five;
SHOW DATABASES;

-- Задание-1 (Операторы, фильтрация, сортировка и ограничение)
-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

SHOW TABLES;
 
DESC users;

SELECT * FROM users;

UPDATE users SET created_at = NOW(), updated_at = NOW();

SELECT * FROM users;

-- Задание-2 (Операторы, фильтрация, сортировка и ограничение)
-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время
-- помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
DROP TABLE IF EXISTS users2;
CREATE TABLE users2 (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO users2 (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Наталья', '1984-11-12', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Александр', '1985-05-20', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Сергей', '1988-02-14', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Иван', '1998-01-12', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Мария', '1992-08-29', '20.10.2017 8:10', '20.10.2017 8:10');
 
SHOW TABLES;
 
DESC users2;

SELECT * FROM users2;

SELECT STR_TO_DATE(created_at, '%d.%m.%Y %H:%i') FROM users2;

UPDATE users2 SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i');
UPDATE users2 SET updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
ALTER TABLE users2 MODIFY COLUMN created_at DATETIME;
ALTER TABLE users2 MODIFY COLUMN updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP;

DESC users2;

SELECT * FROM users2;

-- Задание-3 (Операторы, фильтрация, сортировка и ограничение)
-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
-- 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом,
-- чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO storehouses_products
  (storehouse_id, product_id, value)
 VALUES
  (1, 1, 0),
  (2, 2, 2500),
  (3, 3, 0),
  (4, 4, 30),
  (5, 5, 500),
  (6, 6, 1);

SHOW TABLES;
 
DESC storehouses_products;

SELECT * FROM storehouses_products ORDER BY CASE WHEN value = 0 THEN 'pass' END, value;
SELECT * FROM storehouses_products ORDER BY value = 0, value;

-- Задание-4 (Операторы, фильтрация, сортировка и ограничение)
-- (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
-- Месяцы заданы в виде списка английских названий (may, august)
DROP TABLE IF EXISTS users3;
CREATE TABLE users3 (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at VARCHAR(255) COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users3 (name, birthday_at) VALUES
  ('Геннадий', '1990 October 05'),
  ('Наталья', '1984 November 12'),
  ('Александр', '1985 May 20'),
  ('Сергей', '1988 February 14'),
  ('Иван', '1998 January 12'),
  ('Мария', '1992 August 29');
  
SHOW TABLES;
 
DESC users3;

SELECT * FROM users3;

SELECT * FROM users3 WHERE birthday_at LIKE '%May%' OR birthday_at LIKE '%August%';

-- Задание-5 (Операторы, фильтрация, сортировка и ограничение)
-- (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке,
-- заданном в списке IN.
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

 -- у первого варианта может быть проблема с совместимостью
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY CASE WHEN id = 5 THEN 1 WHEN id = 1 THEN 2 WHEN id = 2 THEN 3 END;

-- Задание-1 (Агрегация данных)
-- Подсчитайте средний возраст пользователей в таблице users.
DROP TABLE IF EXISTS users4;
CREATE TABLE users4 (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users4 (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
  
 SELECT AVG( TIMESTAMPDIFF( YEAR, birthday_at, NOW() ) ) FROM users4; 
 
-- Задание-2 (Агрегация данных)
-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.
DROP TABLE IF EXISTS users5;
CREATE TABLE users5 (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users5 (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

-- для года рождения пользователя (цифровой и буквенный формат дня недели)
SELECT COUNT(*) as number, DAYOFWEEK(birthday_at) as weekday FROM users5 GROUP BY weekday;
SELECT COUNT(*) as number, DATE_FORMAT(birthday_at, '%a') as weekday FROM users5 GROUP BY weekday;
-- для текущего 2020 года (цифровой и буквенный формат дня недели)
SELECT COUNT(*) as number, DAYOFWEEK(DATE_FORMAT(birthday_at, '2020-%m-%d')) as weekday FROM users5 GROUP BY weekday;
SELECT COUNT(*) as number, DATE_FORMAT(DATE_FORMAT(birthday_at, '2020-%m-%d'), '%a') as weekday FROM users5 GROUP BY weekday;
-- без хардкода
SELECT COUNT(*) as number, DAYOFWEEK(CONCAT(YEAR(NOW()), '-', MONTH(birthday_at), '-', DAY(birthday_at))) as weekday FROM users5 GROUP BY weekday;
SELECT COUNT(*) as number, DATE_FORMAT(CONCAT(YEAR(NOW()), '-', MONTH(birthday_at), '-', DAY(birthday_at)), '%a') as weekday FROM users5 GROUP BY weekday;

-- Задание-3 (Агрегация данных)
-- (по желанию) Подсчитайте произведение чисел в столбце таблицы.s
DROP TABLE IF EXISTS multiple;
CREATE TABLE multiple (
  id SERIAL PRIMARY KEY,
  value INT UNSIGNED
  );
 
INSERT INTO multiple (value) VALUES (1), (2), (3), (4), (5);

SELECT * FROM multiple;

SELECT EXP(SUM(LOG(value))) FROM multiple;
