 /*select
 distinct SP.ProductID,SO.* from 
 Sales.SpecialOfferProduct SP
 left outer join 
 Sales.SalesOrderDetail SO
 on SP.ProductID=SO.ProductID
 order by SP.ProductID ;*/

/*select
 distinct SP.ProductID from 
 Sales.SpecialOfferProduct SP
 left outer join 
 Sales.SalesOrderDetail SO
 on SP.ProductID=SO.ProductID
 where SO.ProductID is NULL
 order by SP.ProductID ;*/

 /*select st.*, sp.*
 from Sales.SalesTerritory as st 
 right outer join Sales.SalesPerson as sp
 on st.TerritoryID=sp.TerritoryID;*/

 /*SELECT * 
 FROM HumanResources.EmployeeDepartmentHistory D JOIN  
 HumanResources.Employee E ON 
 D.BusinessEntityID=E.BusinessEntityID
 JOIN HumanResources.Department P ON
 P.DepartmentID= D.DepartmentID
 Where D.BusinessEntityID <> 3;*/

 /*SELECT * FROM HumanResources.Department
 WHERE DepartmentID =
 (
 SELECT DepartmentID FROM HumanResources.EmployeeDepartmentHistory
 WHERE BusinessEntityID=46 AND EndDate IS NULL
 );*/

 /*SELECT * FROM
 HumanResources.Employee
 WHERE  EXISTS 
 (SELECT * FROM HumanResources.EmployeeDepartmentHistory
 WHERE BusinessEntityID=HumanResources.EMPLOYEE.BusinessEntityID -- EVEN WITHOUT THE CONDITIONA IN THE WHERE CLAUSE IT IS WORKING
 AND DepartmentID IS NOT NULL
 );*/




/*SELECT      c.name  AS 'ColumnName'
            ,t.name AS 'TableName'
FROM        sys.columns c
JOIN        sys.tables  t   ON c.object_id = t.object_id
WHERE       c.name LIKE '%RATE%'
ORDER BY    TableName
            ,ColumnName;*/
/*select  
        s.[name]            'Schema',
        t.[name]            'Table',
        c.[name]            'Column',
        d.[name]            'Data Type',
        d.[max_length]      'Max Length',
        d.[precision]       'Precision',
        c.[is_identity]     'Is Id',
        c.[is_nullable]     'Is Nullable',
        c.[is_computed]     'Is Computed',
        d.[is_user_defined] 'Is UserDefined',
        t.[modify_date]     'Date Modified',
        t.[create_date]     'Date created'
from        sys.schemas s
inner join  sys.tables  t
on s.schema_id = t.schema_id
inner join  sys.columns c
on t.object_id = c.object_id
inner join  sys.types   d
on c.user_type_id = d.user_type_id
where c.name like '%BusinessEntityID%';*/

--EMPLOYEEID,EMPLOYEE NAME,DEPARTMENT NAME,DATE OF JOINING,EMPLOYEE ADDRESS
-- EMPLOYEE,DEPARTMENT,EMPLOYEEDEPARTMENTHISTORY,CONTACT,ADDRESS TABLES


exec sp_columns ADDRESS;

SELECT NAME AS [NAME OF THE DEPARTMENT],DH.DepartmentID,E.HIREDATE AS [DATE OF JOINING],
P.FirstName+P.MiddleName+P.LastName AS [NAME OF THE EMPLOYEE],
--A.AddressLine1--NOT THIS,
--A.AddressLine2--,A.City,A.PostalCode,A.SpatialLocation,A.StateProvinceID 
A.AddressLine1+A.City+A.PostalCode+--A.SpatialLocation
CAST (A.StateProvinceID AS nvarchar) AS [ADDRESS OF EMPLOYEE]
FROM HumanResources.Department D
JOIN HumanResources.EmployeeDepartmentHistory DH 
ON D.DepartmentID=DH.DepartmentID
JOIN HumanResources.Employee E 
ON E.BusinessEntityID=DH.BusinessEntityID
JOIN PERSON.PERSON P
ON E.BusinessEntityID=P.BusinessEntityID
JOIN Person.BusinessEntityAddress BA
ON P.BusinessEntityID=BA.BusinessEntityID
JOIN PERSON.Address A
ON BA.AddressID=A.AddressID;

EXEC sp_columns ADDRESS; 

-- EMPLOYEEID,DESIGNATION,PAY OR RATE OF PAY OF THE EMPLOYEE SALARY

SELECT BusinessEntityID,RATE FROM
HumanResources.EmployeePayHistory;

