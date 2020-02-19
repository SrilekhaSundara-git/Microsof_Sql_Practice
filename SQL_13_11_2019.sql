select  
        s.[name]            'Schema',
        t.[name]            'Table',
        c.[name]            'Column',
        d.[name]            'Data Type',
        c.[max_length]      'Length',
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
where c.name like '%rate%'


select * from person.EmailAddress

select len(EmailAddress) as [Length]
from Person.EmailAddress
select CHARINDEX('@',EmailAddress)
 from Person.EmailAddress
select e.BusinessEntityID as[Employee_id],concat(p.FirstName,' ',p.MiddleName,' ',p.LastName) as [Name],
substring(EmailAddress,1,charindex('@',EmailAddress)-1),EmailAddress
from Person.EmailAddress e
inner join Person.Person p
on e.BusinessEntityID=p.BusinessEntityID

select char(65)

select * from sales.staffs

--Ques.1. Write a SQL query to fetch the count of employees working in same department

select h.DepartmentID,d.Name as [Depart Name]
,count(h.BusinessEntityID) as [Number of Employees in each Department]
from HumanResources.EmployeeDepartmentHistory h
inner join HumanResources.Department d
on h.DepartmentID=d.DepartmentID
group by h.DepartmentID,d.Name
having count(BusinessEntityID)>1;

--Write a SQL query to fetch employee id having salary greater than or equal to 50 and less than or equal 10.


select distinct BusinessEntityID,rate
from HumanResources.EmployeePayHistory
where rate between 10 and 50
order by Rate;

select * from sales.customers

select substring(email,1,charindex('.',email)-1) from sales.customers


--Write a SQL query to fetch all the Employees who are also managers from EmployeeDetails table.


select * from sales.staffs


select DISTINCT s1.manager_id,concat(s2.first_name,' ',s2.last_name ) aS [NAME]--,s2.manager_id
from sales.staffs s1 
left outer join sales.staffs s2 
on s1.manager_id=s2.staff_id
WHERE S1.manager_id IS NOT NULL;

--Write a SQL query to fetch all employee records from EmployeeDetails table who have a salary record in EmployeeSalary table.
SELECT E.BusinessEntityID,P.RATE
FROM HumanResources.Employee E
LEFT OUTER JOIN HumanResources.EmployeePayHistory P
ON E.BusinessEntityID=P.BusinessEntityID
WHERE P.RATE IS NULL;

WITH R_CTE
AS
(

SELECT BusinessEntityID,RATE,DENSE_RANK() OVER(ORDER BY RATE DESC) AS [RATE_NO]
FROM HumanResources.EmployeePayHistory
)
SELECT * FROM R_CTE WHERE [RATE_NO]<=3

