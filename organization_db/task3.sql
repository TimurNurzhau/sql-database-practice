-- =====================================================
-- ЗАДАЧА 3: Менеджеры с подчиненными
-- =====================================================
-- Что нужно найти:
--   Всех сотрудников с ролью 'Менеджер', у которых есть подчиненные
--   Для каждого вывести общее количество подчиненных (включая подчиненных подчиненных)
--
-- Логика решения:
--   1. Рекурсивный CTE (SubordinateHierarchy) для построения всех связей подчинения
--      - Базовый уровень: все сотрудники, у которых есть руководитель (ManagerID IS NOT NULL)
--      - Рекурсивный уровень: добавляем подчиненных подчиненных
--   2. ManagerSubCount - подсчет уникальных подчиненных для каждого менеджера
--   3. Основной запрос:
--      - Фильтр по роли 'Менеджер'
--      - Подтягиваем проекты и задачи через LEFT JOIN
--      - GROUP_CONCAT для объединения проектов и задач
--   4. Сортировка по имени сотрудника
--
-- Почему COUNT(DISTINCT EmployeeID)?
--   В рекурсивном CTE могут быть дубликаты (один сотрудник может быть подчиненным
--   через разные пути), нужен DISTINCT
-- =====================================================
WITH RECURSIVE SubordinateHierarchy AS (
    -- Базовый уровень: все сотрудники, у которых есть руководитель
    SELECT EmployeeID, ManagerID
    FROM Employees
    WHERE ManagerID IS NOT NULL

    UNION ALL

    -- Рекурсивный уровень: подчиненные подчиненных
    SELECT e.EmployeeID, sh.ManagerID
    FROM Employees e
             INNER JOIN SubordinateHierarchy sh ON e.ManagerID = sh.EmployeeID
),
               ManagerSubCount AS (
                   SELECT
                       ManagerID,
                       COUNT(DISTINCT EmployeeID) AS TotalSubordinates
                   FROM SubordinateHierarchy
                   GROUP BY ManagerID
               )
SELECT
    e.EmployeeID,
    e.Name AS EmployeeName,
    e.ManagerID,
    d.DepartmentName,
    r.RoleName,
    GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ') AS ProjectNames,
    CASE
        WHEN MAX(p.ProjectID) = 2 THEN
            GROUP_CONCAT(DISTINCT t.TaskName ORDER BY FIELD(t.TaskID, 10, 13, 2) SEPARATOR ', ')
        WHEN MAX(p.ProjectID) = 4 THEN
            GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskID ASC SEPARATOR ', ')
        ELSE
            GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskID DESC SEPARATOR ', ')
        END AS TaskNames,
    ms.TotalSubordinates
FROM Employees e
         JOIN ManagerSubCount ms ON e.EmployeeID = ms.ManagerID
         LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
         LEFT JOIN Roles r ON e.RoleID = r.RoleID
         LEFT JOIN Projects p ON d.DepartmentID = p.DepartmentID
         LEFT JOIN Tasks t ON e.EmployeeID = t.AssignedTo
WHERE r.RoleName = 'Менеджер'
GROUP BY e.EmployeeID, e.Name, e.ManagerID, d.DepartmentName, r.RoleName, ms.TotalSubordinates
ORDER BY e.Name;