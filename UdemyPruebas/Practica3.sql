--Practica 3
select * , (
	select idPaciente as PacienteID from [dbo].[TurnoPaciente] as TP where TP.idTurno= T.idTurno
	)from	[dbo].[Turno] as T

USE AdventureWorks2017
SELECT * FROM [Person].[Address]
--STARTING PRACTICE 3
go
use Life
SELECT * FROM [dbo].[Usuario] AS U
	inner join [dbo].[InformacionUsuario] as I
	on U.idUsuario=I.idUsuario

SELECT U.* FROM [dbo].[Usuario] AS U
	LEFT JOIN [dbo].[InformacionUsuario] as I
	ON U.idUsuario= I.idUsuario
WHERE I.idUsuario IS  NULL

--
SELECT I.* 
		FROM [dbo].[Usuario] as U
		RIGHT JOIN [dbo].[InformacionUsuario] AS I
		ON U.idUsuario =I.idUsuario
WHERE U.idUsuario IS NULL
--CREAR PROCEDURES
GO
CREATE PROCEDURE Select_pacientes(
	@idPaciente int )
as
set nocount on

select * from Paciente	AS P
				INNER JOIN TurnoPaciente as TP ON TP.idPaciente= P.idPaciente
				INNER JOIN Turno as T ON T.idTurno= TP.idTurno
				INNER JOIN MedicoEspecialidad ME ON ME.idMedico= TP.idMedico
WHERE P.idPaciente= @idPaciente


go
execute Select_pacientes 2
select * from  [dbo].[HistoriaPaciente]
select * from [dbo].[Medico]
insert into [dbo].[HistoriaPaciente] values(1,2,12)
go
--crear procedure Pra obtener  historia del paciente
ALTER PROCEDURE getHistoria(@idPaciente int )
as
set nocount on
	select P.nombre,H.idHistoria,H.fechaHistoria,H.observacion,M.nombre from [dbo].[Paciente] as P 
		INNER JOIN [dbo].[HistoriaPaciente] AS HP ON P.idPaciente= HP.idPaciente
		INNER JOIN [dbo].[Historia] AS H ON H.idHistoria= HP.idHistoria
		INNER JOIN [dbo].[Medico] as M on M.idMedico=HP.idMedico
	where P.idPaciente= @idPaciente;
GO
EXECUTE getHistoria 2
GO
CREATE PROCEDURE obtenerEspMedico(@idMedico int)
as
set nocount on
	SELECT * FROM [dbo].[Medico] as M
			INNER JOIN [dbo].[MedicoEspecialidad] AS ME on ME.idMedico=M.idMedico
			INNER JOIN [dbo].[Especialidad] AS E ON ME.idEspecialidad= E.idEspecialidad
	WHERE M.idMedico=@idMedico
go
execute obtenerEspMedico 12
update [dbo].[Medico] set idEspecialidad=3 where idMedico=12
select * from Paciente
go
alter PROCEDURE updatePaciente(
	@idPaciente int,
	@apellido varchar(20),
	@count int output)
as
set nocount on
	
	if exists(select*from Paciente where idPaciente=@idPaciente)
		begin
		begin transaction 
		update Paciente set apellido=@apellido where idPaciente=@idPaciente
		if @@rowcount <>1
			begin
			rollback transaction
			set @count=-1
			end
		else
			begin
			commit transaction
			select @count=count(idPaciente) from Paciente;
			end
		end
	else 
		set @count=-1
	
go
select*from Paciente
declare @count int =0;
execute updatePaciente '78',@apellido='jhomara' ,@count= @count output
select @count as CantidadPacientes
