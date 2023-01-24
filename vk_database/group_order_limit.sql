-- Написать скрипт, возвращающий список имен (только firstname) пользователей
-- без повторений в алфавитном порядке. [ORDER BY]
SELECT DISTINCT firstname
FROM users
ORDER BY firstname;

-- Выведите количество мужчин старше 35 лет [COUNT].
SELECT COUNT(birthday) AS quantity_older_35
FROM profiles
WHERE YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(birthday, 5)) > 35;

-- Сколько заявок в друзья в каждом статусе? (таблица friend_requests) [GROUP BY]
SELECT status, COUNT(status) AS request_quantity
FROM friend_requests
GROUP BY status;

-- Выведите номер пользователя, который отправил 
-- больше всех заявок в друзья (таблица friend_requests) [LIMIT].
SELECT initiator_user_id, COUNT(initiator_user_id) AS request_quantity_from_one_user
FROM friend_requests
GROUP BY initiator_user_id
ORDER BY request_quantity_from_one_user DESC
LIMIT 1;

-- Выведите названия и номера групп, имена которых состоят из 5 символов [LIKE].
SELECT name, id 
FROM communities
WHERE name LIKE '_____';