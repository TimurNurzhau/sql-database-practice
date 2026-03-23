WITH RECURSIVE EmployeeHierarchy AS (
    SELECT EmployeeID, Name, ManagerID, DepartmentID, RoleID
    FROM Employees
    WHERE EmployeeID = 1
    UNION ALL
    SELECT e.EmployeeID, e.Name, e.ManagerID, e.DepartmentID, e.RoleID
    FROM Employees e
             INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT eh.EmployeeID, eh.Name AS EmployeeName, eh.ManagerID,
       d.DepartmentName, r.RoleName,
       GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ') AS ProjectNames,
       GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskID SEPARATOR ', ') AS TaskNames
FROM EmployeeHierarchy eh
         LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
         LEFT JOIN Roles r ON eh.RoleID = r.RoleID
         LEFT JOIN Projects p ON d.DepartmentID = p.DepartmentID
         LEFT JOIN Tasks t ON eh.EmployeeID = t.AssignedTo
GROUP BY eh.EmployeeID, eh.Name, eh.ManagerID, d.DepartmentName, r.RoleName
ORDER BY eh.Name;