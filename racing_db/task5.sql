WITH CarAvg AS (
    SELECT c.name, c.class, AVG(r.position) AS avg_pos, COUNT(r.race) AS race_count
    FROM Cars c
             JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
     LowPosition AS (
         SELECT class, COUNT(*) AS low_count
         FROM CarAvg
         WHERE avg_pos > 3.0
         GROUP BY class
     ),
     MaxLowCount AS (
         SELECT MAX(low_count) AS max_low FROM LowPosition
     ),
     TargetClasses AS (
         SELECT class FROM LowPosition WHERE low_count = (SELECT max_low FROM MaxLowCount)
     )
SELECT ca.name AS car_name, ca.class AS car_class,
       CASE
           WHEN ca.avg_pos = 2.0 THEN FORMAT(ca.avg_pos, 4)
           WHEN ca.avg_pos = FLOOR(ca.avg_pos) THEN CONCAT(FLOOR(ca.avg_pos), '.0000')
           ELSE FORMAT(ca.avg_pos, 4)
           END AS average_position,
       ca.race_count, cl.country AS car_country,
       (SELECT COUNT(DISTINCT race) FROM Results WHERE car IN (SELECT name FROM Cars WHERE class IN (SELECT class FROM TargetClasses))) AS total_races,
       lp.low_count AS low_position_count
FROM CarAvg ca
         JOIN Classes cl ON ca.class = cl.class
         JOIN LowPosition lp ON ca.class = lp.class
WHERE ca.class IN (SELECT class FROM TargetClasses)
ORDER BY lp.low_count DESC, ca.class, ca.name;