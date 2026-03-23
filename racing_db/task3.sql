-- =====================================================
-- ЗАДАЧА 3: Классы с наименьшей средней позицией
-- =====================================================
-- Что нужно найти:
--   Классы, у которых средняя позиция по всем автомобилям минимальна
--   Для каждого автомобиля из этих классов вывести информацию
--
-- Логика решения:
--   1. CarAvg - средняя позиция каждого автомобиля
--   2. ClassAvg - средняя позиция каждого класса (среднее от средних позиций автомобилей)
--   3. MinClassAvg - минимальное значение среди средних позиций классов
--   4. Выбираем автомобили из классов, где class_avg_pos = min_avg
--   5. total_races = race_count (количество гонок для данного автомобиля)
--
-- Почему total_races = race_count?
--   По условию задания нужно вывести количество гонок, в которых участвовал автомобиль
--   (см. ожидаемый вывод: Ferrari 488 ... 1 Italy 1 - последняя 1 это race_count)
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
     ClassAvg AS (
         SELECT
             class,
             AVG(avg_pos) AS class_avg_pos
         FROM CarAvg
         GROUP BY class
     ),
     MinClassAvg AS (
         SELECT MIN(class_avg_pos) AS min_avg
         FROM ClassAvg
     )
SELECT
    ca.name AS car_name,
    ca.class AS car_class,
    ca.avg_pos AS average_position,
    ca.race_count,
    cl.country AS car_country,
    ca.race_count AS total_races
FROM CarAvg ca
         JOIN Classes cl ON ca.class = cl.class
WHERE ca.class IN (
    SELECT class
    FROM ClassAvg
    WHERE class_avg_pos = (SELECT min_avg FROM MinClassAvg)
)
ORDER BY ca.avg_pos, ca.name;

-- =====================================================
-- ПРИМЕЧАНИЕ ПО ПОДЗАПРОСУ
-- =====================================================
-- В данном решении используется вложенный подзапрос для поиска
-- минимальной средней позиции среди классов.
-- Альтернативный подход с оконной функцией RANK() мог бы быть
-- более эффективным на больших объемах данных, но текущий вариант
-- более читаемый и полностью соответствует условию задачи.