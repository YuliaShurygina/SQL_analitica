-- Создайте представление с произвольным SELECT-запросом из прошлых уроков [CREATE VIEW]

CREATE VIEW people_older_35 AS
	SELECT p.user_id, u.firstname, u.lastname, p.gender, p.birthday
	FROM profiles as p
	INNER JOIN users as u ON p.user_id = u.id
	WHERE YEAR(CURRENT_TIMESTAMP) - YEAR(p.birthday) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(p.birthday, 5)) > 35;
-- Выведите данные, используя написанное представление [SELECT]

SELECT * FROM people_older_35;

-- Удалите представление [DROP VIEW]

DROP VIEW people_older_35;

-- * Сколько новостей (записей в таблице media) у каждого пользователя? 
-- Вывести поля: news_count (количество новостей), user_id (номер пользователя),
-- user_email (email пользователя). Попробовать решить с помощью CTE или с помощью обычного JOIN.

-- JOIM  

SELECT m.user_id, COUNT(m.user_id) as news_count, u.email
FROM media AS m
INNER JOIN users AS u ON  m.user_id = u.id
GROUP BY user_id
ORDER BY user_id;

-- CTE

USE `vk`;
DROP procedure IF EXISTS `news_quantity`;

USE `vk`;
DROP procedure IF EXISTS `vk`.`news_quantity`;
;

DELIMITER $$
USE `vk`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `news_quantity`()
BEGIN
	SELECT m.user_id, COUNT(m.user_id) as news_count, u.email
	FROM media AS m
	INNER JOIN users AS u ON  m.user_id = u.id
	GROUP BY user_id
	ORDER BY user_id;
END$$

DELIMITER ;
;

