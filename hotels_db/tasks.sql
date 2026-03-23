-- =============================================
-- База данных: Бронирование отелей
-- Решения задач 1-3
-- =============================================

-- Задача 1
-- Определить клиентов с более чем двумя бронированиями в разных отелях
-- =============================================

WITH CustomerBookings AS (
    SELECT
        c.ID_customer,
        c.name,
        c.email,
        c.phone,
        COUNT(b.ID_booking) AS total_bookings,
        COUNT(DISTINCT h.ID_hotel) AS unique_hotels,
        AVG(DATEDIFF(b.check_out_date, b.check_in_date)) AS avg_stay_duration,
        GROUP_CONCAT(DISTINCT h.name ORDER BY h.name SEPARATOR ', ') AS hotels_list
    FROM Customer c
             JOIN Booking b ON c.ID_customer = b.ID_customer
             JOIN Room r ON b.ID_room = r.ID_room
             JOIN Hotel h ON r.ID_hotel = h.ID_hotel
    GROUP BY c.ID_customer, c.name, c.email, c.phone
    HAVING total_bookings > 2 AND unique_hotels > 1
)
SELECT
    name,
    email,
    phone,
    total_bookings,
    hotels_list,
    ROUND(avg_stay_duration, 4) AS avg_stay_duration
FROM CustomerBookings
ORDER BY total_bookings DESC;

-- =============================================
-- Задача 2
-- Определить клиентов с >2 бронированиями в разных отелях и потративших >500
-- =============================================

SELECT
    c.ID_customer,
    c.name,
    COUNT(b.ID_booking) AS total_bookings,
    SUM(r.price) AS total_spent,
    COUNT(DISTINCT h.ID_hotel) AS unique_hotels
FROM Customer c
         JOIN Booking b ON c.ID_customer = b.ID_customer
         JOIN Room r ON b.ID_room = r.ID_room
         JOIN Hotel h ON r.ID_hotel = h.ID_hotel
GROUP BY c.ID_customer, c.name
HAVING total_bookings > 2
   AND unique_hotels > 1
   AND total_spent > 500
ORDER BY total_spent ASC;

-- =============================================
-- Задача 3
-- Категоризация отелей и определение предпочтений клиентов
-- =============================================

WITH HotelCategory AS (
    SELECT
        h.ID_hotel,
        h.name AS hotel_name,
        AVG(r.price) AS avg_price,
        CASE
            WHEN AVG(r.price) < 175 THEN 'Дешевый'
            WHEN AVG(r.price) BETWEEN 175 AND 300 THEN 'Средний'
            ELSE 'Дорогой'
            END AS category
    FROM Hotel h
             JOIN Room r ON h.ID_hotel = r.ID_hotel
    GROUP BY h.ID_hotel, h.name
),
     CustomerHotels AS (
         SELECT
             c.ID_customer,
             c.name,
             GROUP_CONCAT(DISTINCT hc.hotel_name ORDER BY hc.hotel_name SEPARATOR ', ') AS visited_hotels,
             MAX(CASE WHEN hc.category = 'Дорогой' THEN 1 ELSE 0 END) AS has_expensive,
             MAX(CASE WHEN hc.category = 'Средний' THEN 1 ELSE 0 END) AS has_medium
         FROM Customer c
                  JOIN Booking b ON c.ID_customer = b.ID_customer
                  JOIN Room r ON b.ID_room = r.ID_room
                  JOIN HotelCategory hc ON r.ID_hotel = hc.ID_hotel
         GROUP BY c.ID_customer, c.name
     )
SELECT
    ID_customer,
    name,
    CASE
        WHEN has_expensive = 1 THEN 'Дорогой'
        WHEN has_medium = 1 THEN 'Средний'
        ELSE 'Дешевый'
        END AS preferred_hotel_type,
    visited_hotels
FROM CustomerHotels
ORDER BY
    CASE preferred_hotel_type
        WHEN 'Дешевый' THEN 1
        WHEN 'Средний' THEN 2
        WHEN 'Дорогой' THEN 3
        END;