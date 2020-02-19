select * from INFORMATION_SCHEMA.TABLES
--select * from INFORMATION_SCHEMA.COLUMNS
SELECT 
    FK = fk.name, 
    FKTable = QUOTENAME(OBJECT_SCHEMA_NAME(fkcol.[object_id])) 
        + '.' + QUOTENAME(OBJECT_NAME(fkcol.[object_id])),
    FKCol = fkcol.name,
    ' references => ',
    PKTable = QUOTENAME(OBJECT_SCHEMA_NAME(pkcol.[object_id])) 
        + '.' + QUOTENAME(OBJECT_NAME(pkcol.[object_id])),
    PKCol = pkcol.name
FROM sys.foreign_keys AS fk
INNER JOIN sys.foreign_key_columns AS fkc
ON fk.[object_id] = fkc.constraint_object_id
INNER JOIN sys.columns AS fkcol
ON fkc.parent_object_id = fkcol.[object_id]
AND fkc.parent_column_id = fkcol.column_id
INNER JOIN sys.columns AS pkcol
ON fkc.referenced_object_id = pkcol.[object_id]
AND fkc.referenced_column_id = pkcol.column_id
ORDER BY fkc.constraint_column_id;