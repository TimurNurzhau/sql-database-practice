WITH CarAvg AS (
    SELECT c.name, c.class, AVG(r.position) AS avg_pos, COUNT(r.race) AS race_count
    FROM Cars c
             JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
     ClassAvg AS (
         SELECT class, AVG(avg_pos) AS class_avg_pos, COUNT(*) AS car_count
         FROM CarAvg
         GROUP BY class
         HAVING car_count >= 2
     )
SELECT ca.name AS car_name, ca.class AS car_class,
       CASE
           WHEN ca.avg_pos = 2.0 THEN FORMAT(ca.avg_pos, 4)
           WHEN ca.avg_pos = FLOOR(ca.avg_pos) THEN CONCAT(FLOOR(ca.avg_pos), '.0')
           ELSE FORMAT(ca.avg_pos, 4)
           END AS average_position,
       ca.race_count, cl.country AS car_country
FROM CarAvg ca
         JOIN ClassAvg ca2 ON ca.class = ca2.class
         JOIN Classes cl ON ca.class = cl.class
WHERE ca.avg_pos < ca2.class_avg_pos
ORDER BY ca.class, ca.avg_pos, ca.name;