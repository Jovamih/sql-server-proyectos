---TABLAS TEMPORALES
go
-- TABLA TEMPORAL EN MEMORIA
declare @tabla table (idPais int IDENTITY(1,1),pais varchar(20) )
						
insert into @tabla values('Argentina')
insert into @tabla values('PERU')
insert into @tabla values('venezuela')
insert into @tabla values('colombia')
insert into @tabla values('Bolivia')

select* from @tabla
go
--TABLA TEMPORAL FISICA	------------------------------------------------------
CREATE TABLE #tempTable (id int identity(1,1), nombre varchar(20))
insert into #tempTable 
	select U.nombre from Usuario as U
			INNER JOIN InformacionUsuario as I ON U.idUsuario=I.idUsuario

select*from #tempTable
delete from #tempTable where id=3
------------------------------------------------------------------------------
select I.*,P.nameProfesion from InformacionUsuario as I
			INNER JOIN Profesiones as P ON I.idProfesion=P.idProfesion