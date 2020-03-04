USE StackOverflow
CREATE SCHEMA Persona AUTHORIZATION angie
DROP SCHEMA Persona
select CURRENT_USER
REVOKE UNMASK TO angie
go
ALTER SCHEMA Persona
			TRANSFER [dbo].[users]
select * from Persona.Users
delete from Persona.users where idUser=2
select*from sys.schemas