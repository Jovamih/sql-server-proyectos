USE [master]
GO
/****** Object:  Database [Life]    Script Date: 11/02/2020 22:29:15 ******/
CREATE DATABASE [Life]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Life', FILENAME = N'D:\User\SQLdatabases\Life.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'Delete', FILENAME = N'D:\Program Files (x86)\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Delete.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Life_log', FILENAME = N'D:\User\SQLdatabases\Life_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Life] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Life].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Life] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Life] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Life] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Life] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Life] SET ARITHABORT OFF 
GO
ALTER DATABASE [Life] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Life] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Life] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Life] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Life] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Life] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Life] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Life] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Life] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Life] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Life] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Life] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Life] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Life] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Life] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Life] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Life] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Life] SET RECOVERY FULL 
GO
ALTER DATABASE [Life] SET  MULTI_USER 
GO
ALTER DATABASE [Life] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Life] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Life] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Life] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Life] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Life', N'ON'
GO
ALTER DATABASE [Life] SET QUERY_STORE = OFF
GO
USE [Life]
GO
/****** Object:  User [angie]    Script Date: 11/02/2020 22:29:16 ******/
CREATE USER [angie] FOR LOGIN [angie] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [UsuarioPruebaRol]    Script Date: 11/02/2020 22:29:17 ******/
CREATE ROLE [UsuarioPruebaRol]
GO
ALTER ROLE [db_datareader] ADD MEMBER [angie]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [angie]
GO
/****** Object:  UserDefinedDataType [dbo].[medico]    Script Date: 11/02/2020 22:29:17 ******/
CREATE TYPE [dbo].[medico] FROM [int] NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[paciente]    Script Date: 11/02/2020 22:29:17 ******/
CREATE TYPE [dbo].[paciente] FROM [int] NOT NULL
GO
/****** Object:  UserDefinedTableType [dbo].[Tabla]    Script Date: 11/02/2020 22:29:17 ******/
CREATE TYPE [dbo].[Tabla] AS TABLE(
	[idTabla] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NULL,
	PRIMARY KEY CLUSTERED 
(
	[idTabla] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  UserDefinedFunction [dbo].[DateToChar]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[DateToChar](@fecha datetime)
		RETURNS varchar(20)
AS BEGIN
	DECLARE @fechaConvert varchar(20);
	SET @fechaConvert= convert(varchar(20),@fecha)
	RETURN @fechaConvert;
END
GO
/****** Object:  UserDefinedFunction [dbo].[obtenerPais]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--FUNCIONES---->Obtener Pais
CREATE FUNCTION [dbo].[obtenerPais](@idPaciente int)
	returns varchar(20)
as
	begin
	declare @nombre varchar(20)
	set @nombre =(select pa.nombre from Paciente AS P	
					INNER JOIN Pais as pa ON pa.idPais= P.idPais
				   where idPaciente= @idPaciente
					)

	return @nombre;
	end
GO
/****** Object:  UserDefinedFunction [dbo].[Potencia]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Potencia](@numero int,@potencia int)
	RETURNS INT
as

begin
	declare @resultado int =1;
	declare @count int=0;
	while @count < @potencia
		BEGIN
		set @resultado= @resultado*@numero;
		set @count= @count +1;
		END
	return @resultado;
end
GO
/****** Object:  UserDefinedFunction [dbo].[Suma]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Suma](@valor1 int , @valor2 int)
RETURNS int
AS

BEGIN
	DECLARE @valor int=0;
	SET @valor=@valor1+@valor2;
RETURN @valor;
END
GO
/****** Object:  UserDefinedFunction [dbo].[usersUnregistered]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[usersUnregistered]()
	returns @user Table 
	( idUsuario int,
	  nombre varchar(20),
	 pass varchar(20))					 
as
begin
	INSERT @user
		SELECT U.idUsuario,U.nombre,U.pass FROM [dbo].[Usuario] as U
				LEFT JOIN [dbo].[InformacionUsuario] AS I
				ON I.idUsuario=U.idUsuario
		WHERE I.idUsuario IS NULL
	return
end;
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](20) NOT NULL,
	[pass] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profesiones]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profesiones](
	[idProfesion] [int] IDENTITY(1,1) NOT NULL,
	[nameProfesion] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idProfesion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InformacionUsuario]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InformacionUsuario](
	[idUsuario] [int] NULL,
	[nombreCompleto] [varchar](50) NOT NULL,
	[edad] [int] NOT NULL,
	[dni] [char](8) NOT NULL,
	[idProfesion] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[UsuariosRegistered]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UsuariosRegistered] AS
	SELECT Usuario.*,Informacion.nombreCompleto,Informacion.edad,Informacion.dni,Profesiones.nameProfesion from [dbo].[Usuario] as Usuario
				  INNER JOIN [dbo].[InformacionUsuario] as Informacion
				  ON Usuario.idUsuario=Informacion.idUsuario
				  INNER JOIN dbo.Profesiones AS Profesiones
				  ON Informacion.idProfesion=Profesiones.idProfesion
			
GO
/****** Object:  View [dbo].[UsuariosPruebaRegistered]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UsuariosPruebaRegistered]
AS
SELECT        dbo.Usuario.idUsuario, dbo.InformacionUsuario.nombreCompleto, dbo.InformacionUsuario.edad, dbo.InformacionUsuario.dni, dbo.Profesiones.nameProfesion
FROM            dbo.Usuario INNER JOIN
                         dbo.InformacionUsuario ON dbo.Usuario.idUsuario = dbo.InformacionUsuario.idUsuario INNER JOIN
                         dbo.Profesiones ON dbo.InformacionUsuario.idProfesion = dbo.Profesiones.idProfesion
GO
/****** Object:  Table [dbo].[LastActivity]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LastActivity](
	[idUsuario] [int] NULL,
	[lastConnection] [datetime] NULL,
	[Estado] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VIEW_UsuariosActivos]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_UsuariosActivos]
AS
SELECT        U.nombre, L.idUsuario, L.lastConnection, L.Estado
FROM            dbo.Usuario AS U INNER JOIN
                         dbo.LastActivity AS L ON L.idUsuario = U.idUsuario
GO
/****** Object:  Table [dbo].[Activity]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Activity](
	[idActivity] [int] IDENTITY(1,1) NOT NULL,
	[actividad] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[idActivity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Especialidad]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Especialidad](
	[idEspecialidad] [int] NOT NULL,
	[especialidad] [varchar](50) NOT NULL,
 CONSTRAINT [PK_idEspecilidad] PRIMARY KEY CLUSTERED 
(
	[idEspecialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Historia]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Historia](
	[idHistoria] [int] IDENTITY(1,1) NOT NULL,
	[fechaHistoria] [datetime] NULL,
	[observacion] [varchar](50) NULL,
 CONSTRAINT [PK_Historia] PRIMARY KEY CLUSTERED 
(
	[idHistoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistoriaPaciente]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoriaPaciente](
	[idHistoria] [int] NULL,
	[idPaciente] [int] NULL,
	[idMedico] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Medico]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medico](
	[idMedico] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](30) NULL,
	[correo] [varchar](30) NULL,
	[Edad] [int] NULL,
	[idEspecialidad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[idMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicoEspecialidad]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicoEspecialidad](
	[idMedico] [int] NOT NULL,
	[idEspecialidad] [int] NOT NULL,
	[descripcion] [varchar](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Paciente]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paciente](
	[idPaciente] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](20) NULL,
	[apellido] [varchar](20) NULL,
	[fechaNacimiento] [date] NULL,
	[domicilio] [varchar](20) NULL,
	[idPais] [char](3) NULL,
	[telefono] [varchar](20) NULL,
	[Email] [varchar](30) NULL,
	[observacion] [varchar](50) NULL,
	[Dni] [char](8) NULL,
 CONSTRAINT [PK_Paciente] PRIMARY KEY CLUSTERED 
(
	[idPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PacientesDeleted]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PacientesDeleted](
	[idPaciente] [int] NULL,
	[nombre] [varchar](20) NULL,
	[fechaNacimiento] [date] NULL,
	[domicilio] [varchar](20) NULL,
	[idPais] [char](3) NULL,
	[telefono] [varchar](20) NULL,
	[Email] [varchar](30) NULL,
	[observacion] [varchar](50) NULL,
	[Dni] [char](8) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pagos]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pagos](
	[idPago] [int] IDENTITY(1,1) NOT NULL,
	[idPaciente] [int] NOT NULL,
	[concepto] [varchar](50) NULL,
	[fecha] [datetime] NULL,
	[monto] [money] NULL,
	[estado] [tinyint] NULL,
	[observacion] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[idPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pais](
	[idPais] [char](3) NOT NULL,
	[nombre] [varchar](15) NULL,
 CONSTRAINT [PK_Pais] PRIMARY KEY CLUSTERED 
(
	[idPais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Turno]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Turno](
	[idTurno] [nchar](10) NOT NULL,
	[fechaTurno] [smalldatetime] NULL,
	[estado] [smallint] NULL,
	[observacion] [varchar](50) NULL,
 CONSTRAINT [PK_Turno] PRIMARY KEY CLUSTERED 
(
	[idTurno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TurnoPaciente]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TurnoPaciente](
	[idTurno] [int] NOT NULL,
	[idPaciente] [int] NOT NULL,
	[idMedico] [int] NOT NULL,
 CONSTRAINT [PK_TurnoPaciente] PRIMARY KEY CLUSTERED 
(
	[idTurno] ASC,
	[idPaciente] ASC,
	[idMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userActions]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userActions](
	[idUsuario] [int] NULL,
	[idActivity] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userJSON]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userJSON](
	[idJSON] [int] IDENTITY(1,1) NOT NULL,
	[jsonfile] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[idJSON] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usersKey]    Script Date: 11/02/2020 22:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usersKey](
	[idUser] [int] NULL,
	[pin] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Activity] ON 

INSERT [dbo].[Activity] ([idActivity], [actividad]) VALUES (1, N'Actualizar Aplicacion')
INSERT [dbo].[Activity] ([idActivity], [actividad]) VALUES (2, N'Desinstalar aplicacion')
INSERT [dbo].[Activity] ([idActivity], [actividad]) VALUES (3, N'Desconectarse')
INSERT [dbo].[Activity] ([idActivity], [actividad]) VALUES (4, N'Stalkear')
INSERT [dbo].[Activity] ([idActivity], [actividad]) VALUES (5, N'Videollamada')
INSERT [dbo].[Activity] ([idActivity], [actividad]) VALUES (6, N'Chat')
INSERT [dbo].[Activity] ([idActivity], [actividad]) VALUES (7, N'Paypal')
SET IDENTITY_INSERT [dbo].[Activity] OFF
INSERT [dbo].[Especialidad] ([idEspecialidad], [especialidad]) VALUES (3, N'Industrial')
INSERT [dbo].[Especialidad] ([idEspecialidad], [especialidad]) VALUES (11, N'Odontologia')
INSERT [dbo].[Especialidad] ([idEspecialidad], [especialidad]) VALUES (4, N'Triaje')
SET IDENTITY_INSERT [dbo].[Historia] ON 

INSERT [dbo].[Historia] ([idHistoria], [fechaHistoria], [observacion]) VALUES (1, CAST(N'2000-12-01T00:00:00.000' AS DateTime), N'Interesante nacimiento')
SET IDENTITY_INSERT [dbo].[Historia] OFF
INSERT [dbo].[HistoriaPaciente] ([idHistoria], [idPaciente], [idMedico]) VALUES (1, 2, 12)
INSERT [dbo].[InformacionUsuario] ([idUsuario], [nombreCompleto], [edad], [dni], [idProfesion]) VALUES (1, N'Johan valerio', 19, N'74804782', 2)
INSERT [dbo].[InformacionUsuario] ([idUsuario], [nombreCompleto], [edad], [dni], [idProfesion]) VALUES (2, N'Elisa tello', 23, N'74833782', 1)
INSERT [dbo].[InformacionUsuario] ([idUsuario], [nombreCompleto], [edad], [dni], [idProfesion]) VALUES (4, N'amparo paez', 21, N'74433782', 4)
INSERT [dbo].[InformacionUsuario] ([idUsuario], [nombreCompleto], [edad], [dni], [idProfesion]) VALUES (5, N'angie abanto', 17, N'74895632', 2)
INSERT [dbo].[InformacionUsuario] ([idUsuario], [nombreCompleto], [edad], [dni], [idProfesion]) VALUES (6, N'ciudadano', 12, N'74805623', 2)
INSERT [dbo].[InformacionUsuario] ([idUsuario], [nombreCompleto], [edad], [dni], [idProfesion]) VALUES (7, N'Lily', 20, N'78990215', 4)
INSERT [dbo].[InformacionUsuario] ([idUsuario], [nombreCompleto], [edad], [dni], [idProfesion]) VALUES (9, N'Clara Montez', 19, N'45673412', 3)
INSERT [dbo].[InformacionUsuario] ([idUsuario], [nombreCompleto], [edad], [dni], [idProfesion]) VALUES (10, N'Marcelo paez', 35, N'45341290', 2)
INSERT [dbo].[LastActivity] ([idUsuario], [lastConnection], [Estado]) VALUES (1, CAST(N'2000-10-12T23:43:12.000' AS DateTime), 0)
INSERT [dbo].[LastActivity] ([idUsuario], [lastConnection], [Estado]) VALUES (4, CAST(N'2020-02-07T16:56:44.107' AS DateTime), 0)
INSERT [dbo].[LastActivity] ([idUsuario], [lastConnection], [Estado]) VALUES (7, CAST(N'2002-10-12T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[LastActivity] ([idUsuario], [lastConnection], [Estado]) VALUES (5, CAST(N'2020-02-07T17:06:11.487' AS DateTime), 0)
INSERT [dbo].[LastActivity] ([idUsuario], [lastConnection], [Estado]) VALUES (9, CAST(N'2011-07-29T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[LastActivity] ([idUsuario], [lastConnection], [Estado]) VALUES (10, CAST(N'2020-02-07T17:11:31.253' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Medico] ON 

INSERT [dbo].[Medico] ([idMedico], [nombre], [correo], [Edad], [idEspecialidad]) VALUES (1, N'Johan valerio', N'elllanoteama.com', 73, 1)
INSERT [dbo].[Medico] ([idMedico], [nombre], [correo], [Edad], [idEspecialidad]) VALUES (2, N'Antonella', N'activa10/10.com', 23, 3)
INSERT [dbo].[Medico] ([idMedico], [nombre], [correo], [Edad], [idEspecialidad]) VALUES (6, N'mark', N'facebokk@hotmail.com', 90, 2)
INSERT [dbo].[Medico] ([idMedico], [nombre], [correo], [Edad], [idEspecialidad]) VALUES (7, N'mark', N'facebokk@hotmail.com', 12, 4)
INSERT [dbo].[Medico] ([idMedico], [nombre], [correo], [Edad], [idEspecialidad]) VALUES (8, N'mark', N'facebokk@hotmail.com', 33, 4)
INSERT [dbo].[Medico] ([idMedico], [nombre], [correo], [Edad], [idEspecialidad]) VALUES (12, N'angie', N'angiee_abanto.com', 18, 3)
INSERT [dbo].[Medico] ([idMedico], [nombre], [correo], [Edad], [idEspecialidad]) VALUES (13, N'ANGELA', N'kodaline@234', 22, 1)
INSERT [dbo].[Medico] ([idMedico], [nombre], [correo], [Edad], [idEspecialidad]) VALUES (14, N'12', N'332', 3239, 88)
INSERT [dbo].[Medico] ([idMedico], [nombre], [correo], [Edad], [idEspecialidad]) VALUES (15, N'12', N'332', 3239, 88)
INSERT [dbo].[Medico] ([idMedico], [nombre], [correo], [Edad], [idEspecialidad]) VALUES (16, N'12', N'332', 3239, 88)
INSERT [dbo].[Medico] ([idMedico], [nombre], [correo], [Edad], [idEspecialidad]) VALUES (17, N'12', N'332', 3239, 88)
INSERT [dbo].[Medico] ([idMedico], [nombre], [correo], [Edad], [idEspecialidad]) VALUES (18, N'12', N'332', 3239, 88)
SET IDENTITY_INSERT [dbo].[Medico] OFF
INSERT [dbo].[MedicoEspecialidad] ([idMedico], [idEspecialidad], [descripcion]) VALUES (12, 3, N'casi ausente')
INSERT [dbo].[MedicoEspecialidad] ([idMedico], [idEspecialidad], [descripcion]) VALUES (2, 3, N'Insteresante')
SET IDENTITY_INSERT [dbo].[Paciente] ON 

INSERT [dbo].[Paciente] ([idPaciente], [nombre], [apellido], [fechaNacimiento], [domicilio], [idPais], [telefono], [Email], [observacion], [Dni]) VALUES (1, N'johan', N'mitma', CAST(N'2000-10-12' AS Date), N'SJM', N'PER', N'954966494', N'avira365@hotmail.com', N'Activo', N'74804782')
INSERT [dbo].[Paciente] ([idPaciente], [nombre], [apellido], [fechaNacimiento], [domicilio], [idPais], [telefono], [Email], [observacion], [Dni]) VALUES (3, N'angie', N'jhomara', CAST(N'1998-12-30' AS Date), N'SJL', N'PER', N'993224901', N'angie@hotmail.com', N'Activa', N'32344229')
INSERT [dbo].[Paciente] ([idPaciente], [nombre], [apellido], [fechaNacimiento], [domicilio], [idPais], [telefono], [Email], [observacion], [Dni]) VALUES (4, N'carla', N'kodaline', CAST(N'1990-12-30' AS Date), N'SJM', N'PER', N'998332455', N'kodaline@hotmail.com', N'Activa', N'89435527')
SET IDENTITY_INSERT [dbo].[Paciente] OFF
INSERT [dbo].[PacientesDeleted] ([idPaciente], [nombre], [fechaNacimiento], [domicilio], [idPais], [telefono], [Email], [observacion], [Dni]) VALUES (2, N'elisa', CAST(N'1997-12-23' AS Date), N'España', N'ESP', N'321888233', N'elisa@hotmail.com', N'Foranea', N'73803765')
INSERT [dbo].[Pais] ([idPais], [nombre]) VALUES (N'BRA', N'Brazil')
INSERT [dbo].[Pais] ([idPais], [nombre]) VALUES (N'PER', N'Perú')
SET IDENTITY_INSERT [dbo].[Profesiones] ON 

INSERT [dbo].[Profesiones] ([idProfesion], [nameProfesion]) VALUES (1, N'Literatura')
INSERT [dbo].[Profesiones] ([idProfesion], [nameProfesion]) VALUES (2, N'Matematicas')
INSERT [dbo].[Profesiones] ([idProfesion], [nameProfesion]) VALUES (3, N'Psicologia')
INSERT [dbo].[Profesiones] ([idProfesion], [nameProfesion]) VALUES (4, N'Geometria')
INSERT [dbo].[Profesiones] ([idProfesion], [nameProfesion]) VALUES (5, N'Analisis Matematico')
INSERT [dbo].[Profesiones] ([idProfesion], [nameProfesion]) VALUES (6, N'Algebra')
SET IDENTITY_INSERT [dbo].[Profesiones] OFF
INSERT [dbo].[Turno] ([idTurno], [fechaTurno], [estado], [observacion]) VALUES (N'1         ', CAST(N'2020-12-12T00:00:00' AS SmallDateTime), 1, N'Casual')
INSERT [dbo].[TurnoPaciente] ([idTurno], [idPaciente], [idMedico]) VALUES (1, 2, 12)
INSERT [dbo].[userActions] ([idUsuario], [idActivity]) VALUES (1, 3)
INSERT [dbo].[userActions] ([idUsuario], [idActivity]) VALUES (2, 4)
INSERT [dbo].[userActions] ([idUsuario], [idActivity]) VALUES (5, 3)
INSERT [dbo].[userActions] ([idUsuario], [idActivity]) VALUES (2, 3)
INSERT [dbo].[userActions] ([idUsuario], [idActivity]) VALUES (1, 6)
INSERT [dbo].[userActions] ([idUsuario], [idActivity]) VALUES (5, 7)
INSERT [dbo].[userActions] ([idUsuario], [idActivity]) VALUES (4, 7)
INSERT [dbo].[userActions] ([idUsuario], [idActivity]) VALUES (4, 7)
SET IDENTITY_INSERT [dbo].[userJSON] ON 

INSERT [dbo].[userJSON] ([idJSON], [jsonfile]) VALUES (1, N'{
    "Usuario":"johan mitma",
    "PWD":     "elindiciofinal33",
    "LastConnection":"2020/11/02",
    "NickNames":["jovamih"]
}')
SET IDENTITY_INSERT [dbo].[userJSON] OFF
INSERT [dbo].[usersKey] ([idUser], [pin]) VALUES (9, 74804782)
INSERT [dbo].[usersKey] ([idUser], [pin]) VALUES (10, 7856443)
INSERT [dbo].[usersKey] ([idUser], [pin]) VALUES (11, 9986745)
INSERT [dbo].[usersKey] ([idUser], [pin]) VALUES (12, 89765530)
INSERT [dbo].[usersKey] ([idUser], [pin]) VALUES (14, 567423)
INSERT [dbo].[usersKey] ([idUser], [pin]) VALUES (15, 9985442)
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([idUsuario], [nombre], [pass]) VALUES (1, N'johan', N'74804782')
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [pass]) VALUES (2, N'elisatello', N'65432')
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [pass]) VALUES (4, N'sandra', N'99972')
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [pass]) VALUES (5, N'angie', N'954221')
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [pass]) VALUES (6, N'coldplay', N'666523')
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [pass]) VALUES (7, N'carla', N'365avira0')
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [pass]) VALUES (9, N'angie_abanto', N'74804782')
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [pass]) VALUES (10, N'amparooPaez', N'7856443')
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [pass]) VALUES (11, N'Fabricio', N'9986745')
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [pass]) VALUES (12, N'Ottis', N'89765530')
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [pass]) VALUES (14, N'Orozco', N'567423')
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [pass]) VALUES (15, N'Gianela', N'9985442')
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [pass]) VALUES (16, N'Eizabeth', N'8776342')
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [pass]) VALUES (17, N'Isabel', N'998753')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Especial__3A2E8FB15D75C7B9]    Script Date: 11/02/2020 22:29:18 ******/
ALTER TABLE [dbo].[Especialidad] ADD UNIQUE NONCLUSTERED 
(
	[especialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__LastActi__645723A794F55BBC]    Script Date: 11/02/2020 22:29:18 ******/
ALTER TABLE [dbo].[LastActivity] ADD UNIQUE NONCLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Paciente__C0308575D628F0B2]    Script Date: 11/02/2020 22:29:18 ******/
ALTER TABLE [dbo].[Paciente] ADD  CONSTRAINT [UQ__Paciente__C0308575D628F0B2] UNIQUE NONCLUSTERED 
(
	[Dni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuario__72AFBCC693191444]    Script Date: 11/02/2020 22:29:18 ******/
ALTER TABLE [dbo].[Usuario] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LastActivity] ADD  CONSTRAINT [zero_default_Estado]  DEFAULT ((0)) FOR [Estado]
GO
ALTER TABLE [dbo].[Medico] ADD  DEFAULT ('Desconocido') FOR [nombre]
GO
ALTER TABLE [dbo].[Pagos] ADD  DEFAULT ('Concepto regular') FOR [concepto]
GO
ALTER TABLE [dbo].[Pagos] ADD  DEFAULT ('Sin observaciones') FOR [observacion]
GO
ALTER TABLE [dbo].[InformacionUsuario]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[InformacionUsuario]  WITH CHECK ADD  CONSTRAINT [FK_IDprofesion_profesiones] FOREIGN KEY([idProfesion])
REFERENCES [dbo].[Profesiones] ([idProfesion])
GO
ALTER TABLE [dbo].[InformacionUsuario] CHECK CONSTRAINT [FK_IDprofesion_profesiones]
GO
ALTER TABLE [dbo].[LastActivity]  WITH CHECK ADD  CONSTRAINT [FK_idUsuario_LastActivity] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[LastActivity] CHECK CONSTRAINT [FK_idUsuario_LastActivity]
GO
ALTER TABLE [dbo].[MedicoEspecialidad]  WITH CHECK ADD  CONSTRAINT [FK_idMedico_Medico] FOREIGN KEY([idMedico])
REFERENCES [dbo].[Medico] ([idMedico])
GO
ALTER TABLE [dbo].[MedicoEspecialidad] CHECK CONSTRAINT [FK_idMedico_Medico]
GO
ALTER TABLE [dbo].[MedicoEspecialidad]  WITH CHECK ADD  CONSTRAINT [fk_isEspecialidad] FOREIGN KEY([idEspecialidad])
REFERENCES [dbo].[Especialidad] ([idEspecialidad])
GO
ALTER TABLE [dbo].[MedicoEspecialidad] CHECK CONSTRAINT [fk_isEspecialidad]
GO
ALTER TABLE [dbo].[userActions]  WITH CHECK ADD  CONSTRAINT [FK_idActivity_actividad] FOREIGN KEY([idActivity])
REFERENCES [dbo].[Activity] ([idActivity])
GO
ALTER TABLE [dbo].[userActions] CHECK CONSTRAINT [FK_idActivity_actividad]
GO
ALTER TABLE [dbo].[userActions]  WITH CHECK ADD  CONSTRAINT [FK_idUsuario_actividad] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[userActions] CHECK CONSTRAINT [FK_idUsuario_actividad]
GO
ALTER TABLE [dbo].[Especialidad]  WITH CHECK ADD CHECK  (([idEspecialidad]>(0)))
GO
ALTER TABLE [dbo].[InformacionUsuario]  WITH CHECK ADD CHECK  (([edad]>(0)))
GO
ALTER TABLE [dbo].[LastActivity]  WITH CHECK ADD CHECK  (([idUsuario]>(0)))
GO
ALTER TABLE [dbo].[MedicoEspecialidad]  WITH CHECK ADD CHECK  (([idMedico]>(0)))
GO
ALTER TABLE [dbo].[userActions]  WITH CHECK ADD CHECK  (([idUsuario]>(0)))
GO
ALTER TABLE [dbo].[userJSON]  WITH CHECK ADD  CONSTRAINT [ckeck_json] CHECK  ((isjson([jsonfile])>(0)))
GO
ALTER TABLE [dbo].[userJSON] CHECK CONSTRAINT [ckeck_json]
GO
/****** Object:  StoredProcedure [dbo].[agregarUsuario]    Script Date: 11/02/2020 22:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[agregarUsuario](
		@nombre varchar(20),
		@password varchar(20))
as begin
set nocount on
	IF NOT EXISTS(SELECT* FROM [dbo].[Usuario] where nombre=@nombre)
		INSERT INTO [dbo].[Usuario] VALUES(@nombre,@password)
	ELSE
		print 'Ya existe un usuario registrado con el mismo nombre'
END
GO
/****** Object:  StoredProcedure [dbo].[getHistoria]    Script Date: 11/02/2020 22:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getHistoria](@idPaciente int )
as
set nocount on
	select P.nombre,H.idHistoria,H.fechaHistoria,H.observacion,M.nombre from [dbo].[Paciente] as P 
		INNER JOIN [dbo].[HistoriaPaciente] AS HP ON P.idPaciente= HP.idPaciente
		INNER JOIN [dbo].[Historia] AS H ON H.idHistoria= HP.idHistoria
		INNER JOIN [dbo].[Medico] as M on M.idMedico=HP.idMedico
	where P.idPaciente= @idPaciente;
GO
/****** Object:  StoredProcedure [dbo].[insertarEspecialidad]    Script Date: 11/02/2020 22:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insertarEspecialidad](
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
	else
		print 'la especialiad ya se encuentra registrada'
END	
GO
/****** Object:  StoredProcedure [dbo].[insertarMedico]    Script Date: 11/02/2020 22:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insertarMedico](
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
/****** Object:  StoredProcedure [dbo].[insertarPaciente]    Script Date: 11/02/2020 22:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insertarPaciente](
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
/****** Object:  StoredProcedure [dbo].[mostrarUsuarios]    Script Date: 11/02/2020 22:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[mostrarUsuarios]
	AS
	SET NOCOUNT ON
	BEGIN
	SELECT * ,
		(SELECT [nameProfesion] from [dbo].[Profesiones] prof WHERE prof.idProfesion= inf.idProfesion) as Profesion
		FROM [dbo].[InformacionUsuario] inf
	end
GO
/****** Object:  StoredProcedure [dbo].[obtenerEspMedico]    Script Date: 11/02/2020 22:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[obtenerEspMedico](@idMedico int)
as
set nocount on
	SELECT * FROM [dbo].[Medico] as M
			INNER JOIN [dbo].[MedicoEspecialidad] AS ME on ME.idMedico=M.idMedico
			INNER JOIN [dbo].[Especialidad] AS E ON ME.idEspecialidad= E.idEspecialidad
	WHERE M.idMedico=@idMedico
GO
/****** Object:  StoredProcedure [dbo].[Select_pacientes]    Script Date: 11/02/2020 22:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_pacientes](
	@idPaciente int )
as
set nocount on

select * from Paciente	AS P
				INNER JOIN TurnoPaciente as TP ON TP.idPaciente= P.idPaciente
				INNER JOIN Turno as T ON T.idTurno= TP.idTurno
				INNER JOIN MedicoEspecialidad ME ON ME.idMedico= TP.idMedico
WHERE P.idPaciente= @idPaciente


GO
/****** Object:  StoredProcedure [dbo].[sp_agregarInformacionUsuario]    Script Date: 11/02/2020 22:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_agregarInformacionUsuario](
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

GO
/****** Object:  StoredProcedure [dbo].[sp_agregarUsuario]    Script Date: 11/02/2020 22:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_agregarUsuario](
	@nombre varchar(20),
	@pass varchar(20)
	)
AS
	IF NOT EXISTS (SELECT * FROM [dbo].[Usuario] WHERE [nombre]=@nombre)
	BEGIN
	INSERT INTO [dbo].[Usuario] ([nombre],[pass]) VALUES (@nombre,@pass)
	END
	ELSE
	BEGIN
	PRINT 'El usuario ya existe'
	END
GO
/****** Object:  StoredProcedure [dbo].[updatePaciente]    Script Date: 11/02/2020 22:29:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updatePaciente](
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
	
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -35
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Usuario"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Profesiones"
            Begin Extent = 
               Top = 6
               Left = 585
               Bottom = 102
               Right = 755
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "InformacionUsuario"
            Begin Extent = 
               Top = 107
               Left = 347
               Bottom = 237
               Right = 531
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UsuariosPruebaRegistered'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UsuariosPruebaRegistered'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "U"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "L"
            Begin Extent = 
               Top = 6
               Left = 414
               Bottom = 119
               Right = 584
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_UsuariosActivos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_UsuariosActivos'
GO
USE [master]
GO
ALTER DATABASE [Life] SET  READ_WRITE 
GO
