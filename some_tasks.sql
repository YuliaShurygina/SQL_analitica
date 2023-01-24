-- Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
SET @seconds = 123456;
	SELECT CONCAT(
		FLOOR(TIME_FORMAT(SEC_TO_TIME(@seconds), '%H') / 24), 'days ',
		MOD(TIME_FORMAT(SEC_TO_TIME(@seconds), '%H'), 24), 'h:',
		TIME_FORMAT(SEC_TO_TIME(@seconds), '%im:%ss')
		) AS Result;




-- Выведите только четные числа от 1 до 10.
-- Пример: 2,4,6,8,10

CREATE TABLE numbers (
  number SMALLINT NOT NULL);
INSERT INTO numbers (number)
VALUES 
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

SELECT * FROM numbers WHERE (number%2)=0;