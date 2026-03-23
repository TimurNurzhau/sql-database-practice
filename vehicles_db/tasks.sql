-- =============================================
-- База данных: Транспортные средства
-- Решения задач
-- =============================================

-- Задача 1
-- Найти производителей и модели мотоциклов с мощностью > 150 л.с.,
-- ценой < 20000 долларов и типом Sport. Сортировка по мощности убывание.
-- =============================================

SELECT
    v.maker,
    m.model
FROM Motorcycle m
         JOIN Vehicle v ON m.model = v.model
WHERE m.horsepower > 150
  AND m.price < 20000
  AND m.type = 'Sport'
ORDER BY m.horsepower DESC;

-- =============================================
-- Задача 2
-- Объединить данные об автомобилях, мотоциклах и велосипедах,
-- соответствующих заданным критериям.
-- =============================================

-- Автомобили: мощность > 150 л.с., объем < 3 л, цена < 35000
SELECT
    v.maker,
    c.model,
    c.horsepower,
    c.engine_capacity,
    'Car' AS vehicle_type
FROM Car c
         JOIN Vehicle v ON c.model = v.model
WHERE c.horsepower > 150
  AND c.engine_capacity < 3.0
  AND c.price < 35000

UNION ALL

-- Мотоциклы: мощность > 150 л.с., объем < 1.5 л, цена < 20000
SELECT
    v.maker,
    m.model,
    m.horsepower,
    m.engine_capacity,
    'Motorcycle' AS vehicle_type
FROM Motorcycle m
         JOIN Vehicle v ON m.model = v.model
WHERE m.horsepower > 150
  AND m.engine_capacity < 1.5
  AND m.price < 20000

UNION ALL

-- Велосипеды: передач > 18, цена < 4000
SELECT
    v.maker,
    b.model,
    NULL AS horsepower,
    NULL AS engine_capacity,
    'Bicycle' AS vehicle_type
FROM Bicycle b
         JOIN Vehicle v ON b.model = v.model
WHERE b.gear_count > 18
  AND b.price < 4000

ORDER BY horsepower DESC;