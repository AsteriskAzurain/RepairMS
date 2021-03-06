USE [repairingInfoMS]
GO
/****** Object:  Table [dbo].[employeeTable]    Script Date: 2021/2/16 18:30:15 ******/
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
/****** Object:  Table [dbo].[paramTable]    Script Date: 2021/2/16 18:30:15 ******/
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
/****** Object:  Table [dbo].[projectDetailTable]    Script Date: 2021/2/16 18:30:15 ******/
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
	[deleteStatus] [tinyint] NOT NULL CONSTRAINT [DF_projectDetailTable_deleteStatus]  DEFAULT ((1)),
 CONSTRAINT [PK_projectDetailTable] PRIMARY KEY CLUSTERED 
(
	[detailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[projectTable]    Script Date: 2021/2/16 18:30:15 ******/
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
	[contactName] [varchar](50) NULL,
	[contactPhone] [varchar](50) NULL,
	[projectDetail] [varchar](255) NOT NULL,
	[siteDetail] [varchar](255) NULL,
	[hasDetail] [tinyint] NULL,
	[createDate] [datetime] NULL,
	[updateDate] [datetime] NULL,
	[deleteStatus] [tinyint] NULL CONSTRAINT [DF_projectTable_deleteStatus]  DEFAULT ((1)),
 CONSTRAINT [PK_projectTable] PRIMARY KEY CLUSTERED 
(
	[projectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[repairmanTable]    Script Date: 2021/2/16 18:30:15 ******/
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
SET IDENTITY_INSERT [dbo].[employeeTable] ON 

INSERT [dbo].[employeeTable] ([employeeID], [employeeName], [password], [deleteStatus]) VALUES (1, N'Antonio', N'111111', 1)
SET IDENTITY_INSERT [dbo].[employeeTable] OFF
SET IDENTITY_INSERT [dbo].[paramTable] ON 

INSERT [dbo].[paramTable] ([paramID], [paramCode], [paramText], [paramValue], [paramType], [remark], [deleteStatus]) VALUES (1, N'New', N'待分配', N'0', 1, N'项目状态', 1)
INSERT [dbo].[paramTable] ([paramID], [paramCode], [paramText], [paramValue], [paramType], [remark], [deleteStatus]) VALUES (2, N'Assigned', N'已分配', N'1', 1, NULL, 1)
INSERT [dbo].[paramTable] ([paramID], [paramCode], [paramText], [paramValue], [paramType], [remark], [deleteStatus]) VALUES (3, N'NeedFollowUp', N'待跟进', N'2', 1, NULL, 1)
INSERT [dbo].[paramTable] ([paramID], [paramCode], [paramText], [paramValue], [paramType], [remark], [deleteStatus]) VALUES (4, N'Finished', N'已完成', N'3', 1, NULL, 1)
INSERT [dbo].[paramTable] ([paramID], [paramCode], [paramText], [paramValue], [paramType], [remark], [deleteStatus]) VALUES (5, NULL, N'电脑问题', N'1', 2, N'问题类型', 1)
INSERT [dbo].[paramTable] ([paramID], [paramCode], [paramText], [paramValue], [paramType], [remark], [deleteStatus]) VALUES (6, NULL, N'器材问题', N'2', 2, NULL, 1)
INSERT [dbo].[paramTable] ([paramID], [paramCode], [paramText], [paramValue], [paramType], [remark], [deleteStatus]) VALUES (7, NULL, N'其他问题', N'3', 2, NULL, 1)
INSERT [dbo].[paramTable] ([paramID], [paramCode], [paramText], [paramValue], [paramType], [remark], [deleteStatus]) VALUES (8, NULL, N'教室', N'1', 3, N'报修地点', 1)
INSERT [dbo].[paramTable] ([paramID], [paramCode], [paramText], [paramValue], [paramType], [remark], [deleteStatus]) VALUES (9, NULL, N'宿舍', N'2', 3, NULL, 1)
INSERT [dbo].[paramTable] ([paramID], [paramCode], [paramText], [paramValue], [paramType], [remark], [deleteStatus]) VALUES (10, NULL, N'其他', N'3', 3, NULL, 1)
INSERT [dbo].[paramTable] ([paramID], [paramCode], [paramText], [paramValue], [paramType], [remark], [deleteStatus]) VALUES (11, NULL, N'Type1', N'1', 4, N'faultType', 1)
INSERT [dbo].[paramTable] ([paramID], [paramCode], [paramText], [paramValue], [paramType], [remark], [deleteStatus]) VALUES (12, NULL, N'Type2', N'2', 4, NULL, 1)
SET IDENTITY_INSERT [dbo].[paramTable] OFF
SET IDENTITY_INSERT [dbo].[projectDetailTable] ON 

INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (1, 1, 1, 1, 1, 1, N'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Doloribus, itaque ipsam! Maiores, adipisci veritatis fugit amet esse repellat possimus modi recusandae et quis pariatur dignissimos sequi velit qui consequuntur. Alias.', N'', CAST(N'2021-02-03 00:59:20.240' AS DateTime), CAST(N'2021-02-03 02:48:32.170' AS DateTime), 1)
INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (2, 1, 9, 2, 2, 0, N'程多足型都史設這紙人之天物？即等現是指言，灣經和不年河善以時甚我為電在有他多權們我區我議持羅老工新備，不只熱，法臺來行演友錢，受關就即空得先持，那為強加紙像直義、動服一我生完城', NULL, CAST(N'2021-02-03 01:01:43.740' AS DateTime), CAST(N'2021-02-05 05:18:49.287' AS DateTime), 1)
INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (15, 3, 1, 1, 1, 2, N'為能筆人說容上防者輪神境水以路些還冷結樣東時這我次去動際各官', NULL, CAST(N'2021-02-05 02:52:56.493' AS DateTime), NULL, 1)
INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (16, 4, 4, 3, 1, 2, N'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Doloribus, itaque ipsam! Maiores, adipisci veritatis fugit amet esse repellat possimus modi recusandae et quis pariatur dignissimos sequi velit qui consequuntur. Alias.', NULL, CAST(N'2021-02-05 02:53:57.080' AS DateTime), NULL, 1)
INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (17, 2, 9, 2, 2, 2, N'外民器則室慢車不合內有苦有不教工財作他度部：童精應時立、供時本就見不天我那時八是時；', NULL, CAST(N'2021-02-05 02:56:01.713' AS DateTime), NULL, 1)
INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (18, 5, 4, 1, 2, 1, N'反而高分再個，怎臺方觀國統他主上多，在電費的友資叫。平技因了製？黑約的長效目的調支也多失病物刻。', N'update', CAST(N'2021-02-05 02:58:19.090' AS DateTime), CAST(N'2021-02-12 03:33:51.643' AS DateTime), 1)
INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (19, 6, 1, 1, 1, 0, N'法臺來行演友錢', NULL, CAST(N'2021-02-05 03:13:22.817' AS DateTime), CAST(N'2021-02-05 03:34:27.990' AS DateTime), 1)
INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (20, 2, 3, 2, 1, 0, NULL, NULL, CAST(N'2021-02-05 03:13:31.000' AS DateTime), CAST(N'2021-02-05 03:34:27.350' AS DateTime), 1)
INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (21, 6, 14, 0, 0, 2, N'指这生少！一到然自出体而方病好。市的么在来妈口年模你喜义没过亲生时从加量生一外党生广空候加己人人……实意散自么，护器丽在过：得着才觉活管年的费市去车管画书，知老？', NULL, CAST(N'2021-02-05 05:15:05.017' AS DateTime), NULL, 1)
INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (22, 1, 20, 0, 0, 0, NULL, NULL, CAST(N'2021-02-05 05:18:46.907' AS DateTime), CAST(N'2021-02-05 05:20:50.367' AS DateTime), 0)
INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (23, 5, 13, 0, 0, 2, N'的上們生要。失的馬生，直跑一，覺每學對爾體怕人不。', NULL, CAST(N'2021-02-05 05:34:33.670' AS DateTime), NULL, 1)
INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (24, 7, 2, 0, 0, 2, NULL, N'update', CAST(N'2021-02-08 00:42:44.500' AS DateTime), CAST(N'2021-02-12 03:35:12.030' AS DateTime), 1)
INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (25, 7, 3, 0, 0, 2, NULL, NULL, CAST(N'2021-02-08 00:43:58.997' AS DateTime), NULL, 1)
INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (26, 9, 7, 0, 0, 2, NULL, NULL, CAST(N'2021-02-10 00:43:59.723' AS DateTime), NULL, 1)
INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (27, 8, 20, 0, 0, 2, NULL, NULL, CAST(N'2021-02-10 02:39:00.177' AS DateTime), NULL, 1)
INSERT [dbo].[projectDetailTable] ([detailID], [projectID], [repairmanID], [severity], [faultType], [faultStatus], [faultDetail], [add_requirement], [createDate], [updateDate], [deleteStatus]) VALUES (28, 11, 12, 0, 0, 2, NULL, NULL, CAST(N'2021-02-10 03:58:46.580' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[projectDetailTable] OFF
SET IDENTITY_INSERT [dbo].[projectTable] ON 

INSERT [dbo].[projectTable] ([projectID], [projectStatus], [priority], [projectType], [projectSite], [contactName], [contactPhone], [projectDetail], [siteDetail], [hasDetail], [createDate], [updateDate], [deleteStatus]) VALUES (1, 1, 2, 2, 1, N'update', N'13811111111', N'投影坏了。', N'图文315', 1, CAST(N'2021-02-02 23:53:25.147' AS DateTime), CAST(N'2021-02-14 07:02:19.940' AS DateTime), 1)
INSERT [dbo].[projectTable] ([projectID], [projectStatus], [priority], [projectType], [projectSite], [contactName], [contactPhone], [projectDetail], [siteDetail], [hasDetail], [createDate], [updateDate], [deleteStatus]) VALUES (2, 2, 0, 3, 2, N'Chapman', N'13901201007', N'空调温度太低。', N'10#529', 1, CAST(N'2021-02-02 23:56:20.943' AS DateTime), CAST(N'2021-02-07 09:25:58.530' AS DateTime), 1)
INSERT [dbo].[projectTable] ([projectID], [projectStatus], [priority], [projectType], [projectSite], [contactName], [contactPhone], [projectDetail], [siteDetail], [hasDetail], [createDate], [updateDate], [deleteStatus]) VALUES (3, 1, 1, 1, 1, N'Scott', N'13902100917', N'无法投屏。', N'图文319', 1, CAST(N'2021-02-02 23:58:43.573' AS DateTime), CAST(N'2021-02-08 00:49:50.047' AS DateTime), 1)
INSERT [dbo].[projectTable] ([projectID], [projectStatus], [priority], [projectType], [projectSite], [contactName], [contactPhone], [projectDetail], [siteDetail], [hasDetail], [createDate], [updateDate], [deleteStatus]) VALUES (4, 1, 0, 3, 1, N'Michelle', N'13811011023', N'桌子腿断了。', N'4#518', 1, CAST(N'2021-02-03 00:02:04.267' AS DateTime), CAST(N'2021-02-08 00:48:38.640' AS DateTime), 1)
INSERT [dbo].[projectTable] ([projectID], [projectStatus], [priority], [projectType], [projectSite], [contactName], [contactPhone], [projectDetail], [siteDetail], [hasDetail], [createDate], [updateDate], [deleteStatus]) VALUES (5, 1, 0, 1, 1, N'Gavin', N'18915203090', N'电脑蓝屏。', N'2#210', 1, CAST(N'2021-02-03 02:48:05.770' AS DateTime), CAST(N'2021-02-07 09:26:11.710' AS DateTime), 1)
INSERT [dbo].[projectTable] ([projectID], [projectStatus], [priority], [projectType], [projectSite], [contactName], [contactPhone], [projectDetail], [siteDetail], [hasDetail], [createDate], [updateDate], [deleteStatus]) VALUES (6, 1, 2, 3, 3, N'Vivian', N'13743902418', N'饮水机漏水。', N'10#317', 1, CAST(N'2021-02-03 03:25:55.840' AS DateTime), CAST(N'2021-02-08 01:16:59.867' AS DateTime), 1)
INSERT [dbo].[projectTable] ([projectID], [projectStatus], [priority], [projectType], [projectSite], [contactName], [contactPhone], [projectDetail], [siteDetail], [hasDetail], [createDate], [updateDate], [deleteStatus]) VALUES (7, 3, 0, 2, 1, N'', N'13959281514', N'教室顶灯时明时暗', N'4#418', 1, CAST(N'2021-02-07 06:09:34.877' AS DateTime), CAST(N'2021-02-08 00:49:47.600' AS DateTime), 1)
INSERT [dbo].[projectTable] ([projectID], [projectStatus], [priority], [projectType], [projectSite], [contactName], [contactPhone], [projectDetail], [siteDetail], [hasDetail], [createDate], [updateDate], [deleteStatus]) VALUES (8, 1, 0, 1, 2, N'王测', N'18910015019', N'电脑连不上校园网SBS', N'9#216', 1, CAST(N'2021-02-07 08:00:41.923' AS DateTime), CAST(N'2021-02-10 02:39:00.180' AS DateTime), 1)
INSERT [dbo].[projectTable] ([projectID], [projectStatus], [priority], [projectType], [projectSite], [contactName], [contactPhone], [projectDetail], [siteDetail], [hasDetail], [createDate], [updateDate], [deleteStatus]) VALUES (9, 1, 0, 2, 1, N'王试', N'17702165918', N'单杠松动', N'健身房', 1, CAST(N'2021-02-07 08:02:16.567' AS DateTime), CAST(N'2021-02-08 01:07:45.177' AS DateTime), 1)
INSERT [dbo].[projectTable] ([projectID], [projectStatus], [priority], [projectType], [projectSite], [contactName], [contactPhone], [projectDetail], [siteDetail], [hasDetail], [createDate], [updateDate], [deleteStatus]) VALUES (10, 0, 1, 3, 2, N'Bernard', N'17725514923', N'寝室连不上网', N'10#523', 0, CAST(N'2021-02-10 00:25:57.360' AS DateTime), NULL, 1)
INSERT [dbo].[projectTable] ([projectID], [projectStatus], [priority], [projectType], [projectSite], [contactName], [contactPhone], [projectDetail], [siteDetail], [hasDetail], [createDate], [updateDate], [deleteStatus]) VALUES (11, 1, 1, 2, 1, N'Ruby', N'15902860197', N'投影亮度不够，还有色偏。', N'2#317', 1, CAST(N'2021-02-10 02:37:26.763' AS DateTime), CAST(N'2021-02-12 02:06:32.693' AS DateTime), 1)
INSERT [dbo].[projectTable] ([projectID], [projectStatus], [priority], [projectType], [projectSite], [contactName], [contactPhone], [projectDetail], [siteDetail], [hasDetail], [createDate], [updateDate], [deleteStatus]) VALUES (12, 0, 2, 3, 2, N'Colin', N'1927715543', N'在哪里可以买到寝室路由器呢', N'10#428', 0, CAST(N'2021-02-10 03:01:50.927' AS DateTime), CAST(N'2021-02-12 02:04:49.030' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[projectTable] OFF
SET IDENTITY_INSERT [dbo].[repairmanTable] ON 

INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (1, N'Harriet', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (2, N'Roberta', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (3, N'Cynthia', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (4, N'Jeffrey', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (5, N'Geraldine', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (6, N'Yehudi', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (7, N'Perry', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (8, N'Robert', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (9, N'Veronica', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (10, N'Norton', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (11, N'Barnett', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (12, N'Clare', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (13, N'Ashley', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (14, N'Jenny', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (15, N'ta', N'111111', 0)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (16, N'Franklin', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (17, N'Yves', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (18, N'Byron', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (19, N'Dorothy', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (20, N'Emma', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (21, N'Sabina', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (22, N'Florence', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (23, N'Odelia', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (24, N'Orville', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (25, N'Nelson', N'111111', 1)
INSERT [dbo].[repairmanTable] ([repairmanID], [repairmanName], [password], [deleteStatus]) VALUES (26, N'h', N'111111', 0)
SET IDENTITY_INSERT [dbo].[repairmanTable] OFF
