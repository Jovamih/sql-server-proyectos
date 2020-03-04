--CREACION DE VISTAS
use Life
select * from Usuario
select*from InformacionUsuario
go
ALTER VIEW UsuariosRegistered AS
	SELECT Usuario.*,Informacion.nombreCompleto,Informacion.edad,Informacion.dni,Profesiones.nameProfesion from [dbo].[Usuario] as Usuario
				  INNER JOIN [dbo].[InformacionUsuario] as Informacion
				  ON Usuario.idUsuario=Informacion.idUsuario
				  INNER JOIN dbo.Profesiones AS Profesiones
				  ON Informacion.idProfesion=Profesiones.idProfesion
			

select*from UsuariosUnregistered
--drop view [dbo].[UsuariosUnregistered]
go