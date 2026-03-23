-- =====================================================
-- ЗАДАЧА 2: Объединить данные по разным типам транспорта
-- =====================================================
-- Критерии отбора:
--   Автомобили: мощность > 150 л.с., объем < 3 л, цена < 35000
--   Мотоциклы: мощность > 150 л.с., объем < 1.5 л, цена < 20000
--   Велосипеды: количество передач > 18, цена < 4000
--
-- Логика решения:
--   1. Используем UNION для объединения трех независимых выборок
--   2. Для велосипедов выводим NULL в полях horsepower и engine_capacity,
--      так как эти характеристики к ним не применимы
--   3. Добавляем поле vehicle_type для идентификации типа транспорта
--   4. Сортировка по horsepower (NULL в конце списка)
--
-- Почему UNION, а не UNION ALL?
--   Данные не пересекаются (разные vehicle_type), можно использовать UNION ALL
--   для производительности, но UNION гарантирует уникальность
-- =====================================================
SELECT v.maker, c.model, c.horsepower, c.engine_capacity, 'Car' AS vehicle_type
FROM Vehicle v
         JOIN Car c ON v.model = c.model
WHERE c.horsepower > 150
  AND c.engine_capacity < 3
  AND c.price < 35000

UNION

SELECT v.maker, m.model, m.horsepower, m.engine_capacity, 'Motorcycle' AS vehicle_type
FROM Vehicle v
         JOIN Motorcycle m ON v.model = m.model
WHERE m.horsepower > 150
  AND m.engine_capacity < 1.5
  AND m.price < 20000

UNION

SELECT v.maker, b.model, NULL AS horsepower, NULL AS engine_capacity, 'Bicycle' AS vehicle_type
FROM Vehicle v
         JOIN Bicycle b ON v.model = b.model
WHERE b.gear_count > 18
  AND b.price < 4000

ORDER BY horsepower DESC;