-- Создание базы данных --
CREATE DATABASE my_orders;
USE my_orders;
-- Создание таблиц --
CREATE TABLE goods (
  good_id SMALLINT PRIMARY KEY NOT NULL,
  good_name VARCHAR(100) NOT NULL,
  brand_name VARCHAR(45) NOT NULL,
  price DECIMAL(7, 2) NOT NULL,
  quantity SMALLINT NOT NULL);
CREATE TABLE customers (
  customer_id MEDIUMINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  customer_name VARCHAR(30) NOT NULL,
  customer_surname VARCHAR(45) NOT NULL,
  phone_number VARCHAR(15) NOT NULL UNIQUE,
  email VARCHAR(320) NOT NULL UNIQUE);
-- Добавление автоинкремента к полю good_id 
ALTER TABLE goods 
CHANGE COLUMN good_id good_id SMALLINT NOT NULL AUTO_INCREMENT;
-- Заполнение таблицы--
INSERT INTO goods (good_name, brand_name, price, quantity)
VALUES 
('Galaxy S22 Ultra', 'Samsung', 91575, 2),
('Galaxy A03 4/64 Gb', 'Samsung', 7451, 100),
('Galaxy A23 4/64 Gb', 'Samsung', 12395, 50),
('Galaxy Note20 Ultra 12/256 Gb', 'Samsung', 52196, 1),
('iPhone 11 128 Gb', 'Apple', 37453, 2),
('iPhone 12 64 Gb', 'Apple', 46296, 15),
('iPhone 13 128 Gb', 'Apple', 52544, 72),
('Redmi Note 10 Pro 6/128 Gb', 'Xiaomi', 17566, 23),
('Redmi 10 2022 4/64 Gb', 'Xiaomi', 11553, 2),
('Redmi A1+ 2/32 Gb', 'Xiaomi', 5911, 88);
INSERT INTO customers (customer_name, customer_surname, phone_number, email)
VALUES 
('Иванов', 'Иван', '+79169157508', 'ivanov@mail.ru'),
('Петров', 'Петр', '+79169157507', 'petrov@mail.ru'),
('Собакин', 'Серафим', '+79169157509', 'sobakin@mail.ru'),
('Веселый', 'Николай', '+79169157501', 'nick@mail.ru'),
('Дураков', 'Иван', '+79169157502', 'fool@mail.ru'),
('Неадекватная', 'Виталина', '+79169157503', 'crazy_vit@mail.ru');
-- Создание таблицы orders--
CREATE TABLE orders (
  order_id MEDIUMINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  customerId MEDIUMINT NOT NULL,
  goodId SMALLINT NOT NULL,
  order_status VARCHAR(15) NOT NULL,
  created_date Date NOT NULL,
  FOREIGN KEY (customerId) REFERENCES customers (customer_id),
  FOREIGN KEY (goodId) REFERENCES goods (good_id)
  );
-- Заполнение данными таблицы orders --
INSERT INTO orders (customerId, goodId, order_status, created_date)
VALUES 
(1 , 2, 'Проверка заказа', '2022-11-25'),
(2 , 1, 'В работе', '2022-11-24'),
(3 , 7, 'Завершен', '2022-11-20'),
(4 , 5, 'Проверка заказа', '2022-11-25'),
(5 , 4, 'В работе', '2022-11-24'),
(6 , 8, 'Завершен', '2022-11-20');
-- Сгруппируйте значений количества в 3 сегмента — меньше 10, 10-30 и больше 30. - CASE--
SELECT good_name, brand_name, quantity,
CASE
    WHEN quantity < 10
        THEN "Товар заканчивается"
    WHEN quantity >= 10 AND quantity < 30
        THEN "Товара мало"
    WHEN quantity >= 30
        THEN "Товара много"
END AS relative_amount
FROM goods;
-- Покажите “полный” статус заказа, используя оператор CASE --
SELECT order_id, customerId, goodId,
CASE
    WHEN order_status = 'Завершен'
        THEN "Заказ закрыт"
    WHEN order_status = 'Проверка заказа'
        THEN "Неоплачено"
    WHEN order_status = 'В работе'
        THEN "Оплачено"
END AS total_status
FROM orders;



