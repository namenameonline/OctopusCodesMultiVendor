USE [master]
GO
/****** Object:  Database [OctopusCodesMultiVendors]    Script Date: 5/15/2020 1:27:21 PM ******/
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
ALTER DATABASE [OctopusCodesMultiVendors] SET  DISABLE_BROKER 
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
/****** Object:  User [proti]    Script Date: 5/15/2020 1:27:21 PM ******/
CREATE USER [proti] FOR LOGIN [proti] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [octopuscodeuser]    Script Date: 5/15/2020 1:27:21 PM ******/
CREATE USER [octopuscodeuser] FOR LOGIN [octopuscodeuser] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [bs_user]    Script Date: 5/15/2020 1:27:21 PM ******/
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
/****** Object:  Table [dbo].[Account]    Script Date: 5/15/2020 1:27:22 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountAddress]    Script Date: 5/15/2020 1:27:22 PM ******/
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
/****** Object:  Table [dbo].[Category]    Script Date: 5/15/2020 1:27:22 PM ******/
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
/****** Object:  Table [dbo].[ForgetPassword]    Script Date: 5/15/2020 1:27:22 PM ******/
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
/****** Object:  Table [dbo].[MemberShip]    Script Date: 5/15/2020 1:27:22 PM ******/
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
/****** Object:  Table [dbo].[MemberShipVendor]    Script Date: 5/15/2020 1:27:22 PM ******/
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
/****** Object:  Table [dbo].[Message]    Script Date: 5/15/2020 1:27:22 PM ******/
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
 CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderAddress]    Script Date: 5/15/2020 1:27:22 PM ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 5/15/2020 1:27:22 PM ******/
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
	[PaymentId] [int] NULL,
	[PaymentStatusId] [int] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrdersDetail]    Script Date: 5/15/2020 1:27:22 PM ******/
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
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 5/15/2020 1:27:22 PM ******/
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
/****** Object:  Table [dbo].[Page]    Script Date: 5/15/2020 1:27:22 PM ******/
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
/****** Object:  Table [dbo].[Payment]    Script Date: 5/15/2020 1:27:22 PM ******/
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
/****** Object:  Table [dbo].[PaymentStatus]    Script Date: 5/15/2020 1:27:23 PM ******/
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
/****** Object:  Table [dbo].[Photo]    Script Date: 5/15/2020 1:27:23 PM ******/
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
/****** Object:  Table [dbo].[Product]    Script Date: 5/15/2020 1:27:23 PM ******/
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
/****** Object:  Table [dbo].[RajaOngkir_CityMapping]    Script Date: 5/15/2020 1:27:23 PM ******/
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
/****** Object:  Table [dbo].[Review]    Script Date: 5/15/2020 1:27:23 PM ******/
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
/****** Object:  Table [dbo].[Setting]    Script Date: 5/15/2020 1:27:23 PM ******/
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
/****** Object:  Table [dbo].[Vendor]    Script Date: 5/15/2020 1:27:23 PM ******/
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
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VendorAddress]    Script Date: 5/15/2020 1:27:23 PM ******/
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
/****** Object:  Table [dbo].[VendorPendingPayment]    Script Date: 5/15/2020 1:27:23 PM ******/
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
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([Id], [Username], [Password], [FullName], [Address], [Email], [Phone], [Status], [IsAdmin]) VALUES (1, N'admin', N'$2a$10$xwTGPfJgX3/VOEyngaL4me5LaCqLr8esBTV1GMkWovuKc50R64e4a', N'Administrator', N'Address 1', N'admin@gmail.com', N'123456999', 1, 1)
INSERT [dbo].[Account] ([Id], [Username], [Password], [FullName], [Address], [Email], [Phone], [Status], [IsAdmin]) VALUES (3, N'customer1', N'$2a$10$xwTGPfJgX3/VOEyngaL4me5LaCqLr8esBTV1GMkWovuKc50R64e4a', N'Customer 1', N'Address 2', N'customer1@gmail.com', N'81382883', 1, 0)
INSERT [dbo].[Account] ([Id], [Username], [Password], [FullName], [Address], [Email], [Phone], [Status], [IsAdmin]) VALUES (4, N'customer2', N'$2a$10$xwTGPfJgX3/VOEyngaL4me5LaCqLr8esBTV1GMkWovuKc50R64e4a', N'Customer 2', N'Address 3', N'customer2@gmail.com', N'123456', 1, 0)
INSERT [dbo].[Account] ([Id], [Username], [Password], [FullName], [Address], [Email], [Phone], [Status], [IsAdmin]) VALUES (5, N'customer3', N'$2a$10$S3.LKgOmCH40sEJj54i8b.JYrt54LcMINCBCCIn1lNhY1zqBHWcUq', N'AAA', N'bbb', N'a@aaaa.com', N'123', 1, 0)
INSERT [dbo].[Account] ([Id], [Username], [Password], [FullName], [Address], [Email], [Phone], [Status], [IsAdmin]) VALUES (7, N'customer10', N'$2a$10$xwTGPfJgX3/VOEyngaL4me5LaCqLr8esBTV1GMkWovuKc50R64e4a', N'Customer 1011', N'Address 10', N'customer11110@gmail.com', N'1231111', 1, 0)
INSERT [dbo].[Account] ([Id], [Username], [Password], [FullName], [Address], [Email], [Phone], [Status], [IsAdmin]) VALUES (8, N'customerA', N'$2a$10$/q1Zer.CUssbXPCMZVQ6cOdG0fyg0dp1UrqwjVenKjMi78i/LXp2u', N'Customer A', N'address 3', N'customerA@gmail.com', N'123', 1, 0)
SET IDENTITY_INSERT [dbo].[Account] OFF
INSERT [dbo].[AccountAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [CustomerId]) VALUES (N'0ee7a12d-fe99-43e5-950e-e4a0fc186461', N'balestier', N'line2', N'Jayapura', N'123456', 3)
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [Name], [Status], [ParentId], [VendorId]) VALUES (39, N'Category 1', 1, NULL, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Status], [ParentId], [VendorId]) VALUES (40, N'Category 1.1', 1, 39, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Status], [ParentId], [VendorId]) VALUES (41, N'Category 1.2', 1, 39, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Status], [ParentId], [VendorId]) VALUES (42, N'Category 2', 1, NULL, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Status], [ParentId], [VendorId]) VALUES (43, N'Category 2.1', 1, 42, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Status], [ParentId], [VendorId]) VALUES (44, N'Category 2.2', 1, 42, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Status], [ParentId], [VendorId]) VALUES (45, N'Category 2.3', 1, 42, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Status], [ParentId], [VendorId]) VALUES (46, N'Category 3', 1, NULL, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Status], [ParentId], [VendorId]) VALUES (47, N'Category 3.1', 1, 46, NULL)
INSERT [dbo].[Category] ([Id], [Name], [Status], [ParentId], [VendorId]) VALUES (48, N'Category 3.2', 1, 46, 15)
INSERT [dbo].[Category] ([Id], [Name], [Status], [ParentId], [VendorId]) VALUES (49, N'Category 3.3', 1, 46, 15)
INSERT [dbo].[Category] ([Id], [Name], [Status], [ParentId], [VendorId]) VALUES (50, N'Category 2.4', 1, 42, 15)
INSERT [dbo].[Category] ([Id], [Name], [Status], [ParentId], [VendorId]) VALUES (51, N'Category 1.3', 1, 39, 16)
INSERT [dbo].[Category] ([Id], [Name], [Status], [ParentId], [VendorId]) VALUES (52, N'Category 3.4', 1, 46, 16)
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[MemberShip] ON 

