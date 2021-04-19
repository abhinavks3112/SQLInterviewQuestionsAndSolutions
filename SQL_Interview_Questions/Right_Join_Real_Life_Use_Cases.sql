-- Right Join Real Life Example Business Cases
Create Table Departments
(
     DepartmentID int primary key,
     DepartmentName nvarchar(50)
)
GO

Create Table Employees
(
     EmployeeID int primary key,
     EmployeeName nvarchar(50),
     DepartmentID int foreign key references Departments(DepartmentID)
)
GO

Insert into Departments values (1, 'IT')
Insert into Departments values (2, 'HR')
Insert into Departments values (3, 'Payroll')
Insert into Departments values (4, 'Admin')
GO

Insert into Employees values (1, 'Mark', 1)
Insert into Employees values (2, 'John', 1)
Insert into Employees values (3, 'Mike', 1)
Insert into Employees values (4, 'Mary', 2)
Insert into Employees values (5, 'Stacy', 2)
GO

-- All Department Name with/without employee name
SELECT d.DepartmentName, e.EmployeeName
FROM Employees e
RIGHT JOIN Departments d
ON e.DepartmentID = d.DepartmentID;

-- All Department Employee Count
SELECT d.DepartmentName, ISNULL(EmpCount.TotalEmployee, 0)
FROM
(SELECT e.DepartmentID, COUNT(e.DepartmentID) AS TotalEmployee
FROM Employees e
GROUP BY e.DepartmentID) EmpCount
RIGHT JOIN Departments d
ON EmpCount.DepartmentID = d.DepartmentID;