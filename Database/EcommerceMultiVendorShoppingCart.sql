USE [master]
GO
/****** Object:  Database [OctopusCodesMultiVendors]    Script Date: 31/05/2020 10.01.02 ******/
CREATE DATABASE [OctopusCodesMultiVendors]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OctopusCodesMultiVendors', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\OctopusCodesMultiVendors.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OctopusCodesMultiVendors_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\OctopusCodesMultiVendors_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OctopusCodesMultiVendors].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET ARITHABORT OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET  ENABLE_BROKER 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET  MULTI_USER 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET QUERY_STORE = OFF
GO
USE [OctopusCodesMultiVendors]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [OctopusCodesMultiVendors]
GO
/****** Object:  User [proti]    Script Date: 31/05/2020 10.01.03 ******/
CREATE USER [proti] FOR LOGIN [proti] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [octopuscodeuser]    Script Date: 31/05/2020 10.01.03 ******/
CREATE USER [octopuscodeuser] FOR LOGIN [octopuscodeuser] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [bs_user]    Script Date: 31/05/2020 10.01.03 ******/
CREATE USER [bs_user] FOR LOGIN [bs_user] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [proti]
GO
ALTER ROLE [db_owner] ADD MEMBER [octopuscodeuser]
GO
ALTER ROLE [db_datareader] ADD MEMBER [octopuscodeuser]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [octopuscodeuser]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 31/05/2020 10.01.03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](250) NULL,
	[Password] [varchar](250) NULL,
	[FullName] [varchar](250) NULL,
	[Address] [varchar](250) NULL,
	[Email] [varchar](250) NULL,
	[Phone] [varchar](50) NULL,
	[Status] [bit] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Table_1] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountAddress]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountAddress](
	[Id] [uniqueidentifier] NOT NULL,
	[LineAddress1] [nvarchar](500) NOT NULL,
	[LineAddress2] [nvarchar](500) NOT NULL,
	[City] [nvarchar](250) NOT NULL,
	[ZipCode] [nvarchar](10) NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_AccountAddress] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountPaymentInfo]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountPaymentInfo](
	[Id] [int] NOT NULL,
	[CreditCardNo] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](500) NOT NULL,
	[ExpiryDate] [nvarchar](5) NOT NULL,
	[AccountId] [int] NOT NULL,
 CONSTRAINT [PK_AccountPaymentInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BankList]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankList](
	[BankId] [int] NOT NULL,
	[BankName] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_BankList] PRIMARY KEY CLUSTERED 
