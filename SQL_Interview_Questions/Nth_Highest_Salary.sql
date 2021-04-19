-- How to find nth highest salary in sql

Create table Employees
(
     ID int primary key identity,
     FirstName nvarchar(50),
     LastName nvarchar(50),
     Gender nvarchar(50),
     Salary int
)
GO

Insert into Employees values ('Ben', 'Hoskins', 'Male', 70000)
Insert into Employees values ('Mark', 'Hastings', 'Male', 60000)
Insert into Employees values ('Steve', 'Pound', 'Male', 45000)
Insert into Employees values ('Ben', 'Hoskins', 'Male', 70000)
Insert into Employees values ('Philip', 'Hastings', 'Male', 45000)
Insert into Employees values ('Mary', 'Lambeth', 'Female', 30000)
Insert into Employees values ('Valarie', 'Vikings', 'Female', 35000)
Insert into Employees values ('John', 'Stanmore', 'Male', 80000)
GO

--Highest Salary
SELECT MAX(Salary) FROM Employees;

--Second highest
SELECT TOP 1 Salary FROM
(SELECT TOP 2 Salary FROM Employees
ORDER BY Salary DESC) Two_Highest_Salary
ORDER BY Two_Highest_Salary.Salary ASC

--Third Highest
SELECT TOP 1 Salary FROM
(SELECT DISTINCT TOP 3 (Salary) FROM Employees
ORDER BY Salary DESC) Three_Highest_Salary
ORDER BY Three_Highest_Salary.Salary ASC

--nth Highest
--SELECT TOP 1 Salary FROM
--(SELECT DISTINCT TOP n (Salary) FROM Employees
--ORDER BY Salary DESC) Nth_Highest_Salary
--ORDER BY Nth_Highest_Salary.Salary ASC

--With CTE
WITH SALARY_RANKING
AS 
(
-- DENSE_RANK gives ranking over a result set based on value, same value gets same ranking
SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS DENSERANK FROM Employees
)
SELECT TOP 1 SALARY FROM SALARY_RANKING 
WHERE SALARY_RANKING.DENSERANK = 2 -- or Nth Number


