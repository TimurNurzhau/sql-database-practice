-- =====================================================
-- ЗАДАЧА 2: Клиенты, соответствующие обоим условиям
-- =====================================================
-- Условия:
--   1. > 2 бронирований и > 1 отеля
--   2. Сумма потраченных средств > 500
--
-- Логика решения:
--   Объединяем оба условия в HAVING:
--     - COUNT(b.ID_booking) > 2
--     - COUNT(DISTINCT h.ID_hotel) > 1
--     - SUM(r.price) > 500
--
-- Почему SUM(r.price), а не SUM(r.price * DATEDIFF(...))?
--   В задании сумма считается по ценам комнат, без учета количества ночей
--   Проверка: Bob Brown: 120 + 350 + 350 = 820 (соответствует ожидаемому выводу)
-- =====================================================
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
GROUP BY c.ID_customer
HAVING COUNT(b.ID_booking) > 2
   AND COUNT(DISTINCT h.ID_hotel) > 1
   AND SUM(r.price) > 500
ORDER BY total_spent;