USE [almacen]
GO
/****** Object:  User [Admin_Almacen]    Script Date: 15/02/2021 22:27:05 ******/
CREATE USER [Admin_Almacen] FOR LOGIN [Admin_Almacen] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Admin_Almacen]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [Admin_Almacen]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [Admin_Almacen]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [Admin_Almacen]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [Admin_Almacen]
GO
ALTER ROLE [db_datareader] ADD MEMBER [Admin_Almacen]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [Admin_Almacen]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [Admin_Almacen]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [Admin_Almacen]
GO
/****** Object:  Table [dbo].[almacen]    Script Date: 15/02/2021 22:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[almacen](
	[nombre_almacen] [nvarchar](50) NOT NULL,
	[largo] [smallint] NOT NULL,
	[ancho] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nombre_almacen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[area_recogida]    Script Date: 15/02/2021 22:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[area_recogida](
	[id_area] [nvarchar](3) NOT NULL,
	[nombre_almacen_area] [nvarchar](50) NOT NULL,
	[tipo_tienda_area] [nvarchar](50) NOT NULL,
	[longitud] [int] NULL,
	[anchura] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caja]    Script Date: 15/02/2021 22:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caja](
	[id_caja] [int] NOT NULL,
	[id_caja_carro] [int] NULL,
	[categoria_caja] [nvarchar](50) NULL,
	[anchura] [int] NULL,
	[longitud] [int] NULL,
	[profundidad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_caja] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[carro]    Script Date: 15/02/2021 22:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[carro](
	[id_carro] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_carro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categoria]    Script Date: 15/02/2021 22:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categoria](
	[nombre_categoria] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nombre_categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cliente]    Script Date: 15/02/2021 22:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cliente](
	[DNI] [nvarchar](20) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Direccion] [nvarchar](50) NOT NULL,
	[CP] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DNI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[linea_pedido]    Script Date: 15/02/2021 22:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[linea_pedido](
	[EAN_linea_pedido] [int] NOT NULL,
	[id_pedido_linea_pedido] [int] NOT NULL,
	[cantidad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EAN_linea_pedido] ASC,
	[id_pedido_linea_pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[localizacion_producto]    Script Date: 15/02/2021 22:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[localizacion_producto](
	[id_segmento_loc] [nvarchar](10) NOT NULL,
	[EAN_loc] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EAN_loc] ASC,
	[id_segmento_loc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pasillo]    Script Date: 15/02/2021 22:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pasillo](
	[id_pasillo] [nvarchar](4) NOT NULL,
	[id_area_pasillo] [nvarchar](3) NOT NULL,
	[longitud] [int] NULL,
	[anchura] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pasillo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pedido]    Script Date: 15/02/2021 22:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pedido](
	[id_pedido] [int] NOT NULL,
	[dni_cliente] [nvarchar](20) NOT NULL,
	[fecha] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto]    Script Date: 15/02/2021 22:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[producto](
	[EAN] [int] NOT NULL,
	[categoria_producto] [nvarchar](50) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[longitud] [int] NULL,
	[anchura] [int] NULL,
	[profundidad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto_recogido]    Script Date: 15/02/2021 22:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[producto_recogido](
	[id_ean_producto] [int] NOT NULL,
	[id_caja_producto] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_ean_producto] ASC,
	[id_caja_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[segmento]    Script Date: 15/02/2021 22:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[segmento](
	[id_segmento] [nvarchar](10) NOT NULL,
	[id_pasillo_segmento] [nvarchar](4) NOT NULL,
	[categoria_segmento] [nvarchar](50) NULL,
	[posicion_segmento] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_segmento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipo_tienda]    Script Date: 15/02/2021 22:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipo_tienda](
	[nombre_tipo_tienda] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nombre_tipo_tienda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[almacen] ([nombre_almacen], [largo], [ancho]) VALUES (N'Albacete', 45, 24)
INSERT [dbo].[almacen] ([nombre_almacen], [largo], [ancho]) VALUES (N'Cuenca', 36, 24)
GO
INSERT [dbo].[area_recogida] ([id_area], [nombre_almacen_area], [tipo_tienda_area], [longitud], [anchura]) VALUES (N'ATA', N'Albacete', N'TIENDA_ABIERTA', 28, 24)
INSERT [dbo].[area_recogida] ([id_area], [nombre_almacen_area], [tipo_tienda_area], [longitud], [anchura]) VALUES (N'ATC', N'Albacete', N'TIENDA_CERRADA', 17, 24)
INSERT [dbo].[area_recogida] ([id_area], [nombre_almacen_area], [tipo_tienda_area], [longitud], [anchura]) VALUES (N'CTA', N'Cuenca', N'TIENDA_ABIERTA', 22, 24)
INSERT [dbo].[area_recogida] ([id_area], [nombre_almacen_area], [tipo_tienda_area], [longitud], [anchura]) VALUES (N'CTC', N'Cuenca', N'TIENDA_CERRADA', 14, 24)
GO
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (1, NULL, N'AMBIENTE', 40, 60, 40)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (2, NULL, N'AMBIENTE', 40, 60, 40)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (3, NULL, N'AMBIENTE', 40, 60, 40)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (4, NULL, N'AMBIENTE', 40, 60, 40)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (5, NULL, N'AMBIENTE', 40, 60, 40)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (6, NULL, N'AMBIENTE', 40, 60, 40)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (7, NULL, N'AMBIENTE', 40, 60, 40)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (8, NULL, N'AMBIENTE', 40, 60, 40)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (9, NULL, N'AMBIENTE', 40, 60, 40)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (10, NULL, N'AMBIENTE', 40, 60, 40)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (11, NULL, N'REFRIGERADO', 34, 52, 34)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (12, NULL, N'REFRIGERADO', 34, 52, 34)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (13, NULL, N'REFRIGERADO', 34, 52, 34)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (14, NULL, N'REFRIGERADO', 34, 52, 34)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (15, NULL, N'REFRIGERADO', 34, 52, 34)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (16, NULL, N'CONGELADO', 32, 52, 32)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (17, NULL, N'CONGELADO', 32, 52, 32)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (18, NULL, N'CONGELADO', 32, 52, 32)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (19, NULL, N'CONGELADO', 32, 52, 32)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (20, NULL, N'CONGELADO', 32, 52, 32)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (21, NULL, N'VOLUMINOSO', 60, 40, 0)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (22, NULL, N'VOLUMINOSO', 60, 40, 0)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (23, NULL, N'VOLUMINOSO', 60, 40, 0)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (24, NULL, N'VOLUMINOSO', 60, 40, 0)
INSERT [dbo].[caja] ([id_caja], [id_caja_carro], [categoria_caja], [anchura], [longitud], [profundidad]) VALUES (25, NULL, N'VOLUMINOSO', 60, 40, 0)
GO
INSERT [dbo].[carro] ([id_carro]) VALUES (1)
INSERT [dbo].[carro] ([id_carro]) VALUES (2)
INSERT [dbo].[carro] ([id_carro]) VALUES (3)
INSERT [dbo].[carro] ([id_carro]) VALUES (4)
INSERT [dbo].[carro] ([id_carro]) VALUES (5)
INSERT [dbo].[carro] ([id_carro]) VALUES (6)
INSERT [dbo].[carro] ([id_carro]) VALUES (7)
INSERT [dbo].[carro] ([id_carro]) VALUES (8)
INSERT [dbo].[carro] ([id_carro]) VALUES (9)
INSERT [dbo].[carro] ([id_carro]) VALUES (10)
GO
INSERT [dbo].[categoria] ([nombre_categoria]) VALUES (N'AMBIENTE')
INSERT [dbo].[categoria] ([nombre_categoria]) VALUES (N'CONGELADO')
INSERT [dbo].[categoria] ([nombre_categoria]) VALUES (N'REFRIGERADO')
INSERT [dbo].[categoria] ([nombre_categoria]) VALUES (N'VOLUMINOSO')
GO
INSERT [dbo].[cliente] ([DNI], [Nombre], [Direccion], [CP]) VALUES (N'04614951R', N'Eduardo Pastor', N'Avenida Falsa 123', 16004)
INSERT [dbo].[cliente] ([DNI], [Nombre], [Direccion], [CP]) VALUES (N'11111111A', N'Prueba Prueba1', N'Avendida Falsa 234', 20001)
INSERT [dbo].[cliente] ([DNI], [Nombre], [Direccion], [CP]) VALUES (N'22222222B', N'Prueba Prueba 2', N'Avenida Falsa 345', 16004)
GO
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (1, 1, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (1, 3, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (1, 4, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (1, 7, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (1, 8, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (1, 11, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (1, 12, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (1, 13, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (1, 14, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (1, 15, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (1, 16, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (1, 17, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (1, 18, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (1, 19, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (1, 20, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (2, 1, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (2, 2, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (2, 3, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (2, 4, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (2, 5, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (2, 6, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (2, 7, 12)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (2, 8, 12)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (2, 11, 12)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (2, 14, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (2, 15, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (2, 16, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (2, 18, 12)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (2, 19, 12)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (2, 20, 12)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (3, 5, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (3, 6, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (3, 7, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (3, 8, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (3, 11, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (3, 12, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (3, 13, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (3, 14, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (3, 15, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (3, 16, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (3, 17, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (3, 18, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (3, 19, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (3, 20, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (4, 1, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (4, 2, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (4, 6, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (4, 7, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (4, 8, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (4, 11, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (4, 12, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (4, 13, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (4, 14, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (4, 15, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (4, 16, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (4, 17, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (4, 18, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (4, 19, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (4, 20, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (5, 1, 24)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (5, 2, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (5, 3, 48)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (5, 4, 12)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (5, 6, 24)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (5, 7, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (5, 10, 48)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (5, 12, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (5, 14, 24)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (5, 15, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (5, 16, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (5, 17, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (5, 19, 24)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (5, 20, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (6, 3, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (6, 4, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (6, 6, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (6, 7, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (6, 8, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (6, 11, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (6, 12, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (6, 13, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (6, 14, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (6, 15, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (6, 16, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (6, 17, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (6, 18, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (6, 20, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (7, 1, 3)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (7, 3, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (7, 7, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (7, 8, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (7, 18, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (7, 19, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (7, 20, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 1, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 2, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 3, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 5, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 6, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 7, 1)
GO
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 8, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 11, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 12, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 13, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 14, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 15, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 16, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 17, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 18, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 19, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (8, 20, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (9, 5, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (10, 5, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (11, 2, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (11, 4, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (11, 6, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (12, 1, 3)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (12, 3, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (12, 6, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (12, 7, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (12, 8, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (12, 11, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (12, 12, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (12, 13, 6)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (12, 15, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (12, 16, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (12, 17, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (12, 18, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (12, 19, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (12, 20, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (13, 1, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (13, 4, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (13, 9, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (13, 14, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (14, 2, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (14, 3, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (14, 7, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (14, 8, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (14, 9, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (14, 11, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (14, 13, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (14, 14, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (14, 18, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (14, 19, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (14, 20, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (15, 4, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (15, 14, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (16, 1, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (16, 2, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (16, 3, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (16, 7, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (16, 8, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (16, 9, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (16, 11, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (16, 18, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (16, 19, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (16, 20, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (17, 2, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (17, 3, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (17, 4, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (17, 6, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (17, 8, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (17, 12, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (17, 13, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (17, 14, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (17, 17, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (17, 18, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (17, 19, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (18, 5, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (18, 8, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (18, 13, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (18, 14, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (18, 15, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (18, 16, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (18, 18, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (18, 19, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (19, 4, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (19, 8, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (19, 12, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (19, 13, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (19, 14, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (19, 15, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (19, 16, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (19, 17, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (19, 18, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (19, 19, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (20, 6, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (20, 8, 3)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (20, 12, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (20, 13, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (20, 14, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (20, 15, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (20, 16, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (20, 17, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (20, 18, 3)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (20, 19, 3)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (21, 2, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (21, 3, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (21, 4, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (21, 10, 2)
GO
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (21, 12, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (21, 15, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (21, 17, 2)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (22, 2, 3)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (22, 3, 3)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (22, 5, 1)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (22, 7, 3)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (22, 11, 3)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (22, 12, 3)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (22, 13, 3)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (22, 14, 3)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (22, 17, 3)
INSERT [dbo].[linea_pedido] ([EAN_linea_pedido], [id_pedido_linea_pedido], [cantidad]) VALUES (22, 20, 3)
GO
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'1', 1)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'10', 2)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'11', 2)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'12', 3)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'19', 4)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'13', 5)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'18', 5)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'14', 6)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'15', 6)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'16', 7)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'17', 8)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'2', 9)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'3', 10)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'4', 11)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'5', 11)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'6', 12)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'20', 13)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'21', 14)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'22', 14)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'23', 15)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'24', 16)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'26', 17)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'7', 18)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'27', 19)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'28', 19)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'29', 20)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'25', 21)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'30', 21)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'8', 22)
INSERT [dbo].[localizacion_producto] ([id_segmento_loc], [EAN_loc]) VALUES (N'9', 22)
GO
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'1', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'10', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'11', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'12', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'13', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'14', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'15', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'16', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'17', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'18', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'2', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'3', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'4', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'5', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'6', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'7', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'8', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'9', N'ATA', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'C1', N'ATC', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'C10', N'ATC', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'C2', N'ATC', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'C3', N'ATC', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'C4', N'ATC', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'C5', N'ATC', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'C6', N'ATC', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'C7', N'ATC', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'C8', N'ATC', 8, 3)
INSERT [dbo].[pasillo] ([id_pasillo], [id_area_pasillo], [longitud], [anchura]) VALUES (N'C9', N'ATC', 8, 3)
GO
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (1, N'04614951R', CAST(N'2021-01-01' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (2, N'04614951R', CAST(N'2021-01-02' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (3, N'04614951R', CAST(N'2021-12-31' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (4, N'04614951R', CAST(N'2021-01-03' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (5, N'22222222B', CAST(N'2021-01-03' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (6, N'11111111A', CAST(N'2021-01-03' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (7, N'22222222B', CAST(N'2021-01-02' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (8, N'11111111A', CAST(N'2021-01-02' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (9, N'04614951R', CAST(N'2021-01-03' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (10, N'22222222B', CAST(N'2021-01-03' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (11, N'22222222B', CAST(N'2021-01-04' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (12, N'11111111A', CAST(N'2021-01-04' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (13, N'11111111A', CAST(N'2021-01-05' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (14, N'11111111A', CAST(N'2021-01-05' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (15, N'11111111A', CAST(N'2021-01-05' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (16, N'11111111A', CAST(N'2021-01-06' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (17, N'11111111A', CAST(N'2021-01-06' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (18, N'22222222B', CAST(N'2021-01-06' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (19, N'04614951R', CAST(N'2021-01-06' AS Date))
INSERT [dbo].[pedido] ([id_pedido], [dni_cliente], [fecha]) VALUES (20, N'04614951R', CAST(N'2021-01-06' AS Date))
GO
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (1, N'AMBIENTE', N'Bolsas de patatas 300g', 35, 23, 9)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (2, N'AMBIENTE', N'Cartón de leche 1l', 17, 10, 7)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (3, N'AMBIENTE', N'Paquete de galletas 800gr', 22, 13, 13)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (4, N'AMBIENTE', N'Pan hamburguesa', 33, 15, 9)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (5, N'AMBIENTE', N'Lata refresco', 7, 12, 12)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (6, N'AMBIENTE', N'Botella aceite de oliva 1.5l', 26, 8, 8)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (7, N'AMBIENTE', N'Paquete de chicles', 13, 7, 7)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (8, N'AMBIENTE', N'Barra de pan', 54, 10, 5)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (9, N'AMBIENTE', N'Detergente líquido', 32, 19, 8)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (10, N'AMBIENTE', N'Gel Corporal', 16, 6, 6)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (11, N'AMBIENTE', N'Botella Agua 1.5l', 30, 8, 8)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (12, N'AMBIENTE', N'Rollo papel de cocina', 40, 23, 25)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (13, N'REFRIGERADO', N'Sandía 8 kg', 18, 18, 18)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (14, N'REFRIGERADO', N'Saco de naranjas 5kg', 44, 32, 32)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (15, N'REFRIGERADO', N'Lechuga', 35, 22, 22)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (16, N'REFRIGERADO', N'Melocotón', 20, 20, 20)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (17, N'CONGELADO', N'Helado Chocolate 1l', 21, 11, 11)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (18, N'AMBIENTE', N'Fideos 450g', 6, 9, 15)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (19, N'CONGELADO', N'Pizza congelada 340g', 28, 27, 3)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (20, N'CONGELADO', N'Guisantes congelados 200g', 4, 3, 1)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (21, N'VOLUMINOSO', N'Papel higiénico 63 rollos', 58, 32, 29)
INSERT [dbo].[producto] ([EAN], [categoria_producto], [nombre], [longitud], [anchura], [profundidad]) VALUES (22, N'AMBIENTE', N'Chocolate 300g', 24, 10, 2)
GO
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'1', N'4', N'AMBIENTE', 1)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'10', N'C1', N'AMBIENTE', 12)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'11', N'15', N'AMBIENTE', 11)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'12', N'7', N'AMBIENTE', 15)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'13', N'15', N'AMBIENTE', 5)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'14', N'1', N'AMBIENTE', 1)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'15', N'C1', N'AMBIENTE', 1)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'16', N'5', N'AMBIENTE', 6)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'17', N'6', N'AMBIENTE', 15)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'18', N'C2', N'AMBIENTE', 3)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'19', N'12', N'AMBIENTE', 2)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'2', N'18', N'AMBIENTE', 8)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'20', N'7', N'REFRIGERADO', 3)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'21', N'7', N'REFRIGERADO', 12)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'22', N'C7', N'REFRIGERADO', 3)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'23', N'8', N'REFRIGERADO', 5)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'24', N'9', N'REFRIGERADO', 2)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'25', N'18', N'VOLUMINOSO', 11)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'26', N'10', N'CONGELADO', 6)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'27', N'10', N'CONGELADO', 12)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'28', N'C10', N'CONGELADO', 2)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'29', N'10', N'CONGELADO', 15)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'3', N'14', N'AMBIENTE', 3)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'30', N'C5', N'VOLUMINOSO', 5)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'4', N'16', N'AMBIENTE', 12)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'5', N'C8', N'AMBIENTE', 5)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'6', N'17', N'AMBIENTE', 3)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'7', N'3', N'AMBIENTE', 8)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'8', N'2', N'AMBIENTE', 12)
INSERT [dbo].[segmento] ([id_segmento], [id_pasillo_segmento], [categoria_segmento], [posicion_segmento]) VALUES (N'9', N'C4', N'AMBIENTE', 9)
GO
INSERT [dbo].[tipo_tienda] ([nombre_tipo_tienda]) VALUES (N'TIENDA_ABIERTA')
INSERT [dbo].[tipo_tienda] ([nombre_tipo_tienda]) VALUES (N'TIENDA_CERRADA')
GO
ALTER TABLE [dbo].[linea_pedido] ADD  DEFAULT ((1)) FOR [cantidad]
GO
ALTER TABLE [dbo].[segmento] ADD  DEFAULT ((1)) FOR [posicion_segmento]
GO
ALTER TABLE [dbo].[area_recogida]  WITH CHECK ADD  CONSTRAINT [FK_area_recogida_almacen] FOREIGN KEY([nombre_almacen_area])
REFERENCES [dbo].[almacen] ([nombre_almacen])
GO
ALTER TABLE [dbo].[area_recogida] CHECK CONSTRAINT [FK_area_recogida_almacen]
GO
ALTER TABLE [dbo].[area_recogida]  WITH CHECK ADD  CONSTRAINT [FK_area_recogida_tipo_tienda] FOREIGN KEY([tipo_tienda_area])
REFERENCES [dbo].[tipo_tienda] ([nombre_tipo_tienda])
GO
ALTER TABLE [dbo].[area_recogida] CHECK CONSTRAINT [FK_area_recogida_tipo_tienda]
GO
ALTER TABLE [dbo].[caja]  WITH CHECK ADD  CONSTRAINT [FK_caja_carro] FOREIGN KEY([id_caja_carro])
REFERENCES [dbo].[carro] ([id_carro])
GO
ALTER TABLE [dbo].[caja] CHECK CONSTRAINT [FK_caja_carro]
GO
ALTER TABLE [dbo].[caja]  WITH CHECK ADD  CONSTRAINT [FK_caja_categoria] FOREIGN KEY([categoria_caja])
REFERENCES [dbo].[categoria] ([nombre_categoria])
GO
ALTER TABLE [dbo].[caja] CHECK CONSTRAINT [FK_caja_categoria]
GO
ALTER TABLE [dbo].[linea_pedido]  WITH CHECK ADD  CONSTRAINT [FK_linea_pedido_pedido] FOREIGN KEY([id_pedido_linea_pedido])
REFERENCES [dbo].[pedido] ([id_pedido])
GO
ALTER TABLE [dbo].[linea_pedido] CHECK CONSTRAINT [FK_linea_pedido_pedido]
GO
ALTER TABLE [dbo].[linea_pedido]  WITH CHECK ADD  CONSTRAINT [FK_linea_pedido_producto] FOREIGN KEY([EAN_linea_pedido])
REFERENCES [dbo].[producto] ([EAN])
GO
ALTER TABLE [dbo].[linea_pedido] CHECK CONSTRAINT [FK_linea_pedido_producto]
GO
ALTER TABLE [dbo].[localizacion_producto]  WITH CHECK ADD  CONSTRAINT [FK_localizacion_producto_producto] FOREIGN KEY([EAN_loc])
REFERENCES [dbo].[producto] ([EAN])
GO
ALTER TABLE [dbo].[localizacion_producto] CHECK CONSTRAINT [FK_localizacion_producto_producto]
GO
ALTER TABLE [dbo].[localizacion_producto]  WITH CHECK ADD  CONSTRAINT [FK_localizacion_producto_segmento] FOREIGN KEY([id_segmento_loc])
REFERENCES [dbo].[segmento] ([id_segmento])
GO
ALTER TABLE [dbo].[localizacion_producto] CHECK CONSTRAINT [FK_localizacion_producto_segmento]
GO
ALTER TABLE [dbo].[pasillo]  WITH CHECK ADD  CONSTRAINT [FK_pasillo_area_recogida] FOREIGN KEY([id_area_pasillo])
REFERENCES [dbo].[area_recogida] ([id_area])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[pasillo] CHECK CONSTRAINT [FK_pasillo_area_recogida]
GO
ALTER TABLE [dbo].[pedido]  WITH CHECK ADD  CONSTRAINT [FK_pedido_cliente] FOREIGN KEY([dni_cliente])
REFERENCES [dbo].[cliente] ([DNI])
GO
ALTER TABLE [dbo].[pedido] CHECK CONSTRAINT [FK_pedido_cliente]
GO
ALTER TABLE [dbo].[producto]  WITH CHECK ADD  CONSTRAINT [FK_producto_categoria] FOREIGN KEY([categoria_producto])
REFERENCES [dbo].[categoria] ([nombre_categoria])
GO
ALTER TABLE [dbo].[producto] CHECK CONSTRAINT [FK_producto_categoria]
GO
ALTER TABLE [dbo].[producto_recogido]  WITH CHECK ADD  CONSTRAINT [FK_producto_recogido_caja] FOREIGN KEY([id_caja_producto])
REFERENCES [dbo].[caja] ([id_caja])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[producto_recogido] CHECK CONSTRAINT [FK_producto_recogido_caja]
GO
ALTER TABLE [dbo].[producto_recogido]  WITH CHECK ADD  CONSTRAINT [FK_producto_recogido_producto] FOREIGN KEY([id_ean_producto])
REFERENCES [dbo].[producto] ([EAN])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[producto_recogido] CHECK CONSTRAINT [FK_producto_recogido_producto]
GO
ALTER TABLE [dbo].[segmento]  WITH CHECK ADD  CONSTRAINT [FK_segmento_categoria] FOREIGN KEY([categoria_segmento])
REFERENCES [dbo].[categoria] ([nombre_categoria])
GO
ALTER TABLE [dbo].[segmento] CHECK CONSTRAINT [FK_segmento_categoria]
GO
ALTER TABLE [dbo].[segmento]  WITH CHECK ADD  CONSTRAINT [FK_segmento_pasillo] FOREIGN KEY([id_pasillo_segmento])
REFERENCES [dbo].[pasillo] ([id_pasillo])
GO
ALTER TABLE [dbo].[segmento] CHECK CONSTRAINT [FK_segmento_pasillo]
GO
