-- Р—Р°РґР°С‡Р° 2: РђРІС‚РѕРјРѕР±РёР»СЊ СЃ РЅР°РёРјРµРЅСЊС€РµР№ СЃСЂРµРґРЅРµР№ РїРѕР·РёС†РёРµР№ СЃСЂРµРґРё РІСЃРµС…
WITH CarAvg AS (
    SELECT c.name, c.class, AVG(r.position) AS avg_pos, COUNT(r.race) AS race_count
    FROM Cars c
             JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
)
SELECT ca.name AS car_name, ca.class AS car_class, ca.avg_pos AS average_position, ca.race_count, cl.country AS car_country
FROM CarAvg ca
         JOIN Classes cl ON ca.class = cl.class
ORDER BY ca.avg_pos, ca.name
    LIMIT 1;