SELECT JOBTITLE,BusinessEntityID
FROM
HumanResources.Employee 
WHERE EXISTS 
(SELECT  BusinessEntityID,RATE FROM
HumanResources.EmployeePayHistory H WHERE H.BusinessEntityID=HumanResources.Employee.BusinessEntityID) ;

SELECT JOBTITLE,E.BusinessEntityID
,RATE	
FROM
HumanResources.Employee E 
JOIN 
HumanResources.EmployeePayHistory H ON  H.BusinessEntityID=E.BusinessEntityID;
--dISPLAY THE SALES PERSON ID ALONG WITH THE SALES PERSON AND THE NAME OF THE TERRIOTORY TO WHICH THEY BELONG TO
SELECT NAME 
FROM SALES.SalesTerritory WHERE
EXISTS (SELECT 
* FROM 
SALES.SalesPerson S
WHERE 
S.TerritoryID=Sales.SalesTerritory.TerritoryID)
;

SELECT NAME 
FROM SALES.SalesReason;

SELECT SP.BusinessEntityID AS [SALES PERSON ID],+' '+LastName AS [NAME],SP.TerritoryID,ST.Name AS[TERRITORY NAME] 
FROM 
PERSON.PERSON P
JOIN 
HumanResources.Employee E
ON P.BusinessEntityID=E.BusinessEntityID
JOIN SALES.SalesPerson SP
ON E.BusinessEntityID=SP.BusinessEntityID
JOIN SALES.SalesTerritory ST
ON ST.TerritoryID=SP.TerritoryID;
--GROUP BY SP.TerritoryID ;


--exercise 4
select BusinessEntityID,st.TerritoryID from 
sales.SalesPerson sp
left outer join 
sales.SalesTerritory st
on sp.TerritoryID=st.TerritoryID;
--exercise 4
SELECT SalesOrderID,'Territory Name'=Name,
Month=Datename(mm,OrderDate),
Year=Datename(yy,OrderDate)
FROM Sales.SalesOrderHeader s
JOIN Sales.SalesTerritory t
ON s.TerritoryID=t.TerritoryID;


SELECT SalesOrderID,'Territory Name'=Name,
OrderDate,Quarter=datepart(qq,OrderDate)
FROM Sales.SalesOrderHeader s
JOIN Sales.SalesTerritory t
ON s.TerritoryID=t.TerritoryID;

select orderdate from sales.SalesOrderHeader;
select month=datename(mm,orderdate) 
from sales.SalesOrderHeader;

select SalesOrderID,
round(sh.TotalDue,0) as [Due Amount],CardType
from sales.SalesOrderHeader sh 
join sales.CreditCard cc 
on sh.CreditCardID=cc.CreditCardID;

SELECT SalesOrderID,Name,Convert(Char(10),OrderDate,103 ) as 'Order Date' FROM Sales.SalesOrderHeader s
JOIN Sales.SalesTerritory t
ON t.TerritoryID=s.TerritoryID

SELECT SalesOrderID,Name,OrderDate as 'Order Date', CONVERT(date,OrderDate ) [dATE OF ORDER] FROM Sales.SalesOrderHeader s
JOIN Sales.SalesTerritory t
ON t.TerritoryID=s.TerritoryID;

SELECT SalesOrderID,ST.NAME [NAME OF TERRITORY] FROM
SALES.SalesOrderHeader SH
JOIN SALES.SalesTerritory ST 
ON SH.TerritoryID=ST.TerritoryID
WHERE DATENAME(MM,SH.OrderDate) LIKE '%MAY%' 
AND DATENAME(YYYY,SH.OrderDate) = '2011';


Select SalesOrderID,TotalDue FROM Sales.SalesOrderHeader
WHERE TotalDue>(Select Avg(TotalDue)FROM SALES.SalesOrderHeader);--4012

SELECT JOBTITLE,BusinessEntityID
FROM
HumanResources.Employee 
WHERE EXISTS 
(SELECT  BusinessEntityID,RATE FROM
HumanResources.EmployeePayHistory H WHERE H.BusinessEntityID=HumanResources.Employee.BusinessEntityID) ;

SELECT SalesOrderID FROM 
SALES.SalesOrderHeader
WHERE EXISTS
(SELECT * FROM SALES.SalesTerritory T
 WHERE T.TerritoryID=SALES.SalesOrderHeader.TerritoryID AND T.NAME LIKE '%Northeast%' );

 Select SalesOrderID FROM Sales.SalesOrderHeader WHERE 
 TerritoryID in (Select TerritoryID FROM Sales.SalesTerritory WHERE Name='NorthEast');

 select subtotal from 
 sales.SalesOrderHeader;

 select salesorderid from 
 sales.salesorderheader
 where SubTotal>
 (select avg(subtotal) from sales.SalesOrderHeader);
