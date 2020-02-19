DECLARE @t int
set @t=65
while(@t<=90)
	begin
	print(char(@t))
	set @t=@t+1
	end

	with n_cte(a,b)
	as
	(
	select 0,datename(dw,0)
	union all 
	select a+1,datename(dw,a+1)
	from n_cte
	where a<6
	
	)

	select b from n_cte;


with r_cte(n,m)
as
(
select 1,datename(mm,dateadd(month,1,-1))

union all
select n+1,datename(mm,dateadd(month,n+1,-1))
from r_cte
where n<12
)
select m from r_cte


declare @m int
set @m=1
while @m<=12
begin
	print(datename(mm,dateadd(mm,@m,-1)))
	set @m=@m+1
end
--select datename(mm,dateadd(month,1,-1)))

select datename(month,dateadd(month,1,-1))


select dateadd(month,0,-1)

select right('adbsg',3)

select charindex('A','srilekha')