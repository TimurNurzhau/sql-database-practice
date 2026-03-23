-- Р—Р°РґР°С‡Р° 3: РљР»Р°СЃСЃС‹ СЃ РЅР°РёРјРµРЅСЊС€РµР№ СЃСЂРµРґРЅРµР№ РїРѕР·РёС†РёРµР№
WITH ClassAvg AS (
    SELECT c.class, AVG(r.position) AS class_avg_pos
    FROM Cars c
             JOIN Results r ON c.name = r.car
    GROUP BY c.class
),
     MinClassAvg AS (
         SELECT MIN(class_avg_pos) AS min_avg FROM ClassAvg
     )
SELECT ca.name AS car_name, ca.class AS car_class, ca.avg_pos AS average_position, ca.race_count, cl.country AS car_country, total_races.total
FROM (
         SELECT c.name, c.class, AVG(r.position) AS avg_pos, COUNT(r.race) AS race_count
         FROM Cars c
                  JOIN Results r ON c.name = r.car
         GROUP BY c.name, c.class
     ) ca
         JOIN Classes cl ON ca.class = cl.class
         JOIN ClassAvg ca2 ON ca.class = ca2.class
         CROSS JOIN (
    SELECT COUNT(DISTINCT race) AS total FROM Results
) total_races
WHERE ca2.class_avg_pos = (SELECT min_avg FROM MinClassAvg)
ORDER BY ca.avg_pos;