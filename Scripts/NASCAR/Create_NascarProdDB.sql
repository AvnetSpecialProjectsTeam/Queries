USE [master]
GO

/****** Object:  Database [NascarProd]    Script Date: 10/2/2017 2:46:19 PM ******/
CREATE DATABASE [NascarProd]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NascarProd', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\NascarProd.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 4194304KB )
 LOG ON 
( NAME = N'NascarProd_log', FILENAME = N'F:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Data\NascarProd_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 4194304KB )
GO

ALTER DATABASE [NascarProd] SET COMPATIBILITY_LEVEL = 130
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NascarProd].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [NascarProd] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [NascarProd] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [NascarProd] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [NascarProd] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [NascarProd] SET ARITHABORT OFF 
GO

ALTER DATABASE [NascarProd] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [NascarProd] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [NascarProd] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [NascarProd] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [NascarProd] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [NascarProd] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [NascarProd] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [NascarProd] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [NascarProd] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [NascarProd] SET  DISABLE_BROKER 
GO

ALTER DATABASE [NascarProd] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [NascarProd] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [NascarProd] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [NascarProd] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [NascarProd] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [NascarProd] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [NascarProd] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [NascarProd] SET RECOVERY FULL 
GO

ALTER DATABASE [NascarProd] SET  MULTI_USER 
GO

ALTER DATABASE [NascarProd] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [NascarProd] SET DB_CHAINING OFF 
GO

ALTER DATABASE [NascarProd] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [NascarProd] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [NascarProd] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [NascarProd] SET QUERY_STORE = OFF
GO

USE [NascarProd]
GO

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO

ALTER DATABASE [NascarProd] SET  READ_WRITE 
GO

