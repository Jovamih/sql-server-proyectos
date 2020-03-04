USE Life
USE Northwind
go
----------
CREATE FUNCTION DateToChar(@fecha datetime)
		RETURNS varchar(20)
AS BEGIN
	DECLARE @fechaConvert varchar(20);
	SET @fechaConvert= convert(varchar(20),@fecha)
	RETURN @fechaConvert;
END
go
/*
convert(type(length),datetime,type_format)

type_format:
110: 2000-12-23
111:200/12/23
112:	20001223
113: Dec 12 2000 23.34:32.3465
114: 23:34:32.2333
120: 2000-12-23 23:34:32
121: 2000-12-23 23:34:32.5885
*/
go
use Life
select *, 'hola' as Saludo from Paciente where apellido LIKE 'jho%'
update Paciente set telefono= '993224901' where idPaciente=3
go

select * from [dbo].[Usuario]
create table LastActivity(
		idUsuario int UNIQUE CHECK(idUsuario>0),
		lastConnection datetime,
		CONSTRAINT FK_idUsuario_LastActivity FOREIGN KEY(idUsuario) REFERENCES Usuario(idUsuario)
		)

	go
select * from LastActivity
ALTER TABLE LastActivity
	ADD CONSTRAINT zero_default_Estado DEFAULT (0) FOR Estado
insert into LastActivity values(9,'2011-07-29')
go
alter TRIGGER userActivity	ON [dbo].[InformacionUsuario]
			AFTER UPDATE
AS BEGIN
set nocount on
		declare @idUsuario int = (select E.idUsuario from inserted as E);
		
		IF EXISTS(SELECT * FROM LastActivity as I where I.idUsuario= @idUsuario )
			UPDATE LastActivity SET lastConnection =getdate(), Estado=1 where idUsuario=@idUsuario
		ELSE
			INSERT INTO LastActivity (idUsuario,lastConnection,Estado)VALUES(@idUsuario,getdate(),1)	
		
END
go
select*from [dbo].[InformacionUsuario]
select * from Usuario
go
update InformacionUsuario set edad=35 where idUsuario=10
update LastActivity SET Estado=1 where idUsuario=10
select * from LastActivity
go
UPDATE LastActivity SET Estado=0 where idUsuario=1
go
print datediff(month, '2000-12-12',getdate())
go
---ESTO VA EN UN SCHEDULES JOB
UPDATE LastActivity SET Estado=0 where DATEDIFF(day,lastConnection,getdate())>=4
go
alter VIEW VIEW_UsuariosActivos
AS 
  SELECT U.nombre,L.* FROM Usuario as U 
			INNER JOIN LastActivity AS L ON L.idUsuario=U.idUsuario
go
select*from VIEW_UsuariosActivos
go
select*from dbo.Historia
select*from dbo.HistoriaPaciente
go