INSERT [dbo].[MemberShip] ([Id], [Name], [Description], [Price], [Month], [Status]) VALUES (5, N'Trial Package', N'<ul class="list-group">
<li class="list-group-item"><strong>10</strong> User</li>
<li class="list-group-item"><strong>500</strong> Projects</li>
<li class="list-group-item"><strong>Unlimited</strong> Email Accounts</li>
<li class="list-group-item"><strong>1000GB</strong> Disk Space</li>
<li class="list-group-item"><strong>10000GB</strong> Monthly Bandwidth</li>
</ul>', CAST(150.00 AS Decimal(18, 2)), 2, 1)
INSERT [dbo].[MemberShip] ([Id], [Name], [Description], [Price], [Month], [Status]) VALUES (6, N'Package 1', N'<ul class="list-group">
<li class="list-group-item"><strong>10</strong> User</li>
<li class="list-group-item"><strong>500</strong> Projects</li>
<li class="list-group-item"><strong>Unlimited</strong> Email Accounts</li>
<li class="list-group-item"><strong>1000GB</strong> Disk Space</li>
<li class="list-group-item"><strong>10000GB</strong> Monthly Bandwidth</li>
</ul>', CAST(200.00 AS Decimal(18, 2)), 3, 1)
INSERT [dbo].[MemberShip] ([Id], [Name], [Description], [Price], [Month], [Status]) VALUES (14, N'Package 2', N'<ul class="list-group">
<li class="list-group-item"><strong>10</strong> User</li>
<li class="list-group-item"><strong>500</strong> Projects</li>
<li class="list-group-item"><strong>Unlimited</strong> Email Accounts</li>
<li class="list-group-item"><strong>1000GB</strong> Disk Space</li>
<li class="list-group-item"><strong>10000GB</strong> Monthly Bandwidth</li>
</ul>', CAST(200.00 AS Decimal(18, 2)), 5, 1)
INSERT [dbo].[MemberShip] ([Id], [Name], [Description], [Price], [Month], [Status]) VALUES (19, N'Package 3', N'<ul class="list-group">
<li class="list-group-item"><strong>10</strong> User</li>
<li class="list-group-item"><strong>500</strong> Projects</li>
<li class="list-group-item"><strong>Unlimited</strong> Email Accounts</li>
<li class="list-group-item"><strong>1000GB</strong> Disk Space</li>
<li class="list-group-item"><strong>10000GB</strong> Monthly Bandwidth</li>
</ul>', CAST(2.00 AS Decimal(18, 2)), 3, 1)
SET IDENTITY_INSERT [dbo].[MemberShip] OFF
SET IDENTITY_INSERT [dbo].[MemberShipVendor] ON 

INSERT [dbo].[MemberShipVendor] ([Id], [MemerShipId], [VendorId], [StartDate], [EndDate], [Price]) VALUES (14, 5, 15, CAST(N'2017-09-12' AS Date), CAST(N'2017-11-12' AS Date), CAST(150.00 AS Decimal(18, 2)))
INSERT [dbo].[MemberShipVendor] ([Id], [MemerShipId], [VendorId], [StartDate], [EndDate], [Price]) VALUES (15, 5, 16, CAST(N'2017-09-12' AS Date), CAST(N'2017-11-12' AS Date), CAST(150.00 AS Decimal(18, 2)))
INSERT [dbo].[MemberShipVendor] ([Id], [MemerShipId], [VendorId], [StartDate], [EndDate], [Price]) VALUES (16, 6, 15, CAST(N'2017-09-12' AS Date), CAST(N'2017-12-12' AS Date), CAST(200.00 AS Decimal(18, 2)))
INSERT [dbo].[MemberShipVendor] ([Id], [MemerShipId], [VendorId], [StartDate], [EndDate], [Price]) VALUES (17, 5, 17, CAST(N'2017-09-12' AS Date), CAST(N'2017-11-12' AS Date), CAST(150.00 AS Decimal(18, 2)))
INSERT [dbo].[MemberShipVendor] ([Id], [MemerShipId], [VendorId], [StartDate], [EndDate], [Price]) VALUES (18, 5, 18, CAST(N'2020-04-28' AS Date), CAST(N'2020-06-28' AS Date), CAST(150.00 AS Decimal(18, 2)))
INSERT [dbo].[MemberShipVendor] ([Id], [MemerShipId], [VendorId], [StartDate], [EndDate], [Price]) VALUES (19, 5, 19, CAST(N'2020-04-28' AS Date), CAST(N'2020-06-28' AS Date), CAST(150.00 AS Decimal(18, 2)))
INSERT [dbo].[MemberShipVendor] ([Id], [MemerShipId], [VendorId], [StartDate], [EndDate], [Price]) VALUES (20, 5, 20, CAST(N'2020-04-30' AS Date), CAST(N'2020-06-30' AS Date), CAST(150.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[MemberShipVendor] OFF
SET IDENTITY_INSERT [dbo].[Message] ON 

INSERT [dbo].[Message] ([Id], [Title], [Body], [DateCreation], [CustomerId], [VendorId], [Status]) VALUES (1002, N'Hello Vendor 2', N'How are you?', CAST(N'2017-09-12' AS Date), 8, 16, 0)
INSERT [dbo].[Message] ([Id], [Title], [Body], [DateCreation], [CustomerId], [VendorId], [Status]) VALUES (1003, N'Hi Vendor 1', N'Nice to meet you', CAST(N'2017-09-12' AS Date), 8, 15, 0)
INSERT [dbo].[Message] ([Id], [Title], [Body], [DateCreation], [CustomerId], [VendorId], [Status]) VALUES (1004, N'halo', N'tanya', CAST(N'2020-04-28' AS Date), 4, 18, 0)
SET IDENTITY_INSERT [dbo].[Message] OFF
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'a4c597b1-c027-4899-85e5-05b906f7f999', N'balestier', N'line2', N'Jayapura', N'123456', 1019)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'2ae55194-735a-4d99-afb1-12cd7867dd63', N'balestier', N'line2', N'Jayapura', N'123456', 2023)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'2fb1f41b-39c1-4752-93ce-13019f3e091b', N'balestier', N'line2', N'Jayapura', N'123456', 1016)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'c81582c1-5d16-4dbe-88e1-3f059a14449f', N'balestier', N'line2', N'Jayapura', N'123456', 2017)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'346562e7-a6c6-4465-ac07-561763c9ff33', N'balestier', N'line2', N'Jayapura', N'123456', 2016)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'7115b506-ed39-49a2-9b96-5d0f34b15d74', N'balestier', N'line2', N'Jayapura', N'123456', 2025)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'6aeb64eb-5c31-4e66-b9b1-6005c6ec8b2c', N'balestier', N'line2', N'Jayapura', N'123456', 1018)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'6e0a76b8-b5dd-4881-96b3-79eb9c53a812', N'balestier', N'line2', N'Jayapura', N'123456', 2020)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'205cbf6b-b8d4-4ea5-afe4-829d49c750cb', N'balestier', N'line2', N'Jayapura', N'123456', 2029)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'78b285c3-2e80-4a54-95e7-87a4fa7c71e2', N'balestier', N'line2', N'Jayapura', N'123456', 2021)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'b6d3b961-0202-489e-bedc-8958eff63a2b', N'balestier', N'line2', N'Jayapura', N'123456', 1017)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'e3ecc12b-4246-4783-af3a-b7ea4fdb6026', N'balestier', N'line2', N'Jayapura', N'123456', 2022)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'06f6732c-4062-48e6-83ba-b9749e8e4f75', N'balestier', N'line2', N'Jayapura', N'123456', 2030)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'92a21e58-68ee-4694-b598-bdd3bb8838ca', N'balestier', N'line2', N'Jayapura', N'123456', 2028)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'49dbf719-5f05-4f43-8d01-d352798bf21d', N'balestier', N'line2', N'Jayapura', N'123456', 2027)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'fbb28162-ef88-4e33-9bd4-de7af3348c6f', N'balestier', N'line2', N'Jayapura', N'123456', 2024)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'8566e8cd-526c-4535-ad85-e69016432275', N'balestier', N'line2', N'Jayapura', N'123456', 2019)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'56694447-601a-4495-8bcd-e6e860dcdeb3', N'balestier', N'line2', N'Jayapura', N'123456', 2026)
INSERT [dbo].[OrderAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [OrderId]) VALUES (N'4844cd4f-5c75-4129-8a51-f9ddac6f875a', N'balestier', N'line2', N'Jayapura', N'123456', 2018)
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (1008, N'New Order for Vendor Vendor 2', CAST(N'2017-09-12' AS Date), 8, 16, 4, 2, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (1009, N'New Order for Vendor Vendor 1', CAST(N'2017-09-12' AS Date), 8, 15, 4, 1, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (1010, N'New Order for Vendor Vendor 2', CAST(N'2017-09-12' AS Date), 8, 16, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (1011, N'New Order for Vendor jufren', CAST(N'2020-04-28' AS Date), 3, 18, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (1012, N'New Order for Vendor jufren', CAST(N'2020-04-28' AS Date), 3, 18, 1, 1, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (1013, N'New Order for Vendor jufren', CAST(N'2020-04-28' AS Date), 4, 18, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (1014, N'New Order for Vendor jufren', CAST(N'2020-04-29' AS Date), 4, 18, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (1015, N'New Order for Vendor jufren', CAST(N'2020-04-29' AS Date), 4, 18, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (1016, N'New Order for Vendor Vendor6', CAST(N'2020-05-01' AS Date), 3, 20, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (1017, N'New Order for Vendor jufren', CAST(N'2020-05-01' AS Date), 3, 18, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (1018, N'New Order for Vendor Vendor6', CAST(N'2020-05-01' AS Date), 3, 20, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (1019, N'New Order for Vendor jufren', CAST(N'2020-05-01' AS Date), 3, 18, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (2016, N'New Order for Vendor jufren', CAST(N'2020-05-01' AS Date), 3, 18, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (2017, N'New Order for Vendor Vendor6', CAST(N'2020-05-01' AS Date), 3, 20, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (2018, N'New Order for Vendor jufren', CAST(N'2020-05-01' AS Date), 3, 18, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (2019, N'New Order for Vendor Vendor6', CAST(N'2020-05-01' AS Date), 3, 20, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (2020, N'New Order for Vendor Vendor6', CAST(N'2020-05-01' AS Date), 3, 20, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (2021, N'New Order for Vendor jufren', CAST(N'2020-05-01' AS Date), 3, 18, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (2022, N'New Order for Vendor Vendor6', CAST(N'2020-05-01' AS Date), 3, 20, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (2023, N'New Order for Vendor jufren', CAST(N'2020-05-01' AS Date), 3, 18, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (2024, N'New Order for Vendor jufren', CAST(N'2020-05-09' AS Date), 3, 18, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (2025, N'New Order for Vendor Vendor6', CAST(N'2020-05-09' AS Date), 3, 20, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (2026, N'New Order for Vendor Vendor6', CAST(N'2020-05-09' AS Date), 3, 20, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (2027, N'New Order for Vendor jufren', CAST(N'2020-05-09' AS Date), 3, 18, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (2028, N'New Order for Vendor jufren', CAST(N'2020-05-09' AS Date), 3, 18, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (2029, N'New Order for Vendor Vendor6', CAST(N'2020-05-09' AS Date), 3, 20, 1, NULL, 1)
INSERT [dbo].[Orders] ([Id], [Name], [DateCreation], [CustomerId], [VendorId], [OrderStatusId], [PaymentId], [PaymentStatusId]) VALUES (2030, N'New Order for Vendor jufren', CAST(N'2020-05-10' AS Date), 3, 18, 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[Orders] OFF
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (1008, 36, CAST(14.00 AS Decimal(18, 2)), 7)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (1008, 37, CAST(23.00 AS Decimal(18, 2)), 6)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (1009, 35, CAST(12.00 AS Decimal(18, 2)), 2)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (1010, 36, CAST(14.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (1011, 43, CAST(100.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (1012, 43, CAST(100.00 AS Decimal(18, 2)), 2)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (1013, 43, CAST(100.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (1014, 44, CAST(1000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (1015, 44, CAST(1000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (1016, 46, CAST(50000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (1017, 44, CAST(1000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (1018, 46, CAST(50000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (1019, 43, CAST(100.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (1019, 44, CAST(1000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2016, 43, CAST(100.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2016, 44, CAST(1000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2017, 46, CAST(50000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2018, 44, CAST(1000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2019, 46, CAST(50000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2020, 46, CAST(50000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2021, 44, CAST(1000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2022, 46, CAST(50000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2023, 44, CAST(1000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2024, 44, CAST(1000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2025, 46, CAST(50000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2026, 46, CAST(50000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2027, 44, CAST(1000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2028, 44, CAST(1000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2029, 46, CAST(50000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[OrdersDetail] ([OrderId], [ProductId], [Price], [Quantity]) VALUES (2030, 44, CAST(1000.00 AS Decimal(18, 2)), 1)
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([Id], [Name], [Status]) VALUES (1, N'New', 1)
INSERT [dbo].[OrderStatus] ([Id], [Name], [Status]) VALUES (4, N'Complete', 1)
INSERT [dbo].[OrderStatus] ([Id], [Name], [Status]) VALUES (6, N'Canceled', 1)
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
SET IDENTITY_INSERT [dbo].[Page] ON 

INSERT [dbo].[Page] ([Id], [Plug], [Title], [Detail], [Status]) VALUES (1, N'about-us', N'About Us', N'	<h5>Lorem ipsum dolor sit amet</h5><br>
	<p>
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam elementum varius dapibus. Sed hendrerit porta felis at sollicitudin. Sed at nunc ac neque semper fermentum. Proin diam sem, semper fermentum eleifend nec, viverra ac est. Sed ultricies, lectus et vehicula imperdiet, felis tortor vehicula turpis, non fermentum enim est et sapien. Nam justo mi, dignissim a euismod ut, pretium sed leo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. In viverra porta est, consequat elementum metus tristique a. Mauris tempus tellus a metus dapibus faucibus egestas lectus consectetur. Integer libero dolor, luctus non congue vitae, tempus ut neque. Nunc eleifend lorem quis diam pharetra sagittis. Aliquam ut dolor dui. Fusce dictum facilisis ipsum eu porttitor. In ultricies rhoncus tortor vitae tincidunt.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Nullam a vulputate leo. Nulla tristique metus eros. Curabitur ultrices commodo mauris, sit amet faucibus lectus fermentum in. Nulla eleifend, augue hendrerit tempus faucibus, diam lacus aliquet urna, eget facilisis turpis risus quis arcu. Cras placerat suscipit sem, ac consequat dui iaculis eu. Cras elit enim, adipiscing lobortis rutrum ac, vehicula nec massa. Praesent pharetra ligula ac erat venenatis feugiat. Quisque id nulla mi. Mauris at orci nec nisi eleifend auctor. Mauris placerat consectetur tincidunt. Nam eu tellus vitae dolor vestibulum commodo. Etiam tristique, urna ac convallis laoreet, enim enim aliquet neque, id cursus risus nulla sed ligula. Nunc quam libero, accumsan vitae consequat at, sollicitudin eget mi. Phasellus in molestie diam. Aliquam enim purus, tempor id sodales non, volutpat eu diam. Donec eu nisl lacinia leo semper lobortis sed sit amet elit.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Aliquam interdum, ipsum a posuere dictum, tellus risus blandit dolor, at tristique sapien urna vel purus. Pellentesque in dictum urna. Sed feugiat libero sit amet arcu malesuada eu convallis dui convallis. Donec facilisis massa a ipsum aliquam lobortis. Praesent ac lectus sed leo aliquam egestas. Sed ante neque, volutpat ac tempor et, bibendum at ligula. Nunc porta vestibulum sodales.
	</p>
	<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Nullam a vulputate leo. Nulla tristique metus eros. Curabitur ultrices commodo mauris, sit amet faucibus lectus fermentum in. Nulla eleifend, augue hendrerit tempus faucibus, diam lacus aliquet urna, eget facilisis turpis risus quis arcu. Cras placerat suscipit sem, ac consequat dui iaculis eu. Cras elit enim, adipiscing lobortis rutrum ac, vehicula nec massa. Praesent pharetra ligula ac erat venenatis feugiat. Quisque id nulla mi. Mauris at orci nec nisi eleifend auctor. Mauris placerat consectetur tincidunt. Nam eu tellus vitae dolor vestibulum commodo. Etiam tristique, urna ac convallis laoreet, enim enim aliquet neque, id cursus risus nulla sed ligula. Nunc quam libero, accumsan vitae consequat at, sollicitudin eget mi. Phasellus in molestie diam. Aliquam enim purus, tempor id sodales non, volutpat eu diam. Donec eu nisl lacinia leo semper lobortis sed sit amet elit.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Aliquam interdum, ipsum a posuere dictum, tellus risus blandit dolor, at tristique sapien urna vel purus. Pellentesque in dictum urna. Sed feugiat libero sit amet arcu malesuada eu convallis dui convallis. Donec facilisis massa a ipsum aliquam lobortis. Praesent ac lectus sed leo aliquam egestas. Sed ante neque, volutpat ac tempor et, bibendum at ligula. Nunc porta vestibulum sodales.
	</p>
	<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Nullam a vulputate leo. Nulla tristique metus eros. Curabitur ultrices commodo mauris, sit amet faucibus lectus fermentum in. Nulla eleifend, augue hendrerit tempus faucibus, diam lacus aliquet urna, eget facilisis turpis risus quis arcu. Cras placerat suscipit sem, ac consequat dui iaculis eu. Cras elit enim, adipiscing lobortis rutrum ac, vehicula nec massa. Praesent pharetra ligula ac erat venenatis feugiat. Quisque id nulla mi. Mauris at orci nec nisi eleifend auctor. Mauris placerat consectetur tincidunt. Nam eu tellus vitae dolor vestibulum commodo. Etiam tristique, urna ac convallis laoreet, enim enim aliquet neque, id cursus risus nulla sed ligula. Nunc quam libero, accumsan vitae consequat at, sollicitudin eget mi. Phasellus in molestie diam. Aliquam enim purus, tempor id sodales non, volutpat eu diam. Donec eu nisl lacinia leo semper lobortis sed sit amet elit.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Aliquam interdum, ipsum a posuere dictum, tellus risus blandit dolor, at tristique sapien urna vel purus. Pellentesque in dictum urna. Sed feugiat libero sit amet arcu malesuada eu convallis dui convallis. Donec facilisis massa a ipsum aliquam lobortis. Praesent ac lectus sed leo aliquam egestas. Sed ante neque, volutpat ac tempor et, bibendum at ligula. Nunc porta vestibulum sodales.
	</p>
', 0)
INSERT [dbo].[Page] ([Id], [Plug], [Title], [Detail], [Status]) VALUES (3, N'legal-notice', N'LEGAL NOTICE', N'	<h5>Lorem ipsum dolor sit amet</h5><br>
	<p>
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam elementum varius dapibus. Sed hendrerit porta felis at sollicitudin. Sed at nunc ac neque semper fermentum. Proin diam sem, semper fermentum eleifend nec, viverra ac est. Sed ultricies, lectus et vehicula imperdiet, felis tortor vehicula turpis, non fermentum enim est et sapien. Nam justo mi, dignissim a euismod ut, pretium sed leo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. In viverra porta est, consequat elementum metus tristique a. Mauris tempus tellus a metus dapibus faucibus egestas lectus consectetur. Integer libero dolor, luctus non congue vitae, tempus ut neque. Nunc eleifend lorem quis diam pharetra sagittis. Aliquam ut dolor dui. Fusce dictum facilisis ipsum eu porttitor. In ultricies rhoncus tortor vitae tincidunt.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Nullam a vulputate leo. Nulla tristique metus eros. Curabitur ultrices commodo mauris, sit amet faucibus lectus fermentum in. Nulla eleifend, augue hendrerit tempus faucibus, diam lacus aliquet urna, eget facilisis turpis risus quis arcu. Cras placerat suscipit sem, ac consequat dui iaculis eu. Cras elit enim, adipiscing lobortis rutrum ac, vehicula nec massa. Praesent pharetra ligula ac erat venenatis feugiat. Quisque id nulla mi. Mauris at orci nec nisi eleifend auctor. Mauris placerat consectetur tincidunt. Nam eu tellus vitae dolor vestibulum commodo. Etiam tristique, urna ac convallis laoreet, enim enim aliquet neque, id cursus risus nulla sed ligula. Nunc quam libero, accumsan vitae consequat at, sollicitudin eget mi. Phasellus in molestie diam. Aliquam enim purus, tempor id sodales non, volutpat eu diam. Donec eu nisl lacinia leo semper lobortis sed sit amet elit.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Aliquam interdum, ipsum a posuere dictum, tellus risus blandit dolor, at tristique sapien urna vel purus. Pellentesque in dictum urna. Sed feugiat libero sit amet arcu malesuada eu convallis dui convallis. Donec facilisis massa a ipsum aliquam lobortis. Praesent ac lectus sed leo aliquam egestas. Sed ante neque, volutpat ac tempor et, bibendum at ligula. Nunc porta vestibulum sodales.
	</p>
	<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Nullam a vulputate leo. Nulla tristique metus eros. Curabitur ultrices commodo mauris, sit amet faucibus lectus fermentum in. Nulla eleifend, augue hendrerit tempus faucibus, diam lacus aliquet urna, eget facilisis turpis risus quis arcu. Cras placerat suscipit sem, ac consequat dui iaculis eu. Cras elit enim, adipiscing lobortis rutrum ac, vehicula nec massa. Praesent pharetra ligula ac erat venenatis feugiat. Quisque id nulla mi. Mauris at orci nec nisi eleifend auctor. Mauris placerat consectetur tincidunt. Nam eu tellus vitae dolor vestibulum commodo. Etiam tristique, urna ac convallis laoreet, enim enim aliquet neque, id cursus risus nulla sed ligula. Nunc quam libero, accumsan vitae consequat at, sollicitudin eget mi. Phasellus in molestie diam. Aliquam enim purus, tempor id sodales non, volutpat eu diam. Donec eu nisl lacinia leo semper lobortis sed sit amet elit.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Aliquam interdum, ipsum a posuere dictum, tellus risus blandit dolor, at tristique sapien urna vel purus. Pellentesque in dictum urna. Sed feugiat libero sit amet arcu malesuada eu convallis dui convallis. Donec facilisis massa a ipsum aliquam lobortis. Praesent ac lectus sed leo aliquam egestas. Sed ante neque, volutpat ac tempor et, bibendum at ligula. Nunc porta vestibulum sodales.
	</p>
	<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Nullam a vulputate leo. Nulla tristique metus eros. Curabitur ultrices commodo mauris, sit amet faucibus lectus fermentum in. Nulla eleifend, augue hendrerit tempus faucibus, diam lacus aliquet urna, eget facilisis turpis risus quis arcu. Cras placerat suscipit sem, ac consequat dui iaculis eu. Cras elit enim, adipiscing lobortis rutrum ac, vehicula nec massa. Praesent pharetra ligula ac erat venenatis feugiat. Quisque id nulla mi. Mauris at orci nec nisi eleifend auctor. Mauris placerat consectetur tincidunt. Nam eu tellus vitae dolor vestibulum commodo. Etiam tristique, urna ac convallis laoreet, enim enim aliquet neque, id cursus risus nulla sed ligula. Nunc quam libero, accumsan vitae consequat at, sollicitudin eget mi. Phasellus in molestie diam. Aliquam enim purus, tempor id sodales non, volutpat eu diam. Donec eu nisl lacinia leo semper lobortis sed sit amet elit.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Aliquam interdum, ipsum a posuere dictum, tellus risus blandit dolor, at tristique sapien urna vel purus. Pellentesque in dictum urna. Sed feugiat libero sit amet arcu malesuada eu convallis dui convallis. Donec facilisis massa a ipsum aliquam lobortis. Praesent ac lectus sed leo aliquam egestas. Sed ante neque, volutpat ac tempor et, bibendum at ligula. Nunc porta vestibulum sodales.
	</p>
', 1)
INSERT [dbo].[Page] ([Id], [Plug], [Title], [Detail], [Status]) VALUES (4, N'tac', N'TERMS AND CONDITIONS', N'	<h5>Lorem ipsum dolor sit amet</h5><br>
	<p>
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam elementum varius dapibus. Sed hendrerit porta felis at sollicitudin. Sed at nunc ac neque semper fermentum. Proin diam sem, semper fermentum eleifend nec, viverra ac est. Sed ultricies, lectus et vehicula imperdiet, felis tortor vehicula turpis, non fermentum enim est et sapien. Nam justo mi, dignissim a euismod ut, pretium sed leo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. In viverra porta est, consequat elementum metus tristique a. Mauris tempus tellus a metus dapibus faucibus egestas lectus consectetur. Integer libero dolor, luctus non congue vitae, tempus ut neque. Nunc eleifend lorem quis diam pharetra sagittis. Aliquam ut dolor dui. Fusce dictum facilisis ipsum eu porttitor. In ultricies rhoncus tortor vitae tincidunt.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Nullam a vulputate leo. Nulla tristique metus eros. Curabitur ultrices commodo mauris, sit amet faucibus lectus fermentum in. Nulla eleifend, augue hendrerit tempus faucibus, diam lacus aliquet urna, eget facilisis turpis risus quis arcu. Cras placerat suscipit sem, ac consequat dui iaculis eu. Cras elit enim, adipiscing lobortis rutrum ac, vehicula nec massa. Praesent pharetra ligula ac erat venenatis feugiat. Quisque id nulla mi. Mauris at orci nec nisi eleifend auctor. Mauris placerat consectetur tincidunt. Nam eu tellus vitae dolor vestibulum commodo. Etiam tristique, urna ac convallis laoreet, enim enim aliquet neque, id cursus risus nulla sed ligula. Nunc quam libero, accumsan vitae consequat at, sollicitudin eget mi. Phasellus in molestie diam. Aliquam enim purus, tempor id sodales non, volutpat eu diam. Donec eu nisl lacinia leo semper lobortis sed sit amet elit.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Aliquam interdum, ipsum a posuere dictum, tellus risus blandit dolor, at tristique sapien urna vel purus. Pellentesque in dictum urna. Sed feugiat libero sit amet arcu malesuada eu convallis dui convallis. Donec facilisis massa a ipsum aliquam lobortis. Praesent ac lectus sed leo aliquam egestas. Sed ante neque, volutpat ac tempor et, bibendum at ligula. Nunc porta vestibulum sodales.
	</p>
	<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Nullam a vulputate leo. Nulla tristique metus eros. Curabitur ultrices commodo mauris, sit amet faucibus lectus fermentum in. Nulla eleifend, augue hendrerit tempus faucibus, diam lacus aliquet urna, eget facilisis turpis risus quis arcu. Cras placerat suscipit sem, ac consequat dui iaculis eu. Cras elit enim, adipiscing lobortis rutrum ac, vehicula nec massa. Praesent pharetra ligula ac erat venenatis feugiat. Quisque id nulla mi. Mauris at orci nec nisi eleifend auctor. Mauris placerat consectetur tincidunt. Nam eu tellus vitae dolor vestibulum commodo. Etiam tristique, urna ac convallis laoreet, enim enim aliquet neque, id cursus risus nulla sed ligula. Nunc quam libero, accumsan vitae consequat at, sollicitudin eget mi. Phasellus in molestie diam. Aliquam enim purus, tempor id sodales non, volutpat eu diam. Donec eu nisl lacinia leo semper lobortis sed sit amet elit.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Aliquam interdum, ipsum a posuere dictum, tellus risus blandit dolor, at tristique sapien urna vel purus. Pellentesque in dictum urna. Sed feugiat libero sit amet arcu malesuada eu convallis dui convallis. Donec facilisis massa a ipsum aliquam lobortis. Praesent ac lectus sed leo aliquam egestas. Sed ante neque, volutpat ac tempor et, bibendum at ligula. Nunc porta vestibulum sodales.
	</p>
	<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Nullam a vulputate leo. Nulla tristique metus eros. Curabitur ultrices commodo mauris, sit amet faucibus lectus fermentum in. Nulla eleifend, augue hendrerit tempus faucibus, diam lacus aliquet urna, eget facilisis turpis risus quis arcu. Cras placerat suscipit sem, ac consequat dui iaculis eu. Cras elit enim, adipiscing lobortis rutrum ac, vehicula nec massa. Praesent pharetra ligula ac erat venenatis feugiat. Quisque id nulla mi. Mauris at orci nec nisi eleifend auctor. Mauris placerat consectetur tincidunt. Nam eu tellus vitae dolor vestibulum commodo. Etiam tristique, urna ac convallis laoreet, enim enim aliquet neque, id cursus risus nulla sed ligula. Nunc quam libero, accumsan vitae consequat at, sollicitudin eget mi. Phasellus in molestie diam. Aliquam enim purus, tempor id sodales non, volutpat eu diam. Donec eu nisl lacinia leo semper lobortis sed sit amet elit.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br>
<p>
Aliquam interdum, ipsum a posuere dictum, tellus risus blandit dolor, at tristique sapien urna vel purus. Pellentesque in dictum urna. Sed feugiat libero sit amet arcu malesuada eu convallis dui convallis. Donec facilisis massa a ipsum aliquam lobortis. Praesent ac lectus sed leo aliquam egestas. Sed ante neque, volutpat ac tempor et, bibendum at ligula. Nunc porta vestibulum sodales.
	</p>
', 1)
INSERT [dbo].[Page] ([Id], [Plug], [Title], [Detail], [Status]) VALUES (5, N'faq', N'FAQ', N'<div class="accordion" id="accordion2">
	<div class="accordion-group">
	  <div class="accordion-heading">
		<h4><a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
		  Collapsible Group Item #1
		</a></h4>
	  </div>
	  <div id="collapseOne" class="accordion-body collapse" style="height: 0px;">
		<div class="accordion-inner">
			Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven''t heard of them accusamus labore sustainable VHS.
			<br><br>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam elementum varius dapibus. Sed hendrerit porta felis at sollicitudin. Sed at nunc ac neque semper fermentum. Proin diam sem, semper fermentum eleifend nec, viverra ac est. Sed ultricies, lectus et vehicula imperdiet, felis tortor vehicula turpis, non fermentum enim est et sapien. Nam justo mi, dignissim a euismod ut, pretium sed leo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. In viverra porta est, consequat elementum metus tristique a. Mauris tempus tellus a metus dapibus faucibus egestas lectus consectetur. Integer libero dolor, luctus non congue vitae, tempus ut neque. Nunc eleifend lorem quis diam pharetra sagittis. Aliquam ut dolor dui. Fusce dictum facilisis ipsum eu porttitor. In ultricies rhoncus tortor vitae tincidunt.
			<br><br>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam elementum varius dapibus. Sed hendrerit porta felis at sollicitudin. Sed at nunc ac neque semper fermentum. Proin diam sem, semper fermentum eleifend nec, viverra ac est. Sed ultricies, lectus et vehicula imperdiet, felis tortor vehicula turpis, non fermentum enim est et sapien. Nam justo mi, dignissim a euismod ut, pretium sed leo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. In viverra porta est, consequat elementum metus tristique a. Mauris tempus tellus a metus dapibus faucibus egestas lectus consectetur. Integer libero dolor, luctus non congue vitae, tempus ut neque. Nunc eleifend lorem quis diam pharetra sagittis. Aliquam ut dolor dui. Fusce dictum facilisis ipsum eu porttitor. In ultricies rhoncus tortor vitae tincidunt.

		</div>
	  </div>
	</div>
	<div class="accordion-group">
	  <div class="accordion-heading">
		<h4><a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo">
		  Collapsible Group Item #2
		</a></h4>
	  </div>
	  <div id="collapseTwo" class="accordion-body collapse">
		<div class="accordion-inner">
		  Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven''t heard of them accusamus labore sustainable VHS.
		</div>
	  </div>
	</div>
	<div class="accordion-group">
	  <div class="accordion-heading">
		<h4><a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion2" href="#collapseThree">
		  Collapsible Group Item #3
		</a></h4>
	  </div>
	  <div id="collapseThree" class="accordion-body collapse">
		<div class="accordion-inner">
		  Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven''t heard of them accusamus labore sustainable VHS.
		</div>
	  </div>
	</div>
	
	<div class="accordion-group">
	  <div class="accordion-heading">
		<h4><a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion2" href="#collapseFour">
		  Collapsible Group Item #4
		</a></h4>
	  </div>
	  <div id="collapseFour" class="accordion-body collapse">
		<div class="accordion-inner">
		  Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven''t heard of them accusamus labore sustainable VHS.
		</div>
	  </div>
	</div>
	
	<div class="accordion-group">
	  <div class="accordion-heading">
		<h4><a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion2" href="#collapseFive">
		  Collapsible Group Item #5
		</a></h4>
	  </div>
	  <div id="collapseFive" class="accordion-body collapse">
		<div class="accordion-inner">
		  Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven''t heard of them accusamus labore sustainable VHS.
		</div>
	  </div>
	</div>
	
	<div class="accordion-group">
	  <div class="accordion-heading">
		<h4><a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion2" href="#collapseSix">
		  Collapsible Group Item #6
		</a></h4>
	  </div>
	  <div id="collapseSix" class="accordion-body collapse">
		<div class="accordion-inner">
		  Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven''t heard of them accusamus labore sustainable VHS.
		</div>
	  </div>
	</div>
  </div>', 1)
SET IDENTITY_INSERT [dbo].[Page] OFF
SET IDENTITY_INSERT [dbo].[Payment] ON 

INSERT [dbo].[Payment] ([Id], [Name], [Status]) VALUES (1, N'Paypal', 1)
INSERT [dbo].[Payment] ([Id], [Name], [Status]) VALUES (2, N'Cash', 1)
SET IDENTITY_INSERT [dbo].[Payment] OFF
INSERT [dbo].[PaymentStatus] ([Id], [Name]) VALUES (1, N'Processing')
INSERT [dbo].[PaymentStatus] ([Id], [Name]) VALUES (2, N'Paid')
INSERT [dbo].[PaymentStatus] ([Id], [Name]) VALUES (3, N'PaymentFailed')
SET IDENTITY_INSERT [dbo].[Photo] ON 

INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (14, N'201709120039154981.jpg', 1, 1, 34)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (15, N'201709120039312542.jpg', 0, 0, 34)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (16, N'201709120040144126.jpg', 1, 1, 35)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (17, N'201709120040326488.jpg', 1, 0, 35)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (18, N'2017091200404741312.jpg', 1, 0, 35)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (19, N'201709120043447817.jpg', 1, 1, 36)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (20, N'201709120044017616.jpg', 1, 0, 36)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (21, N'2017091200441225911.jpg', 0, 0, 36)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (22, N'20170912004546054b1.jpg', 1, 1, 37)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (23, N'20170912004553849b2.jpg', 1, 0, 37)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (24, N'20170912004608794b3.jpg', 1, 0, 37)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (25, N'20170912004618212b4.jpg', 1, 0, 37)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (26, N'201709120927116752.jpg', 1, 1, 38)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (27, N'201709120927206924.jpg', 1, 0, 38)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (28, N'20170912092755197kindle.png', 1, 1, 39)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (29, N'201709120928180519.jpg', 1, 0, 39)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (30, N'201709120932091181.jpg', 1, 1, 40)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (31, N'201709120932191963.jpg', 1, 0, 40)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (32, N'201709120932467386.jpg', 1, 1, 41)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (33, N'201709120932582827.jpg', 1, 0, 41)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (34, N'20200429195213050laptop.jpg', 1, 1, 43)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (35, N'20200429195427426laptop.jpg', 1, 1, 44)
INSERT [dbo].[Photo] ([Id], [Name], [Status], [Main], [ProductId]) VALUES (36, N'20200501095837150images.jpg', 1, 1, 46)
SET IDENTITY_INSERT [dbo].[Photo] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [Name], [Price], [Quantity], [Description], [Status], [CategoryId], [VendorId], [Views], [WeightInGrams]) VALUES (34, N'Product 1', CAST(20.00 AS Decimal(18, 2)), 200, N'<p>Description Product 1</p>', 1, 40, 15, 0, 10)
INSERT [dbo].[Product] ([Id], [Name], [Price], [Quantity], [Description], [Status], [CategoryId], [VendorId], [Views], [WeightInGrams]) VALUES (35, N'Product 2', CAST(12.00 AS Decimal(18, 2)), 500, N'<p>Description Product 2</p>', 1, 49, 15, 1, 10)
INSERT [dbo].[Product] ([Id], [Name], [Price], [Quantity], [Description], [Status], [CategoryId], [VendorId], [Views], [WeightInGrams]) VALUES (36, N'Product 3', CAST(14.00 AS Decimal(18, 2)), 6, N'<p>Description Product 3</p>', 1, 52, 16, 0, 10)
INSERT [dbo].[Product] ([Id], [Name], [Price], [Quantity], [Description], [Status], [CategoryId], [VendorId], [Views], [WeightInGrams]) VALUES (37, N'Product 4', CAST(23.00 AS Decimal(18, 2)), 5, N'<p>Description product 4</p>', 1, 44, 16, 1, 10)
INSERT [dbo].[Product] ([Id], [Name], [Price], [Quantity], [Description], [Status], [CategoryId], [VendorId], [Views], [WeightInGrams]) VALUES (38, N'Product 5', CAST(21.00 AS Decimal(18, 2)), 6, N'<p>Description Product 5</p>', 1, 47, 17, 1, 10)
INSERT [dbo].[Product] ([Id], [Name], [Price], [Quantity], [Description], [Status], [CategoryId], [VendorId], [Views], [WeightInGrams]) VALUES (39, N'Product 6', CAST(24.00 AS Decimal(18, 2)), 200, N'<p>Description Product 6</p>', 1, 45, 17, 2, 10)
INSERT [dbo].[Product] ([Id], [Name], [Price], [Quantity], [Description], [Status], [CategoryId], [VendorId], [Views], [WeightInGrams]) VALUES (40, N'Product 7', CAST(24.00 AS Decimal(18, 2)), 200, N'<p>Description Product 7</p>', 1, 45, 17, 0, 10)
INSERT [dbo].[Product] ([Id], [Name], [Price], [Quantity], [Description], [Status], [CategoryId], [VendorId], [Views], [WeightInGrams]) VALUES (41, N'Product 8', CAST(20.00 AS Decimal(18, 2)), 7, N'<p>Description Product 8</p>', 1, 45, 17, 0, 10)
INSERT [dbo].[Product] ([Id], [Name], [Price], [Quantity], [Description], [Status], [CategoryId], [VendorId], [Views], [WeightInGrams]) VALUES (43, N'testproduct', CAST(100.00 AS Decimal(18, 2)), 10, N'<p>test</p>', 1, 40, 18, 11, 10)
INSERT [dbo].[Product] ([Id], [Name], [Price], [Quantity], [Description], [Status], [CategoryId], [VendorId], [Views], [WeightInGrams]) VALUES (44, N'Laptop', CAST(1000.00 AS Decimal(18, 2)), 10, N'<p>test</p>', 1, 40, 18, 8, 10)
INSERT [dbo].[Product] ([Id], [Name], [Price], [Quantity], [Description], [Status], [CategoryId], [VendorId], [Views], [WeightInGrams]) VALUES (46, N'Mouse', CAST(50000.00 AS Decimal(18, 2)), 100, N'<p>test</p>', 1, 40, 20, 4, 20)
SET IDENTITY_INSERT [dbo].[Product] OFF
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'9bdc044b-ac96-48ce-98fb-0007c3bb2196', N'328', N'28', N'Sulawesi Selatan', N'Kota', N'Palopo', N'91911')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'10b319be-5405-4607-bddf-0145b09b8e89', N'73', N'31', N'Sulawesi Utara', N'Kota', N'Bitung', N'95512')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'863e67b9-6362-431f-81e8-02272a0a0c78', N'276', N'22', N'Nusa Tenggara Barat (NTB)', N'Kota', N'Mataram', N'83131')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'9cdfec83-e988-4513-b124-052bee5d7ad2', N'62', N'4', N'Bengkulu', N'Kota', N'Bengkulu', N'38229')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'b0bf8422-cab5-4360-95dc-07836b595305', N'242', N'33', N'Sumatera Selatan', N'Kota', N'Lubuk Linggau', N'31614')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'c2614d51-8308-4a31-a49e-08449a547268', N'51', N'11', N'Jawa Timur', N'Kota', N'Batu', N'65311')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'586774bd-85a5-4a71-ae87-08ca79cb305f', N'235', N'21', N'Nanggroe Aceh Darussalam (NAD)', N'Kota', N'Lhokseumawe', N'24352')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'83fe6ac6-43c8-4a42-b697-0bdd4c990dce', N'337', N'32', N'Sumatera Barat', N'Kota', N'Pariaman', N'25511')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'55d52565-6803-41bb-bd34-0db5787a3536', N'403', N'3', N'Banten', N'Kota', N'Serang', N'42111')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'aa2406dd-6f55-4096-8cd0-1026c5f24d5c', N'459', N'34', N'Sumatera Utara', N'Kota', N'Tanjung Balai', N'21321')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'571c25d2-5fb2-4f2d-96c4-16586624ce26', N'326', N'14', N'Kalimantan Tengah', N'Kota', N'Palangka Raya', N'73112')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'3496decd-3dc3-4970-945f-17821ff6b02c', N'467', N'16', N'Kalimantan Utara', N'Kota', N'Tarakan', N'77114')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'4a85691c-01be-4bc2-9513-178f3f73f3e3', N'321', N'32', N'Sumatera Barat', N'Kota', N'Padang Panjang', N'27122')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'8dfc62fb-d6cf-400a-96f1-1ddc0fd2c747', N'182', N'30', N'Sulawesi Tenggara', N'Kota', N'Kendari', N'93126')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'88d4fc5a-8ce0-4c47-8ece-1e0de29f5247', N'20', N'21', N'Nanggroe Aceh Darussalam (NAD)', N'Kota', N'Banda Aceh', N'23238')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'fab71adf-8c54-4f8b-bdbd-1e959eca8a78', N'213', N'23', N'Nusa Tenggara Timur (NTT)', N'Kota', N'Kupang', N'85119')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'5120be3f-f5c5-4e6a-95f9-230daab0b4ac', N'425', N'25', N'Papua Barat', N'Kota', N'Sorong', N'98411')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'b8d83219-1a9d-4fe0-bec7-258eaf92e7fd', N'267', N'31', N'Sulawesi Utara', N'Kota', N'Manado', N'95247')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'ae3ab7f5-ada9-46da-a502-277f00f6b215', N'488', N'19', N'Maluku', N'Kota', N'Tual', N'97612')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'1d817513-dd0a-4414-b424-297eda0480a4', N'115', N'9', N'Jawa Barat', N'Kota', N'Depok', N'16416')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'0f24c020-2e1a-49f9-8d53-2af0570a7e5a', N'250', N'10', N'Jawa Tengah', N'Kota', N'Magelang', N'56133')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'28ecc71e-9472-4e67-bd71-2affd50186c2', N'179', N'11', N'Jawa Timur', N'Kota', N'Kediri', N'64125')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'0c621523-6902-48bd-a085-2b79462a3283', N'34', N'9', N'Jawa Barat', N'Kota', N'Banjar', N'46311')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'87fc1305-f62d-4c57-9274-2db53b230d7a', N'107', N'9', N'Jawa Barat', N'Kota', N'Cimahi', N'40512')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'ccf5a43f-2822-4b1d-8433-30e7d47d1bc3', N'283', N'18', N'Lampung', N'Kota', N'Metro', N'34111')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'26fcefc8-67ef-41e7-b442-32aab4ce53c7', N'53', N'30', N'Sulawesi Tenggara', N'Kota', N'Bau-Bau', N'93719')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'312728db-61e1-4389-ab78-3b0c6236860e', N'248', N'11', N'Jawa Timur', N'Kota', N'Madiun', N'63122')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'6ddc6d34-12a0-41e3-b52a-3b0d3dbe7808', N'48', N'17', N'Kepulauan Riau', N'Kota', N'Batam', N'29413')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'aa6ddbf4-0977-4fc7-9121-3f87f64f36b3', N'89', N'15', N'Kalimantan Timur', N'Kota', N'Bontang', N'75313')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'3436aa7c-71c8-4c63-a961-40b0dceaa3f7', N'23', N'9', N'Jawa Barat', N'Kota', N'Bandung', N'40111')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'f5233bcf-5d78-480e-a539-43a275b179ae', N'256', N'11', N'Jawa Timur', N'Kota', N'Malang', N'65112')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'90ad908d-5bad-4439-bed3-4621f5c68355', N'387', N'15', N'Kalimantan Timur', N'Kota', N'Samarinda', N'75133')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'04f7ba42-5e93-4327-907f-485c9fd142c6', N'386', N'10', N'Jawa Tengah', N'Kota', N'Salatiga', N'50711')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'e751e18e-ec6e-4af7-9676-496e100a4e4d', N'350', N'26', N'Riau', N'Kota', N'Pekanbaru', N'28112')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'b38b0f71-898d-4aed-8442-4a4af4b6950e', N'327', N'33', N'Sumatera Selatan', N'Kota', N'Palembang', N'30111')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'9f34089a-5a48-4e21-8410-50111b1bd9e0', N'353', N'34', N'Sumatera Utara', N'Kota', N'Pematang Siantar', N'21126')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'56f2cd19-a3fb-46ff-a785-52e6aa19f2d2', N'153', N'6', N'DKI Jakarta', N'Kota', N'Jakarta Selatan', N'12230')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'797de186-a250-44ca-bf19-56835f4fd3b6', N'93', N'32', N'Sumatera Barat', N'Kota', N'Bukittinggi', N'26115')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'7e800f59-901b-43d5-a711-576191649dd8', N'456', N'3', N'Banten', N'Kota', N'Tangerang', N'15111')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'3eae63d7-91da-43b7-8693-5d6c89f0cf03', N'204', N'31', N'Sulawesi Utara', N'Kota', N'Kotamobagu', N'95711')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'9824961a-2c5c-4347-b945-5f435bbfeee8', N'444', N'11', N'Jawa Timur', N'Kota', N'Surabaya', N'60119')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'fedb5b1a-4d11-4054-aa63-64c7f2bb871e', N'14', N'19', N'Maluku', N'Kota', N'Ambon', N'97222')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'3c084545-7e79-4111-9954-672a89db8943', N'21', N'18', N'Lampung', N'Kota', N'Bandar Lampung', N'35139')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'c26938f2-4319-4980-8915-67ddb1b4d58e', N'478', N'20', N'Maluku Utara', N'Kota', N'Tidore Kepulauan', N'97815')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'72f77b4e-05ff-41be-bd8f-689ee234cdb7', N'445', N'10', N'Jawa Tengah', N'Kota', N'Surakarta (Solo)', N'57113')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'3ff47898-d9fb-4644-a5a7-6f6872c5b6a5', N'442', N'8', N'Jambi', N'Kota', N'Sungaipenuh', N'37113')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'6c628519-dcdf-448e-8302-7a0e86900c18', N'336', N'28', N'Sulawesi Selatan', N'Kota', N'Parepare', N'91123')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'3df54682-f467-48e7-b0af-7a144ce40997', N'69', N'22', N'Nusa Tenggara Barat (NTB)', N'Kota', N'Bima', N'84139')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'eca9ba31-e1d4-4311-a458-7a19615db453', N'421', N'32', N'Sumatera Barat', N'Kota', N'Solok', N'27315')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'5aa9af56-295d-4a73-bd3c-8307e2511d72', N'485', N'31', N'Sulawesi Utara', N'Kota', N'Tomohon', N'95416')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'133af046-bfb6-48ff-b35b-8787d9f5b5ed', N'151', N'6', N'DKI Jakarta', N'Kota', N'Jakarta Barat', N'11220')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'9038e148-e53d-42be-ad1f-893ef16aba4b', N'394', N'32', N'Sumatera Barat', N'Kota', N'Sawah Lunto', N'27416')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'693a088c-cb79-4d5b-be9c-8a21987f4d13', N'323', N'34', N'Sumatera Utara', N'Kota', N'Padang Sidempuan', N'22727')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'ae0ed142-3264-4196-a46c-8b2f3b2653ea', N'230', N'21', N'Nanggroe Aceh Darussalam (NAD)', N'Kota', N'Langsa', N'24412')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'92de598a-6b30-4ebf-8a72-8d8efb92a119', N'55', N'9', N'Jawa Barat', N'Kota', N'Bekasi', N'17121')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'c362515f-0499-4bf7-9ae0-8e5515622290', N'154', N'6', N'DKI Jakarta', N'Kota', N'Jakarta Timur', N'13330')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'5f427bdb-9831-4516-935c-8f7ae14eb216', N'114', N'1', N'Bali', N'Kota', N'Denpasar', N'80227')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'f7a844be-8efb-4b8e-ae77-9195589e2733', N'318', N'32', N'Sumatera Barat', N'Kota', N'Padang', N'25112')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'6395e644-0361-4b4e-a899-93f583795274', N'75', N'11', N'Jawa Timur', N'Kota', N'Blitar', N'66124')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'0aede14d-e356-4315-a626-95220783c565', N'329', N'29', N'Sulawesi Tengah', N'Kota', N'Palu', N'94111')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'1d3640e5-8fc1-4270-85d4-98c1c5520e82', N'343', N'11', N'Jawa Timur', N'Kota', N'Pasuruan', N'67118')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'9bdd9837-ced0-48ff-9587-99d94f71943c', N'429', N'21', N'Nanggroe Aceh Darussalam (NAD)', N'Kota', N'Subulussalam', N'24882')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'380e97ae-225d-44db-9de8-9f9d9985b8d9', N'470', N'34', N'Sumatera Utara', N'Kota', N'Tebing Tinggi', N'20632')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'53fad079-2614-4009-9772-a077ce55b396', N'349', N'10', N'Jawa Tengah', N'Kota', N'Pekalongan', N'51122')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'2560fb88-b449-407e-89ce-a0c3c9e68c16', N'367', N'33', N'Sumatera Selatan', N'Kota', N'Prabumulih', N'31121')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'5a70aad0-1cb3-439e-9bf3-a4a7ee4e0603', N'158', N'24', N'Papua', N'Kota', N'Jayapura', N'99114')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'165a38a8-3b6d-4088-9915-a538520910ec', N'370', N'11', N'Jawa Timur', N'Kota', N'Probolinggo', N'67215')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'17b107b5-0deb-402f-91ff-abf3fb1111b0', N'109', N'9', N'Jawa Barat', N'Kota', N'Cirebon', N'45116')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'c7ce6645-f7e4-47fc-a53f-b27470d8d6b3', N'384', N'21', N'Nanggroe Aceh Darussalam (NAD)', N'Kota', N'Sabang', N'23512')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'ff59abe1-ed14-4398-9f12-b3ae072175e3', N'79', N'9', N'Jawa Barat', N'Kota', N'Bogor', N'16119')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'257b33f4-7770-49b3-97d5-b4eb864c45aa', N'324', N'33', N'Sumatera Selatan', N'Kota', N'Pagar Alam', N'31512')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'e2a7cb3c-9e2f-4495-9679-b7e2135ba940', N'501', N'5', N'DI Yogyakarta', N'Kota', N'Yogyakarta', N'55111')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'46ddc4c5-706a-4835-a11d-b947ce592dce', N'477', N'20', N'Maluku Utara', N'Kota', N'Ternate', N'97714')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'90b65eab-4f56-40c9-8f98-b9aea0f16de6', N'120', N'26', N'Riau', N'Kota', N'Dumai', N'28811')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'1519f5dd-dc30-4687-b6d7-bf58d61ad85d', N'278', N'34', N'Sumatera Utara', N'Kota', N'Medan', N'20228')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'808c55ce-94c6-4615-b6ed-c286b656c769', N'70', N'34', N'Sumatera Utara', N'Kota', N'Binjai', N'20712')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'5b7ea3ab-5a89-4600-84f3-c453f5d31c46', N'130', N'7', N'Gorontalo', N'Kota', N'Gorontalo', N'96115')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'19ce433d-516e-4242-acf2-c67122fb602b', N'156', N'8', N'Jambi', N'Kota', N'Jambi', N'36111')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'65cbf3d8-b228-4acd-86a4-ca1b7b524e9b', N'290', N'11', N'Jawa Timur', N'Kota', N'Mojokerto', N'61316')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'6b0be905-6bbd-4f5d-9d9d-d13e133b1c95', N'457', N'3', N'Banten', N'Kota', N'Tangerang Selatan', N'15332')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'266216a7-d29d-41ab-936f-d358602b613c', N'431', N'9', N'Jawa Barat', N'Kota', N'Sukabumi', N'43114')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'9872cbfd-8dea-4448-95b5-d52df4cdf6b2', N'35', N'13', N'Kalimantan Selatan', N'Kota', N'Banjarbaru', N'70712')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'a1c64413-965f-4dfb-9a05-d8d10651d199', N'152', N'6', N'DKI Jakarta', N'Kota', N'Jakarta Pusat', N'10540')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'3562727c-bf4d-4bbb-95e9-e6cad49ff814', N'365', N'12', N'Kalimantan Barat', N'Kota', N'Pontianak', N'78112')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'21c1f07e-2934-4f57-962f-e785453426c5', N'137', N'34', N'Sumatera Utara', N'Kota', N'Gunungsitoli', N'22813')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'632b7aaf-f6da-4a20-adc3-e79929adce5d', N'462', N'17', N'Kepulauan Riau', N'Kota', N'Tanjung Pinang', N'29111')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'e3e86a2d-9799-47e8-a08f-e907f56c00c6', N'415', N'12', N'Kalimantan Barat', N'Kota', N'Singkawang', N'79117')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'ba641e9b-cecd-4e56-8e29-ebd40aea052c', N'334', N'2', N'Bangka Belitung', N'Kota', N'Pangkal Pinang', N'33115')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'a7223a51-bd34-44c4-b9e2-ebe537ebd25f', N'19', N'15', N'Kalimantan Timur', N'Kota', N'Balikpapan', N'76111')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'54f86c30-eea5-4a58-abe5-ee21b8084fe2', N'106', N'3', N'Banten', N'Kota', N'Cilegon', N'42417')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'8ab127a8-581b-4844-9649-ef325fed88a7', N'36', N'13', N'Kalimantan Selatan', N'Kota', N'Banjarmasin', N'70117')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'b4a8721b-a660-472f-8467-efd2c3317069', N'473', N'10', N'Jawa Tengah', N'Kota', N'Tegal', N'52114')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'47a8b753-6206-45f8-a3ab-f10a237fa4ec', N'345', N'32', N'Sumatera Barat', N'Kota', N'Payakumbuh', N'26213')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'8af3d381-3352-4d57-bbef-f7ca9b098373', N'469', N'9', N'Jawa Barat', N'Kota', N'Tasikmalaya', N'46116')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'a6ab4307-6e26-4ba0-9e4f-f9792ab53a67', N'399', N'10', N'Jawa Tengah', N'Kota', N'Semarang', N'50135')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'21c43f1e-8d19-41a3-bf4a-fa425210614e', N'407', N'34', N'Sumatera Utara', N'Kota', N'Sibolga', N'22522')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'8fa2b36e-d0f0-4ebe-b107-fd1c96379367', N'254', N'28', N'Sulawesi Selatan', N'Kota', N'Makassar', N'90111')
INSERT [dbo].[RajaOngkir_CityMapping] ([Id], [city_id], [province_id], [province], [type], [city_name], [postal_code]) VALUES (N'35a6ed55-f809-464c-9424-fff53ae94988', N'155', N'6', N'DKI Jakarta', N'Kota', N'Jakarta Utara', N'14140')
SET IDENTITY_INSERT [dbo].[Review] ON 

