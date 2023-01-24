-- Написать cкрипт, добавляющий в БД vk, которую создали на занятии,
-- 2-3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей) (CREATE TABLE)

DROP TABLE IF EXISTS `book_genres`;
CREATE TABLE `book_genres` (
	`id` SERIAL,
	`name` varchar(55) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
	id SERIAL,
	`genre_id` BIGINT unsigned NULL,
	`media_id` BIGINT unsigned NOT NULL,

	FOREIGN KEY (genre_id) REFERENCES book_genres(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS `books_comments`;
CREATE TABLE `books_comments` (
	id SERIAL,
	`user_id` BIGINT UNSIGNED NOT NULL,
	`book_id` BIGINT unsigned NOT NULL,
    `text` TEXT,
    `created_at` DATETIME DEFAULT NOW(), 

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);


-- Заполнить 2 таблицы БД vk данными (по 10 записей в каждой таблице) (INSERT)
INSERT INTO users (firstname, lastname, email, password_hash, phone)
VALUES 
('Petr', 'Ivanov', 'ivanov@mail.ru', '051188', 79169547855),
('Fedor', 'Ivanov', 'ivanov77@mail.ru', '051187', 79169557855),
('Alex', 'Sharapov', 'sharapov@mail.ru', 'ghjldg', 79179547855),
('Julia', 'Petrova', 'julia@mail.ru', '05ghj', 79169547834),
('Valeria', 'Ivanova', 'ivanovaV@mail.ru', '051186ghj', 79169547835),
('Alla', 'Timofeeva', 'alla@mail.ru', 'alla', 79169547836),
('Timofey', 'Ivanov', 'timofey@mail.ru', '078909', 79169547837),
('Victor', 'Victorov', 'victor@mail.ru', '789879', 79169547838),
('Petra', 'Ivanova', 'ivanovaP@mail.ru', '4uie', 79169547839),
('Ivan', 'Petrov', 'petrov@mail.ru', '915755', 79169547833);

INSERT INTO book_genres (name, user_id)
VALUES
('detectiv', 1),
('love_romance', 1);


INSERT INTO media_types(name)
VALUES
('books');


INSERT INTO media(media_type_id,  user_id, body, filename, size)
VALUES
(1, 1, 'book_1', 'Puaro', 5),
(1, 1, 'book_2', 'Marple', 7),
(1, 1, 'book_3', 'Murder', 5),
(1, 1, 'book_4', 'Psycho', 9),
(1, 1, 'book_5', 'love', 8),
(1, 1, 'book_6', 'love_you', 4),
(1, 1, 'book_7', 'Kilo', 6),
(1, 1, 'book_8', 'Killing_Eve', 5),
(1, 1, 'book_9', 'Killing_me', 7),
(1, 1, 'book_10', 'Kill', 5);


INSERT INTO books (genre_id, media_id)
VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 5),
(2, 6),
(1, 7);

INSERT INTO books_comments(user_id, book_id, text)
VALUES
(1, 1, 'Great Book!!!');


INSERT INTO profiles(user_id, gender, birthday)
VALUES
(1, 'M', '2008-10-23'),
(2, 'M', '1986-10-23');

INSERT INTO messages(from_user_id, to_user_id, body)
VALUES
(1, 2, 'fghkjhgfs fghkhf'),
(2, 1, 'ghjkjhgf yuliujh');

-- 3.* Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = true).
-- При необходимости предварительно добавить такое поле в таблицу profiles со значением 
-- по умолчанию = false (или 0) (ALTER TABLE + UPDATE)
ALTER TABLE profiles ADD COLUMN is_active SMALLINT DEFAULT 0;

UPDATE profiles SET is_active = 1
WHERE YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(birthday, 5)) < 18
; 
-- или
UPDATE profiles SET is_active = 1
WHERE DATEDIFF(CURRENT_TIMESTAMP, birthday) < 18;

-- 4.* Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней) (DELETE)
UPDATE messages
	SET created_at='2223-11-24 04:06:29'
	WHERE from_user_id = 2;

-- Удалим сообщение из будущего
DELETE FROM messages
WHERE created_at > now()
;

-- Часто есть смысл использовать автообновление значения поля при операции UPDATE
--, например: "updated_at DATETIME ON UPDATE now()".