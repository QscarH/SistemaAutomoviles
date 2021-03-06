USE [master]
GO
/****** Object:  Database [ControldeAutos]    Script Date: 24/10/2018 02:31:49 p. m. ******/
CREATE DATABASE [ControldeAutos]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ControldeAutos', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ControldeAutos.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ControldeAutos_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ControldeAutos_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ControldeAutos] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ControldeAutos].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ControldeAutos] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ControldeAutos] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ControldeAutos] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ControldeAutos] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ControldeAutos] SET ARITHABORT OFF 
GO
ALTER DATABASE [ControldeAutos] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ControldeAutos] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ControldeAutos] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ControldeAutos] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ControldeAutos] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ControldeAutos] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ControldeAutos] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ControldeAutos] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ControldeAutos] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ControldeAutos] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ControldeAutos] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ControldeAutos] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ControldeAutos] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ControldeAutos] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ControldeAutos] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ControldeAutos] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ControldeAutos] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ControldeAutos] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ControldeAutos] SET  MULTI_USER 
GO
ALTER DATABASE [ControldeAutos] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ControldeAutos] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ControldeAutos] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ControldeAutos] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ControldeAutos] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ControldeAutos] SET QUERY_STORE = OFF
GO
USE [ControldeAutos]
GO
/****** Object:  Table [dbo].[Automovil]    Script Date: 24/10/2018 02:31:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Automovil](
	[FolioAuto] [varchar](50) NOT NULL,
	[Marca] [varchar](50) NULL,
	[Modelo] [varchar](50) NULL,
	[Color] [varchar](50) NULL,
	[Tipo_transmision] [varchar](50) NULL,
	[Descripcion_fisica] [varchar](250) NULL,
 CONSTRAINT [PK_Automovil] PRIMARY KEY CLUSTERED 
(
	[FolioAuto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Solicitud_de_transporte]    Script Date: 24/10/2018 02:31:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solicitud_de_transporte](
	[NumLote] [int] NOT NULL,
	[Fecha] [date] NULL,
 CONSTRAINT [PK_Solicitud_de_transporte] PRIMARY KEY CLUSTERED 
(
	[NumLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transporte_auto]    Script Date: 24/10/2018 02:31:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transporte_auto](
	[NumLote] [int] NULL,
	[FolioAuto] [varchar](50) NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_transporte_auto2_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[transporte_auto]  WITH CHECK ADD  CONSTRAINT [FK_auto_Solicitud_de_transporte] FOREIGN KEY([NumLote])
REFERENCES [dbo].[Solicitud_de_transporte] ([NumLote])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[transporte_auto] CHECK CONSTRAINT [FK_auto_Solicitud_de_transporte]
GO
ALTER TABLE [dbo].[transporte_auto]  WITH CHECK ADD  CONSTRAINT [fk_auto_transporte] FOREIGN KEY([FolioAuto])
REFERENCES [dbo].[Automovil] ([FolioAuto])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[transporte_auto] CHECK CONSTRAINT [fk_auto_transporte]
GO
/****** Object:  StoredProcedure [dbo].[AgregaAuto]    Script Date: 24/10/2018 02:31:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Oscar
-- Create date: 24-10-2018
-- Description:	Agrega datos a los autos
-- =============================================
CREATE PROCEDURE [dbo].[AgregaAuto] 
	-- Add the parameters for the stored procedure here
	@folio varchar(50),
	@marca varchar (50),
	@modelo varchar (50),
	@color varchar (50),
	@Tipo_transmision varchar (50),
	@Descripcion varchar (250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Automovil(FolioAuto, Marca, Modelo, Color, Tipo_transmision, Descripcion_fisica) 
	VALUES (@folio, @marca, @modelo, @color, @Tipo_transmision, @Descripcion) 
END
GO
/****** Object:  StoredProcedure [dbo].[AgregarAuto]    Script Date: 24/10/2018 02:31:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Oscar
-- Create date: 24-10-2018
-- Description:	Agrega datos a los autos
-- =============================================
CREATE PROCEDURE [dbo].[AgregarAuto] 
	-- Add the parameters for the stored procedure here
	@folio varchar(50),
	@marca varchar (50),
	@modelo varchar (50),
	@color varchar (50),
	@Tipo_transmision varchar (50),
	@Descripcion varchar (250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Automovil (FolioAuto, Marca, Modelo, Color, Tipo_transmision, Descripcion_fisica) 
	VALUES (@folio, @marca, @modelo, @color, @Tipo_transmision, @Descripcion)
END
GO
/****** Object:  StoredProcedure [dbo].[ModificaAuto]    Script Date: 24/10/2018 02:31:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Oscar
-- Create date: 24-10-2018
-- Description:	Agrega datos a los autos
-- =============================================
CREATE PROCEDURE [dbo].[ModificaAuto] 
	-- Add the parameters for the stored procedure here
	@folio varchar(50),
	@marca varchar (50),
	@modelo varchar (50),
	@color varchar (50),
	@Tipo_transmision varchar (50),
	@Descripcion varchar (250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Automovil SET Marca=@marca, Modelo=@modelo, Color=@color, Tipo_transmision=@Tipo_transmision, Descripcion_fisica=@Descripcion 
	where FolioAuto=@folio
END
GO
/****** Object:  StoredProcedure [dbo].[PeticionAutoTransporte]    Script Date: 24/10/2018 02:31:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Oscar
-- Create date: 24-10-2018
-- Description:	Agrega datos a los autos
-- =============================================
CREATE PROCEDURE [dbo].[PeticionAutoTransporte]
	-- Add the parameters for the stored procedure here
	@lote	int,
	@folio varchar(50),
	@marca varchar (50),
	@modelo varchar (50),
	@color varchar (50),
	@Tipo_transmision varchar (50),
	@Descripcion varchar (250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Automovil (FolioAuto, Marca, Modelo, Color, Tipo_transmision, Descripcion_fisica) 
	VALUES (@folio, @marca, @modelo, @color, @Tipo_transmision, @Descripcion)
	INSERT INTO dbo.transporte_auto (FolioAuto, NumLote) 
	VALUES (@folio, @lote)
END
GO
/****** Object:  StoredProcedure [dbo].[VerAutos]    Script Date: 24/10/2018 02:31:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Oscar
-- Create date: 24-10-2018
-- Description:	Agrega datos a los autos
-- =============================================
CREATE PROCEDURE [dbo].[VerAutos] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT dbo.Automovil.FolioAuto, Marca, Modelo, Color, Tipo_Transmision, Descripcion_fisica
	FROM dbo.Automovil
END
GO
/****** Object:  StoredProcedure [dbo].[VerAutoTransporte]    Script Date: 24/10/2018 02:31:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Oscar
-- Create date: 24-10-2018
-- Description:	Agrega datos a los autos
-- =============================================
CREATE PROCEDURE [dbo].[VerAutoTransporte] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT dbo.Solicitud_de_transporte.NumLote, dbo.Automovil.FolioAuto, Marca, Modelo, Color, Tipo_Transmision, Descripcion_fisica
	FROM dbo.Automovil, dbo.Solicitud_de_transporte, dbo.transporte_auto 
	WHERE (dbo.Solicitud_de_transporte.NumLote = dbo.transporte_auto.Numlote) AND (dbo.Automovil.FolioAuto = dbo.transporte_auto.FolioAuto)
END
GO
USE [master]
GO
ALTER DATABASE [ControldeAutos] SET  READ_WRITE 
GO
