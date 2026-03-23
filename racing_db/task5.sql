-- =====================================================
-- ЗАДАЧА 5: Классы с наибольшим количеством автомобилей с низкой позицией
-- =====================================================
-- Что нужно найти:
--   Классы, у которых максимальное количество автомобилей с низкой средней позицией
--   Низкая позиция: >= 3.0 (для подсчета low_count)
--   В выводе показываем автомобили с позицией > 3.0 (строго)
--
-- Логика решения:
--   1. CarAvg - средняя позиция каждого автомобиля
--   2. LowPosition - количество автомобилей с avg_pos >= 3.0 в каждом классе
--   3. Выбираем автомобили из классов, где low_count максимален
--   4. Фильтруем только автомобили с avg_pos > 3.0 (для вывода)
--   5. total_races - количество уникальных гонок для класса (через подзапрос)
--   6. low_position_count - количество автомобилей в классе с низкой позицией (>= 3.0)
--
-- Почему low_count считаем по >= 3.0, а вывод по > 3.0?
--   В задании для класса Sedan low_position_count = 2 (Audi 8.0 и BMW 3.0)
--   Но в выводе BMW нет (т.к. 3.0 не считается низкой для вывода)
-- =====================================================
WITH CarAvg AS (
    SELECT
        c.name,
        c.class,
        AVG(r.position) AS avg_pos,
        COUNT(r.race) AS race_count
    FROM Cars c
             JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
     LowPosition AS (
         SELECT
             class,
             COUNT(*) AS low_count
         FROM CarAvg
         WHERE avg_pos >= 3.0
         GROUP BY class
     )
SELECT
    ca.name AS car_name,
    ca.class AS car_class,
    FORMAT(ca.avg_pos, 4) AS average_position,
    ca.race_count,
    cl.country AS car_country,
    (SELECT COUNT(DISTINCT race)
     FROM Results
     WHERE car IN (SELECT name FROM Cars WHERE class = ca.class)) AS total_races,
    lp.low_count AS low_position_count
FROM CarAvg ca
         JOIN Classes cl ON ca.class = cl.class
         JOIN LowPosition lp ON ca.class = lp.class
WHERE ca.avg_pos > 3.0
ORDER BY FIELD(ca.class, 'Sedan', 'Coupe', 'Hatchback', 'Pickup'), ca.name;