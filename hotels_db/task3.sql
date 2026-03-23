-- =====================================================
-- ЗАДАЧА 3: Категоризация отелей и предпочтения клиентов
-- =====================================================
-- Что нужно сделать:
--   1. Категоризировать отели по средней стоимости номера:
--      - Дешевый: < 175
--      - Средний: 175-300
--      - Дорогой: > 300
--   2. Определить предпочтения клиентов:
--      - Если есть Дорогой -> Дорогой
--      - Иначе если есть Средний -> Средний
--      - Иначе -> Дешевый
--   3. Вывести список отелей, которые посетил клиент
--
-- Логика решения:
--   1. HotelCategory - категория каждого отеля
--   2. CustomerHotels - список отелей с категориями для каждого клиента
--   3. CustomerPreference - определение предпочтения по приоритету (Дорогой > Средний > Дешевый)
--   4. Сортировка: сначала Дешевый, потом Средний, потом Дорогой
-- =====================================================
WITH HotelCategory AS (
    SELECT
        h.ID_hotel,
        h.name,
        CASE
            WHEN AVG(r.price) < 175 THEN 'Дешевый'
            WHEN AVG(r.price) BETWEEN 175 AND 300 THEN 'Средний'
            ELSE 'Дорогой'
            END AS category
    FROM Hotel h
             JOIN Room r ON h.ID_hotel = r.ID_hotel
    GROUP BY h.ID_hotel
),
     CustomerHotels AS (
         SELECT
             c.ID_customer,
             c.name,
             hc.name AS hotel_name,
             hc.category
         FROM Customer c
                  JOIN Booking b ON c.ID_customer = b.ID_customer
                  JOIN Room r ON b.ID_room = r.ID_room
                  JOIN HotelCategory hc ON r.ID_hotel = hc.ID_hotel
         GROUP BY c.ID_customer, hc.name, hc.category
     ),
     CustomerPreference AS (
         SELECT
             ID_customer,
             name,
             CASE
                 WHEN SUM(CASE WHEN category = 'Дорогой' THEN 1 ELSE 0 END) > 0 THEN 'Дорогой'
                 WHEN SUM(CASE WHEN category = 'Средний' THEN 1 ELSE 0 END) > 0 THEN 'Средний'
                 ELSE 'Дешевый'
                 END AS preferred_type,
             GROUP_CONCAT(DISTINCT hotel_name ORDER BY hotel_name SEPARATOR ',') AS visited_hotels
         FROM CustomerHotels
         GROUP BY ID_customer, name
     )
SELECT
    ID_customer,
    name,
    preferred_type,
    visited_hotels
FROM CustomerPreference
ORDER BY FIELD(preferred_type, 'Дешевый', 'Средний', 'Дорогой'), ID_customer;

-- =====================================================
-- ПРИМЕЧАНИЕ ПО СОРТИРОВКЕ
-- =====================================================
-- Функция FIELD() используется для сортировки клиентов
-- в порядке: Дешевый → Средний → Дорогой.
-- Это соответствует бизнес-логике задания и ожидаемому выводу.
-- Без FIELD() сортировка по алфавиту дала бы другой порядок:
-- Дешевый → Дорогой → Средний.