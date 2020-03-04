use StackOverflow
print EOMONTH(getdate())
print DATENAME(WEEKDAY,EOMONTH(getdate()))

go
declare @moneda float =34.343
select format(@moneda,'c4','de-de') as Moneda
select FORMAT(@moneda,'p0') as [Percent]
--CREANDO UNA TABLA DE JSON's
go
select jsonfile.* from 
			OPENROWSET(BULK N'D:\User\CSCmd\Udemy\CrudDatabase\jsonfile.json', SINGLE_CLOB) as m
			CROSS APPLY OPENJSON(BulkColumn)	WITH(
				usuario varchar(20) '$.Usuario',
				descripcion varchar(20) '$.PWD',
				descripcion1 varchar(20) '$.LastConnection',
				descripcion3 varchar(20) '$.NickNames'
			) as jsonfile

go
alter table [Persona].[users]
	add constraint unique_user UNIQUE([nombre])
select* from [Persona].[users]
declare @lastId table(nombre varchar(20));
insert into Persona.users(nombre,pwd) output INSERTED.nombre into @lastId values('codege98','87765r3322'),('Carla Kodaline','peruu876332')
select nombre from @lastId
go
execute as user='dbo'
DENY UNMASK TO angie
go
select * from Persona.users order by nombre asc OFFSET 3 ROWS OFFSET 3 ROWS  fetch next 3 rows only
go
declare @letra varchar(max)=(select * from Persona.users FOR JSON PATH)
print @letra
go
---VALOES ESPECIALES
GO
--selecciona elemntos indicado en el prier indice
SELECT CHOOSE(1,'hola','mundo','kodaline','') as Palabra
--selecciona el primer elemnto not null
select COALESCE(NULL,NULL,NULL,'carla',NULL,'codege') as FirstNotNull
go
declare @letra varchar(100);
declare @numero int=0;
select @letra= COALESCE(@letra+',','') + U.nombre from Persona.users as U
print @letra
go
declare @gg int;
print COALESCE(NULL,@gg,null)
go
select*,STUFF(pwd,2,5,'*******') as StuffedPassword from [Persona].[users]

create type Tabla01 as TABLE(
   texto varchar(100)
   )
declare @tabla Tabla01;
insert into @tabla values('holaaa'),('Como estas')
use StackOverflow
select * from @tabla
select u.nombre,u.pwd into myTable from Persona.users as u
select*from myTable
GO
--DELETE [dbo].[myTable] WHERE EXISTS(SELECT*FROM )