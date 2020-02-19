
--The aim of this exercise is to create a table-valued function to show em[ployee details for any given year and get the name of the employee for the id
-- For example, you should be able to run this query:
select datename(year,HireDate)


create function fun_year_01(@year1 date)
returns table
as
return
(
select BusinessEntityID,JobTitle,BirthDate,HireDate
 from HumanResources.Employee
 where DATEname(year,HireDate)=@year1
)

select * from dbo.fun_year_01('2009')
select db.BusinessEntityID,concat(p.FirstName,' ',p.MiddleName,' ',p.LastName) as [Name of the Employee],JobTitle
,Convert(nvarchar,BirthDate,105) as [Date of Birth],convert(nvarchar, HireDate,105)as [Hire Date]
from dbo.fun_year_01('2009') db
inner join Person.Person p
on db.BusinessEntityID=p.BusinessEntityID
order by db.BusinessEntityID


select * from HumanResources.Employee
where DATEname(year,HireDate)='2008'


select * from HumanResources.Department

create function department_group_name(@namD nvarchar(50))
returns table
as
return
(
select DepartmentID,Name,GroupName
from HumanResources.Department
where name =@namD
)

select * from department_group_name('Engineering')


select * from Sales.SalesTerritory

select * from HumanResources.Department
--where name like '%Engineering%'

select * from Sales.SalesTerritory 
where [Group]='North America'

create function fun_sales_terri(@gr varchar(40))
returns table
as
return 
(
select * from Sales.SalesTerritory
where [Group]=@gr
)

select * from fun_sales_terri('North America')


create function HumanResources.Employee_Payee(@Ratep int)
returns table
as
return
(
select e.BusinessEntityID,e.JobTitle,er.Rate
from HumanResources.Employee e
inner join HumanResources.EmployeePayHistory er
on e.BusinessEntityID=er.BusinessEntityID
where er.rate>@Ratep
)
go

select * from HumanResources.Employee_Payee(50)


select * from dbo.ufnGetContactInformation(1)


select e.BusinessEntityID,e.JobTitle,convert(nvarchar,e.HireDate,105)as [Hire Date],e.Gender
from HumanResources.Employee e
cross apply dbo.ufnGetContactInformation(e.BusinessEntityID)

select e.BusinessEntityID,e.JobTitle,convert(nvarchar,e.HireDate,105)as [Hire Date],e.Gender
from HumanResources.Employee e
outer apply dbo.ufnGetContactInformation(e.BusinessEntityID)--even if null


