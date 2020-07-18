-- -------------------------------------- --
-- Хранимые процедуры и функции, триггеры --
-- -------------------------------------- --
-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.
USE shop;
DELIMITER //

DROP TRIGGER IF EXISTS check_product_name_description//

CREATE TRIGGER check_product_name_description
BEFORE UPDATE ON products
FOR EACH ROW 
BEGIN
	DECLARE prod_name VARCHAR(255);
	DECLARE prod_description TEXT;
	
	IF NEW.name IS NULL AND NEW.description IS NULL
	THEN
	 SET NEW.name = COALESCE(NEW.name, OLD.name);
	 SET NEW.description = COALESCE(NEW.description, OLD.description);
	 -- Можно сделать, чтобы выводил ошибку с текстом о невозможности изменения обеих столбцов
	 -- SIGNAL SQLSTATE '45000'
	 -- SET MESSAGE_TEXT = 'Операция не может быть выполнена. Значения NULL одновременно в name и в description недопустимы.';
	END IF;

END//

DELIMITER ;
-- Проверка на одновременный запрос изменений
-- UPDATE products SET name = NULL, description = NULL WHERE id = 1;

-- Проверка на последовательные изменения
-- UPDATE products SET name =  NULL WHERE id = 1;
-- UPDATE products SET description = NULL WHERE id = 1;

-- Возвращение значений
-- UPDATE products SET name = 'Intel Core i3-8100', description = 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.' WHERE id = 1;

