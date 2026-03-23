-- =====================================================
-- ЗАДАЧА 1: Клиенты с более чем двумя бронированиями в разных отелях
-- =====================================================
-- Что нужно найти:
--   Клиенты, у которых > 2 бронирований и бронирования в > 1 отеле
--
-- Логика решения:
--   1. Соединяем таблицы Customer, Booking, Room, Hotel
--   2. Группируем по клиенту
--   3. Применяем HAVING:
--      - COUNT(b.ID_booking) > 2 (более двух бронирований)
--      - COUNT(DISTINCT h.ID_hotel) > 1 (более одного отеля)
--   4. Формируем список отелей через GROUP_CONCAT с сортировкой по имени
--   5. Сортируем по количеству бронирований, затем по имени
-- =====================================================
SELECT
    c.name,
    c.email,
    c.phone,
    COUNT(b.ID_booking) AS total_bookings,
    GROUP_CONCAT(DISTINCT h.name ORDER BY h.name SEPARATOR ', ') AS hotels,
    AVG(DATEDIFF(b.check_out_date, b.check_in_date)) AS avg_stay
FROM Customer c
         JOIN Booking b ON c.ID_customer = b.ID_customer
         JOIN Room r ON b.ID_room = r.ID_room
         JOIN Hotel h ON r.ID_hotel = h.ID_hotel
GROUP BY c.ID_customer
HAVING COUNT(DISTINCT h.ID_hotel) > 1 AND COUNT(b.ID_booking) > 2
ORDER BY total_bookings DESC, c.name;