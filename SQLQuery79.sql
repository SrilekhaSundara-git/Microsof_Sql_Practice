USE AdventureWorks2012
GO;
SELECT * FROM HumanResources.Employee;
SELECT COUNT(*) FROM HumanResources.Employee;

SELECT MAX(LEN(JobTitle)) FROM HumanResources.Employee;

SELECT * 
FROM HumanResources.Employee 
WHERE LEN(JobTitle)>=40;

SELECT TOP 3 * FROM SALES.SalesPerson
WHERE Bonus BETWEEN 4000 AND 6000;

SELECT BusinessEntityID AS 'Employee Id'
,upper(JobTitle) AS [DESIGNATION]
,DATEDIFF(YY,BirthDate,GETDATE()) AS 'AGE OF THE EMPLOYEE'
FROM HumanResources.Employee
WHERE JobTitle = 'Marketing Manager' or JobTitle='Marketing Specialist' ;

USE AdventureWorks2012

GO

SELECT t.name AS table_name, SCHEMA_NAME(schema_id) AS schema_name,
 c.name AS column_name
FROM sys.tables AS t
INNER JOIN sys.columns c ON t.OBJECT_ID = c.OBJECT_ID
WHERE c.name LIKE '%ORDER%'
ORDER BY schema_name, table_name; 

exec sp_columns SalesOrderHeader;
--33
select min(SubTotal) as 'Minimum amount'
,max(SubTotal) [Max amount]
,SalesOrderID from Sales.SalesOrderHeader
where SubTotal>5000
group by SalesOrderID;
--34
select SalesOrderID,
avg(SubTotal) [Average of Amount] 
from Sales.SalesOrderHeader
group by SalesOrderID
having avg(SubTotal)>5000;


--substring(StudentCode,4,len(StudentCode))
--SELECT t.name AS table_name, SCHEMA_NAME(schema_id) AS schema_name,
 
SELECT t.name AS table_name, SCHEMA_NAME(schema_id) AS schema_name,
 c.name AS column_name
FROM sys.tables AS t
INNER JOIN sys.columns c ON t.OBJECT_ID = c.OBJECT_ID
WHERE c.name LIKE '%unit%'
ORDER BY schema_name, table_name; 



exec sp_columns SalesOrderDetail;

select SalesOrderID,
OrderQty,UnitPrice from Sales.SalesOrderDetail;


