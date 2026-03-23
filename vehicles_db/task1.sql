-- =====================================================
-- ЗАДАЧА 1: Найти производителей и модели мотоциклов
-- =====================================================
-- Условия:
--   - мощность двигателя > 150 лошадиных сил
--   - цена < 20000 долларов
--   - тип мотоцикла = 'Sport'
--
-- Логика решения:
--   1. Соединяем таблицы Vehicle и Motorcycle по модели (Vehicle.model = Motorcycle.model)
--   2. Применяем фильтры по мощности, цене и типу
--   3. Сортируем результаты по убыванию мощности
--
-- Почему явно указываем таблицы Vehicle.maker и Motorcycle.model?
--   Потому что поле model есть в обеих таблицах, без явного указания MySQL выдаст ошибку
--   "Column 'model' in field list is ambiguous"
-- =====================================================
SELECT Vehicle.maker, Motorcycle.model
FROM Vehicle
         JOIN Motorcycle ON Vehicle.model = Motorcycle.model
WHERE Motorcycle.horsepower > 150
  AND Motorcycle.price < 20000
  AND Motorcycle.type = 'Sport'
ORDER BY Motorcycle.horsepower DESC;