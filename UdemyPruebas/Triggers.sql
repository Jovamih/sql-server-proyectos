SELECT*FROM [dbo].[Paciente]

GO
CREATE TABLE PacientesDeleted(
	[idPaciente] int,
[nombre] varchar(20),
[fechaNacimiento]date,
[domicilio] varchar(20),
[idPais] char(3),
[telefono] varchar(20),
[Email] varchar(30),
[observacion] varchar(50),
[Dni] char(8)
)


GO
-----------USE Life---------
CREATE TRIGGER dbo.UsersDeleted
		ON [dbo].[Paciente]
AFTER DELETE
AS BEGIN
	SET NOCOUNT ON
	INSERT   into [dbo].[PacientesDeleted] 
		select d.[idPaciente], d.[nombre],d.[fechaNacimiento],d.[domicilio],d.[idPais],d.[telefono],d.[Email],d.[observacion],d.[Dni]from deleted as d
END
go
DELETE FROM Paciente where idPaciente=2
SELECT*FROM PacientesDeleted
select*from Paciente
UPDATE [dbo].[Paciente] set Dni=32344229 where idPaciente=3
CREATE TABLE usersKey(idUser int,pin int);
go

CREATE TRIGGER usersKeylogger	ON [dbo].[Usuario]
				AFTER	INSERT
AS BEGIN
	INSERT INTO usersKey
		SELECT I.idUsuario,I.pass FROM inserted as I
END
---
go
sp_help Usuario
select*from Usuario
select*from usersKey
go
alter procedure agregarUsuario(
		@nombre varchar(20),
		@password varchar(20))
as begin
set nocount on
	IF NOT EXISTS(SELECT* FROM [dbo].[Usuario] where nombre=@nombre)
		INSERT INTO [dbo].[Usuario] VALUES(@nombre,@password)
	ELSE
		print 'Ya existe un usuario registrado con el mismo nombre'
END
go
execute agregarUsuario 'Isabel',998753

use master
go

----------------TRIGGER practice
CREATE TRIGGER TriggerupdatePaciente	ON Paciente	
				AFTER UPDATE
AS BEGIN
	SET NOCOUNT ON
	SELECT*FROM inserted
	select*from deleted
END
go
--- ACTUALIZAR PACIENTE
select*from Paciente
update Paciente set telefono=009988679 where idPaciente=4
go
DISABLE TRIGGER [TriggerupdatePaciente] ON [dbo].[Paciente]
go
ENABLE TRIGGER [TriggerupdatePaciente] ON [dbo].[Paciente]

SELECT*FROM SYS.TRIGGERS
print convert(datetime,getdate(),111)
declare
print concat('hola',getdate(),' que pasoo')

