--Displays all the employees other than KING and without designations manager, clerk, and salesman.

select * from sales.staffs;


select s1.staff_id,concat(s1.first_name,' ',s1.last_name) as [Name],s1.manager_id,concat(s2.first_name,' ',s2.last_name)
 from sales.staffs s1 
left outer join sales.staffs s2 
on s1.manager_id=s2.staff_id;

with emp_r([Employee_id],[Name],manager_id,[Level])
as
(
select staff_id as [Employee_id],concat(first_name,' ',last_name) as [Name],manager_id,1 as [Level]

 from sales.staffs s1 
 where s1.manager_id is null

union all

select staff_id as [Employee_id],concat(first_name,' ',last_name) as [Name],s2.manager_id,e.[Level]+1 as[Level]
from sales.staffs s2 inner join emp_r e
on s2.manager_id=e.[Employee_id]
)

select e1.[Employee_id],
e1.Name as [Emp Name],
coalesce(cast(e1.manager_id as varchar(50)),'Employee Boss') as [Manager_id],
isnull(e2.Name ,'Boss') as [Name of Manager],e1.[Level],
case
when cast(e1.[Level] as varchar(20))= '1' then 'KING'
WHEN cast(e1.[Level] as varchar(20))= '2' THEN 'MANAGER' 
WHEN cast(e1.[Level]as varchar(20))= '3' THEN 'CLERK' 
WHEN cast(e1.[Level]as varchar(20))= '4' THEN 'SALES PERSON'
ELSE cast(e1.[Level] as varchar(20))
END AS Designation
from emp_r e1
left join emp_r e2
on e1.manager_id=e2.[Employee_id]
order by e1.[Employee_id];
--Displays all the employees whose names contains letter A and fourth letter is R

select * from Person.Person


select distinct BusinessEntityID as [Employee Id],concat(FirstName,' ',MiddleName,' ',LastName) as [Name of the Eamployee]
from Person.Person
where FirstName like '%a%'and FirstName like '___R'

-- Display the unique designations that employees belong to (per each department in EMP table).

select * from HumanResources.Department

select distinct
d.name as [Department Name],count(h.BusinessEntityID) as [Employee Count]
from HumanResources.EmployeeDepartmentHistory h
inner join HumanResources.Department d
on h.DepartmentID=d.DepartmentID
group by d.Name
order by [Employee Count];

--Display the list of employees, who have been with the company for more than 5 years.

select * 
from HumanResources.Employee
where datediff(yy,HireDate,ModifiedDate)>5

--Display the names of the departments that are not assigned to any employee.
select * from HumanResources.Employee

select DepartmentID
from HumanResources.EmployeeDepartmentHistory dh 
left outer join HumanResources.Employee e 
on dh.BusinessEntityID=e.BusinessEntityID
where e.JobTitle is null;

--Display the list of employees by combining the first two characters and last two characters.


select distinct concat(left(firstname,2),right(firstname,4)),FirstName
 from person.Person

 --Convert the HIREDATE in the employee table to any known date format of yours.

 select BusinessEntityID,datename(month,HireDate)
 from HumanResources.Employee

 --Calculate the total salary for each employee. That should INCLUDE commission too.

 select * from HumanResources.EmployeePayHistory

 select * from INFORMATION_SCHEMA.COLUMNS 
where COLUMN_NAME like '%bonus%' 
order by TABLE_NAME

select * from sales.SalesPerson


select BusinessEntityID,SalesQuota+Bonus as [Sal]
 from Sales.SalesPerson

 --Display all the employees from department 30 whose salary is less than maximum salary of department 20. 


 select distinct DepartmentID from HumanResources.EmployeeDepartmentHistory

 select * from HumanResources.EmployeePayHistory
 select p.*,h.DepartmentID
from HumanResources.EmployeePayHistory p
inner join HumanResources.EmployeeDepartmentHistory h
on p.BusinessEntityID=h.BusinessEntityID
where h.DepartmentID = 11
and rate <

(select max(rate)
from HumanResources.EmployeePayHistory p
inner join HumanResources.EmployeeDepartmentHistory h
on p.BusinessEntityID=h.BusinessEntityID
where h.DepartmentID = 10)--60.0962

--Displays all the employees who are drawing same salaries

with cte_e
as
(

select BusinessEntityID,rate,dense_rank() over(order by rate desc) as [Same]
from HumanResources.EmployeePayHistory
)

select distinct r1.BusinessEntityID,r1.rate,r1.same from cte_e r1 inner join cte_e r2 
on r1.[Same]=r2.[Same] and r1.BusinessEntityID<>r2.BusinessEntityID
order by r1.same;

--Display all the employees who are drawing maximum salaries in each location.

select o.BusinessEntityID,o.Region,o.SalesQuota
 from 
(select p.BusinessEntityID,t.Name as[Region],SalesQuota,
max(SalesQuota) over(partition by t.Name) as  [Maxi]
 from sales.SalesPerson p
inner join Sales.SalesTerritory t 
on p.TerritoryID=t.TerritoryID)o
where o.SalesQuota=o.Maxi;
--Display the list of employees (who is both employee and manager).

with emp_cte1([Employee_id],[Name],manager_id,[Level])
as
(
select staff_id as [Employee_id],concat(first_name,' ',last_name) as [Name],manager_id,1 as [Level]
from sales.staffs
where manager_id is null

union all

select s.staff_id as [Employee_id],concat(s.first_name,' ',s.last_name) as [Name],s.manager_id,e.[Level]+1
from sales.staffs s 
inner join emp_cte1 e
on s.manager_id=e.[Employee_id]
)

select e1.[Employee_id],
e1.Name as [Emp Name],
coalesce(cast(e1.manager_id as varchar(50)),'Employee Boss') as [Manager_id],
isnull(e2.Name ,'Boss') as [Name of Manager],e1.[Level],
case
when cast(e1.[Level] as varchar(20))= '1' then 'KING'
WHEN cast(e1.[Level] as varchar(20))= '2' THEN 'MANAGER' 
WHEN cast(e1.[Level]as varchar(20))= '3' THEN 'CLERK' 
WHEN cast(e1.[Level]as varchar(20))= '4' THEN 'SALES PERSON'
ELSE cast(e1.[Level] as varchar(20))
END AS Designation
from emp_cte1 e1
left join emp_cte1 e2
on e1.manager_id=e2.[Employee_id]
where e1.[Level]=2
order by e1.[Employee_id];

WITH cte_numbers(n, weekday) 
AS (
    SELECT 
        0, 
        DATENAME(DW, 0)
    UNION ALL
    SELECT    
        n + 1, 
        DATENAME(DW, n + 1)
    FROM    
        cte_numbers
    WHERE n < 6
)
SELECT 
    weekday
FROM 
    cte_numbers;

	select ascii('Z')

	WITH CTE_RE(N,M)
	AS
	(
	SELECT 65,CHAR(65)

	UNION ALL

	SELECT N+1,CHAR(N+1)
	FROM CTE_RE
	WHERE N<90
	)
	SELECT M AS [aLPHABETS] FROM CTE_RE


	DECLARE @F INT
	SET @F=65
	WHILE (@F<91)
	BEGIN
	PRINT(CHAR(@F))
	SET @F=@F+1
	END

	WITH CTE_MONTH(M,N)
	AS
	(
	SELECT 1,DATENAME(MONTH, DATEADD(MONTH, 1,-1))

	UNION ALL

	SELECT M+1,DATENAME(MONTH, DATEADD(MONTH, M+1,-1))
	FROM CTE_MONTH
	WHERE M<12
	)
	SELECT * FROM CTE_MONTH