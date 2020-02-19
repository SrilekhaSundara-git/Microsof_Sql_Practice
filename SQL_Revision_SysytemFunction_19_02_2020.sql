declare @start int
set @start=65
while @start<=90
BEGIN
    PRINT char(@start)
	set @start=@start+1
END

DECLARE @WEEK INT
SET @WEEK=0
WHILE @WEEK<=6
BEGIN
	PRINT DATENAME(DW,@WEEK)
	SET @WEEK=@WEEK+1
END

DECLARE @MONTH INT
SET @MONTH=1
WHILE @MONTH<=12
BEGIN
	PRINT  @MONTH - 1
	PRINT DATENAME(MONTH, DATEADD(MONTH, @MONTH-1, '1 Jan 1900'))
	SET @MONTH=@MONTH+1
END

SELECT DATEADD(month, -2, '2017/08/25') AS DateAdd;

--ascii code 160 is a non-breaking space. it is different than a normal space (ascii code 32).
declare @my int =10;
print 'The value of the'+char(32) + CAST(@my as varchar(10)) +char(32)+ 'number';
print @my;
set @my=20;
print 'The value of my number for using set function '+ char(32)+ CAST(@my as varchar(10));
print @my;
--Write a SQL query to find first and last names of all employees 
--whose first name starts with “SA”. Submit your query statements as Prepare DB & run queries.
--To list all the tables in the sql schema
SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, COLUMN_DEFAULT
FROM SoftUni.INFORMATION_SCHEMA.COLUMNS

SELECT 
    FK = fk.name, 
    FKTable = QUOTENAME(OBJECT_SCHEMA_NAME(fkcol.[object_id])) 
        + '.' + QUOTENAME(OBJECT_NAME(fkcol.[object_id])),
    FKCol = fkcol.name,
    ' references => ',
    PKTable = QUOTENAME(OBJECT_SCHEMA_NAME(pkcol.[object_id])) 
        + '.' + QUOTENAME(OBJECT_NAME(pkcol.[object_id])),
    PKCol = pkcol.name
FROM sys.foreign_keys AS fk
INNER JOIN sys.foreign_key_columns AS fkc
ON fk.[object_id] = fkc.constraint_object_id
INNER JOIN sys.columns AS fkcol
ON fkc.parent_object_id = fkcol.[object_id]
AND fkc.parent_column_id = fkcol.column_id
INNER JOIN sys.columns AS pkcol
ON fkc.referenced_object_id = pkcol.[object_id]
AND fkc.referenced_column_id = pkcol.column_id
ORDER BY fkc.constraint_column_id;
/*
Write a SQL query to find first and last names of 
all employees whose first name starts with “SA”. 
Submit your query statements as Prepare DB & run queries.
*/

select FirstName,LastName
from Employees
where FirstName like upper('Sa%')

/*Write a SQL query to find first and last names of all employees whose last name contains “ei”. 
Submit your query statements as Prepare DB & run queries.*/
select FirstName,LastName
from Employees
where LastName like upper('%ei%')

/*Write a SQL query to find the first names of all employees in the departments with ID 3 or 10 and whose hire year is
 between 1995 and 2005 inclusive. 
Submit your query statements as Prepare DB & run queries.
*/
select FirstName,DepartmentID,Year(Hiredate) as [Year Of Hire]
from Employees
where DepartmentID in (3,10)
and year(HireDate) between 1995 and 2005;
 

/*Write a SQL query to find the first and last names of 
all employees whose job titles does not contain “engineer”. Submit your query statements as Prepare DB & run queries.
*/

select * from Employees

select concat(FirstName,' ',LastName) as [Name of the Employee]
from Employees
where JobTitle not like upper('%Engineer%');

/*
Write a SQL query to find town names that are 5 or 6 symbols long and order them alphabetically by town name.
 Submit your query statements as Prepare DB & run queries.
*/

select * 
from towns
where len(Name) between 5 and 6
order by Name asc;

sp_help towns

exec sp_columns towns

select distinct Name
from Towns

/*
Write a SQL query to find all towns that start with letters
 M, K, B or E. Order them alphabetically by town name.
 Submit your query statements as Prepare DB & run queries.
*/

select * 
from Towns
where Name like upper('M%') or Name like upper('K%') or Name like upper('B%') or Name like upper('E%')
order by Name Asc;

select * 
from Towns
where left(Name,1)  in ('M','K','B','E')
order by Name ASC;

/*
Write a SQL query to find all towns that does not start with letters R, B or D. Order them alphabetically by name. 
Submit your query statements as Prepare DB & run queries.
*/

select * 
from Towns
where CHARINDEX('R',Name)<>1 
order by Name Asc;

select * 
from Towns
where left(Name,1) not in ('B','R','D')
order by Name ASC;

select * 
from Towns
where substring(Name,1,1) ='B'
order by Name ASC;

select * 
from Towns
where substring(Name,1,1) not in ('B','R','D')
order by Name ASC;



