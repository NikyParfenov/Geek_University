-- 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел.
-- Вызов функции FIBONACCI(10) должен возвращать число 55.

DROP FUNCTION IF EXISTS FIBONACCI;
DELIMITER //

CREATE FUNCTION FIBONACCI(user_number INT)
RETURNS INT DETERMINISTIC
BEGIN
	SET @x = user_number;
	RETURN ( ( POW((1+SQRT(5))/2, @x) - POW((1-SQRT(5))/2, @x) ) / SQRT(5) );
END//

SELECT FIBONACCI(10)//