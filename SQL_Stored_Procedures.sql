select * from INFORMATION_SCHEMA.TABLES
--select * from INFORMATION_SCHEMA.COLUMNS
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


--Create stored procedure usp_GetEmployeesSalaryAbove35000 that returns all employees’ first and last names for whose salary is above 35000. Submit your query statement as Run skeleton, run queries & check DB in Judge.

--select * from Employees

select concat(FirstName,' ',MiddleName,' ',LastName) as [Name of Employee],Salary
from Employees
where Salary>35000;

create  procedure spGet_EmployeeSalry
@sal int,
@EmpName nvarchar output
as
begin
	select  FirstName ,Salary
 from Employees
where Salary>@sal;
end


declare @empn nvarchar
execute spGet_EmployeeSalry 35000,@empn out
print @empn

/*Create stored procedure usp_GetEmployeesSalaryAboveNumber that accept a number (of type MONEY) as parameter and return all employees’ first and last names whose salary is above or equal to the given number. 
Submit your query statement as Run skeleton, run queries & check DB in Judge.*/

select FirstName,LastName
from Employees
where Salary>=30000

exec sp_columns employees

create procedure spGetEmployessMoneyInput
@inputsal money
as
begin
	select FirstName,LastName
	from Employees
	where Salary>=@inputsal
end


execute spGetEmployessMoneyInput @inputsal=48100

/*Write a stored procedure usp_GetTownsStartingWith that accept string as parameter and returns all town names starting with that string. Submit your query statement as Run skeleton, run queries & check DB in Judge.*/
exec sp_columns towns

CREATE PROC usp_GetTownsStartingWith(@Text VARCHAR(50)) 
         AS
	 SELECT Name
	   FROM Towns 
	  WHERE LEFT(Name,LEN(@Text)) = @Text

EXEC dbo.usp_GetTownsStartingWith 'B'


/*select Name,LEFT(Name,LEN('Cal')) from
towns*/

--Write a stored procedure usp_GetEmployeesFromTown that accepts town name as parameter and return the employees’ first and last name that live in the given town. Submit your query statement as Run skeleton, run queries & check DB in Judge.
select e.FirstName,e.LastName,t.Name
from
Addresses a
inner join towns t
on a.TownID=t.TownID
inner join Employees e
on a.AddressID=e.AddressID
where t.Name like '%Bell%'

create procedure spGet_EmployeesFromTown
(@hello varchar(20))
as
BEGIN 
	select e.FirstName,e.LastName,t.Name
	from
	Addresses a
	inner join towns t
	on a.TownID=t.TownID
	inner join Employees e
	on a.AddressID=e.AddressID
	where LEFT(t.Name,LEN(@hello)) = @hello
END

execute spGet_EmployeesFromTown @hello ='Bell'


/*Write a function ufn_GetSalaryLevel(@salary MONEY) that receives salary of an employee and returns the level of the salary.

If salary is < 30000 return “Low”
If salary is between 30000 and 50000 (inclusive) return “Average”
If salary is > 50000 return “High”*/

SELECT * FROM Employees
alter PROCEDURE sp_GetSalaryLevel
@inSalaryname varchar(50)
as
begin
SELECT 
CASE
WHEN E.Salary <30000 THEN 'LOW'
WHEN  E.Salary >=30000  and E.Salary <= 50000 THEN 'AVERAGE'
WHEN E.SALARY >50000 THEN 'HIGH'
END AS [LEVEL]
FROM Employees E
WHERE FirstName =@inSalaryname
end

execute sp_GetSalaryLevel @inSalaryname='Guy'