(
	[BankId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[Status] [bit] NOT NULL,
	[ParentId] [int] NULL,
	[VendorId] [int] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ForgetPassword]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ForgetPassword](
	[Id] [uniqueidentifier] NOT NULL,
	[Username] [varchar](250) NOT NULL,
 CONSTRAINT [PK_ForgetPassword] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MemberShip]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MemberShip](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[Description] [ntext] NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Month] [int] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_MemberShip] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MemberShipVendor]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MemberShipVendor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MemerShipId] [int] NOT NULL,
	[VendorId] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_MemberShipVendor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Message]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Message](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](250) NULL,
	[Body] [ntext] NULL,
	[DateCreation] [date] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[VendorId] [int] NOT NULL,
	[Status] [bit] NOT NULL,
	[Sender] [int] NOT NULL,
 CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MessageDetail]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MessageDetail](
	[Id] [uniqueidentifier] NOT NULL,
	[MessageHeaderId] [uniqueidentifier] NOT NULL,
	[Body] [ntext] NOT NULL,
	[DateCreation] [datetime] NOT NULL,
	[Status] [bit] NOT NULL,
	[Sender] [int] NOT NULL,
 CONSTRAINT [PK_MessageDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MessageHeader]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MessageHeader](
	[MsgId] [uniqueidentifier] NOT NULL,
	[LastMessage] [nvarchar](250) NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[VendorId] [int] NULL,
	[CustomerId] [int] NULL,
	[AdminId] [int] NULL,
	[SenderType] [int] NULL,
 CONSTRAINT [PK_MessageHeader] PRIMARY KEY CLUSTERED 
(
	[MsgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MessageSenderType]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MessageSenderType](
	[SenderType] [int] NOT NULL,
	[SenderTypeDescription] [nvarchar](10) NULL,
 CONSTRAINT [PK_MessageSenderType] PRIMARY KEY CLUSTERED 
(
	[SenderType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderAddress]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderAddress](
	[Id] [uniqueidentifier] NOT NULL,
	[LineAddress1] [nvarchar](500) NOT NULL,
	[LineAddress2] [nvarchar](500) NOT NULL,
	[City] [nvarchar](250) NOT NULL,
	[ZipCode] [nvarchar](10) NOT NULL,
	[OrderId] [int] NOT NULL,
 CONSTRAINT [PK_OrderAddress] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[DateCreation] [date] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[VendorId] [int] NOT NULL,
	[OrderStatusId] [int] NOT NULL,
	[PaymentReference] [nvarchar](250) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrdersDetail]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdersDetail](
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_OrdersDetail] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Page]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Page](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Plug] [varchar](250) NULL,
	[Title] [varchar](250) NULL,
	[Detail] [ntext] NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Page] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentStatus]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentStatus](
	[Id] [int] NOT NULL,
	[Name] [varchar](250) NOT NULL,
 CONSTRAINT [PK_PaymentStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Photo]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Photo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[Status] [bit] NOT NULL,
	[Main] [bit] NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_Photo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 31/05/2020 10.01.04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Description] [ntext] NULL,
	[Status] [bit] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[VendorId] [int] NOT NULL,
	[Views] [int] NOT NULL,
	[WeightInGrams] [float] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RajaOngkir_CityMapping]    Script Date: 31/05/2020 10.01.05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RajaOngkir_CityMapping](
	[Id] [uniqueidentifier] NOT NULL,
	[city_id] [nvarchar](50) NOT NULL,
	[province_id] [nvarchar](50) NOT NULL,
	[province] [nvarchar](250) NOT NULL,
	[type] [nvarchar](250) NOT NULL,
	[city_name] [nvarchar](250) NOT NULL,
	[postal_code] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_RajaOngkir_CityMapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 31/05/2020 10.01.05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[VendorId] [int] NOT NULL,
	[Detail] [ntext] NULL,
	[DatePost] [date] NOT NULL,
 CONSTRAINT [PK_RatingReview] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RewardsPoint]    Script Date: 31/05/2020 10.01.05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RewardsPoint](
	[Id] [uniqueidentifier] NOT NULL,
	[AccountId] [int] NULL,
	[AccumulatedPoints] [decimal](18, 0) NOT NULL,
	[VendorId] [int] NULL,
 CONSTRAINT [PK_RewardsPoint] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Setting]    Script Date: 31/05/2020 10.01.05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Setting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Key] [varchar](250) NULL,
	[Value] [ntext] NULL,
	[Group] [varchar](250) NULL,
	[TypeOfControl] [varchar](50) NULL,
 CONSTRAINT [PK_Setting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vendor]    Script Date: 31/05/2020 10.01.05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](250) NULL,
	[Password] [varchar](250) NULL,
	[Name] [varchar](250) NULL,
	[Email] [varchar](250) NULL,
	[Phone] [varchar](50) NULL,
	[Logo] [varchar](50) NULL,
	[Status] [bit] NOT NULL,
	[BankStatus] [bit] NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Vendor] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VendorAddress]    Script Date: 31/05/2020 10.01.05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorAddress](
	[Id] [uniqueidentifier] NOT NULL,
	[LineAddress1] [nvarchar](500) NOT NULL,
	[LineAddress2] [nvarchar](500) NOT NULL,
	[City] [nvarchar](250) NOT NULL,
	[ZipCode] [nvarchar](10) NOT NULL,
	[VendorId] [int] NOT NULL,
 CONSTRAINT [PK_VendorAddress] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VendorPayment]    Script Date: 31/05/2020 10.01.05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorPayment](
	[Id] [uniqueidentifier] NOT NULL,
	[VendorId] [int] NOT NULL,
	[Amount] [decimal](18, 0) NOT NULL,
	[Bank] [nvarchar](250) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[AccountNo] [nvarchar](50) NOT NULL,
	[Status] [int] NOT NULL,
	[PaymentDate] [datetime] NULL,
	[OrderId] [int] NOT NULL,
 CONSTRAINT [PK_VendorPayment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VendorPaymentInfo]    Script Date: 31/05/2020 10.01.05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorPaymentInfo](
	[VendorId] [int] NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Bank] [nvarchar](250) NOT NULL,
	[AccountNo] [nvarchar](50) NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_VendorPaymentInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VendorPendingDelivery]    Script Date: 31/05/2020 10.01.05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorPendingDelivery](
	[DeliveryOrderId] [uniqueidentifier] NOT NULL,
	[VendorId] [int] NOT NULL,
	[StartDeliveryDate] [datetime] NULL,
	[EstimatedDeliveredDays] [nvarchar](250) NOT NULL,
	[EstimatedDeliveredDate] [datetime] NULL,
	[OrderId] [int] NOT NULL,
	[TrackingId] [nvarchar](250) NULL,
	[DeliveredDate] [datetime] NULL,
 CONSTRAINT [PK_VendorPendingDelivery] PRIMARY KEY CLUSTERED 
(
	[DeliveryOrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VendorPendingPayment]    Script Date: 31/05/2020 10.01.05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorPendingPayment](
	[PaymentOrderID] [uniqueidentifier] NOT NULL,
	[VendorId] [int] NOT NULL,
	[MerchandiseAmount] [decimal](18, 0) NOT NULL,
	[DeliveryFee] [decimal](18, 0) NOT NULL,
	[OrderId] [int] NOT NULL,
 CONSTRAINT [PK_VendorPendingPayment] PRIMARY KEY CLUSTERED 
(
	[PaymentOrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Page]    Script Date: 31/05/2020 10.01.05 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Page] ON [dbo].[Page]
(
	[Plug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [WeightInGrams]
GO
ALTER TABLE [dbo].[Vendor] ADD  DEFAULT ((0)) FOR [BankStatus]
GO
ALTER TABLE [dbo].[AccountAddress]  WITH CHECK ADD  CONSTRAINT [FK_AccountAddress_Account] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[AccountAddress] CHECK CONSTRAINT [FK_AccountAddress_Account]
GO
ALTER TABLE [dbo].[AccountPaymentInfo]  WITH CHECK ADD  CONSTRAINT [FK_AccountPaymentInfo_Account] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AccountPaymentInfo] CHECK CONSTRAINT [FK_AccountPaymentInfo_Account]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Category] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Category]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Vendor]
GO
ALTER TABLE [dbo].[MemberShipVendor]  WITH CHECK ADD  CONSTRAINT [FK_MemberShipVendor_MemberShip] FOREIGN KEY([MemerShipId])
REFERENCES [dbo].[MemberShip] ([Id])
GO
ALTER TABLE [dbo].[MemberShipVendor] CHECK CONSTRAINT [FK_MemberShipVendor_MemberShip]
GO
ALTER TABLE [dbo].[MemberShipVendor]  WITH CHECK ADD  CONSTRAINT [FK_MemberShipVendor_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MemberShipVendor] CHECK CONSTRAINT [FK_MemberShipVendor_Vendor]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_Account] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_Account]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_MessageSenderType] FOREIGN KEY([Sender])
REFERENCES [dbo].[MessageSenderType] ([SenderType])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_MessageSenderType]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_Vendor]
GO
ALTER TABLE [dbo].[MessageDetail]  WITH CHECK ADD  CONSTRAINT [FK_MessageDetail_MessageHeader] FOREIGN KEY([MessageHeaderId])
REFERENCES [dbo].[MessageHeader] ([MsgId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MessageDetail] CHECK CONSTRAINT [FK_MessageDetail_MessageHeader]
GO
ALTER TABLE [dbo].[MessageHeader]  WITH CHECK ADD  CONSTRAINT [FK_MessageHeader_Account] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[MessageHeader] CHECK CONSTRAINT [FK_MessageHeader_Account]
GO
ALTER TABLE [dbo].[MessageHeader]  WITH CHECK ADD  CONSTRAINT [FK_MessageHeader_Account1] FOREIGN KEY([AdminId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[MessageHeader] CHECK CONSTRAINT [FK_MessageHeader_Account1]
GO
ALTER TABLE [dbo].[MessageHeader]  WITH CHECK ADD  CONSTRAINT [FK_MessageHeader_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
GO
ALTER TABLE [dbo].[MessageHeader] CHECK CONSTRAINT [FK_MessageHeader_Vendor]
GO
ALTER TABLE [dbo].[OrderAddress]  WITH CHECK ADD  CONSTRAINT [FK_OrderAddress_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderAddress] CHECK CONSTRAINT [FK_OrderAddress_Orders]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Account] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Account]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_OrderStatus] FOREIGN KEY([OrderStatusId])
REFERENCES [dbo].[OrderStatus] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_OrderStatus]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Vendor]
GO
ALTER TABLE [dbo].[OrdersDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrdersDetail_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrdersDetail] CHECK CONSTRAINT [FK_OrdersDetail_Orders]
GO
ALTER TABLE [dbo].[OrdersDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrdersDetail_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[OrdersDetail] CHECK CONSTRAINT [FK_OrdersDetail_Product]
GO
ALTER TABLE [dbo].[Photo]  WITH CHECK ADD  CONSTRAINT [FK_Photo_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Photo] CHECK CONSTRAINT [FK_Photo_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Vendor]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Account] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Account]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Vendor]
GO
ALTER TABLE [dbo].[RewardsPoint]  WITH CHECK ADD  CONSTRAINT [FK_RewardsPoint_Account] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[RewardsPoint] CHECK CONSTRAINT [FK_RewardsPoint_Account]
GO
ALTER TABLE [dbo].[RewardsPoint]  WITH CHECK ADD  CONSTRAINT [FK_RewardsPoint_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
GO
ALTER TABLE [dbo].[RewardsPoint] CHECK CONSTRAINT [FK_RewardsPoint_Vendor]
GO
ALTER TABLE [dbo].[VendorAddress]  WITH CHECK ADD  CONSTRAINT [FK_VendorAddress_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VendorAddress] CHECK CONSTRAINT [FK_VendorAddress_Vendor]
GO
ALTER TABLE [dbo].[VendorPayment]  WITH CHECK ADD  CONSTRAINT [FK_VendorPayment_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VendorPayment] CHECK CONSTRAINT [FK_VendorPayment_Vendor]
GO
ALTER TABLE [dbo].[VendorPaymentInfo]  WITH CHECK ADD  CONSTRAINT [FK_VendorPaymentInfo_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VendorPaymentInfo] CHECK CONSTRAINT [FK_VendorPaymentInfo_Vendor]
GO
ALTER TABLE [dbo].[VendorPendingDelivery]  WITH CHECK ADD  CONSTRAINT [FK_VendorPendingDelivery_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VendorPendingDelivery] CHECK CONSTRAINT [FK_VendorPendingDelivery_Orders]
GO
ALTER TABLE [dbo].[VendorPendingDelivery]  WITH CHECK ADD  CONSTRAINT [FK_VendorPendingDelivery_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
GO
ALTER TABLE [dbo].[VendorPendingDelivery] CHECK CONSTRAINT [FK_VendorPendingDelivery_Vendor]
GO
ALTER TABLE [dbo].[VendorPendingPayment]  WITH CHECK ADD  CONSTRAINT [FK_VendorPendingPayment_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VendorPendingPayment] CHECK CONSTRAINT [FK_VendorPendingPayment_Orders]
GO
ALTER TABLE [dbo].[VendorPendingPayment]  WITH CHECK ADD  CONSTRAINT [FK_VendorPendingPayment_Orders1] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[VendorPendingPayment] CHECK CONSTRAINT [FK_VendorPendingPayment_Orders1]
GO
ALTER TABLE [dbo].[VendorPendingPayment]  WITH CHECK ADD  CONSTRAINT [FK_VendorPendingPayment_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
GO
ALTER TABLE [dbo].[VendorPendingPayment] CHECK CONSTRAINT [FK_VendorPendingPayment_Vendor]
GO
USE [master]
GO
ALTER DATABASE [OctopusCodesMultiVendors] SET  READ_WRITE 
GO
