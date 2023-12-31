USE [PROG260FA23]
GO
/****** Object:  Table [dbo].[HouseProduce]    Script Date: 10/25/2023 10:29:28 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HouseProduce]') AND type in (N'U'))
DROP TABLE [dbo].[HouseProduce]
GO
/****** Object:  Table [dbo].[House]    Script Date: 10/25/2023 10:29:28 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[House]') AND type in (N'U'))
DROP TABLE [dbo].[House]
GO
/****** Object:  Table [dbo].[Game]    Script Date: 10/25/2023 10:29:28 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Game]') AND type in (N'U'))
DROP TABLE [dbo].[Game]
GO
/****** Object:  Table [dbo].[Game]    Script Date: 10/25/2023 10:29:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Game](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Publisher] [nvarchar](50) NULL,
	[Release_Date] [datetime2](7) NULL,
	[Sold] [int] NULL,
	[Rating] [nchar](10) NULL,
 CONSTRAINT [PK_Game] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[House]    Script Date: 10/25/2023 10:29:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[House](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Location] [nvarchar](50) NULL,
	[Price] [int] NULL,
	[UoM] [nchar](10) NULL,
	[Sell_by_Date] [datetime2](7) NULL,
 CONSTRAINT [PK_House] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HouseProduce]    Script Date: 10/25/2023 10:29:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HouseProduce](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Location] [nvarchar](50) NULL,
	[Price] [float] NULL,
	[UoM] [nvarchar](50) NULL,
	[Sell_by_Date] [datetime2](7) NULL,
 CONSTRAINT [PK_HouseProduce] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Game] ON 

INSERT [dbo].[Game] ([ID], [Name], [Publisher], [Release_Date], [Sold], [Rating]) VALUES (1, N'The Secret of Monkey Island', N'Lucasfilm Games', CAST(N'1990-10-01T00:00:00.0000000' AS DateTime2), NULL, N'94        ')
INSERT [dbo].[Game] ([ID], [Name], [Publisher], [Release_Date], [Sold], [Rating]) VALUES (2, N'The Secret Island', N'Bull Games', CAST(N'2022-10-01T00:00:00.0000000' AS DateTime2), 80, N'56        ')
INSERT [dbo].[Game] ([ID], [Name], [Publisher], [Release_Date], [Sold], [Rating]) VALUES (3, N'The Hightest Point', N'Bill Ling', CAST(N'1987-10-01T00:00:00.0000000' AS DateTime2), 180, N'100       ')
INSERT [dbo].[Game] ([ID], [Name], [Publisher], [Release_Date], [Sold], [Rating]) VALUES (4, N'The Milky Way', N'Dictionary Queue', CAST(N'2019-10-01T00:00:00.0000000' AS DateTime2), 200, N'95        ')
INSERT [dbo].[Game] ([ID], [Name], [Publisher], [Release_Date], [Sold], [Rating]) VALUES (5, N'The Des Moines', N'Iowa', CAST(N'2014-10-01T00:00:00.0000000' AS DateTime2), 13, N'70        ')
SET IDENTITY_INSERT [dbo].[Game] OFF
GO
SET IDENTITY_INSERT [dbo].[HouseProduce] ON 

INSERT [dbo].[HouseProduce] ([ID], [Name], [Location], [Price], [UoM], [Sell_by_Date]) VALUES (3, N'Green Apples', N'13Z', 4.15, N'Lbs', CAST(N'2024-09-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[HouseProduce] ([ID], [Name], [Location], [Price], [UoM], [Sell_by_Date]) VALUES (8, N'Green Apples', N'13Z', 4.15, N'Lbs', CAST(N'2024-09-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[HouseProduce] ([ID], [Name], [Location], [Price], [UoM], [Sell_by_Date]) VALUES (13, N'Green Apples', N'13Z', 4.15, N'Lbs', CAST(N'2024-09-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[HouseProduce] ([ID], [Name], [Location], [Price], [UoM], [Sell_by_Date]) VALUES (18, N'Green Apples', N'13Z', 4.15, N'Lbs', CAST(N'2024-09-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[HouseProduce] ([ID], [Name], [Location], [Price], [UoM], [Sell_by_Date]) VALUES (23, N'Green Apples', N'13Z', 4.15, N'Lbs', CAST(N'2024-09-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[HouseProduce] ([ID], [Name], [Location], [Price], [UoM], [Sell_by_Date]) VALUES (28, N'Green Apples', N'13Z', 4.15, N'Lbs', CAST(N'2024-09-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[HouseProduce] ([ID], [Name], [Location], [Price], [UoM], [Sell_by_Date]) VALUES (33, N'Green Apples', N'13Z', 4.15, N'Lbs', CAST(N'2024-09-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[HouseProduce] ([ID], [Name], [Location], [Price], [UoM], [Sell_by_Date]) VALUES (38, N'Green Apples', N'13Z', 4.15, N'Lbs', CAST(N'2024-09-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[HouseProduce] ([ID], [Name], [Location], [Price], [UoM], [Sell_by_Date]) VALUES (43, N'Green Apples', N'13Z', 4.15, N'Lbs', CAST(N'2024-09-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[HouseProduce] ([ID], [Name], [Location], [Price], [UoM], [Sell_by_Date]) VALUES (48, N'Green Apples', N'13Z', 4.15, N'Lbs', CAST(N'2024-09-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[HouseProduce] ([ID], [Name], [Location], [Price], [UoM], [Sell_by_Date]) VALUES (53, N'Green Apples', N'13Z', 4.15, N'Lbs', CAST(N'2024-09-09T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[HouseProduce] OFF
GO
