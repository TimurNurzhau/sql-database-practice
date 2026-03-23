WITH ClassAvg AS (
    SELECT c.class, AVG(r.position) AS class_avg_pos
    FROM Cars c
             JOIN Results r ON c.name = r.car
    GROUP BY c.class
),
     MinClassAvg AS (
         SELECT MIN(class_avg_pos) AS min_avg FROM ClassAvg
     ),
     TargetClasses AS (
         SELECT class FROM ClassAvg WHERE class_avg_pos = (SELECT min_avg FROM MinClassAvg)
     )
SELECT ca.name AS car_name, ca.class AS car_class, ca.avg_pos AS average_position, ca.race_count, cl.country AS car_country,
       (SELECT COUNT(DISTINCT race) FROM Results WHERE car IN (SELECT name FROM Cars WHERE class IN (SELECT class FROM TargetClasses))) AS total_races
FROM (
         SELECT c.name, c.class, AVG(r.position) AS avg_pos, COUNT(r.race) AS race_count
         FROM Cars c
                  JOIN Results r ON c.name = r.car
         GROUP BY c.name, c.class
     ) ca
         JOIN Classes cl ON ca.class = cl.class
WHERE ca.class IN (SELECT class FROM TargetClasses)
ORDER BY ca.avg_pos, ca.name;