-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).
SELECT from_user_id, to_user_id, COUNT(to_user_id) AS max_messages
FROM messages
WHERE to_user_id = 1
GROUP BY from_user_id
ORDER BY max_messages DESC
LIMIT 1;
-- c детализацией фамилии
SELECT from_user_id, u1.lastname AS sender, to_user_id, u2.lastname AS reciever, COUNT(to_user_id) AS max_messages
FROM messages
INNER JOIN users AS u1 ON u1.id = messages.from_user_id
INNER JOIN  users AS u2 ON u2.id = messages.to_user_id
WHERE to_user_id = 1
GROUP BY from_user_id
ORDER BY max_messages DESC
LIMIT 1;


-- Подсчитать количество групп, в которые вступил каждый пользователь.

SELECT u.id, u.lastname, COUNT(community_id) AS communities_quantity
FROM users_communities
RIGHT JOIN users AS u ON u.id = users_communities.user_id
GROUP BY u.id
ORDER BY u.id;

-- Подсчитать количество пользователей в каждом сообществе.
SELECT c.name AS group_name, community_id, COUNT(user_id) AS people_quantity
FROM users_communities
RIGHT JOIN communities AS c ON c.id = users_communities.community_id
GROUP BY community_id
ORDER BY community_id;

-- * Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
SELECT COUNT(likes.id) AS likes_to_children
FROM likes
INNER JOIN media AS m ON m.id = likes.media_id
INNER JOIN profiles AS p ON p.user_id = m.user_id
WHERE YEAR(CURRENT_TIMESTAMP) - YEAR(p.birthday) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(p.birthday, 5)) < 10
ORDER BY m.user_id;

-- * Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT p.gender, COUNT(p.gender) AS total_likes_by_gender
FROM likes
INNER JOIN profiles AS p ON p.user_id = likes.user_id
GROUP BY p.gender
ORDER BY total_likes_by_gender DESC
LIMIT 1;