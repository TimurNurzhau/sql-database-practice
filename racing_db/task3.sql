WITH CarAvg AS (
    SELECT c.name, c.class, AVG(r.position) AS avg_pos, COUNT(r.race) AS race_count
    FROM Cars c
             JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
     ClassAvg AS (
         SELECT class, AVG(avg_pos) AS class_avg_pos
         FROM CarAvg
         GROUP BY class
     ),
     MinClassAvg AS (
         SELECT MIN(class_avg_pos) AS min_avg FROM ClassAvg
     )
SELECT ca.name AS car_name, ca.class AS car_class, ca.avg_pos AS average_position, ca.race_count, cl.country AS car_country,
       ca.race_count AS total_races
FROM CarAvg ca
         JOIN Classes cl ON ca.class = cl.class
WHERE ca.class IN (SELECT class FROM ClassAvg WHERE class_avg_pos = (SELECT min_avg FROM MinClassAvg))
ORDER BY ca.avg_pos, ca.name;