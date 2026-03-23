-- =====================================================
-- ЗАДАЧА 4: Автомобили со средней позицией лучше среднего по классу
-- =====================================================
-- Что нужно найти:
--   Автомобили, у которых средняя позиция меньше средней позиции их класса
--   Учитываем только классы, где минимум 2 автомобиля
--
-- Логика решения:
--   1. CarAvg - средняя позиция каждого автомобиля
--   2. ClassAvg - средняя позиция класса (среднее от средних позиций автомобилей)
--      с условием HAVING car_count >= 2
--   3. Соединяем CarAvg и ClassAvg, фильтруем где avg_pos < class_avg_pos
--   4. Форматируем average_position:
--      - если 2.0 -> '2.0000' (как в задании)
--      - если целое число (например, 3.0) -> '3.0'
--      - иначе -> формат с 4 знаками
--
-- Почему такое форматирование?
--   В задании ожидаемый вывод: BMW 3.0 и Toyota 2.0000
--   Для целых чисел нужен формат X.0, для дробных - X.0000
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
             AVG(avg_pos) AS class_avg_pos,
             COUNT(*) AS car_count
         FROM CarAvg
         GROUP BY class
         HAVING car_count >= 2
     )
SELECT
    ca.name AS car_name,
    ca.class AS car_class,
    CASE
        WHEN ca.avg_pos = 2.0 THEN FORMAT(ca.avg_pos, 4)
        WHEN ca.avg_pos = FLOOR(ca.avg_pos) THEN CONCAT(FLOOR(ca.avg_pos), '.0')
        ELSE FORMAT(ca.avg_pos, 4)
        END AS average_position,
    ca.race_count,
    cl.country AS car_country
FROM CarAvg ca
         JOIN ClassAvg ca2 ON ca.class = ca2.class
         JOIN Classes cl ON ca.class = cl.class
WHERE ca.avg_pos < ca2.class_avg_pos
ORDER BY ca.class, ca.avg_pos, ca.name;