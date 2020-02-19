--Displays all the employees other than KING and without designations manager, clerk, and salesman.

with r_cte(staff_id,[Name of the Employee],[Level],manager_id)
as

(

select staff_id,concat(first_name,' ',last_name) as [Name of the Employee],1 as [Level],manager_id
from sales.staffs where manager_id is null

union all

select s2.staff_id,concat(first_name,' ',last_name) as [Name of the Employee], r.[Level]+1 as [Level] ,s2.manager_id

from sales.staffs s2 
inner join  r_cte r
on s2.manager_id=r.staff_id
)
select r1.staff_id,r1.[Name of the Employee],r1.[Level],isnull(cast(r1.manager_id as varchar(50)),'Employee Boss') as [Manager_id],coalesce(r2.[Name of the Employee],'No manager' )as [ManagerName],

case
when cast(r1.[Level] as varchar(40))='1' then 'KING'
WHEN cast(r1.[Level] as varchar(20))= '2' THEN 'MANAGER' 
WHEN cast(r1.[Level]as varchar(20))= '3' THEN 'CLERK' 
WHEN cast(r1.[Level]as varchar(20))= '4' THEN 'SALES PERSON'
ELSE cast(r1.[Level] as varchar(20))
END AS Designation
from r_cte r1
left outer join r_cte r2 
on r1.manager_id=r2.staff_id;

--Displays all the employees whose names contains letter A and fourth letter is R.

select * from sales.staffs where first_name like '%a%' and first_name like '____r'
select FirstName from Person.Person
 where FirstName like '%a%' and FirstName like '___r'
 --Display the unique designations that employees belong to (per each department in EMP table).


 create table emp(empno varchar(100),ename varchar(100),job varchar(100),mgr varchar(100),hiredate date,sal decimal,com varchar(100),deptno varchar(100));
create table dept(deptno varchar(100),dname varchar(100),loc varchar(100));
create table salgrade(grade varchar(100),losal varchar(100),highsal varchar(100));

insert into emp values('7369','SMITH','CLERK','7902','17-DEC-80','800','','20');
insert into emp values('7499','ALLEN','SALESMAN','7698','20-FEB-81','1600','300','30');
insert into emp values('7521','WARD','SALESMAN','7698','22-FEB-81','1250','500','30');
insert into emp values('7566',  'JONES','MANAGER','7839','02-APR-81','2975','','20');
insert into emp values('7654',  'MARTIN',  'SALESMAN','7698','28-SEP-81','1250','1400','30');
insert into emp values('7698','BLAKE','MANAGER','7839','01-MAY-81 ','2850','','30');
insert into emp values('7782','CLARK','MANAGER','7839','09-JUN-81','2450','','10');
insert into emp values('7788','SCOTT','ANALYST','7566','09-DEC-82','3000','','20');
insert into emp values('7839','KING','PRESIDENT','','17-NOV-81','5000','','10');
insert into emp values('7844','TURNER','SALESMAN','7698','08-SEP-81','1500','0','30');
insert into emp values('7876','ADAMS','CLERK','7788','12-JAN-83','1100','','20');
insert into emp values('7900','JAMES','CLERK','7698','03-DEC-81','950','','30');
insert into emp values('7902','FORD','ANALYST','7566','03-DEC-81','3000','','20');
insert into emp values('7934','MILLER','CLERK','7782','23-JAN-82','1300','', '10');


insert into dept values('10', 'ACCOUNTING','NEW YORK');
insert into dept values('20','RESEARCH','DALLAS');
insert into dept values('30','SALES','CHICAGO');
insert into dept values('40', 'OPERATIONS','BOSTON');


insert into salgrade values( '1','700','1200');
insert into salgrade values('2','1201','1400');
insert into salgrade values('3','1401','2000');
insert into salgrade values('4','2001','3000');
insert into salgrade values('5','3001','9999');


select dname,count(job)
from emp e
inner join dept d 
on e.deptno=d.deptno
group by dname

select distinct dname,job
from emp e
inner join dept d
on e.deptno=d.deptno;

--Display the list of employees, who have been with the company for more than 5 years.

select e.*,datediff(yy,HireDate,'1992') as [Difference in years]
from emp e
where datediff(yy,HireDate,'1992')>5


--Display the names of the departments that are not assigned to any employee.

exec sp_columns emp
select dname as [Name of department] from dept d
left outer join 
emp e on d.deptno=e.deptno
where e.deptno is null;


select ename from emp;
--Display the list of employees by combining the first two characters and last two characters.
select concat(LEFT ( ename , 2 ),right(ename,2) ) from emp;

--Calculate the total salary for each employee. That should INCLUDE commission too.
exec sp_columns emp
select sal  +CAST(CAST(com AS float) AS decimal(36, 20)) as [Total Salary with commission]
from emp;
--Display all the employees from department 30 whose salary is less than maximum salary of department 20. 

select * from emp where deptno=30 and sal
<
(

select max(sal) from emp where deptno=20)

--Displays all the employees who are drawing same salaries.

with rte
as
(
select empno,ename,job,deptno,sal,com ,dense_rank() over (order by sal) as [ran]
from emp
)
select r1.empno,r1.ename,r1.job,r1.deptno,r1.sal,r1.com,r1.[ran]
from rte r1 
inner join rte r2
on r1.ran=r2.ran
and r1.empno<>r2.empno ;


--Display all the employees who are drawing maximum salaries in each location.


select a.Salary,a.Locat
 from 
(select max(sal) as [Salary],loc as [Locat]
from emp e 
inner join dept d
on e.deptno=d.deptno
group by loc
)a


select distinct loc as [Locat],max(sal) over(partition by loc) as [Salary]
from emp e 
inner join dept d
on e.deptno=d.deptno;


select distinct ename as [Name],loc as [Region],max(sal) over(partition by loc) as [Salary]
from emp e 
inner join dept d
on e.deptno=d.deptno
where sal in 
(
select a.Salary
 from 
(select max(sal) as [Salary],loc as [Locat]
from emp e 
inner join dept d
on e.deptno=d.deptno
group by loc
)a)
order by [Salary] asc;

select max(sal) as [Salary],loc as [Locat]
from emp e 
inner join dept d
on e.deptno=d.deptno
group by loc;

--Display the 5th highest paid employee

with pte
as
(
select ename as [Name],sal as [Salary],dense_rank() over(order by sal desc)[ran]
from emp
)
select * from pte where [ran]<5;
--Display the top 5 employees wrt salary.

select top 5* 
from emp
order by sal desc


