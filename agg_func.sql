-- Создание базы данных --
CREATE DATABASE hometask3;
USE hometask3;
-- Создание таблицы --
CREATE TABLE human_resources(
    worker_id SMALLINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    worker_name VARCHAR(15) NOT NULL,
    worker_surname VARCHAR(20) NOT NULL,
    specialty VARCHAR(25) NOT NULL,
    seniority SMALLINT NOT NULL,
    salary MEDIUMINT NOT NULL,
    age SMALLINT NOT NULL);
-- Заполнение таблицы--   
INSERT INTO human_resources(worker_name, worker_surname, specialty, seniority, salary, age)
VALUES
('Вася', 'Васькин', 'начальник', 40, 100000, 60),
('Петя', 'Петькин', 'начальник', 8, 70000, 30),
('Катя', 'Каткина', 'инженер', 2, 70000, 25),
('Саша', 'Сашкин', 'инженер', 12, 50000, 35),
('Иван', 'Иванов', 'рабочий', 40, 30000, 59),
('Петр', 'Петров', 'рабочий', 20, 25000, 40),
('Сидор', 'Сидоров', 'рабочий', 10, 20000, 35),
('Антон', 'Антонов', 'рабочий', 8, 19000, 28),
('Юра', 'Юркин', 'рабочий', 5, 15000, 25),
('Максим', 'Воронин', 'рабочий', 2, 11000, 22),
('Юра', 'Галкин', 'рабочий', 3, 12000, 24),
('Люся', 'Люськина', 'уборщик', 10, 10000, 49);
-- Отсортируйте поле “зарплата” (salary) в порядке убывания и возрастания--
-- Возрастание--
SELECT *
FROM human_resources
ORDER BY salary;
-- Убывание--
SELECT *
FROM human_resources
ORDER BY salary DESC;
-- Выведите 5 максимальных зарплат (salary)--
SELECT salary
FROM human_resources
ORDER BY salary DESC
LIMIT 5;
-- Подсчитать суммарную зарплату(salary) по каждой специальности --
SELECT specialty, SUM(salary) as sum_salary
FROM human_resources
GROUP BY specialty;
-- Найти количество сотрудников по специальности “Рабочий” (post) в возрасте от 24 до 42 лет.--
SELECT specialty, COUNT(specialty) as total_count_of_workers
FROM human_resources
WHERE age >= 24 AND age <= 42
GROUP BY specialty
HAVING specialty = 'рабочий';
-- Найти количество специальностей--
SELECT COUNT(DISTINCT specialty) as specialty_quantity
FROM human_resources;
-- Вывести специальности, у которых средний возраст сотрудника меньше 44 лет --
SELECT specialty, AVG(age) as average_age
FROM human_resources
GROUP BY specialty
HAVING average_age < 44;
