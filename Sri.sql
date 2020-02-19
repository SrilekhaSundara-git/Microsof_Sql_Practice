use AdventureWorks2012;
exec sp_columns PurchaseOrderDetail;
--Revenue Unittprice
--TransactionId PurchaseOrderDetailID
--TransationTs ModifiedDate
--Product-- roductID
select ModifiedDate
from Purchasing.PurchaseOrderDetail;
USE AdventureWorks2012
GO
SELECT ROW_NUMBER() OVER(
       ORDER BY CustomerID) AS RowNum, 
       CustomerID, 
       SalesOrderID, 
       OrderDate, 
       SalesOrderNumber, 
       SubTotal, 
       TotalDue
FROM Sales.SalesOrderHeader


select UnitPrice,
ProductID,
ModifiedDate,
ROW_NUMBER() OVER (ORDER BY ModifiedDate ASC) As RowNumber,
avg(UnitPrice) over (Partition by ProductId Order by ModifiedDate asc rows 6 preceding) as R7
from 
Purchasing.PurchaseOrderDetail


SELECT * FROM 
Purchasing.PurchaseOrderDetail
ORDER BY ModifiedDate;

drop table Orders;

USE Srilekha
GO
CREATE TABLE Orders (
    TransactionID int NOT NULL,
    Product varchar(255) NOT NULL,
    Revenue bigint,
	TransactionTs  Datetime
    PRIMARY KEY (TransactionID) 2019-01-0
	9300 9 89 10 47 14 68 15 13
);90 
--product bread-1 2019-01-01:00:00.000' 2011-04-23 00:00:00.000
--product milk--2
--19-01-01 11 120 400  123 16 2019-01-03 345 20 250
INSERT INTO Orders (TransactionID, Product, Revenue, TransactionTs)
VALUES (20,'milk',250,'2019-01-03')


select * from Orders ORDER BY TransactionTs


WITH CTE_DailyRevenue (Revenue, Product, TransactionTs, RowNumber, R7)
AS
(
SELECT Revenue,
Product,
TransactionTs,
ROW_NUMBER() OVER (partition by Product ORDER BY TransactionTs ASC) RowNumber,

AVG(Revenue) OVER (partition by Product ORDER BY TransactionTs ASC ROWS 6 PRECEDING) AS R7
FROM Orders
)
SELECT Revenue,
Product,
TransactionTs,
RowNumber,
CASE WHEN RowNumber > 6 THEN R7 ELSE NULL END AS Rolling_AVG_7DAY
FROM CTE_DailyRevenue
ORDER BY TransactionTs;