CREATE SEQUENCE Persona.customID
AS INT
	START WITH 10001
	INCREMENT BY 1
	MINVALUE -1;
go
CREATE TABLE Persona.Registro(
	idUser int DEFAULT(NEXT VALUE FOR Persona.customID) NOT NULL,
	Nombre varchar(20) NOT NULL,
	Edad int not null,
	Correo varchar(20)
)
go
ALTER TABLE [Persona].[Registro]
	ADD CONSTRAINT check_Edad CHECK(Edad>0)
go
INSERT INTO [Persona].[Registro] ([Nombre],[Edad],[Correo])values ('johan mitma',19,'avira365@hotmail.com')
select*from  [Persona].[Registro]
ALTER TABLE [Persona].[Registro]
		ADD CONSTRAINT unique_Nombre UNIQUE(Nombre)
go
