create function Payrate(@rate money)
returns @table table (EmployeeId int not null,Ratechangedate datetime not null,Rate money not null,PayFrequency tinyint not null, ModifiedDate datetime not null)
as
begin
	insert @table
	select *
	from HumanResources.EmployeePayHistory
	where Rate > @rate
return 
end

select * from Payrate(45)


select * from Sales.SalesTerritory

select * from Sales.SalesOrderHeader



create function fnContinentSummary(@gr varchar(40),@mont varchar(40))
returns table
as
return
	select datename(month,OrderDate) as [Orderdate],t.Name,sum(SubTotal) as[Total]
	from Sales.SalesTerritory t 
	inner join sales.SalesOrderHeader h 
	on t.TerritoryID=h.TerritoryID
	where datename(month,orderdate)=@mont and [Group]=@gr
	group by datename(month,OrderDate),t.Name


select * from fnContinentSummary('North America','April')
select distinct datename(month,ModifiedDate)
from Sales.SalesTerritory

select datename(month,OrderDate) as [Orderdate],t.Name,sum(SubTotal) as[Total]
from Sales.SalesTerritory t 
inner join sales.SalesOrderHeader h 
on t.TerritoryID=h.TerritoryID
where datename(month,orderdate)='April' and [Group]='Europe'
group by datename(month,OrderDate),t.Name


select * from Person.Person




select len('srilekha')
select * from Sales.SalesTerritory

set @c=65

select * from Sales.Store
with cte(m,n,O)
as

(
select 65,char(65),FirstName
FROM Person.Person
WHERE SUBSTRING(FirstName, 1, 1)=CHAR(65)

union all

select m+1,char(m+1),c.O
from cte c
where SUBSTRING(c.O, 1, 1)=CHAR(m+1)
and
m<90
)
select n,O from cte



declare @hello int
set @hello =65
while @hello<90
begin
	select distinct FirstName,len(FirstName)--,COUNT(FirstName)
	from Person.Person
	WHERE SUBSTRING(FirstName, 1, 1)=CHAR(@hello)
	--group by FirstName,len(FirstName)
	set @hello=@hello+1
end

