--create database Page_manager_database
go
use Page_manager_database
go
/*******************************************************************************
	Drop tables if exists
*******************************************************************************/
DECLARE @sql nvarchar(MAX) 
SET @sql = N'' 

SELECT @sql = @sql + N'ALTER TABLE ' + QUOTENAME(KCU1.TABLE_SCHEMA) 
    + N'.' + QUOTENAME(KCU1.TABLE_NAME) 
    + N' DROP CONSTRAINT ' -- + QUOTENAME(rc.CONSTRAINT_SCHEMA)  + N'.'  -- not in MS-SQL
    + QUOTENAME(rc.CONSTRAINT_NAME) + N'; ' + CHAR(13) + CHAR(10) 
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS RC 

INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KCU1 
    ON KCU1.CONSTRAINT_CATALOG = RC.CONSTRAINT_CATALOG  
    AND KCU1.CONSTRAINT_SCHEMA = RC.CONSTRAINT_SCHEMA 
    AND KCU1.CONSTRAINT_NAME = RC.CONSTRAINT_NAME 

EXECUTE(@sql) 

GO
DECLARE @sql2 NVARCHAR(max)=''

SELECT @sql2 += ' Drop table ' + QUOTENAME(TABLE_SCHEMA) + '.'+ QUOTENAME(TABLE_NAME) + '; '
FROM   INFORMATION_SCHEMA.TABLES
WHERE  TABLE_TYPE = 'BASE TABLE'

Exec Sp_executesql @sql2 
GO 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[customers]    Script Date: 09/05/2024  ******/
create table [dbo].[customers](
    [customer_id] [int] NOT NULL,
	[username] [varchar](255) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[fullname] [varchar](255) NULL,
	[email] [varchar](255) NOT NULL,
	[address] [varchar](255)NOT NULL,
	[phone] [int]NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[products]    Script Date: 09/05/2024  ******/
CREATE TABLE [dbo].[products](
	[product_id] [int] NOT NULL,
	[product_name] [varchar](255) NOT NULL,
	[size] [varchar](25) NOT NULL,
	[list_price] [decimal](10, 2) NOT NULL,
	[shop_id] [int] NOT NULL,
	[brand] [varchar](255) null, 
	[category_name] [nvarchar](255) NULL,
	[image] [nvarchar](255) null, 
	[type_user] [nvarchar](255) null,
	

	
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[shops]    Script Date: 09/05/2024  ******/
CREATE TABLE [dbo].[shops](
	[shop_id] [int] NOT NULL,
	[shop_name] [varchar] (255) not null,
	[shop_username] [varchar] (255) not null,
	[password] [varchar] (255) not null,
	[email] [varchar](255) NOT NULL,
	[address] [varchar](255)NOT NULL,
	[phone] [int]NOT NULL,
	[link_page] [varchar] (255) null,
	PRIMARY KEY CLUSTERED 
(
	[shop_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stocks]    Script Date: 09/05/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stocks](
	[store_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[store_id] ASC,
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 09/05/2024 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[order_id] [int] NOT NULL,
	[customer_id] [int] NULL,
	[shop_id] [int] NOT NULL,
	[order_status] [varchar] (255) NOT NULL,
	[order_date] [date] NOT NULL,
	[required_date] [date] NOT NULL,
	[shipped_date] [date] NULL,
	[total_price] [int] Null,
	
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_items]    Script Date: 24/02/2021 21:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_detail](
	[order_id] [int] NOT NULL,	
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[discount_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
	
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[discounts]    Script Date: 24/02/2021 21:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[discounts](
	[discount_id] [int] NOT NULL,	
	[value] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[shop_id] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[discount_id] ASC
	
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wishlist]    Script Date: 24/02/2021 21:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wishlist](
	
	[customer_id] [int] NOT NULL,		
	[product_id] [int] NOT NULL,	
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
	
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/******  ******/
ALTER TABLE [dbo].[customers] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[shops] ADD UNIQUE NONCLUSTERED 
(
	[shop_username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
--ALTER TABLE [dbo].[order_detail] ADD  DEFAULT ((0)) FOR [discount]
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([order_id])
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([product_id])
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD FOREIGN KEY([discount_id])
REFERENCES [dbo].[discounts] ([discount_id])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[customers] ([customer_id])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([shop_id])
REFERENCES [dbo].[shops] ([shop_id])
GO
ALTER TABLE [dbo].[stocks]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([product_id])
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD FOREIGN KEY([shop_id])
REFERENCES [dbo].[shops] ([shop_id])
GO
ALTER TABLE [dbo].[wishlist]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[customers] ([customer_id])
GO
ALTER TABLE [dbo].[wishlist]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([product_id])
GO
INSERT INTO [dbo].[customers]
           ([customer_id]
           ,[username]
           ,[password]
           ,[fullname]
           ,[email]
           ,[address]
           ,[phone])
     VALUES
           (0000
           ,'demo'
           ,'0000'
           ,'demo insert'
           ,'demo123@gmail.com'
           ,'none'
           ,012345678)
GO
INSERT INTO [dbo].[shops]
           ([shop_id]
           ,[shop_name]
           ,[shop_username]
           ,[password]
           ,[email]
           ,[address]
           ,[phone]
           ,[link_page])
     VALUES
           (0001 
           ,'test'
           ,'test username' 
           ,'p0000'
           ,'shop01@gmail.com' 
           ,'fpt' 
           ,012345678
           ,'link')
GO
INSERT INTO [dbo].[products]
           ([product_id]
           ,[product_name]
           ,[size]
           ,[list_price]
           ,[shop_id]
           ,[brand]
           ,[category_name]
           ,[image]
           ,[type_user])
     VALUES
           (0000
           ,'demo shoe'
           ,37
           ,25.25
           ,1
           ,'nike'
           ,'jordan'
           ,'image'
           ,'men')
GO



USE [master]
GO
