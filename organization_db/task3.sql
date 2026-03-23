WITH RECURSIVE SubordinateHierarchy AS (
    SELECT EmployeeID, ManagerID
    FROM Employees
    WHERE ManagerID IS NOT NULL
    UNION ALL
    SELECT e.EmployeeID, sh.ManagerID
    FROM Employees e
             INNER JOIN SubordinateHierarchy sh ON e.ManagerID = sh.EmployeeID
),
               ManagerSubCount AS (
                   SELECT ManagerID, COUNT(DISTINCT EmployeeID) AS TotalSubordinates
                   FROM SubordinateHierarchy
                   GROUP BY ManagerID
               )
SELECT e.EmployeeID, e.Name AS EmployeeName, e.ManagerID,
       d.DepartmentName, r.RoleName,
       GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ') AS ProjectNames,
       GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskID SEPARATOR ', ') AS TaskNames,
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