INSERT [dbo].[Review] ([Id], [CustomerId], [VendorId], [Detail], [DatePost]) VALUES (1005, 8, 16, N'Good vendor', CAST(N'2017-09-12' AS Date))
SET IDENTITY_INSERT [dbo].[Review] OFF
SET IDENTITY_INSERT [dbo].[Setting] ON 

INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (1, N'facebook', N'http://facebook.com/', N'social network', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (2, N'youtube', N'http://youtube.com/', N'social network', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (3, N'twitter', N'http://twitter.com/', N'social network', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (4, N'Website Name', N'OctopusCodes MultiVendor', N'general', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (5, N'Shop Info', N'<h5>OctopusCodes111</h5>
<p>18 Street, CA 93727, USA <br /> octopuscodes@gmail.com<br /> Tel 123-456-789<br /> Fax 123-456-789<br /> website:octopuscodes.com</p>', N'general', N'textarea')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (6, N'Latest Products', N'6', N'general', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (7, N'Mosted Viewed', N'6', N'general', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (8, N'Best Sellers', N'6', N'general', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (9, N'Page Size', N'9', N'general', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (10, N'Logo', N'20170910142549511logo.png', N'general', N'file')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (11, N'PayPalSubmitUrl', N'https://www.sandbox.paypal.com/cgi-bin/webscr', N'paypal', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (12, N'PayPalUsername', N'sb-dilrg1627051@business.example.com', N'paypal', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (13, N'ReturnUrl', N'http://localhost:58544/Vendors/success', N'paypal', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (14, N'PDTToken', N'EDgDGd-90n4vqAKnvRGEn7hEmRsu-HazZxqveMzW4aQux6Ww9-mn9kESwbRpb7RtlXV8J57dif4D-hpx', N'paypal', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (15, N'SMTP_HOST', NULL, N'general', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (16, N'SMTP_USER', NULL, N'general', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (17, N'SMTP_PASSWORD', NULL, N'general', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (18, N'SMTP_PORT', NULL, N'general', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (19, N'RajaOngkir_Api_Key', N'36bf328fad08e188c756242ed9f9bf71', N'general', N'textbox')
INSERT [dbo].[Setting] ([Id], [Key], [Value], [Group], [TypeOfControl]) VALUES (20, N'RajaOngkir_Url', N'https://api.rajaongkir.com', N'general', N'textbox')
SET IDENTITY_INSERT [dbo].[Setting] OFF
SET IDENTITY_INSERT [dbo].[Vendor] ON 

INSERT [dbo].[Vendor] ([Id], [Username], [Password], [Name], [Email], [Phone], [Logo], [Status]) VALUES (15, N'vendor1', N'$2a$10$xwTGPfJgX3/VOEyngaL4me5LaCqLr8esBTV1GMkWovuKc50R64e4a', N'Vendor 1', N'vendor1@gmail.com', N'123', N'20170912002658219logo-80x80.png', 1)
INSERT [dbo].[Vendor] ([Id], [Username], [Password], [Name], [Email], [Phone], [Logo], [Status]) VALUES (16, N'vendor2', N'$2a$10$84OKDM6GxQYX4Ox8ku3g.Od3G93nLuhQ6fnyj90Rixlm6v0PiFFdS', N'Vendor 2', N'vendor2@gmail.com', N'12345678', N'20170912004153639logo-80x80.png', 1)
INSERT [dbo].[Vendor] ([Id], [Username], [Password], [Name], [Email], [Phone], [Logo], [Status]) VALUES (17, N'vendor3', N'$2a$10$Zfc5yHXqSotGRxtKtYD8XecuWcM28DSPkiwYCl0sUxy1XyPOJV8VW', N'Vendor 3', N'vendor3@gmail.com', N'123', N'20170912092605896logo-80x80.png', 1)
INSERT [dbo].[Vendor] ([Id], [Username], [Password], [Name], [Email], [Phone], [Logo], [Status]) VALUES (18, N'vendor4', N'$2a$10$UBT.jgX3dni0hKzCYzx.G.uY0aRhLfHeN.3NvIxpwMEvtc9e4O4B6', N'Vendor 4', N'vendor4@gmail.com', NULL, N'no-logo.jpg', 1)
INSERT [dbo].[Vendor] ([Id], [Username], [Password], [Name], [Email], [Phone], [Logo], [Status]) VALUES (19, N'vendor5', N'$2a$10$46y1qEjRV3g02srgM6cV0.ZTQd6t20CVox4AJzljf6ckWnZXz.8re', N'vendor5', N'vendor5@gmail.com', NULL, N'no-logo.jpg', 1)
INSERT [dbo].[Vendor] ([Id], [Username], [Password], [Name], [Email], [Phone], [Logo], [Status]) VALUES (20, N'vendor6', N'$2a$10$Zq4rsDtJj6N5GQI5f0670.4PmW08eZranOjwxufJgwUh7mofWVYtC', N'Vendor6', N'namenameonline@gmail.com', N'81382883', N'no-logo.jpg', 1)
SET IDENTITY_INSERT [dbo].[Vendor] OFF
INSERT [dbo].[VendorAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [VendorId]) VALUES (N'19c75cae-8d35-4493-867e-394ec99e94b3', N'balestier', N'balestier', N'Banda Aceh', N'123456', 20)
INSERT [dbo].[VendorAddress] ([Id], [LineAddress1], [LineAddress2], [City], [ZipCode], [VendorId]) VALUES (N'10e6a37e-332e-4923-85e8-ef3c73b4b378', N'Malang', N'Malang', N'Malang', N'123455', 18)
INSERT [dbo].[VendorPendingPayment] ([PaymentOrderID], [VendorId], [MerchandiseAmount], [DeliveryFee], [OrderId]) VALUES (N'a0b1f044-c4e3-4c4b-93fe-0cd28c6fda90', 20, CAST(50000 AS Decimal(18, 0)), CAST(120000 AS Decimal(18, 0)), 2029)
INSERT [dbo].[VendorPendingPayment] ([PaymentOrderID], [VendorId], [MerchandiseAmount], [DeliveryFee], [OrderId]) VALUES (N'6396e943-3b4d-480a-b026-46c4b5ab0cc3', 20, CAST(5000000 AS Decimal(18, 0)), CAST(116000 AS Decimal(18, 0)), 2026)
INSERT [dbo].[VendorPendingPayment] ([PaymentOrderID], [VendorId], [MerchandiseAmount], [DeliveryFee], [OrderId]) VALUES (N'28079f04-9184-46aa-b124-7daf57b08e99', 18, CAST(10000 AS Decimal(18, 0)), CAST(111000 AS Decimal(18, 0)), 2024)
INSERT [dbo].[VendorPendingPayment] ([PaymentOrderID], [VendorId], [MerchandiseAmount], [DeliveryFee], [OrderId]) VALUES (N'b4355cc5-1d51-4982-aff3-86a94b5df2e0', 18, CAST(1000 AS Decimal(18, 0)), CAST(111000 AS Decimal(18, 0)), 2030)
INSERT [dbo].[VendorPendingPayment] ([PaymentOrderID], [VendorId], [MerchandiseAmount], [DeliveryFee], [OrderId]) VALUES (N'f2cde753-6660-49cd-a576-b1acddef64c2', 18, CAST(1000 AS Decimal(18, 0)), CAST(115000 AS Decimal(18, 0)), 2028)
INSERT [dbo].[VendorPendingPayment] ([PaymentOrderID], [VendorId], [MerchandiseAmount], [DeliveryFee], [OrderId]) VALUES (N'ea219aaf-c99d-4d16-8ca5-b89f4d967619', 18, CAST(10000 AS Decimal(18, 0)), CAST(111000 AS Decimal(18, 0)), 2027)
INSERT [dbo].[VendorPendingPayment] ([PaymentOrderID], [VendorId], [MerchandiseAmount], [DeliveryFee], [OrderId]) VALUES (N'9dd42f33-4930-480b-8e4f-c3301158276b', 20, CAST(5000000 AS Decimal(18, 0)), CAST(116000 AS Decimal(18, 0)), 2025)
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Table_1]    Script Date: 5/15/2020 1:27:23 PM ******/
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [IX_Table_1] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Page]    Script Date: 5/15/2020 1:27:23 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Page] ON [dbo].[Page]
(
	[Plug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Vendor]    Script Date: 5/15/2020 1:27:23 PM ******/
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [IX_Vendor] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((1)) FOR [PaymentStatusId]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [WeightInGrams]
GO
ALTER TABLE [dbo].[AccountAddress]  WITH CHECK ADD  CONSTRAINT [FK_AccountAddress_Account] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[AccountAddress] CHECK CONSTRAINT [FK_AccountAddress_Account]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Category] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Category]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
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
GO
ALTER TABLE [dbo].[MemberShipVendor] CHECK CONSTRAINT [FK_MemberShipVendor_Vendor]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_Account] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_Account]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_Vendor]
GO
ALTER TABLE [dbo].[OrderAddress]  WITH CHECK ADD  CONSTRAINT [FK_OrderAddress_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
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
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Payment] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[Payment] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Payment]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_PaymentStatus] FOREIGN KEY([PaymentStatusId])
REFERENCES [dbo].[PaymentStatus] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_PaymentStatus]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Vendor]
GO
ALTER TABLE [dbo].[OrdersDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrdersDetail_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
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
ALTER TABLE [dbo].[VendorAddress]  WITH CHECK ADD  CONSTRAINT [FK_VendorAddress_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
GO
ALTER TABLE [dbo].[VendorAddress] CHECK CONSTRAINT [FK_VendorAddress_Vendor]
GO
ALTER TABLE [dbo].[VendorPendingPayment]  WITH CHECK ADD  CONSTRAINT [FK_VendorPendingPayment_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[VendorPendingPayment] CHECK CONSTRAINT [FK_VendorPendingPayment_Orders]
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
