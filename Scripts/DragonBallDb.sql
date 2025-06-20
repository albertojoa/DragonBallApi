USE [master]
GO
/****** Object:  Database [DragonBallDb]    Script Date: 11/4/2025 05:32:29 p. m. ******/
CREATE DATABASE [DragonBallDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DragonBallDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DragonBallDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DragonBallDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DragonBallDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DragonBallDb] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DragonBallDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DragonBallDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DragonBallDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DragonBallDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DragonBallDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DragonBallDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [DragonBallDb] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DragonBallDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DragonBallDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DragonBallDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DragonBallDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DragonBallDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DragonBallDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DragonBallDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DragonBallDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DragonBallDb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DragonBallDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DragonBallDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DragonBallDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DragonBallDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DragonBallDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DragonBallDb] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [DragonBallDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DragonBallDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DragonBallDb] SET  MULTI_USER 
GO
ALTER DATABASE [DragonBallDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DragonBallDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DragonBallDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DragonBallDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DragonBallDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DragonBallDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DragonBallDb] SET QUERY_STORE = ON
GO
ALTER DATABASE [DragonBallDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DragonBallDb]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 11/4/2025 05:32:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Characters]    Script Date: 11/4/2025 05:32:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Characters](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[Ki] [nvarchar](35) NOT NULL,
	[Race] [nvarchar](25) NOT NULL,
	[Gender] [nvarchar](20) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[Affiliation] [nvarchar](35) NOT NULL,
 CONSTRAINT [PK_Characters] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transformations]    Script Date: 11/4/2025 05:32:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transformations](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[Ki] [nvarchar](35) NOT NULL,
	[CharacterId] [int] NOT NULL,
 CONSTRAINT [PK_Transformations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_Transformations_CharacterId]    Script Date: 11/4/2025 05:32:29 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_Transformations_CharacterId] ON [dbo].[Transformations]
(
	[CharacterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Transformations]  WITH CHECK ADD  CONSTRAINT [FK_Transformations_Characters_CharacterId] FOREIGN KEY([CharacterId])
REFERENCES [dbo].[Characters] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Transformations] CHECK CONSTRAINT [FK_Transformations_Characters_CharacterId]
GO
USE [master]
GO
ALTER DATABASE [DragonBallDb] SET  READ_WRITE 
GO
