-- Р—Р°РґР°С‡Р° 3: РљР°С‚РµРіРѕСЂРёР·Р°С†РёСЏ РѕС‚РµР»РµР№ Рё РїСЂРµРґРїРѕС‡С‚РµРЅРёСЏ РєР»РёРµРЅС‚РѕРІ
WITH HotelCategory AS (
    SELECT h.ID_hotel, h.name,
           CASE
               WHEN AVG(r.price) < 175 THEN 'Р”РµС€РµРІС‹Р№'
               WHEN AVG(r.price) BETWEEN 175 AND 300 THEN 'РЎСЂРµРґРЅРёР№'
               ELSE 'Р”РѕСЂРѕРіРѕР№'
               END AS category
    FROM Hotel h
             JOIN Room r ON h.ID_hotel = r.ID_hotel
    GROUP BY h.ID_hotel
),
     CustomerHotels AS (
         SELECT c.ID_customer, c.name, hc.name AS hotel_name, hc.category
         FROM Customer c
                  JOIN Booking b ON c.ID_customer = b.ID_customer
                  JOIN Room r ON b.ID_room = r.ID_room
                  JOIN HotelCategory hc ON r.ID_hotel = hc.ID_hotel
         GROUP BY c.ID_customer, hc.name, hc.category
     ),
     CustomerPreference AS (
         SELECT ID_customer, name,
                CASE
                    WHEN SUM(CASE WHEN category = 'Р”РѕСЂРѕРіРѕР№' THEN 1 ELSE 0 END) > 0 THEN 'Р”РѕСЂРѕРіРѕР№'
                    WHEN SUM(CASE WHEN category = 'РЎСЂРµРґРЅРёР№' THEN 1 ELSE 0 END) > 0 THEN 'РЎСЂРµРґРЅРёР№'
                    ELSE 'Р”РµС€РµРІС‹Р№'
                    END AS preferred_type,
                GROUP_CONCAT(DISTINCT hotel_name ORDER BY hotel_name SEPARATOR ', ') AS visited_hotels
         FROM CustomerHotels
         GROUP BY ID_customer, name
     )
SELECT ID_customer, name, preferred_type, visited_hotels
FROM CustomerPreference
ORDER BY FIELD(preferred_type, 'Р”РµС€РµРІС‹Р№', 'РЎСЂРµРґРЅРёР№', 'Р”РѕСЂРѕРіРѕР№');