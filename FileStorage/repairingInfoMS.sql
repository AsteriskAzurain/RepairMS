USE [master]
GO
/****** Object:  Database [repairingInfoMS]    Script Date: 2021/2/2 8:17:26 ******/
CREATE DATABASE [repairingInfoMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'repairingInfoMS', FILENAME = N'D:\3D Objects\repairingInfoMS.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'repairingInfoMS_log', FILENAME = N'D:\3D Objects\repairingInfoMS_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [repairingInfoMS] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [repairingInfoMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [repairingInfoMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [repairingInfoMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [repairingInfoMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [repairingInfoMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [repairingInfoMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [repairingInfoMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [repairingInfoMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [repairingInfoMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [repairingInfoMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [repairingInfoMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [repairingInfoMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [repairingInfoMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [repairingInfoMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [repairingInfoMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [repairingInfoMS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [repairingInfoMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [repairingInfoMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [repairingInfoMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [repairingInfoMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [repairingInfoMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [repairingInfoMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [repairingInfoMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [repairingInfoMS] SET RECOVERY FULL 
GO
ALTER DATABASE [repairingInfoMS] SET  MULTI_USER 
GO
ALTER DATABASE [repairingInfoMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [repairingInfoMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [repairingInfoMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [repairingInfoMS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [repairingInfoMS] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'repairingInfoMS', N'ON'
GO
USE [repairingInfoMS]
GO
/****** Object:  Table [dbo].[employeeTable]    Script Date: 2021/2/2 8:17:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[employeeTable](
	[employeeID] [int] IDENTITY(1,1) NOT NULL,
	[employeeName] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[deleteStatus] [tinyint] NULL CONSTRAINT [DF_employeeTable_deleteStatus]  DEFAULT ((1)),
 CONSTRAINT [PK_employeeTable] PRIMARY KEY CLUSTERED 
(
	[employeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[paramTable]    Script Date: 2021/2/2 8:17:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[paramTable](
	[paramID] [int] IDENTITY(1,1) NOT NULL,
	[paramCode] [varchar](50) NULL,
	[paramText] [varchar](50) NULL,
	[paramValue] [varchar](50) NULL,
	[paramType] [int] NULL,
	[remark] [varchar](255) NULL,
	[deleteStatus] [tinyint] NULL CONSTRAINT [DF_paramTable_deleteStatus]  DEFAULT ((1)),
 CONSTRAINT [PK_paramTable] PRIMARY KEY CLUSTERED 
(
	[paramID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[projectDetailTable]    Script Date: 2021/2/2 8:17:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[projectDetailTable](
	[detailID] [int] IDENTITY(1,1) NOT NULL,
	[projectID] [int] NULL,
	[repairmanID] [int] NULL,
	[severity] [int] NULL,
	[faultType] [int] NULL,
	[faultStatus] [int] NULL,
	[faultDetail] [varchar](255) NULL,
	[add_requirement] [varchar](255) NULL,
	[createDate] [datetime] NULL,
	[updateDate] [datetime] NULL,
	[deleteStatus] [tinyint] NOT NULL,
 CONSTRAINT [PK_projectDetailTable] PRIMARY KEY CLUSTERED 
(
	[detailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[projectTable]    Script Date: 2021/2/2 8:17:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[projectTable](
	[projectID] [int] IDENTITY(1,1) NOT NULL,
	[projectStatus] [int] NULL,
	[priority] [int] NULL,
	[projectType] [int] NULL,
	[projectSite] [int] NULL,
	[contractName] [varchar](50) NULL,
	[contractPhone] [varchar](50) NULL,
	[projectDetail] [varchar](255) NOT NULL,
	[siteDetail] [varchar](255) NULL,
	[hasDetail] [tinyint] NULL,
	[createDate] [datetime] NULL,
	[updateDate] [datetime] NULL,
	[deleteStatus] [tinyint] NULL,
 CONSTRAINT [PK_projectTable] PRIMARY KEY CLUSTERED 
(
	[projectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[repairmanTable]    Script Date: 2021/2/2 8:17:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[repairmanTable](
	[repairmanID] [int] IDENTITY(1,1) NOT NULL,
	[repairmanName] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[deleteStatus] [tinyint] NULL CONSTRAINT [DF_repairmanTable_deleteStatus]  DEFAULT ((1)),
 CONSTRAINT [PK_repairmanTable] PRIMARY KEY CLUSTERED 
(
	[repairmanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[projectDetailTable] ADD  CONSTRAINT [DF_projectDetailTable_deleteStatus]  DEFAULT ((1)) FOR [deleteStatus]
GO
ALTER TABLE [dbo].[projectTable] ADD  CONSTRAINT [DF_projectTable_deleteStatus]  DEFAULT ((1)) FOR [deleteStatus]
GO
USE [master]
GO
ALTER DATABASE [repairingInfoMS] SET  READ_WRITE 
GO
