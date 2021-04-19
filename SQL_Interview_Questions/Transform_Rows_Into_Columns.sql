-- Transform rows into columns in sql server
Create Table Countries
(
 Country nvarchar(50),
 City nvarchar(50)
)
GO

Insert into Countries values ('USA','New York')
Insert into Countries values ('USA','Houston')
Insert into Countries values ('USA','Dallas')

Insert into Countries values ('India','Hyderabad')
Insert into Countries values ('India','Bangalore')
Insert into Countries values ('India','New Delhi')

Insert into Countries values ('UK','London')
Insert into Countries values ('UK','Birmingham')
Insert into Countries values ('UK','Manchester')

SELECT * FROM Countries;

-- Convert rows to column using pivot
SELECT Country, City1, City2, City3
FROM
(
	SELECT Country, City, 'City' + CAST(ROW_NUMBER() OVER (PARTITION BY Country ORDER BY Country) AS varchar(10)) ColumnSequence
	FROM Countries
) Temp
PIVOT
(
	MAX(City)
	For ColumnSequence IN (City1, City2, City3)
) Piv


Create Table tblProductSales
(
 SalesAgent nvarchar(50),
 SalesCountry nvarchar(50),
 SalesAmount int
);

Insert into tblProductSales values('Tom', 'UK', 200)
Insert into tblProductSales values('John', 'US', 180)
Insert into tblProductSales values('John', 'UK', 260)
Insert into tblProductSales values('David', 'India', 450)
Insert into tblProductSales values('Tom', 'India', 350)
Insert into tblProductSales values('David', 'US', 200)
Insert into tblProductSales values('Tom', 'US', 130)
Insert into tblProductSales values('John', 'India', 540)
Insert into tblProductSales values('John', 'UK', 120)
Insert into tblProductSales values('David', 'UK', 220)
Insert into tblProductSales values('John', 'UK', 420)
Insert into tblProductSales values('David', 'US', 320)
Insert into tblProductSales values('Tom', 'US', 340)
Insert into tblProductSales values('Tom', 'UK', 660)
Insert into tblProductSales values('John', 'India', 430)
Insert into tblProductSales values('David', 'India', 230)
Insert into tblProductSales values('David', 'India', 280)
Insert into tblProductSales values('Tom', 'UK', 480)
Insert into tblProductSales values('John', 'US', 360)
Insert into tblProductSales values('David', 'UK', 140)

Select * from tblProductSales

SELECT SalesAgent, India, UK, US
FROM tblProductSales
Pivot
(
	Sum(SalesAmount)
	For SalesCountry in ([India], [UK], [US])
)Piv
