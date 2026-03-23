-- =============================================
-- База данных: Структура организации
-- Решения задач 1-3 (с использованием RECURSIVE)
-- =============================================

-- Задача 1
-- Найти всех сотрудников, подчиняющихся Ивану Иванову (EmployeeID = 1)
-- =============================================

WITH RECURSIVE EmployeeHierarchy AS (
    SELECT
        EmployeeID,
        Name,
        ManagerID,
        DepartmentID,
        RoleID
    FROM Employees
    WHERE EmployeeID = 1

    UNION ALL

    SELECT
        e.EmployeeID,
        e.Name,
        e.ManagerID,
        e.DepartmentID,
        e.RoleID
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
    GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskName SEPARATOR ', ') AS TaskNames
FROM EmployeeHierarchy eh
         LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
         LEFT JOIN Roles r ON eh.RoleID = r.RoleID
         LEFT JOIN Projects p ON eh.DepartmentID = p.DepartmentID
         LEFT JOIN Tasks t ON eh.EmployeeID = t.AssignedTo
GROUP BY eh.EmployeeID, eh.Name, eh.ManagerID, d.DepartmentName, r.RoleName
ORDER BY eh.Name;

-- =============================================
-- Задача 2
-- Добавить количество задач и количество подчиненных
-- =============================================

WITH RECURSIVE EmployeeHierarchy AS (
    SELECT
        EmployeeID,
        Name,
        ManagerID,
        DepartmentID,
        RoleID
    FROM Employees
    WHERE EmployeeID = 1

    UNION ALL

    SELECT
        e.EmployeeID,
        e.Name,
        e.ManagerID,
        e.DepartmentID,
        e.RoleID
    FROM Employees e
             INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
),
               SubordinateCount AS (
                   SELECT
                       ManagerID,
                       COUNT(*) AS total_subordinates
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
    GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ') AS ProjectNames,
    GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskName SEPARATOR ', ') AS TaskNames,
    COUNT(DISTINCT t.TaskID) AS TotalTasks,
    COALESCE(sc.total_subordinates, 0) AS TotalSubordinates
FROM EmployeeHierarchy eh
         LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
         LEFT JOIN Roles r ON eh.RoleID = r.RoleID
         LEFT JOIN Projects p ON eh.DepartmentID = p.DepartmentID
         LEFT JOIN Tasks t ON eh.EmployeeID = t.AssignedTo
         LEFT JOIN SubordinateCount sc ON eh.EmployeeID = sc.ManagerID
GROUP BY eh.EmployeeID, eh.Name, eh.ManagerID, d.DepartmentName, r.RoleName, sc.total_subordinates
ORDER BY eh.Name;

-- =============================================
-- Задача 3
-- Найти менеджеров, имеющих подчиненных (включая подчиненных подчиненных)
-- =============================================

WITH RECURSIVE EmployeeHierarchy AS (
    SELECT
        EmployeeID,
        Name,
        ManagerID,
        DepartmentID,
        RoleID
    FROM Employees

    UNION ALL

    SELECT
        e.EmployeeID,
        e.Name,
        e.ManagerID,
        e.DepartmentID,
        e.RoleID
    FROM Employees e
             INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
),
               AllSubordinates AS (
                   SELECT
                       ManagerID,
                       COUNT(*) AS total_subordinates
                   FROM EmployeeHierarchy
                   WHERE ManagerID IS NOT NULL
                   GROUP BY ManagerID
               )
SELECT
    e.EmployeeID,
    e.Name AS EmployeeName,
    e.ManagerID,
    d.DepartmentName,
    r.RoleName,
    GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ') AS ProjectNames,
    GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskName SEPARATOR ', ') AS TaskNames,
    COALESCE(ast.total_subordinates, 0) AS TotalSubordinates
FROM Employees e
         LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
         LEFT JOIN Roles r ON e.RoleID = r.RoleID
         LEFT JOIN Projects p ON e.DepartmentID = p.DepartmentID
         LEFT JOIN Tasks t ON e.EmployeeID = t.AssignedTo
         LEFT JOIN AllSubordinates ast ON e.EmployeeID = ast.ManagerID
WHERE r.RoleName = 'Менеджер'
  AND COALESCE(ast.total_subordinates, 0) > 0
GROUP BY e.EmployeeID, e.Name, e.ManagerID, d.DepartmentName, r.RoleName, ast.total_subordinates
ORDER BY e.EmployeeID;