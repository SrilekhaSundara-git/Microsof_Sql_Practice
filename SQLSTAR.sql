--SELECT * FROM sales.staffs
--SELF JOIN 
/*SELECT S1.STAFF_ID [EMP ID],CONCAT(S1.first_name,' ',S1.last_name) AS [NAME OF EMPLOYEE],S1.EMAIL,ISNULL(CAST(S1.manager_id AS VARCHAR(50)),'BOSS')[MANAGER ID],COALESCE(CONCAT(S2.first_name,' ',S2.last_name),'nO mANAGER') AS [NAME OF MANAGER]
--ISNULL(CAST(CONCAT(S2.first_name,' ',S2.last_name) AS VARCHAR(50)),'OWNER ') AS [NAME OF MANAGER]
FROM SALES.staffs S1 
LEFT OUTER JOIN SALES.STAFFS S2
ON S1.manager_id=S2.staff_id*/


/*select staff_id as [emp_id],concat(first_name,' ',last_name) as [Name of Employee],EMail,manager_id
from sales.staffs where manager_id is null;*/
--Displays all the employees other than KING and without designations manager, clerk, and salesman.
with emp_cte (staff_id,[Name of the Employee],Email,manager_id,[Level])
as
(
select staff_id,concat(first_name,' ',last_name) as [Name of the Employee],Email,manager_id,1 as [Level]
from sales.staffs s1
where manager_id is null

union all
select s1.staff_id,concat(s1.first_name,' ',s1.last_name) as [Name of the Employee],s1.Email,s1.manager_id,c.[Level]+1
from sales.staffs s1
join emp_cte c
on s1.manager_id=c.staff_id
)
select c1.staff_id as [Emp_id],c1.[Name of the Employee],c1.Email,isnull(cast(c1.manager_id as varchar(50) ),'Super Boss') as [Manager_id],c1.[Level],isnull(cast(c2.[Name of the Employee]as varchar(50)),'Owner') as [Manager Name],
case
when cast(c1.[Level] as varchar(40))='1' then 'KING'
ELSE ' '
END AS Designation --coalesce(Designation,' ')
from emp_cte c1
left outer join emp_cte c2
on c1.manager_id=c2.staff_id

--Displays all the employees whose names contains letter A and fourth letter is R.
select * 
from sales.staffs
where first_name like '%a%' and first_name like '___r'

--Display the unique designations that employees belong to (per each department in EMP table).
-- This gives unique job title(designations) and the count of designations per department
select  Department_Name,JobTitle,[Count ofEmployee] from 
(
select distinct  Name as [Department_Name]--,BusinessEntityID as [Emp id],h.DepartmentID,
,JobTitle,count(h.BusinessEntityID) over(partition by h.DepartmentID) as [No of Employees in each department]--,
,row_number() over(partition by h.DepartmentID order by Name) as [Count ofEmployee]
from HumanResources.Department d
left outer join HumanResources.EmployeeDepartmentHistory h
on d.DepartmentID=h.DepartmentID
--order by Name desc;
left outer join HumanResources.Employee e 
on e.BusinessEntityID=h.BusinessEntityID
) as a
order by Department_Name,JobTitle,[Count ofEmployee]
--This gives count of number of employees per deprtment
select distinct  Name as [Department_Name]--,BusinessEntityID as [Emp id],h.DepartmentID,
,JobTitle,count(h.BusinessEntityID) over(partition by h.DepartmentID) as [No of Employees in each department]--,
--,row_number() over(partition by h.DepartmentID order by Name) as [Count ofEmployee]
from HumanResources.Department d
left outer join HumanResources.EmployeeDepartmentHistory h
on d.DepartmentID=h.DepartmentID
--order by Name desc;
left outer join HumanResources.Employee e 
on e.BusinessEntityID=h.BusinessEntityID

--Display the list of employees, who have been with the company for more than 5 years.
select * from 
( 
	select BusinessEntityID,DATEDIFF(YEAR,HireDate,GETDATE() ) AS [No of Years in Organisation]
	from HumanResources.Employee
)as b
where [No of Years in Organisation]>5
order by [No of Years in Organisation] asc;
--
with empw_cte
as
(
	select BusinessEntityID as [Emp],rate,dense_rank() over (order by Rate desc) [Rank_D]
	from HumanResources.EmployeePayHistory h 

)

select distinct r1.* --r1.empno,r1.ename,r1.job,r1.deptno,r1.sal,r1.com,r1.[ran]
from empw_cte r1 
inner join empw_cte r2
on r1.[Rank_D]=r2.[Rank_D]
and r1.[Emp]<>r2.[Emp] 
order by r1.Rank_D

select e.BusinessEntityID,JobTitle
from HumanResources.Employee e
left outer join HumanResources.EmployeeDepartmentHistory h
on e.BusinessEntityID=h.BusinessEntityID
where h.DepartmentID is null;

--Display the list of employees by combining the first two characters and last two characters.
select * from sales.staffs
SELECT concat(Left(first_name,2),' ', right(last_name,2)) as  [Adding Name]
from sales.Staffs
--Convert the HIREDATE in the employee table to any known date format of yours.
select convert(varchar, HireDate, 105) as [Hiredate Change in format]
from HumanResources.Employee

select * from HumanResources.EmployeePayHistory

select distinct * from HumanResources.EmployeeDepartmentHistory

select distinct rate,h.DepartmentID,eh.BusinessEntityID
from HumanResources.EmployeeDepartmentHistory h 
--left outer join HumanResources.Employee e
--on h.BusinessEntityID=e.BusinessEntityID
left outer join HumanResources.EmployeePayHistory eh
on h.BusinessEntityID=eh.BusinessEntityID
where h.DepartmentID=7 and rate >
(
	select max(rate)--17.7885
	from HumanResources.EmployeeDepartmentHistory h 
--left outer join HumanResources.Employee e
--on h.BusinessEntityID=e.BusinessEntityID
	left outer join HumanResources.EmployeePayHistory eh
	on h.BusinessEntityID=eh.BusinessEntityID
	where h.DepartmentID =12
)

select *from HumanResources.EmployeePayHistory

select * from HumanResources.Employee

select e.BusinessEntityID as [Emp_Id],DepartmentID,
case
when cast(MaritalStatus as varchar(40))='S' then 'Single'
WHEN cast(MaritalStatus as varchar(20))= 'M' THEN 'Married' 
ELSE 'Unknown'
END AS MaritalStatus,
case
when cast(Gender as varchar(20))='F' then 'Female'
when cast(Gender as varchar(20))='M' then 'Male'
Else 'Not Disclosed'
End as Gender
from HumanResources.Employee e 
inner join HumanResources.[EmployeeDepartmentHistory] h 
on e.BusinessEntityID=h.BusinessEntityID

select char(90)

declare @a int
set @a =65
while (@a<91)
BEGIN 
	PRINT(CHAR(@a))
	set @a=@a+1
END

WITH A_CTE(A,B)
AS
(
	SELECT 65,CHAR(65)
	UNION ALL
	SELECT A+1,CHAR(A+1)
	FROM A_CTE
	WHERE A<90
)
SELECT B FROM A_CTE


WITH CTE(N,M)
AS
(

SELECT 1,DATENAME(MONTH, DATEADD(MONTH, -1+1,1))

UNION ALL

SELECT N+1,DATENAME(MONTH, DATEADD(MONTH, -1+(N+1),1))

FROM CTE

WHERE N<12
)

SELECT M AS [MONTH] FROM CTE

--SELECT DATEADD(MONTH, 0+2,1)