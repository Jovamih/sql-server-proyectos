--ROLES
--Roles del sistema| Roles del Servidor | Roles de Usuario
--->			Verificar el usuario que uso
select user as Usuario
-->			Crear login desde Transact-SQL 
CREATE  LOGIN angieabanto	
		with PASSWORD ='angieabanto'
--->Crear usuario desde
CREATE USER angiee FOR LOGIN angieabanto
			
--->crear roles de la base de datos
CREATE ROLE RolPrueba AUTHORIZATION dbo

use Life
select*from[dbo].[LastActivity]
go
DISABLE TRIGGER [usersKeylogger] ON [dbo].[Usuario]