-- Р—Р°РґР°С‡Р° 1: РќР°Р№С‚Рё РїСЂРѕРёР·РІРѕРґРёС‚РµР»РµР№ Рё РјРѕРґРµР»Рё РјРѕС‚РѕС†РёРєР»РѕРІ СЃ РјРѕС‰РЅРѕСЃС‚СЊСЋ Р±РѕР»РµРµ 150 Р».СЃ., С†РµРЅРѕР№ РјРµРЅРµРµ 20000, С‚РёРї Sport
SELECT Vehicle.maker, Motorcycle.model
FROM Vehicle
         JOIN Motorcycle ON Vehicle.model = Motorcycle.model
WHERE horsepower > 150 AND price < 20000 AND Motorcycle.type = 'Sport'
ORDER BY horsepower DESC;