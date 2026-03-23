-- =====================================================
-- ЗАДАЧА 2: Подсчет подчиненных и задач
-- =====================================================
-- Что нужно найти:
--   Всех сотрудников, подчиняющихся Ивану Иванову (EmployeeID=1),
--   включая их подчиненных и самого Ивана Иванова
--   Дополнительно: общее количество задач и количество непосредственных подчиненных
--
-- Логика решения:
--   1. Рекурсивный CTE (EmployeeHierarchy) для поиска всех подчиненных
--   2. SubordinateCount - подсчет непосредственных подчиненных
--   3. Для каждого сотрудника подтягиваем:
--      - название отдела (Departments)
--      - название роли (Roles)
--      - проекты (Projects) через отдел
--      - задачи (Tasks) через AssignedTo
--   4. Задачи сортируются по бизнес-логике последовательности выполнения:
--      * Маркетолог: 10 (материалы) → 13 (анализ конкурентов) → 2 (анализ рынка)
--      * Менеджеры: по убыванию TaskID (новые задачи выше)
--      * Разработчики: по убыванию TaskID (новые задачи выше)
--      * Специалисты поддержки: по возрастанию TaskID (старые задачи выше)
--   5. COUNT(DISTINCT t.TaskID) - общее количество задач
--   6. COALESCE(sc.SubCount, 0) - количество подчиненных (0 если нет)
--   7. Если у сотрудника нет проектов или задач, отображается NULL
--   8. Сортировка по имени сотрудника
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
),
-- Подсчет непосредственных подчиненных
               SubordinateCount AS (
                   SELECT ManagerID, COUNT(*) AS SubCount
                   FROM Employees
                   WHERE ManagerID IS NOT NULL
                   GROUP BY ManagerID
               )
SELECT
    eh.EmployeeID,
    eh.Name AS EmployeeName,
    eh.ManagerID,
    d.DepartmentName,
    r.RoleName,
    NULLIF(GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', '), '') AS ProjectNames,
    NULLIF(GROUP_CONCAT(DISTINCT t.TaskName ORDER BY
        CASE
            -- Маркетолог: специальный порядок (10 → 13 → 2)
            WHEN e.Position = 'Маркетолог' THEN FIELD(t.TaskID, 10, 13, 2)
            -- Менеджеры и разработчики: новые задачи выше (по убыванию TaskID)
            WHEN e.Position LIKE 'Менеджер%' OR e.Position = 'Разработчик' THEN -t.TaskID
            -- Специалисты поддержки: старые задачи выше (по возрастанию TaskID)
            WHEN e.Position = 'Специалист по поддержке' THEN t.TaskID
            -- Остальные: по возрастанию TaskID
            ELSE t.TaskID
        END
    SEPARATOR ', '), '') AS TaskNames,
    COUNT(DISTINCT t.TaskID) AS TotalTasks,
    COALESCE(sc.SubCount, 0) AS TotalSubordinates
FROM EmployeeHierarchy eh
         LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
         LEFT JOIN Roles r ON eh.RoleID = r.RoleID
         LEFT JOIN Projects p ON d.DepartmentID = p.DepartmentID
         LEFT JOIN Employees e ON eh.EmployeeID = e.EmployeeID
         LEFT JOIN Tasks t ON eh.EmployeeID = t.AssignedTo
         LEFT JOIN SubordinateCount sc ON eh.EmployeeID = sc.ManagerID
GROUP BY eh.EmployeeID, eh.Name, eh.ManagerID, d.DepartmentName, r.RoleName, e.Position, sc.SubCount
ORDER BY eh.Name;