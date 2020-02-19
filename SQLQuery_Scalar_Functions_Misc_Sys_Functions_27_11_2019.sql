SELECT GETDATE()

SELECT CURRENT_TIMESTAMP

SELECT DATENAME(MONTH, DATEADD(MONTH, -1+3,1))

WITH CTE(N,M)
AS
(

SELECT 1,DATENAME(MONTH, DATEADD(MONTH, -1+1,1))

UNION ALL

SELECT N+1,DATENAME(MONTH, DATEADD(MONTH, -1+(N+1),1))

FROM CTE

WHERE N<12
)

SELECT * FROM CTE


SELECT DAY(GETDATE())

SELECT MONTH(GETDATE())

SELECT YEAR(GETDATE())


SELECT DATENAME(DW,0)


SELECT DATENAME(WEEKDAY,GETDATE())


SELECT BusinessEntityID,HireDate,CONCAT(DAY(CAST(HireDate AS NVARCHAR)),' ',DATENAME(MONTH,CAST(HireDate AS NVARCHAR)),' ',DATENAME(YEAR,CAST(HireDate AS NVARCHAR))) AS [NAMING OF DATE]
FROM HumanResources.Employee



SELECT BusinessEntityID,HireDate,CONCAT(DAY(CONVERT( NVARCHAR,HireDate)),' ',DATENAME(MONTH,CONVERT(NVARCHAR,HireDate)),' ',DATENAME(YEAR,CONVERT( NVARCHAR,HireDate))) AS [NAMING OF DATE]
FROM HumanResources.Employee



SELECT BusinessEntityID,HireDate,CONVERT(nvarchar,HireDate,103)
FROM HumanResources.Employee
SELECT CONVERT(DATE ,GETDATE(),103)
SELECT CONVERT(NVARCHAR ,GETDATE(),103)

DECLARE @HELLO INT,@COUNTER INT
SET @HELLO=1
SET @COUNTER=1
WHILE(@COUNTER<10)
BEGIN
PRINT(CEILING(RAND() *100))
SET @COUNTER=@COUNTER+1
END


DECLARE @DOB DATE
DECLARE @AGE INT
SET @DOB= '11-01-1992'
SET @AGE=DATEDIFF(YEAR,@DOB,CONVERT(DATE,GETDATE() ))
SELECT @AGE

CREATE PROCEDURE SP_GETAGE_01
@DOB DATE
--@AGE INT
AS
BEGIN

SELECT (DATEDIFF(YEAR,@DOB,CONVERT(DATE,GETDATE())))

 END
--SELECT @AGE

EXECUTE SP_GETAGE_01 @DOB='1/01/1992'


CREATE PROCEDURE SP_GETAGE_03
@DOB DATE,
@AGE INT OUTPUT
AS
BEGIN

SELECT @AGE=(DATEDIFF(YEAR,@DOB,CONVERT(DATE,GETDATE())))

 END
--SELECT @AGE
Declare @Empage int
Execute SP_GETAGE_03 '1/01/1992', @Empage output
Print @Empage
--EXECUTE 
--function

CREATE FUNCTION Age(@DOB Date)  
RETURNS INT  
AS  
BEGIN  
 DECLARE @Age INT  
 SET @Age = DATEDIFF(YEAR, @DOB, GETDATE()) - CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END  
 RETURN @Age  
END


select BusinessEntityID,convert(nvarchar,HireDate,104)as [Joining Date],dbo.Age(HireDate) as[No of Years in the Company]
from HumanResources.Employee
where dbo.Age(HireDate)>8



create function Employeepay(@pays float)
returns float
as
begin
return(@pays*8*30)
end

select dbo.Employeepay(12.56)

CREATE FUNCTION sales.udfNetSale(
    @quantity INT,
    @list_price DEC(10,2),
    @discount DEC(4,2)
)
RETURNS DEC(10,2)
AS 
BEGIN
    RETURN @quantity * @list_price * (1 - @discount);
END;


SELECT 
    sales.udfNetSale(10,100,0.1) net_sale;


SELECT 
    order_id, 
    SUM(sales.udfNetSale(quantity, list_price, discount)) net_amount
FROM 
    sales.order_items
GROUP BY 
    order_id
ORDER BY
    net_amount DESC;


create function hello (@firstdate date ,@lastdate date)
returns int
as
begin 
	declare @datediff int
	set  @datediff=datediff(day,@firstdate,@lastdate)
	return @datediff
end


select DoctorId,DoctorName,FirstEpisodeDate,LastEpisodeDate,isnull(cast(dbo.hello(FirstEpisodeDate,LastEpisodeDate)as varchar),'Is still Working')[No of days]
from tblDoctor


--Create a function called fnLetterCount which takes two parameters:

create function Count_Letters(@firstname varchar(50),@secondname varchar(50))
returns int
as
begin
declare @countletter int
set @countletter=sum(len(@firstname)+len(@secondname))
return @countletter
end

SELECT dbo.Count_Letters('Wise','Owl')

AS 'Number of letters'
select BusinessEntityID --,sum(len(FirstName)+len(LastName))
,dbo.Count_Letters(FirstName,LastName)as [Count of Letters]
from Person.Person
group by BusinessEntityID
order by BusinessEntityID


create function calculate_month3(@mon int)
returns varchar(50)
as
begin
declare @monname varchar(50)
while(@mon<13)
set @monname=datename(month,dateadd(month,-1+@mon,1))
return @monname
end


select dbo.calculate_month3(1) as [Month Name]


