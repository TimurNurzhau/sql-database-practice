-- =============================================
-- База данных: Автомобильные гонки
-- Решения задач 1-5
-- =============================================

-- Задача 1
-- Определить автомобили из каждого класса с наименьшей средней позицией
-- =============================================

WITH CarAvgPosition AS (
    SELECT
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Cars c
             JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
     MinPositionPerClass AS (
         SELECT
             car_class,
             MIN(average_position) AS min_avg_position
         FROM CarAvgPosition
         GROUP BY car_class
     )
SELECT
    cap.car_name,
    cap.car_class,
    ROUND(cap.average_position, 4) AS average_position,
    cap.race_count
FROM CarAvgPosition cap
         JOIN MinPositionPerClass mppc
              ON cap.car_class = mppc.car_class
                  AND cap.average_position = mppc.min_avg_position
ORDER BY average_position;

-- =============================================
-- Задача 2
-- Определить автомобиль с наименьшей средней позицией среди всех
-- =============================================

WITH CarAvgPosition AS (
    SELECT
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Cars c
             JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
)
SELECT
    cap.car_name,
    cap.car_class,
    ROUND(cap.average_position, 4) AS average_position,
    cap.race_count,
    cl.country AS car_country
FROM CarAvgPosition cap
         JOIN Classes cl ON cap.car_class = cl.class
ORDER BY cap.average_position ASC, cap.car_name ASC
    LIMIT 1;

-- =============================================
-- Задача 3
-- Определить классы с наименьшей средней позицией и вывести автомобили из этих классов
-- =============================================

WITH CarAvgPosition AS (
    SELECT
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Cars c
             JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
     ClassAvgPosition AS (
         SELECT
             car_class,
             AVG(average_position) AS class_avg_position
         FROM CarAvgPosition
         GROUP BY car_class
     ),
     MinClassAvg AS (
         SELECT MIN(class_avg_position) AS min_avg
         FROM ClassAvgPosition
     )
SELECT
    cap.car_name,
    cap.car_class,
    ROUND(cap.average_position, 4) AS average_position,
    cap.race_count,
    cl.country AS car_country,
    (SELECT COUNT(*) FROM Results r
                              JOIN Cars c ON r.car = c.name
     WHERE c.class = cap.car_class) AS total_races
FROM CarAvgPosition cap
         JOIN Classes cl ON cap.car_class = cl.class
WHERE cap.car_class IN (
    SELECT cap2.car_class
    FROM CarAvgPosition cap2
             JOIN ClassAvgPosition clavg ON cap2.car_class = clavg.car_class
    WHERE clavg.class_avg_position = (SELECT min_avg FROM MinClassAvg)
)
ORDER BY average_position;

-- =============================================
-- Задача 4
-- Определить автомобили со средней позицией лучше средней по классу (в классе минимум 2 авто)
-- =============================================

WITH CarAvgPosition AS (
    SELECT
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Cars c
             JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
     ClassAvgPosition AS (
         SELECT
             car_class,
             AVG(average_position) AS class_avg_position,
             COUNT(*) AS car_count
         FROM CarAvgPosition
         GROUP BY car_class
         HAVING COUNT(*) >= 2
     )
SELECT
    cap.car_name,
    cap.car_class,
    ROUND(cap.average_position, 4) AS average_position,
    cap.race_count,
    cl.country AS car_country
FROM CarAvgPosition cap
         JOIN ClassAvgPosition clavg ON cap.car_class = clavg.car_class
         JOIN Classes cl ON cap.car_class = cl.class
WHERE cap.average_position < clavg.class_avg_position
ORDER BY cap.car_class, cap.average_position;

-- =============================================
-- Задача 5
-- Определить классы с наибольшим количеством автомобилей со средней позицией > 3.0
-- =============================================

WITH CarAvgPosition AS (
    SELECT
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Cars c
             JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
     LowPositionCars AS (
         SELECT
             car_name,
             car_class,
             average_position,
             race_count
         FROM CarAvgPosition
         WHERE average_position >= 3.0
     ),
     ClassLowCount AS (
         SELECT
             car_class,
             COUNT(*) AS low_position_count
         FROM LowPositionCars
         GROUP BY car_class
     ),
     MaxLowCount AS (
         SELECT MAX(low_position_count) AS max_count
         FROM ClassLowCount
     )
SELECT
    lpc.car_name,
    lpc.car_class,
    ROUND(lpc.average_position, 4) AS average_position,
    lpc.race_count,
    cl.country AS car_country,
    (SELECT COUNT(*) FROM Results r
                              JOIN Cars c ON r.car = c.name
     WHERE c.class = lpc.car_class) AS total_races,
    clc.low_position_count
FROM LowPositionCars lpc
         JOIN ClassLowCount clc ON lpc.car_class = clc.car_class
         JOIN Classes cl ON lpc.car_class = cl.class
WHERE clc.low_position_count = (SELECT max_count FROM MaxLowCount)
ORDER BY clc.low_position_count DESC;