--TargetTable_Mapping
--Session_Time
--InfaList_P
/**select l.[Folder Name],l.[Workflow Name],l.[Session Name],l.[Source Connection Name],l.[Source Connection Type1],l.[Source connection type]
,l.[Session Avg Target Row Count],l.[Frequency]
from dbo.InfaList_P l*/

--select * from dbo.TargetTable_Mapping

--exec sp_columns Session_Time
--select st.[Mapping Name],st.[Session Name],st.[End Time] 
--from  Session_Time st
exec sp_columns infaList_P



select distinct tt.[SUBJECT_AREA],tt.[TARGET_NAME],tt.[MAPPING_NAME],--155
l.[Folder Name],l.[Workflow Name],l.[Session Name],l.[Source Connection Name],l.[Source Connection Type1],l.[Source connection type]
,l.[Session Avg Target Row Count],l.[Frequency],
st.[Mapping Name],st.[Session Name],st.[End Time],
l.[Target connection type],
l.[Target Connection Name],
l.[Target Connection Type1]
from dbo.TargetTable_Mapping tt--Target
join dbo.Session_Time st
on  tt.[MAPPING_NAME]=st.[Mapping Name]
join dbo.InfaList_P l
on l.[Folder Name]= tt.[SUBJECT_AREA]
and l.[Session Name]=st.[Session Name]--230 rows
--where tt.[SUBJECT_AREA]<>'WESTMART_PROD' 95
order by tt.[SUBJECT_AREA],tt.[TARGET_NAME],tt.[MAPPING_NAME],l.[Session Name]


select distinct tt.[TARGET_NAME]-- 40 rows
from dbo.TargetTable_Mapping tt--Target
join dbo.Session_Time st
on  tt.[MAPPING_NAME]=st.[Mapping Name]
join dbo.InfaList_P l
on l.[Folder Name]= tt.[SUBJECT_AREA]
and l.[Session Name]=st.[Session Name]
--where tt.[SUBJECT_AREA] ='WESTMART_PROD' 40 rows


select distinct tt.[TARGET_NAME]-- 44 rows
from dbo.TargetTable_Mapping tt

(select distinct tt.[TARGET_NAME]-- 44 rows
from dbo.TargetTable_Mapping tt
except
select distinct tt.[TARGET_NAME]-- 40 rows
from dbo.TargetTable_Mapping tt--Target
join dbo.Session_Time st
on  tt.[MAPPING_NAME]=st.[Mapping Name]
join dbo.InfaList_P l
on l.[Folder Name]= tt.[SUBJECT_AREA]
and l.[Session Name]=st.[Session Name])--4 rows

select distinct tt.[TARGET_NAME]-- 41 rows
from dbo.TargetTable_Mapping tt
join dbo.Session_Time st
on  ltrim(tt.[MAPPING_NAME])=ltrim(st.[Mapping Name])
left join dbo.InfaList_P l
on l.[Folder Name]= tt.[SUBJECT_AREA]
and l.[Session Name]=st.[Session Name]

select distinct tt.[TARGET_NAME]-- 40 rows
from dbo.TargetTable_Mapping tt
left join dbo.Session_Time st
on  ltrim(tt.[MAPPING_NAME])=ltrim(st.[Mapping Name])
join dbo.InfaList_P l
on l.[Folder Name]= tt.[SUBJECT_AREA]
and l.[Session Name]=st.[Session Name]

select distinct tt.[TARGET_NAME]-- 44 rows
from dbo.TargetTable_Mapping tt
left join dbo.Session_Time st
on  ltrim(tt.[MAPPING_NAME])=ltrim(st.[Mapping Name])
left join dbo.InfaList_P l
on l.[Folder Name]= tt.[SUBJECT_AREA]
and l.[Session Name]=st.[Session Name]




