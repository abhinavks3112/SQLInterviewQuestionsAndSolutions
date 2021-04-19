-- SQL query to get organization hierarchy
Create table Employees
(
     EmployeeID int primary key identity,
     EmployeeName nvarchar(50),
     ManagerID int foreign key references Employees(EmployeeID)
)
GO

Insert into Employees values ('John', NULL)
Insert into Employees values ('Mark', NULL)
Insert into Employees values ('Steve', NULL)
Insert into Employees values ('Tom', NULL)
Insert into Employees values ('Lara', NULL)
Insert into Employees values ('Simon', NULL)
Insert into Employees values ('David', NULL)
Insert into Employees values ('Ben', NULL)
Insert into Employees values ('Stacy', NULL)
Insert into Employees values ('Sam', NULL)
GO

Update Employees Set ManagerID = 8 Where EmployeeName IN ('Mark', 'Steve', 'Lara')
Update Employees Set ManagerID = 2 Where EmployeeName IN ('Stacy', 'Simon')
Update Employees Set ManagerID = 3 Where EmployeeName IN ('Tom')
Update Employees Set ManagerID = 5 Where EmployeeName IN ('John', 'Sam')
Update Employees Set ManagerID = 4 Where EmployeeName IN ('David')
GO


SELECT * FROM Employees;

DECLARE @EmployeeID int;
SET @EmployeeID = 7;
--CTE will give employee id, employee name and their managers id result set
WITH EmployeeCTE
AS 
(
    -- Anchor expression
	SELECT EmployeeId, EmployeeName, ManagerID
	FROM Employees
	WHERE EmployeeId = @EmployeeID

	UNION ALL
	-- The evaulated expression serves as result set for next iteration, which further gives some rows till we come to the top just like recursive factorial 
	-- program in c#. It recursively calls itself until it gets to the last expression where Anchor expression has a result but recursive expression has no result
	-- example in case manager id is null, so on join, no row will come up, and union result will be just the row(s) from anchor expression. All result set is made
	-- into a union set.
	SELECT e.EmployeeId, e.EmployeeName, e.ManagerID
	FROM Employees e JOIN EmployeeCTE m
	ON e.EmployeeId = m.ManagerID
)
-- Self join with cte result set to get the manager name from manager id in cte result set
SELECT emp.EmployeeName AS EmployeeName, mgr.EmployeeName AS ManagerName
FROM EmployeeCTE emp
JOIN EmployeeCTE mgr
ON emp.ManagerId = mgr.EmployeeId;
