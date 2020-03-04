USE Northwind
ALTER TABLE  [dbo].[Pacientes] ADD CONSTRAINT FK_IDPaciente FOREIGN KEY([ID_paciente]) 
	REFERENCES CitaMedica([ID_paciente]);
	--alterar tabla de Cias medicas para aceptar llaves foraneas
--ALTER TABLE [dbo].[CitaMedica] ADD CONSTRAINT PK_IDcita PRIMARY KEY([ID_cita]) 
ALTER TABLE [dbo].[CitaMedica] 
	DROP CONSTRAINT [PK_CitaMedica]

ALTER TABLE[dbo].[Pacientes] DROP CONSTRAINT [FK_IDPaciente]

ALTER TABLE [dbo].[Pacientes] ADD CONSTRAINT PK_IDpaciente PRIMARY KEY([ID_paciente]);
ALTER TABLE [dbo].[CitaMedica] ADD CONSTRAINT FK_angieee