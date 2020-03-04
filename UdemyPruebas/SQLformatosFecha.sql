
--funciones GETDATE() y GETUTCDATE()
select getdate() as FechaActual, getutcdate() as FechaUTC
go
--funciones DATEADD(TIPO_PARAMETRO_FECHA,CANTIDAD,FECHA);
declare @fecha smalldatetime=getdate();
select DATEADD(DAY,12,@fecha) as fECHA
--funcion DATEDIFF resta dos fechas
go
declare @fecha datetime=getdate();
select datediff(month,'2000-12-12',@fecha)
go
--funcion DATEPART nos dvuelve una parte espcifica de la fecha
select DATEPART(day,getdate()) as DiaDeHoy 
--funcion isDATE
go
declare @fecha date='2000-12-23';
if ISDATE('2001-2-1')= 1
	PRINT 'ES FECHA'
else
	print 'No es una fecha'
go
--CAST or CONVERT datatypes
---> CAST(@valor AS DATA_TYPE) return vale_type
---> CONVERT 
DECLARE @numero money=234.456;
PRINT CAST(@numero as int)
PRINT CONVERT(INT,@numero)
select * from [dbo].[Especialidad]
select CAST([idEspecialidad] as money) as idMoney from [dbo].[Especialidad]


--Fechas con Formato
go
declare @fecha date=getdate();
PRINT CONVERT(VARCHAR(20),@fecha,110)
print convert(varchar(20),@fecha,111)
print convert(varchar(20),@fecha,112)
/*
formato
110--> YYYY-MM-DD
111--> YYYY/MM/DD
112--> YYYYMMDD
*/