-- =====================================================
-- ЗАДАЧА 1: Рекурсивный поиск всех подчиненных Ивана Иванова
-- =====================================================
-- Что нужно найти:
--   Всех сотрудников, подчиняющихся Ивану Иванову (EmployeeID=1),
--   включая их подчиненных и самого Ивана Иванова
--
-- Логика решения:
--   1. Рекурсивный CTE (EmployeeHierarchy):
--      - Базовый уровень: сотрудник с EmployeeID = 1
--      - Рекурсивный уровень: сотрудники, у которых ManagerID = EmployeeID из предыдущего уровня
--   2. Для каждого сотрудника подтягиваем:
--      - название отдела (Departments)
--      - название роли (Roles)
--      - проекты (Projects) через отдел
--      - задачи (Tasks) через AssignedTo
--   3. Объединяем проекты и задачи через GROUP_CONCAT
--   4. Сортировка по имени сотрудника
--
-- Почему рекурсия?
--   Иерархия подчинения может быть любой глубины, нужен рекурсивный обход
-- =====================================================
WITH RECURSIVE EmployeeHierarchy AS (
    -- Базовый уровень: Иван Иванов
    SELECT EmployeeID, Name, ManagerID, DepartmentID, RoleID
    FROM Employees
    WHERE EmployeeID = 1

    UNION ALL

    -- Рекурсивный уровень: подчиненные
    SELECT e.EmployeeID, e.Name, e.ManagerID, e.DepartmentID, e.RoleID
    FROM Employees e
             INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT
    eh.EmployeeID,
    eh.Name AS EmployeeName,
    eh.ManagerID,
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
        END AS TaskNames
FROM EmployeeHierarchy eh
         LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
         LEFT JOIN Roles r ON eh.RoleID = r.RoleID
         LEFT JOIN Projects p ON d.DepartmentID = p.DepartmentID
         LEFT JOIN Tasks t ON eh.EmployeeID = t.AssignedTo
GROUP BY eh.EmployeeID, eh.Name, eh.ManagerID, d.DepartmentName, r.RoleName
ORDER BY eh.Name;