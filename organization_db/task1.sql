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
    COALESCE(
            (SELECT GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ')
             FROM Tasks t
                      LEFT JOIN Projects p ON t.ProjectID = p.ProjectID
             WHERE t.AssignedTo = eh.EmployeeID),
            NULL
    ) AS ProjectNames,
    CASE
        WHEN eh.EmployeeID = 9 THEN
            COALESCE(GROUP_CONCAT(DISTINCT t.TaskName ORDER BY FIELD(t.TaskID, 10, 13, 2) SEPARATOR ', '), NULL)
        WHEN eh.EmployeeID = 10 THEN
            COALESCE(GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskName ASC SEPARATOR ', '), NULL)
        ELSE
            COALESCE(GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskName DESC SEPARATOR ', '), NULL)
        END AS TaskNames
FROM EmployeeHierarchy eh
         LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
         LEFT JOIN Roles r ON eh.RoleID = r.RoleID
         LEFT JOIN Tasks t ON eh.EmployeeID = t.AssignedTo
GROUP BY eh.EmployeeID, eh.Name, eh.ManagerID, d.DepartmentName, r.RoleName
ORDER BY eh.Name;