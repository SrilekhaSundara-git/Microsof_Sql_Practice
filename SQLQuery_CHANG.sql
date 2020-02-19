WITH CTE_DailyRevenue (Revenue, Product, TransactionTs, RowNumber, R7)
AS
(
SELECT Revenue,
Product,
TransactionTs,
DENSE_Rank() OVER ( ORDER BY TransactionTs ASC) RowNumber,

AVG(Revenue) OVER (partition by Product ORDER BY TransactionTs ASC ROWS 6 PRECEDING) AS R7
FROM Orders
)
SELECT Revenue,
Product,
TransactionTs,
RowNumber,
R7,
CASE WHEN RowNumber > 6 THEN R7 ELSE NULL END AS Rolling_AVG_7DAY
FROM CTE_DailyRevenue
ORDER BY TransactionTs;

WITH CTE_DailyRevenue (Revenue, Product, TransactionTs, RowNumber, R7)
AS
(
SELECT Revenue,
Product,
       TransactionTs,
       DENSE_RANK() OVER (ORDER BY TransactionTs ASC) RowNumber,
       AVG(Revenue) OVER (partition by Product ORDER BY TransactionTs ASC ROWS 6 PRECEDING) AS R7
FROM   Orders
)
SELECT Revenue,
Product,
TransactionTs,
CASE WHEN RowNumber > 6 THEN R7 ELSE NULL END AS Rolling_AVG_7DAY
FROM   CTE_DailyRevenue
ORDER BY TransactionTs;
