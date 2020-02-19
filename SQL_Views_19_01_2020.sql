CREATE VIEW vW_Customer 
as
(
select c.CustomerID,c.AccountNumber,c.StoreID,c.TerritoryID,
p.FirstName,p.MiddleName,p.LastName
from Sales.Customer c
join Person.Person p
on c.PersonID=p.BusinessEntityID
)


select * from vW_Customer


alter VIEW vW_Customer 
as
(
select c.CustomerID,c.AccountNumber,c.StoreID,c.TerritoryID,p.Title,
p.FirstName,p.MiddleName,p.LastName
from Sales.Customer c
join Person.Person p
on c.PersonID=p.BusinessEntityID
)


select * from vW_Customer



/*1. Create a view called dbo.vw_Products that displays a list of the products from the
Production.Product table joined to the Production.ProductCostHistory table. Include columns
that describe the product and show the cost history for each product. Test the view by creating a
query that retrieves data from the view.*/


create view vW_ProductCostHistoryproduct 
as 
(

select p.Name ,p.ProductID,p.ProductNumber,h.StartDate,h.StandardCost
from Production.Product p
inner join Production.ProductCostHistory h 
on p.ProductID=h.ProductID
)

select * 
from vW_ProductCostHistoryproduct 

/*Create a view called dbo.vw_CustomerTotals that displays the total sales from the TotalDue
column per year and month for each customer. Test the view by creating a query that retrieves
data from the view.*/--Sales.Customer AS C Sales.SalesOrderHeader
select * from Sales.Customer

select * from Sales.SalesOrderHeader

select CustomerID,count(*)[No Of Customer],datepart(month,DueDate)[Month],datepart(year,DueDate)[Year]
from Sales.SalesOrderHeader h 
group by CustomerID,datepart(month,DueDate),datepart(year,DueDate)
order by datepart(month,DueDate),datepart(year,DueDate)
--group by CustomerID

create view vW_CustomerTotals
as

select CustomerID,count(*)[No Of Customer],datepart(month,DueDate)[Month],datepart(year,DueDate)[Year]
from Sales.SalesOrderHeader h 
group by CustomerID,datepart(month,DueDate),datepart(year,DueDate)
--order by datepart(month,DueDate),datepart(year,DueDate)-- There should be no orderby clause in creating of views

select * from  vW_CustomerTotals
order by[Month],[Year]


select *from
sales.SalesOrderHeader

select * from 
sales.SalesOrderDetail


select SalesOrderID, sum(orderQty) --over(partition by SalesOrderDetailID)  
from 
sales.SalesOrderDetail d 
group by SalesOrderID
order by SalesOrderID

create view HumanResources.vW_EmployeeDeptData
With SchemaBinding
as
(
select e.BusinessEntityID,MaritalStatus,DepartmentID
from HumanResources.Employee e
join HumanResources.EmployeeDepartmentHistory h
on e.BusinessEntityID=h.BusinessEntityID
)

create unique clustered index idxvW_EmployeeDeptData
on HumanResources.vW_EmployeeDeptData(BusinessEntityID,DepartmentID)