
CREATE TABLE Usuario(
	idUsuario int IDENTITY(1,1) PRIMARY KEY NOT NULL ,
	nombre varchar(20) UNIQUE NOT NULL,
	pass varchar(20) NOT NULL
	)

CREATE TABLE InformacionUsuario(
	idUsuario int REFERENCES Usuario(idUsuario),
	nombreCompleto varchar(50) NOT NULL,
	edad INTEGER CHECK(edad>0) NOT NULL,
	dni char(8) NOT NULL,
	idProfesion int NOT NULL,
	CONSTRAINT FK_IDprofesion_profesiones FOREIGN KEY(idProfesion)
			REFERENCES Profesiones(idProfesion)
	)
GO
CREATE TABLE Profesiones(
	idProfesion int IDENTITY(1,1)PRIMARY KEY NOT NULL,
	nameProfesion varchar(20) NOT NULL
	)



