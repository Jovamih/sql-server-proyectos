print getdate()
declare @dato smalldatetime= getdate();

print convert(varchar(20),getdate(),111)

GO
BACKUP DATABASE Northwind
TO DISK='D:\User\SQLproyectos\BackupSQL\NorthwindPRO.bak'
WITH NO_COMPRESSION,
NAME='NorthwindPRO365'
go

---------schedules JOBS en backup
--print getdate()
declare @name varchar(20) ='LifePRO'
declare @fecha  varchar(30)= convert(varchar(30),convert(date,getdate()))
declare @ruta varchar(100)='D:\User\SQLproyectos\BackupSQL\';
declare @fullname varchar(40)=@name+'-'+replace(@fecha,' ','-')+'.bak'
PRINT @fullname
declare @fullruta varchar(200)=@ruta+@fullname
print @fullruta
BACKUP DATABASE Life
TO DISK= @fullruta
WITH NO_COMPRESSION,CHECKSUM
--NAME=@name;
go
BACKUP DATABASE Life
TO DISK='D:\User\SQLproyectos\BackupSQL\Life.bak'
WITH NO_COMPRESSION,CHECKSUM,
NAME='LifePRO365'