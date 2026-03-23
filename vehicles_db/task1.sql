-- Задача 1: Найти производителей и модели мотоциклов с мощностью более 150 л.с., ценой менее 20000, тип Sport
SELECT maker, model FROM Vehicle
                             JOIN Motorcycle ON Vehicle.model = Motorcycle.model
WHERE horsepower > 150 AND price < 20000 AND type = 'Sport'
ORDER BY horsepower DESC;