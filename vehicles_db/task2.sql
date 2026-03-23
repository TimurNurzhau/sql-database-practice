-- Р—Р°РґР°С‡Р° 2: РћР±СЉРµРґРёРЅРёС‚СЊ РґР°РЅРЅС‹Рµ РїРѕ Р°РІС‚РѕРјРѕР±РёР»СЏРј, РјРѕС‚РѕС†РёРєР»Р°Рј Рё РІРµР»РѕСЃРёРїРµРґР°Рј СЃ РєСЂРёС‚РµСЂРёСЏРјРё
SELECT maker, model, horsepower, engine_capacity, 'Car' AS vehicle_type
FROM Vehicle JOIN Car ON Vehicle.model = Car.model
WHERE horsepower > 150 AND engine_capacity < 3 AND price < 35000
UNION
SELECT maker, model, horsepower, engine_capacity, 'Motorcycle' AS vehicle_type
FROM Vehicle JOIN Motorcycle ON Vehicle.model = Motorcycle.model
WHERE horsepower > 150 AND engine_capacity < 1.5 AND price < 20000
UNION
SELECT maker, model, NULL AS horsepower, NULL AS engine_capacity, 'Bicycle' AS vehicle_type
FROM Vehicle JOIN Bicycle ON Vehicle.model = Bicycle.model
WHERE gear_count > 18 AND price < 4000
ORDER BY horsepower DESC;