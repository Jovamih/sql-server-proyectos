CREATE PROCEDURE sp_employeesForName(
	@name varchar(20)
	)
AS
SELECT * FROM  [dbo].[Employees] where [FirstName] LIKE '%'+@name+'%'
GO

EXEC sp_employeesForName 'a'
GO
CREATE PROCEDURE sp_agregarUsuario(
	@nombre varchar(20),
	@pass varchar(20)
	)
AS
	IF NOT EXISTS (SELECT * FROM [dbo].[Usuario] WHERE [nombre]=@nombre)
	BEGIN
	INSERT INTO [dbo].[Usuario] ([nombre],[pass]) VALUES (@nombre,@pass)
	END

GO 
EXEC sp_agregarUsuario 'carla','365avira0'
SELECT * FROM [dbo].[Usuario]
SELECT * FROM [dbo].[InformacionUsuario]
GO
alter PROCEDURE sp_agregarInformacionUsuario(
	@idUsuario INTEGER,
	@nombreCompleto varchar(20),
	@edad int,
	@dni char(8),
	@idProfesion int )
AS
SET NOCOUNT ON
IF EXISTS(SELECT* FROM [dbo].[Usuario] WHERE idUsuario=@idUsuario)
	BEGIN
	IF NOT EXISTS (SELECT * FROM [dbo].[InformacionUsuario] where[idUsuario]=@idUsuario )
		INSERT INTO [dbo].[InformacionUsuario] VALUES (@idUsuario,@nombreCompleto,@edad,@dni,@idProfesion)
	ELSE
	PRINT 'EL USUARIO YA TIENE INFORMACION REGISTRADA'
	END
ELSE
	BEGIN
	PRINT 'El usuario NO existe en el registro pincipal, intente registrarlo primero y luego edite su infomacion personal'
	END

go

EXEC sp_agregarInformacionUsuario 4,'Usuario anonimo',21,'74433782',4
GO
SELECT * FROM [dbo].[InformacionUsuario]
DELETE FROM [dbo].[InformacionUsuario] WHERE idUsuario=4 
go
--procedimientos almacenados-- declaraciion de variables
DECLARE @saludo varchar(20)='como estas?'
DECLARE @SaludoAngie varchar(20) 
--SET @saludo='ok'
--go
--no existe SELECT @saludo as saludo
--Uso de la funcion ISNULL()
PRINT ISNULL(@SaludoAngie,'NO HA SALUDADO')
--uso de subconsultas y alias
--creamos un procedure
GO
alter PROCEDURE mostrarUsuarios
	AS
	SET NOCOUNT ON
	BEGIN
	SELECT * ,
		(SELECT [nameProfesion] from [dbo].[Profesiones] prof WHERE prof.idProfesion= inf.idProfesion) as Profesion
		FROM [dbo].[InformacionUsuario] inf
	end
go
--procedure
exec mostrarUsuarios
