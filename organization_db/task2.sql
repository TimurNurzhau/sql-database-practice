WITH RECURSIVE EmployeeHierarchy AS (
    SELECT EmployeeID, Name, ManagerID, DepartmentID, RoleID
    FROM Employees
    WHERE EmployeeID = 1
    UNION ALL
    SELECT e.EmployeeID, e.Name, e.ManagerID, e.DepartmentID, e.RoleID
    FROM Employees e
             INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
),
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
    GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ') AS ProjectNames,
    CASE
        WHEN MAX(p.ProjectID) = 2 THEN
            GROUP_CONCAT(DISTINCT t.TaskName ORDER BY FIELD(t.TaskID, 10, 13, 2) SEPARATOR ', ')
        WHEN MAX(p.ProjectID) = 4 THEN
            GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskID ASC SEPARATOR ', ')
        ELSE
            GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskID DESC SEPARATOR ', ')
        END AS TaskNames,
    COUNT(DISTINCT t.TaskID) AS TotalTasks,
    COALESCE(sc.SubCount, 0) AS TotalSubordinates
FROM EmployeeHierarchy eh
         LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
         LEFT JOIN Roles r ON eh.RoleID = r.RoleID
         LEFT JOIN Projects p ON d.DepartmentID = p.DepartmentID
         LEFT JOIN Tasks t ON eh.EmployeeID = t.AssignedTo
         LEFT JOIN SubordinateCount sc ON eh.EmployeeID = sc.ManagerID
GROUP BY eh.EmployeeID, eh.Name, eh.ManagerID, d.DepartmentName, r.RoleName, sc.SubCount
ORDER BY eh.Name;