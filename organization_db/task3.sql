-- =====================================================
-- ЗАДАЧА 3: Менеджеры с подчиненными
-- =====================================================
-- Что нужно найти:
--   Всех сотрудников, которые занимают роль менеджера и имеют подчиненных
--   (то есть число подчиненных больше 0)
--
-- Логика решения:
--   1. Рекурсивный CTE (SubordinateHierarchy) для поиска всех подчиненных
--      на всех уровнях (включая подчиненных подчиненных)
--   2. ManagerSubCount - подсчет всех подчиненных для каждого менеджера
--   3. Для каждого менеджера подтягиваем:
--      - название отдела (Departments)
--      - название роли (Roles)
--      - проекты (Projects) через отдел
--      - задачи (Tasks) через AssignedTo
--   4. Задачи сортируются по бизнес-логике:
--      * Менеджеры: по убыванию TaskID (новые задачи выше)
--   5. Фильтр: только сотрудники с ролью 'Менеджер' и количеством подчиненных > 0
--   6. Если у сотрудника нет проектов или задач, отображается NULL
--   7. Сортировка по имени сотрудника
--
-- Почему рекурсия?
--   Нужно найти всех подчиненных на всех уровнях, включая подчиненных подчиненных
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
-- Подсчет всех подчиненных для каждого менеджера
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
    NULLIF(GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', '), '') AS ProjectNames,
    NULLIF(GROUP_CONCAT(DISTINCT t.TaskName ORDER BY
        CASE
            -- Менеджеры: новые задачи выше (по убыванию TaskID)
            WHEN e.Position LIKE 'Менеджер%' THEN -t.TaskID
            -- Остальные: по возрастанию TaskID
            ELSE t.TaskID
        END
    SEPARATOR ', '), '') AS TaskNames,
    ms.TotalSubordinates
FROM Employees e
         INNER JOIN ManagerSubCount ms ON e.EmployeeID = ms.ManagerID
         LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
         LEFT JOIN Roles r ON e.RoleID = r.RoleID
         LEFT JOIN Projects p ON d.DepartmentID = p.DepartmentID
         LEFT JOIN Tasks t ON e.EmployeeID = t.AssignedTo
WHERE r.RoleName = 'Менеджер'
  AND ms.TotalSubordinates > 0
GROUP BY e.EmployeeID, e.Name, e.ManagerID, d.DepartmentName, r.RoleName, ms.TotalSubordinates
ORDER BY e.Name;