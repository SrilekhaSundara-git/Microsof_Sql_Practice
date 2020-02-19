SELECT * FROM humanresources.EmployeePayHistory


select * 
from HumanResources.EmployeePayHistory 
order by rate asc;

create index In_Rate_Emp_Pay_History
on HumanResources.EmployeePayHistory(rate asc)

sp_Helpindex [HumanResources.EmployeePayHistory] 

--1. Create a temp table called #CustomerInfo that contains CustomerID, FirstName,
-- and LastName columns. Include CountOfSales and SumOfTotalDue columns. Populate the table with a query using the Sales.Customer, 
--Person.Person, and Sales.SalesOrderHeader tables. 
drop table #CustomerInfo

select * from Sales.SalesOrderHeader

select * from  Sales.Customer
CREATE TABLE #CustomerInfo(CustomerID INT, [Name] VARCHAR(60),SumOfTotalDue MONEY,CountOfSales INT); 
GO 
INSERT INTO #CustomerInfo(CustomerID,[Name],CountOfSales,SumOfTotalDue)
select distinct h.customerid,concat(p.FirstName,' ',p.MiddleName,' ',p.LastName) as [Name],
sum(h.TotalDue) as [SumOfTotal Due],count(*) as [CountOfSales]
from Person.Person p
inner join sales.customer c
on p.BusinessEntityID=c.CustomerID
inner join Sales.SalesOrderHeader h
on c.CustomerID=h.CustomerID
group by h.customerid,concat(p.FirstName,' ',p.MiddleName,' ',p.LastName)
--order by h.CustomerID asc

/*SELECT C.CustomerID, FirstName, LastName,COUNT(*),
SUM(TotalDue) FROM Sales.Customer AS C INNER JOIN Person.Person AS P ON C.CustomerID = P.BusinessEntityID 
INNER JOIN Sales.SalesOrderHeader AS SOH ON C.CustomerID = SOH.CustomerID GROUP BY C.CustomerID, FirstName, LastName ;*/


select * from #CustomerInfo


create function fun_Val(@due money)
returns @table table
(CustomerID INT not null, 
[Name] VARCHAR(60),
SumOfTotalDue MONEY,
CountOfSales INT)
with schemabinding
as
begin
insert @table
select distinct h.customerid,concat(p.FirstName,' ',p.MiddleName,' ',p.LastName) as [Name],
sum(h.TotalDue) as [SumOfTotal Due],count(*) as [CountOfSales]
from Person.Person p
inner join sales.customer c
on p.BusinessEntityID=c.CustomerID
inner join Sales.SalesOrderHeader h
on c.CustomerID=h.CustomerID
where TotalDue>@due
group by h.customerid,concat(p.FirstName,' ',p.MiddleName,' ',p.LastName)
having sum(TotalDue)>@due
return
end

select distinct h.customerid,concat(p.FirstName,' ',p.MiddleName,' ',p.LastName) as [Name],
sum(h.TotalDue) as [SumOfTotal Due],count(*) as [CountOfSales]
from Person.Person p
inner join sales.customer c
on p.BusinessEntityID=c.CustomerID
inner join Sales.SalesOrderHeader h
on c.CustomerID=h.CustomerID
where TotalDue<>0
group by h.customerid,concat(p.FirstName,' ',p.MiddleName,' ',p.LastName)
having sum(TotalDue)>1000

select * from sales.SalesOrderHeader

select * from dbo.fun_Val(2000)
--Change the code written in creating temporary table  to use a table variable instead of a  temp table. 
DECLARE @CustomerInfo TABLE 
(CustomerID INT, FirstName VARCHAR(50),LastName VARCHAR(50),CountOfSales INT,SumOfTotalDue MONEY)
INSERT INTO @CustomerInfo(CustomerID,FirstName,LastName,CountOfSales, SumOfTotalDue) 
SELECT C.CustomerID, FirstName, LastName,COUNT(*),SUM(TotalDue) 
FROM Sales.Customer AS C 
INNER JOIN Person.Person AS P 
ON C.CustomerID = P.BusinessEntityID 
INNER JOIN Sales.SalesOrderHeader AS SOH
ON C.CustomerID = SOH.CustomerID 
GROUP BY C.CustomerID, FirstName, LastName 
select CustomerID,FirstName,LastName,CountOfSales,SumOfTotalDue from @CustomerInfo
--EXEC sp_executesql ('SELECT * FROM @CustomerInfo') N'@tbl tbltype READONLY', @tbl)

declare @hello int
set @hello=1
while(@hello<101)
begin
   print(@hello)
   set @hello=@hello+1
end
--3. Create a table variable with two integer columns, one of them an INDENTITY column. Use a WHILE loop to populate the table with 1,000 random integers using the following formula.  Use a second WHILE loop to print the values from the table variable one by one. 
--CAST(RND() * 10000 AS INT) + 1 
-- Here’s a possible solution: 
DECLARE @test TABLE (ID INTEGER NOT NULL IDENTITY, Random INT) DECLARE @Count INT = 1; DECLARE @Value INT
WHILE @Count <= 1000 BEGIN     SET @Value = CAST(RAND()*10000 AS INT) + 1;     
INSERT INTO @test(Random)     VALUES(@Value);     SET @Count += 1; END; 
SET @Count = 1; WHILE @Count <= 1000 BEGIN     SELECT @Value = Random     
FROM @test     WHERE ID = @Count;     
PRINT @Value;     SET @Count += 1; END
select ID , Random from @test


