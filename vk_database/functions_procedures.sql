-- Используя транзакцию, написать функцию, которая удаляет всю информацию об указанном пользователе из БД.
-- Пользователь задается по id. Удалить нужно все сообщения, лайки, медиа записи, 
-- профиль и запись из таблицы users. Функция должна возвращать номер пользователя.

-- добавлениt удаления дочерних таблиц при удалении родительской
ALTER TABLE `friend_requests` 
DROP FOREIGN KEY `friend_requests_ibfk_2`; 
ALTER TABLE `friend_requests`
ADD CONSTRAINT `friend_requests_ibfk_2` 
FOREIGN KEY (`target_user_id`)
REFERENCES `users` (`id`)
ON DELETE CASCADE;
ALTER TABLE `likes`
DROP FOREIGN KEY `likes_ibfk_1`;
ALTER TABLE `likes`
ADD CONSTRAINT `likes_ibfk_1` 
FOREIGN KEY (`user_id`)
REFERENCES `users` (`id`)
ON DELETE CASCADE;
ALTER TABLE `media`
DROP FOREIGN KEY `media_ibfk_1`;
ALTER TABLE `media`
ADD CONSTRAINT `media_ibfk_1`
FOREIGN KEY (`user_id`)
REFERENCES `users` (`id`)
ON DELETE CASCADE;
ALTER TABLE `likes`
DROP FOREIGN KEY `likes_ibfk_2`;
ALTER TABLE `likes`
ADD CONSTRAINT `likes_ibfk_2`
FOREIGN KEY (`media_id`)
REFERENCES `media` (`id`)
ON DELETE CASCADE;
ALTER TABLE `profiles`
Drop FOREIGN KEY `profiles_ibfk_2`;
ALTER TABLE `profiles`
ADD CONSTRAINT `profiles_ibfk_2`
FOREIGN KEY (`photo_id`)
REFERENCES `media` (`id`)
ON DELETE CASCADE;
ALTER TABLE `messages`
Drop FOREIGN KEY `messages_ibfk_1`;
ALTER TABLE `messages`
ADD CONSTRAINT `essages_ibfk_1`
FOREIGN KEY (`from_user_id`)
REFERENCES `users` (`id`)
ON DELETE CASCADE;
ALTER TABLE `messages`
Drop FOREIGN KEY `messages_ibfk_2`;
ALTER TABLE `messages`
ADD CONSTRAINT `messages_ibfk_2`
FOREIGN KEY (`to_user_id`)
REFERENCES `users` (`id`)
ON DELETE CASCADE;
ALTER TABLE `users_communities`
Drop FOREIGN KEY `users_communities_ibfk_1`;
ALTER TABLE `users_communities`
ADD CONSTRAINT `users_communities_ibfk_1`
FOREIGN KEY (`user_id`)
REFERENCES `users` (`id`)
ON DELETE CASCADE;
--
USE vk;

DROP FUNCTION IF EXISTS func_user_deletion;

DELIMITER // 
CREATE FUNCTION func_user_deletion(some_user_id BIGINT UNSIGNED)
RETURNS BIGINT READS SQL DATA
    BEGIN
		DELETE FROM users
			WHERE id = some_user_id;
    RETURN some_user_id;
    END//
DELIMITER ;

START TRANSACTION;
SELECT func_user_deletion(4);
COMMIT;

-- Предыдущую задачу решить с помощью процедуры.

USE `vk`;
DROP procedure IF EXISTS `user_deletion_procedure`;

USE `vk`;
DROP procedure IF EXISTS `vk`.`user_deletion_procedure`;
;

DELIMITER $$
USE `vk`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_deletion_procedure`(some_user_id BIGINT UNSIGNED)
    MODIFIES SQL DATA
BEGIN
	START TRANSACTION;
    	DELETE FROM users
			WHERE id = some_user_id;
	COMMIT;
END$$

DELIMITER ;
;

--* Написать триггер, который проверяет новое появляющееся сообщество.
--  Длина названия сообщества (поле name) должна быть не менее 5 символов. 
-- Если требование не выполнено, то выбрасывать исключение с пояснением.

drop TRIGGER if exists check_community_name_before_insert;

DELIMITER //

CREATE TRIGGER check_community_name_before_insert BEFORE INSERT ON communities
FOR EACH ROW
BEGIN
    IF LENGTH(NEW.name) < 5 THEN
		SIGNAL SQLSTATE '42000' 
		SET MESSAGE_TEXT = 'Вставка отменена. Название сообщества должно быть не менее 5 символов.';
    END IF;
END//

DELIMITER ;
