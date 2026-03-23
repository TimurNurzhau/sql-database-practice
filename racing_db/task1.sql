-- =====================================================
-- ЗАДАЧА 1: Автомобили с наименьшей средней позицией в каждом классе
-- =====================================================
-- Что нужно найти:
--   Для каждого класса определить автомобиль(и), у которых средняя позиция в гонках минимальна
--
-- Логика решения:
--   1. С помощью CTE (CarAvg) вычисляем для каждого автомобиля:
--      - среднюю позицию (AVG(r.position))
--      - количество гонок (COUNT(r.race))
--      - год выпуска (MAX(c.year)) - нужен для сортировки
--   2. Находим минимальную среднюю позицию для каждого класса
--   3. Выбираем автомобили, у которых средняя позиция равна минимальной для своего класса
--   4. Сортируем по средней позиции, а при равенстве - по году выпуска
--
-- Почему используем CTE?
--   Для повышения читаемости и возможности повторного использования подзапроса
-- =====================================================
WITH CarAvg AS (
    SELECT
        c.name,
        c.class,
        AVG(r.position) AS avg_pos,
        COUNT(r.race) AS race_count,
        MAX(c.year) AS year
FROM Cars c
    JOIN Results r ON c.name = r.car
GROUP BY c.name, c.class
    )
SELECT
    ca.name AS car_name,
    ca.class AS car_class,
    ca.avg_pos AS average_position,
    ca.race_count
FROM CarAvg ca
WHERE (ca.class, ca.avg_pos) IN (
    SELECT class, MIN(avg_pos)
    FROM CarAvg
    GROUP BY class
)
ORDER BY ca.avg_pos, ca.year;