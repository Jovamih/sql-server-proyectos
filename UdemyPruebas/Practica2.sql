use Life
alter table [dbo].[Paciente]
	add Dni char(8) UNIQUE
	go
CREATE PROCEDURE insertarPaciente(
	@nombre varchar(20),
	 @apellido varchar(20),
	@fecha date,
	@domicilio varchar(20),
	@idPais char(30),
	@telefono varchar(2),
	@email varchar(30),
	@observacion varchar(50),
	@dni char(8)
	)
	AS
BEGIN
IF NOT EXISTS(SELECT * FROM [dbo].[Paciente] where Dni= @dni)
	INSERT INTO [dbo].[Paciente] 
				([nombre],[apellido],[fechaNacimiento],[domicilio],[idPais],[telefono],[Email],[observacion],[Dni])
			VALUES (@nombre,@apellido,@fecha,@domicilio,@idPais,@telefono,@email,@observacion,@dni);
ELSE 
	print 'ya existe un usuario registrado, por seguridad no se actualizaron los datos  '
END
GO
EXEC insertarPaciente 'carla','kodaline', '1990-12-30','SJM','PER','099378273','kodaline@hotmail.com','Activa','89435527' 

select * from [dbo].[Paciente]
UPDATE [dbo].[Paciente] SET [domicilio]='SJM' WHERE [Dni]='74804782'
select [idPais], count([idPaciente]) AS Cantidad from [dbo].[Paciente] group by [idPais]

--Stored Prodedure para insertar turnos
alter table [dbo].[Turno]
	alter column [fechaTurno] smalldatetime
go
CREATE PROCEDURE insertarTurno (
	@idTurno char(10),
	@fecha smalldatetime,
	@estado smallint,
	@observacion varchar(50) )
	AS
BEGIN
print 'despues lo implemento'
END

GO
--select * from [dbo].[Medico]
--sp_help Medico
--DELETE FROM [dbo].[Medico] WHERE idMedico IN (9,10)
SELECT * FROM Medico
GO
ALTER TABLE [dbo].[Medico] 
	ADD  idEspecialidad int
GO
CREATE PROCEDURE insertarMedico(
	@nombre varchar(30),
	@correo varchar(30),
	@Edad int,
	@idEspecialidad int,
	@descripcion varchar(50)
	)
	--SET NOCOUNT ON
AS
BEGIN
SET NOCOUNT ON
IF NOT EXISTS(SELECT TOP 1 idMedico FROM [dbo].[Medico] where nombre=@nombre)
	begin
	INSERT INTO [dbo].[Medico] ([nombre],[correo],[Edad])
			VALUES (@nombre,@correo,@Edad);
	DECLARE @idMedico int
	set @idMedico =@@IDENTITY;
	INSERT INTO [dbo].[MedicoEspecialidad] values (@idMedico,@idEspecialidad,@descripcion)
	print 'Medico agregado correctamente'
	END
ELSE
print 'ya existe un medico registrado con el mismo nombre'
END
GO

CREATE TABLE Especialidad(
	idEspecialidad INTEGER CHECK(idEspecialidad>0),
	especialidad varchar(50) UNIQUE not null,
	CONSTRAINT PK_idEspecilidad primary key(idEspecialidad)
	)
go
CREATE TABLE MedicoEspecialidad
	(
	idMedico int CHECK(idMedico>0) not null,
	idEspecialidad int not null,
	descripcion varchar(30) not null,
    CONSTRAINT FK_idMedico_Medico FOREIGN KEY(idMedico) REFERENCES Medico (idMedico),
	CONSTRAINT fk_isEspecialidad FOREIGN KEY(idEspecialidad) references Especialidad(idEspecialidad)
	)
--procedimiento Agregar especialidad
EXEC insertarEspecialidad 11, 'Odontologia'
--procedimiento insertar medico
EXEC insertarMedico 'angie','angiee_abanto.com',18,3,'casi ausente'
--delete from Medico where nombre='angie'
go
select* from Medico
select* from MedicoEspecialidad
GO
CREATE PROCEDURE insertarEspecialidad(
	@idEspecialidad int,
	@especialidad varchar(50)
	)
AS
BEGIN
SET NOCOUNT ON
	IF NOT EXISTS(SELECT*FROM [dbo].[Especialidad] WHERE [idEspecialidad]=@idEspecialidad or especialidad=@especialidad)
		begin
		INSERT INTO [dbo].[Especialidad] values(@idEspecialidad,@especialidad)
		print 'Especialidad agregada correctamente'
		end
	ELSE
		print 'la especialiad ya se encuentra registrada'
END	