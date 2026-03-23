WITH CarAvg AS (
    SELECT c.name, c.class, AVG(r.position) AS avg_pos, COUNT(r.race) AS race_count
    FROM Cars c
             JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
)
SELECT ca.name AS car_name, ca.class AS car_class, ca.avg_pos AS average_position, ca.race_count
FROM CarAvg ca
WHERE (ca.class, ca.avg_pos) IN (
    SELECT class, MIN(avg_pos) FROM CarAvg GROUP BY class
)
ORDER BY ca.avg_pos, ca.name;