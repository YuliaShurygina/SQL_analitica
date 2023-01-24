-- Cоздайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
CREATE VIEW show_cars AS
SELECT * 
FROM test_db
WHERE cost < 25000;
SELECT * FROM show_cars;

-- Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)
ALTER VIEW show_cars AS
SELECT *
FROM test_db
WHERE cost < 30000;
SELECT * FROM show_cars;

-- Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
CREATE VIEW skoda_and_audi_cars AS
SELECT *
FROM test_db
WHERE name IN ('Skoda', 'Audi');
SELECT * FROM skoda_and_audi_cars;
