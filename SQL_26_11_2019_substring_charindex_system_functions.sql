select *from Person.EmailAddress

select CHARINDEX('@',EmailAddress,1) [@ located at]from Person.EmailAddress

select SUBSTRING(EmailAddress,CHARINDEX('@',EmailAddress,1)+1,len(EmailAddress)-CHARINDEX('@',EmailAddress,1))
from Person.EmailAddress
select *from Person.EmailAddress
select SUBSTRING(EmailAddress,1,CHARINDEX('@',EmailAddress,1)-1) as [Email Address without domain],SUBSTRING(EmailAddress,CHARINDEX('@',EmailAddress,1)+1,len(EmailAddress)-CHARINDEX('@',EmailAddress,1)) as [Domain Name]
from Person.EmailAddress

select SUBSTRING(EmailAddress,1,2)+REPLICATE('*',5)+SUBSTRING(EmailAddress,CHARINDEX('@',EmailAddress,1)+1,len(EmailAddress)-CHARINDEX('@',EmailAddress,1))[Masking]
from Person.EmailAddress

select distinct left(EmailAddress,2)
+REPLICATE('*',5)+SUBSTRING(EmailAddress,CHARINDEX('@',EmailAddress,1)+1,len(EmailAddress)-CHARINDEX('@',EmailAddress,1))[Masking]
from Person.EmailAddress


select concat(FirstName,Space(5),MiddleName)
from Person.Person


select EmailAddress,REPLACE(EmailAddress,'.com','.net')
 from Person.EmailAddress

 select EmailAddress,PATINDEX('%@aaa%',EmailAddress)
 from Person.EmailAddress
