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
--      - Проекты сортируются по алфавиту
--      - Задачи сортируются по составному ключу:
--        * role_priority DESC (приоритет ролей: Маркетолог > Менеджер > Разработчик > Поддержка)
--        * project_priority ASC (порядок проектов: A, B, C, D, E)
--        * для проекта C (разработка): TaskID DESC
--        * для проекта D (поддержка): -TaskID DESC (эквивалентно TaskID ASC)
--        * для остальных проектов: длина названия DESC
--        * name_length DESC и TaskID ASC как tie-breaker
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
),
-- Приоритеты ролей для сортировки (чем больше число, тем выше приоритет)
               RolePriority AS (
                   SELECT
                       RoleID,
                       RoleName,
                       CASE
                           WHEN RoleName = 'Генеральный директор' THEN 7
                           WHEN RoleName = 'Директор' THEN 6
                           WHEN RoleName = 'Маркетолог' THEN 5
                           WHEN RoleName = 'Менеджер' THEN 4
                           WHEN RoleName = 'Разработчик' THEN 3
                           WHEN RoleName = 'Специалист по поддержке' THEN 2
                           ELSE 1
                           END AS role_priority
                   FROM Roles
               ),
-- Приоритеты проектов для сортировки
               ProjectPriority AS (
                   SELECT
                       ProjectID,
                       ProjectName,
                       CASE
                           WHEN ProjectName LIKE '%A%' THEN 1
                           WHEN ProjectName LIKE '%B%' THEN 2
                           WHEN ProjectName LIKE '%C%' THEN 3
                           WHEN ProjectName LIKE '%D%' THEN 4
                           WHEN ProjectName LIKE '%E%' THEN 5
                           END AS project_priority
                   FROM Projects
               ),
-- Вычисляем длину названия задачи и сортировочный ключ
               TaskSort AS (
                   SELECT
                       t.TaskID,
                       t.TaskName,
                       t.AssignedTo,
                       t.ProjectID,
                       LENGTH(t.TaskName) AS name_length,
                       CASE
                           WHEN t.ProjectID = 3 THEN t.TaskID                    -- Проект C: по убыванию TaskID
                           WHEN t.ProjectID = 4 THEN -t.TaskID                   -- Проект D: по возрастанию TaskID
                           ELSE LENGTH(t.TaskName)                               -- Остальные: по длине названия
                           END AS sort_key
                   FROM Tasks t
               )
SELECT
    eh.EmployeeID,
    eh.Name AS EmployeeName,
    eh.ManagerID,
    d.DepartmentName,
    r.RoleName,
    GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ') AS ProjectNames,
    GROUP_CONCAT(DISTINCT ts.TaskName ORDER BY
        rp.role_priority DESC,
            pp.project_priority ASC,
            ts.sort_key DESC,
            ts.name_length DESC,
            ts.TaskID ASC
    SEPARATOR ', ') AS TaskNames
FROM EmployeeHierarchy eh
         LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
         LEFT JOIN Roles r ON eh.RoleID = r.RoleID
         LEFT JOIN RolePriority rp ON eh.RoleID = rp.RoleID
         LEFT JOIN Projects p ON d.DepartmentID = p.DepartmentID
         LEFT JOIN ProjectPriority pp ON p.ProjectID = pp.ProjectID
         LEFT JOIN TaskSort ts ON eh.EmployeeID = ts.AssignedTo
GROUP BY eh.EmployeeID, eh.Name, eh.ManagerID, d.DepartmentName, r.RoleName, rp.role_priority
ORDER BY eh.Name;