-- =====================================================
-- ЗАДАЧА 2: Автомобиль с наименьшей средней позицией среди всех
-- =====================================================
-- Что нужно найти:
--   Один автомобиль, у которого средняя позиция в гонках минимальна
--   Если таких несколько - выбрать по алфавиту (по имени)
--
-- Логика решения:
--   1. Вычисляем среднюю позицию для каждого автомобиля
--   2. Добавляем страну производства класса автомобиля
--   3. Сортируем по средней позиции, затем по имени
--   4. Берем первую строку (LIMIT 1)
--
-- Почему LIMIT 1?
--   По условию нужно выбрать один автомобиль (по алфавиту при равенстве)
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
)
SELECT
    ca.name AS car_name,
    ca.class AS car_class,
    ca.avg_pos AS average_position,
    ca.race_count,
    cl.country AS car_country
FROM CarAvg ca
         JOIN Classes cl ON ca.class = cl.class
ORDER BY ca.avg_pos, ca.name
    LIMIT 1;