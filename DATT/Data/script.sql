USE [master]
GO
/****** Object:  Database [DATT]    Script Date: 5/23/2023 9:59:06 PM ******/
CREATE DATABASE [DATT]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DATT', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\DATT.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DATT_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\DATT_log.ldf' , SIZE = 1280KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DATT] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DATT].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DATT] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DATT] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DATT] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DATT] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DATT] SET ARITHABORT OFF 
GO
ALTER DATABASE [DATT] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DATT] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [DATT] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DATT] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DATT] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DATT] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DATT] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DATT] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DATT] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DATT] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DATT] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DATT] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DATT] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DATT] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DATT] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DATT] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DATT] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DATT] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DATT] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DATT] SET  MULTI_USER 
GO
ALTER DATABASE [DATT] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DATT] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DATT] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DATT] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [DATT]
GO
/****** Object:  StoredProcedure [dbo].[CAP_NHAT_GIAO_HANG]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[CAP_NHAT_GIAO_HANG]
@ID int
as
begin
	update HOA_DON set TRANG_THAI_GIAO = 'Đã giao hàng' where ID_HD = @ID
end

GO
/****** Object:  StoredProcedure [dbo].[DoanhThuDanhMuc]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[DoanhThuDanhMuc]
as
begin
select COUNT(CHI_TIET_HOA_DON.ID_SP) as SO_LUONG_BAN, DANH_MUC from CHI_TIET_HOA_DON, HOA_DON, SAN_PHAM 
where CHI_TIET_HOA_DON.ID_HD = HOA_DON.ID_HD and SAN_PHAM.ID_SP = CHI_TIET_HOA_DON.ID_SP group by DANH_MUC
end
GO
/****** Object:  StoredProcedure [dbo].[DoanhThuNgay]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[DoanhThuNgay]
as
begin
select  Day(HOA_DON.NGAY_XUAT) as NGAY, SUM(TONG_TIEN) as DANH_THU from CHI_TIET_HOA_DON, HOA_DON where CHI_TIET_HOA_DON.ID_HD = HOA_DON.ID_HD group by Day(HOA_DON.NGAY_XUAT)
end
GO
/****** Object:  StoredProcedure [dbo].[DoanhThuThang]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[DoanhThuThang]
as
begin
select  MONTH(HOA_DON.NGAY_XUAT) as THANG, SUM(TONG_TIEN) as DANH_THU from CHI_TIET_HOA_DON, HOA_DON where CHI_TIET_HOA_DON.ID_HD = HOA_DON.ID_HD group by MONTH(HOA_DON.NGAY_XUAT)
end
GO
/****** Object:  StoredProcedure [dbo].[TAM_TINH]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TAM_TINH]
@ACC INT
AS 
BEGIN
DECLARE @THANH_TIEN INT
SET @THANH_TIEN = (SELECT SUM(GIA*SO_LUONG) 
FROM SAN_PHAM INNER JOIN CHI_TIET_HOA_DON 
ON SAN_PHAM.ID_SP = CHI_TIET_HOA_DON.ID_SP WHERE CHI_TIET_HOA_DON.ID_ACC = 2 and TRANG_THAI is null)
SELECT @THANH_TIEN
END



GO
/****** Object:  StoredProcedure [dbo].[THEM_KHACH_VAO_HOA_DON]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[THEM_KHACH_VAO_HOA_DON]
@IDKH int, @IDAC int
as
begin
	Update CHI_TIET_HOA_DON set ID_KH = @IDKH, TRANG_THAI = 'true' where ID_ACC = @IDAC
end


GO
/****** Object:  Table [dbo].[ACCOUNT]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT](
	[ID_ACC] [int] IDENTITY(1,1) NOT NULL,
	[USERNAME] [nvarchar](50) NULL,
	[PASSWORD] [nvarchar](50) NULL,
	[QUYEN] [nvarchar](50) NULL,
 CONSTRAINT [PK_ACCOUNT] PRIMARY KEY CLUSTERED 
(
	[ID_ACC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BLOG]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BLOG](
	[ID_DMB] [int] IDENTITY(1,1) NOT NULL,
	[ID_SP] [int] NULL,
	[ANH] [nvarchar](50) NULL,
	[TIEU_DE] [nvarchar](200) NULL,
	[NOI_DUNG] [nvarchar](max) NULL,
 CONSTRAINT [PK_BLOG] PRIMARY KEY CLUSTERED 
(
	[ID_DMB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CHI_NHANH]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CHI_NHANH](
	[ID_CN] [int] IDENTITY(1,1) NOT NULL,
	[TEN_CHI_NHANH] [nvarchar](50) NULL,
	[DIA_CHI] [nvarchar](100) NULL,
	[SDT] [varchar](10) NULL,
 CONSTRAINT [PK_CHI_NHANH] PRIMARY KEY CLUSTERED 
(
	[ID_CN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CHI_TIET_HOA_DON]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHI_TIET_HOA_DON](
	[ID_CTHD] [int] IDENTITY(1,1) NOT NULL,
	[ID_SP] [int] NULL,
	[ID_KH] [int] NULL,
	[ID_CN] [int] NULL,
	[ID_ACC] [int] NULL,
	[ID_HD] [int] NULL,
	[SO_LUONG] [int] NULL,
	[TONG_TIEN] [int] NULL,
	[TRANG_THAI] [nvarchar](50) NULL,
 CONSTRAINT [PK_CHI_TIET_HOA_DON] PRIMARY KEY CLUSTERED 
(
	[ID_CTHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DANH GIA]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DANH GIA](
	[ID_DG] [int] IDENTITY(1,1) NOT NULL,
	[ID_SP] [int] NULL,
	[DIEM] [int] NULL,
	[NOI_DUNG] [nvarchar](max) NULL,
	[KIEM_TRA] [nvarchar](50) NULL,
	[ID_ACC] [int] NULL,
 CONSTRAINT [PK_DANH GIA] PRIMARY KEY CLUSTERED 
(
	[ID_DG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HOA_DON]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOA_DON](
	[ID_HD] [int] IDENTITY(1,1) NOT NULL,
	[NGAY_XUAT] [datetime] NULL,
	[TRANG_THAI_GIAO] [nvarchar](50) NULL,
 CONSTRAINT [PK_HOA_DON] PRIMARY KEY CLUSTERED 
(
	[ID_HD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KHACH_HANG]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KHACH_HANG](
	[ID_KH] [int] IDENTITY(1,1) NOT NULL,
	[TEN_KHACH_HANG] [nvarchar](50) NULL,
	[DIA_CHI] [nvarchar](100) NULL,
	[SDT] [varchar](10) NULL,
	[EMAIL] [nvarchar](50) NULL,
 CONSTRAINT [PK_KHACH_HANG] PRIMARY KEY CLUSTERED 
(
	[ID_KH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SAN_PHAM]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAN_PHAM](
	[ID_SP] [int] IDENTITY(1,1) NOT NULL,
	[THUONG_HIEU] [nvarchar](50) NULL,
	[DANH_MUC] [nvarchar](50) NULL,
	[TEN_SAN_PHAM] [nvarchar](100) NULL,
	[THONG_TIN_TONG_QUAT] [nvarchar](150) NULL,
	[GIA] [int] NULL,
	[ANH] [nvarchar](100) NULL,
	[GIAM_GIA] [int] NULL,
	[SO_LUONG_TON] [int] NULL,
 CONSTRAINT [PK_SAN_PHAM] PRIMARY KEY CLUSTERED 
(
	[ID_SP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[THONG_TIN_CUA_HANG]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THONG_TIN_CUA_HANG](
	[TEN_CUA_HANG] [nvarchar](50) NOT NULL,
	[FB] [nvarchar](150) NULL,
	[TIKTOK] [nvarchar](150) NULL,
	[YOUTUBE] [nvarchar](150) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[THONG_TIN_SAN_PHAM]    Script Date: 5/23/2023 9:59:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THONG_TIN_SAN_PHAM](
	[ID_TTSP] [int] IDENTITY(1,1) NOT NULL,
	[ID_SP] [int] NULL,
	[XUAT_XU] [nvarchar](50) NULL,
	[KICH_THUOC] [nvarchar](50) NULL,
	[CONG_NGHE_MAN_HINH] [nvarchar](150) NULL,
	[CAMERA_SAU] [nvarchar](50) NULL,
	[CAMERA_TRUOC] [nvarchar](50) NULL,
	[CHIP] [nvarchar](50) NULL,
	[RAM] [nvarchar](50) NULL,
	[BO_NHO] [nvarchar](50) NULL,
	[PIN] [nvarchar](50) NULL,
	[THE_SIM] [nvarchar](50) NULL,
	[HE_DIEU_HANH] [nvarchar](50) NULL,
	[DO_PHAN_GIAI] [nvarchar](50) NULL,
	[TAN_SO_QUET] [nvarchar](50) NULL,
	[GPU] [nvarchar](50) NULL,
	[CONG] [nvarchar](250) NULL,
	[HO_TRO_MANG] [nvarchar](50) NULL,
	[WI_FI] [nvarchar](50) NULL,
	[BLUETOOTH] [nvarchar](50) NULL,
	[KICH_THUOC_MAN_HINH] [nvarchar](50) NULL,
	[TRONG_LUONG] [nvarchar](50) NULL,
	[CHAT_LIEU] [nvarchar](50) NULL,
	[CAM_BIEN_VAN_TAY] [nvarchar](50) NULL,
	[TINH_NANG_DAC_BIET] [nvarchar](350) NULL,
	[SO_KHE_RAM] [nvarchar](50) NULL,
	[THOI_DIEM_RA_MAT] [date] NULL,
 CONSTRAINT [PK_THONG_TIN_SAN_PHAM] PRIMARY KEY CLUSTERED 
(
	[ID_TTSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[ACCOUNT] ON 

INSERT [dbo].[ACCOUNT] ([ID_ACC], [USERNAME], [PASSWORD], [QUYEN]) VALUES (1, N'Admin1', N'123456', N'admin')
INSERT [dbo].[ACCOUNT] ([ID_ACC], [USERNAME], [PASSWORD], [QUYEN]) VALUES (2, N'User1', N'123456', NULL)
INSERT [dbo].[ACCOUNT] ([ID_ACC], [USERNAME], [PASSWORD], [QUYEN]) VALUES (3, N'User2', N'123456', NULL)
INSERT [dbo].[ACCOUNT] ([ID_ACC], [USERNAME], [PASSWORD], [QUYEN]) VALUES (4, N'giathien', N'199992', NULL)
SET IDENTITY_INSERT [dbo].[ACCOUNT] OFF
SET IDENTITY_INSERT [dbo].[BLOG] ON 

INSERT [dbo].[BLOG] ([ID_DMB], [ID_SP], [ANH], [TIEU_DE], [NOI_DUNG]) VALUES (1, NULL, N'Sforum-realme-11-Pro-11-e1684137932902.jpg', N'Tin được không: Điện thoại realme dưới 7 triệu có thiết kế cao cấp, camera 200MP, màn hình cong, sạc nhanh 100W', N'<p><strong><a href="https://cellphones.com.vn/mobile/realme.html">realme</a>&nbsp;11 Pro+ l&agrave; mẫu&nbsp;<a href="https://cellphones.com.vn/mobile.html">smartphone</a>&nbsp;hiếm hoi trong ph&acirc;n kh&uacute;c gi&aacute; dưới 7 triệu đồng được trang bị ngoại h&igrave;nh đẹp mắt, cấu h&igrave;nh mạnh mẽ k&egrave;m&nbsp;<a href="https://cellphones.com.vn/phu-kien/camera.html">camera</a>&nbsp;200MP si&ecirc;u độ ph&acirc;n giải.</strong></p>

<p>realme mới đ&acirc;y đ&atilde; giới thiệu d&ograve;ng sản phẩm realme 11 series ho&agrave;n to&agrave;n mới kế nhiệm cho sự th&agrave;nh c&ocirc;ng của d&ograve;ng realme 10 series ra mắt v&agrave;o năm ngo&aacute;i. Ở phi&ecirc;n bản lần n&agrave;y người d&ugrave;ng tiếp tục c&oacute; ba sự lựa chọn l&agrave; realme 11, realme 11 Pro v&agrave; realme 11 Pro+.</p>

<p>Trong đ&oacute; phi&ecirc;n bản cao cấp nhất v&agrave; được người d&ugrave;ng quan t&acirc;m nhất vẫn ch&iacute;nh l&agrave; chiếc realme 11 Pro+, bởi chiếc m&aacute;y n&agrave;y được trang bị v&ocirc; c&ugrave;ng nhiều t&iacute;nh năng cao cấp, đi k&egrave;m một ngoại h&igrave;nh đẹp mắt,&nbsp;<a href="https://cellphones.com.vn/man-hinh.html">m&agrave;n h&igrave;nh</a>&nbsp;cong sang trọng trong khi mức gi&aacute; lại chưa tới 77 triệu đồng.</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-11.jpg" style="height:500px; width:100%" /></p>

<p>Ở thời điểm năm ngo&aacute;i, realme g&acirc;y &quot;sốt&quot; thị trường&nbsp;<a href="https://cellphones.com.vn/sforum">c&ocirc;ng nghệ</a>&nbsp;khi ra mắt chiếc realme 10 Pro+, một chiếc m&aacute;y gi&aacute; chỉ hơn 6 triệu đồng nhưng được trang bị m&agrave;n h&igrave;nh cong cạnh, một t&iacute;nh năng vốn chỉ xuất hiện tr&ecirc;n c&aacute;c d&ograve;ng smartphone cao cấp. B&ecirc;n cạnh đ&oacute;, realme 10 Pro+ cũng trang bị phần cứng hấp dẫn k&egrave;m ngoại h&igrave;nh trẻ trung, đẹp mắt. Chiếc m&aacute;y n&agrave;y d&ugrave; kh&ocirc;ng được b&aacute;n ch&iacute;nh h&atilde;ng ở thị trường Việt Nam nhưng vẫn được người d&ugrave;ng c&ocirc;ng nghệ Việt săn đ&oacute;n.</p>

<p>Kế nhiệm những th&agrave;nh c&ocirc;ng vốn c&oacute;, realme 11 Pro+ được giới thiệu thậm ch&iacute; c&ograve;n vượt trội hơn nhiều so với realme 10 Pro+. M&aacute;y c&oacute; ngoại h&igrave;nh v&ocirc; c&ugrave;ng sang trọng với mặt lưng giả da, cụm camera thiết kế dạng m&ocirc;-đun h&igrave;nh tr&ograve;n kh&aacute; giống với c&aacute;c d&ograve;ng m&aacute;y cao cấp, đi k&egrave;m m&agrave;n h&igrave;nh AMOLED cong cạnh v&agrave; phần cứng mạnh mẽ.</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-10.jpg" style="height:500px; width:100%" /></p>

<p>Phi&ecirc;n bản đang c&oacute; trong b&agrave;i viết n&agrave;y&nbsp; l&agrave; phi&ecirc;n bản m&agrave;u trắng be, đi k&egrave;m với c&aacute;c chi tiết m&agrave;u v&agrave;ng đồng được t&ocirc; điểm xung quanh th&acirc;n m&aacute;y, tạo n&ecirc;n một cảm gi&aacute;c đ&acirc;y l&agrave; một chiếc smartphone cao cấp chứ kh&ocirc;ng phải l&agrave; một chiếc smartphone tầm trung c&oacute; gi&aacute; chưa tới 7 triệu đồng.</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-12.jpg" style="height:500px; width:100%" /></p>

<p>Ngo&agrave;i ra người d&ugrave;ng c&ograve;n c&oacute; thể lựa chọn th&ecirc;m c&aacute;c tuỳ chọn m&agrave;u sắc kh&aacute;c như m&agrave;u xanh r&ecirc;u v&agrave; m&agrave;u đen. Với tuỳ chọn m&agrave;u đen th&igrave; mặt lưng của m&aacute;y sẽ được ho&agrave;n thiện từ chất liệu k&iacute;nh b&oacute;ng. Ở cả ba tuỳ chọn m&agrave;u sắc, khung viền của m&aacute;y ho&agrave;n thiện từ nhựa, đặc điểm chung của đa số smartphone gi&aacute; rẻ v&agrave; tầm trung hiện nay tới từ thương hiệu Trung Quốc.</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-7.jpg" style="height:500px; width:100%" /><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-6.jpg" style="height:500px; width:100%" /></p>

<p>realme 11 Pro+ trang bị một m&agrave;n h&igrave;nh k&iacute;ch thước 6.7 inch, sử dụng tấm nền AMOLED với độ ph&acirc;n giải FHD+, đi k&egrave;m tần số qu&eacute;t cao 120Hz. M&agrave;n h&igrave;nh n&agrave;y c&oacute; độ s&aacute;ng 950 nits, hỗ trợ HDR10+ v&agrave; c&oacute; thể hiển thị được hơn 1 tỷ m&agrave;u sắc kh&aacute;c nhau.</p>

<p>Như đ&atilde; đề cập, m&agrave;n h&igrave;nh của realme 11 Pro+ l&agrave; m&agrave;n h&igrave;nh cong cạnh b&ecirc;n, cho thao t&aacute;c vuốt, chạm sử dụng thuận tiện thay v&igrave; m&agrave;n h&igrave;nh dạng phẳng. Tất nhi&ecirc;n m&agrave;n h&igrave;nh cong cũng c&oacute; nhược điểm của n&oacute;, đ&oacute; l&agrave; người d&ugrave;ng sẽ kh&oacute; d&aacute;n cường lực hơn, hoặc nếu d&aacute;n loại UV th&igrave; cũng sẽ k&eacute;m bền d&ugrave; gi&aacute; th&agrave;nh cao hơn.</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-16.jpg" style="height:500px; width:100%" /><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-14.jpg" style="height:500px; width:100%" /><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-13.jpg" style="height:500px; width:100%" /></p>

<p>realme 11 Pro+ sử dụng thiết kế m&agrave;n h&igrave;nh &quot;nốt ruồi&quot; với camera selfie 32MP đặt ở ch&iacute;nh giữa viền tr&ecirc;n của m&agrave;n h&igrave;nh.</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-15.jpg" style="height:500px; width:100%" /></p>

<p>Về th&ocirc;ng số camera ch&iacute;nh, realme 11 Pro+ cũng l&agrave; một trong những chiếc smartphone hiếm hoi trong ph&acirc;n kh&uacute;c dưới 7 triệu được trang bị camera 200MP do&nbsp;<a href="https://cellphones.com.vn/mobile/samsung.html">Samsung</a>&nbsp;ph&aacute;t triển. M&aacute;y đi k&egrave;m th&ecirc;m hai ống k&iacute;nh nữa l&agrave; camera g&oacute;c rộng 8MP cho g&oacute;c nh&igrave;n 112 độ v&agrave; camera macro 2MP.</p>

<p>Chất lượng ảnh chụp của điện thoại realme từ trước tới nay vẫn lu&ocirc;n được người d&ugrave;ng tin tưởng. V&agrave; tr&ecirc;n realme 11 Pro+ cũng vậy, với bộ ba camera n&agrave;y người d&ugrave;ng ho&agrave;n to&agrave;n c&oacute; thể chụp ra được những bức ảnh đẹp ở đa số điều kiện.</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-8.jpg" style="height:500px; width:100%" /><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-5.jpg" style="height:500px; width:100%" /></p>

<p>Một số ảnh chụp nhanh từ camera của realme 11 Pro+:</p>

<p>&nbsp;</p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-1.jpg"><img alt="Sforum - realme 11 Pro+ camera sample (1)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-1.jpg" style="height:500px; width:100%" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-2.jpg"><img alt="Sforum - realme 11 Pro+ camera sample (2)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-2.jpg" style="height:500px; width:100%" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-3.jpg"><img alt="Sforum - realme 11 Pro+ camera sample (3)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-3.jpg" style="height:500px; width:100%" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-4.jpg"><img alt="Sforum - realme 11 Pro+ camera sample (4)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-4.jpg" style="height:500px; width:100%" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-5.jpg"><img alt="Sforum - realme 11 Pro+ camera sample (5)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-5.jpg" style="height:500px; width:100%" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-6.jpg"><img alt="Sforum - realme 11 Pro+ camera sample (6)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-6.jpg" style="height:500px; width:100%" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-7.jpg"><img alt="Sforum - realme 11 Pro+ camera sample (7)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-7.jpg" style="height:500px; width:100%" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-8.jpg"><img alt="Sforum - realme 11 Pro+ camera sample (8)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-camera-sample-8.jpg" style="height:500px; width:100%" /></a></p>

<p>Về hiệu năng, đ&acirc;y tiếp tục l&agrave; một ưu điểm của realme 11 Pro+ khi m&aacute;y được trang bị con chip Dimensity 7050 mới được MediaTek ra mắt c&aacute;ch đ&acirc;y &iacute;t l&acirc;u. Đ&acirc;y l&agrave; một con chip tập trung v&agrave;o ph&acirc;n kh&uacute;c tầm trung v&agrave; mang lại hiệu năng đủ mạnh mẽ để đ&aacute;p ứng c&aacute;c nhu cầu giải tr&iacute; của người d&ugrave;ng.</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/Sforum-realme-11-Pro-1.jpg" style="height:500px; width:100%" /></p>

<p>realme 11 Pro+ c&oacute; ba tuỳ chọn bộ nhớ, trong đ&oacute; tuỳ chọn thấp nhất đ&atilde; l&agrave; RAM 12GB k&egrave;m bộ nhớ 256GB, hai phi&ecirc;n bản c&ograve;n lại l&agrave; 12/512GB v&agrave; 12GB/1TB. M&aacute;y c&oacute; vi&ecirc;n pin dung lượng 5000mAh k&egrave;m sạc nhanh 100W, tặng k&egrave;m củ sạc sẵn.</p>

<p>Về gi&aacute; b&aacute;n, realme 11 Pro+ l&ecirc;n kệ tại thị trường Trung Quốc với mức gi&aacute; khởi điểm chỉ từ 1999 tệ, tương đương 6.7 triệu đồng cho tuỳ chọn 12GB/256GB. Phi&ecirc;n bản cao cấp nhất 12GB/1TB cũng chỉ c&oacute; gi&aacute; 2599 tệ, tương đương 8.79 triệu đồng. Đ&acirc;y quả thực l&agrave; một mức gi&aacute; v&ocirc; c&ugrave;ng hấp dẫn so với những g&igrave; m&agrave; chiếc m&aacute;y n&agrave;y mang lại.</p>

<p>&nbsp;</p>

<p><strong>Một v&agrave;i h&igrave;nh ảnh kh&aacute;c của realme 11 Pro+:</strong></p>

<table border="0" cellpadding="0" cellspacing="0" style="width:100%">
	<tbody>
		<tr>
			<td><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtgi2oabjj32dw1l97s2.jpg"><img alt="006bWoNYly1hdtgi2oabjj32dw1l97s2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtgi2oabjj32dw1l97s2.jpg" style="height:853px; width:100%" /></a></td>
			<td><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtgi74t9fj32g01mo7wh.jpg"><img alt="006bWoNYly1hdtgi74t9fj32g01mo7wh" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtgi74t9fj32g01mo7wh.jpg" style="height:853px; width:100%" /></a></td>
			<td><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtgi4xkbuj32g01monpd.jpg"><img alt="006bWoNYly1hdtgi4xkbuj32g01monpd" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtgi4xkbuj32g01monpd.jpg" style="height:853px; width:100%" /></a></td>
		</tr>
		<tr>
			<td><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtgi05g3aj32g01mo7wh.jpg"><img alt="006bWoNYly1hdtgi05g3aj32g01mo7wh" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtgi05g3aj32g01mo7wh.jpg" style="height:853px; width:100%" /></a></td>
			<td><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtgi22kv3j32g01mo7wh.jpg"><img alt="006bWoNYly1hdtgi22kv3j32g01mo7wh" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtgi22kv3j32g01mo7wh.jpg" style="height:853px; width:100%" /></a></td>
			<td><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtgi9fkaqj32g01mokjl.jpg"><img alt="006bWoNYly1hdtgi9fkaqj32g01mokjl" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtgi9fkaqj32g01mokjl.jpg" style="height:853px; width:100%" /></a></td>
		</tr>
		<tr>
			<td><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtghwucsej31l22dmh92.jpg"><img alt="006bWoNYly1hdtghwucsej31l22dmh92" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtghwucsej31l22dmh92.jpg" style="height:853px; width:100%" /></a></td>
			<td colspan="2" rowspan="1"><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtgibcs84j32g01mo7wh.jpg"><img alt="006bWoNYly1hdtgibcs84j32g01mo7wh" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtgibcs84j32g01mo7wh.jpg" style="height:853px; width:100%" /></a></td>
		</tr>
		<tr>
			<td colspan="3"><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtghyf0j4j32g01mo4qp.jpg"><img alt="006bWoNYly1hdtghyf0j4j32g01mo4qp" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/006bWoNYly1hdtghyf0j4j32g01mo4qp.jpg" style="height:853px; width:100%" /></a></td>
		</tr>
	</tbody>
</table>
')
INSERT [dbo].[BLOG] ([ID_DMB], [ID_SP], [ANH], [TIEU_DE], [NOI_DUNG]) VALUES (2, NULL, N'Sforum-vivo-X-Flip-21-e1682074786884.jpg', N'Cận cảnh vivo X Flip: Mặt lưng giả da, màn hình phụ lớn, camera Zeiss, Snapdragon 8+ Gen 1, giá 20.5 triệu đồng', N'<p>B&ecirc;n cạnh chiếc X Fold2, smartphone m&agrave;n h&igrave;nh gập cao cấp tới từ thương hiệu vivo vừa mới được giới thiệu v&agrave;o ng&agrave;y 20/4 vừa qua th&igrave; nh&agrave; sản xuất n&agrave;y c&ograve;n giới thiệu th&ecirc;m một mẫu smartphone gập mới c&oacute; dạng &quot;vỏ s&ograve;&quot; mang t&ecirc;n vivo X Flip. Đ&acirc;y cũng l&agrave; mẫu smartphone &quot;vỏ s&ograve;&quot; đầu ti&ecirc;n của vivo được giới thiệu tới người d&ugrave;ng&nbsp;<a href="https://cellphones.com.vn/sforum">c&ocirc;ng nghệ</a>.</p>

<p>&nbsp;</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-17.jpg" style="height:1365px; width:2048px" /></p>

<p>&nbsp;</p>

<p>Về cơ bản, vivo X Flip dường như được lấy cảm hứng từ chiếc&nbsp;<a href="https://cellphones.com.vn/mobile/oppo.html">OPPO</a>&nbsp;Find N2 Flip ra mắt v&agrave;o cuối năm ngo&aacute;i bởi OPPO. Cả hai sản phẩm n&agrave;y chia sẻ kh&aacute; nhiều điểm tương đồng. Cũng dễ hiểu th&ocirc;i bởi cả vivo v&agrave; OPPO, cộng th&ecirc;m&nbsp;<a href="https://cellphones.com.vn/mobile/oneplus.html">OnePlus</a>&nbsp;v&agrave; iQOO đều l&agrave; thương hiệu thuộc c&ugrave;ng c&ocirc;ng ty BBK Electronics, n&ecirc;n việc hai sản phẩm của hai h&atilde;ng n&agrave;y c&oacute; điểm tương đồng cũng kh&ocirc;ng phải l&agrave; điều g&igrave; đ&oacute; qu&aacute; kh&oacute; hiểu.</p>

<p>&nbsp;</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-4.jpg" style="height:1365px; width:2048px" /></p>

<p>&nbsp;</p>

<p>Với vivo X Flip, vivo c&oacute; c&aacute;ch tiếp cận kh&aacute; giống với OPPO Find N2 Flip, đ&oacute; l&agrave; tập trung v&agrave;o ngoại h&igrave;nh, hiệu năng v&agrave; phần cứng. M&aacute;y nổi bật với thiết kế đẹp, thời trang, nhỏ nhắn, hướng tới đối tượng người d&ugrave;ng trẻ v&agrave; đặc biệt l&agrave; người d&ugrave;ng nữ l&agrave; ch&iacute;nh. Chiếc m&aacute;y n&agrave;y c&ograve;n c&oacute; m&agrave;n h&igrave;nh lớn giống Find N2 Flip cũng như c&oacute; hiệu năng mạnh mẽ, cụm camera chất lượng nhờ hợp t&aacute;c c&ugrave;ng Zeiss cũng như c&oacute; gi&aacute; b&aacute;n dễ tiếp cận.</p>

<p>&nbsp;</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-13.jpg" style="height:1365px; width:2048px" /></p>

<p>&nbsp;</p>

<p>vivo X Flip c&oacute; mặt lưng được ho&agrave;n thiện từ chất liệu giả da cao cấp. Phi&ecirc;n bản c&oacute; trong b&agrave;i viết n&agrave;y l&agrave; phi&ecirc;n bản m&agrave;u t&iacute;m. Ngo&agrave;i ra sản phẩm c&ograve;n c&oacute; tuỳ chọn m&agrave;u đen v&agrave; m&agrave;u v&agrave;ng cũng kh&aacute; đẹp mắt v&agrave; sang trọng.</p>

<p>&nbsp;</p>

<p>vivo trang bị cho X Flip một m&agrave;n h&igrave;nh ch&iacute;nh c&oacute; k&iacute;ch thước 6.74 inch, sử dụng tấm nền Foldable LTPO AMOLED với độ ph&acirc;n giải FHD+ k&egrave;m theo tần số qu&eacute;t 120Hz. Đ&acirc;y l&agrave; m&agrave;n h&igrave;nh 10-bit m&agrave;u, c&oacute; khả năng hiển thị hơn 1 tỷ m&agrave;u sắc kh&aacute;c nhau, cũng như hỗ trợ c&aacute;c c&ocirc;ng nghệ hiển thị cao cấp như HDR10+ v&agrave; Dolby Vision.</p>

<p>&nbsp;</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-16.jpg" style="height:1365px; width:2048px" /></p>

<p>&nbsp;</p>

<p>Được biết, vivo ứng dụng c&ocirc;ng nghệ bản lề với kết cấu &quot;giọt nước&quot; gi&uacute;p tối giản ho&aacute; linh kiện b&ecirc;n trong, tăng đồ bền cho bản lề, hạn chế khoảng trống giữa hai nửa m&agrave;n h&igrave;nh cũng như hạn chế phần hiển thị nếp gấp nơi đặt bản lề. Đ&acirc;y l&agrave; một giải ph&aacute;p từng được OPPO ứng dụng lần đầu ti&ecirc;n tr&ecirc;n chiếc OPPO Find N ra mắt v&agrave;o cuối năm 2021 v&agrave; hiện tại n&oacute; được ứng dụng tr&ecirc;n rất nhiều smartphone gập kh&aacute;c nhau.</p>

<p>&nbsp;</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-6.jpg" style="height:1365px; width:2048px" /><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-5.jpg" style="height:1365px; width:2048px" /></p>

<p>&nbsp;</p>

<p>M&agrave;n h&igrave;nh n&agrave;y của vivo X Flip c&oacute; thiết kế &quot;nốt ruồi&quot; với camera selfie 32MP đặt ở ch&iacute;nh giữa cạnh viền tr&ecirc;n. Đ&aacute;ng tiếc l&agrave; m&agrave;n h&igrave;nh n&agrave;y lại kh&ocirc;ng được t&iacute;ch hợp cảm biến v&acirc;n tay dưới m&agrave;n h&igrave;nh như chiếc X Fold2. Thay v&agrave;o đ&oacute; m&aacute;y vẫn chỉ c&oacute; cảm biến v&acirc;n tay một chạm đặt ở cạnh b&ecirc;n, t&iacute;ch hợp v&agrave;o n&uacute;t nguồn của m&aacute;y.</p>

<p>&nbsp;</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-3.jpg" style="height:1365px; width:2048px" /></p>

<p>&nbsp;</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-52.gif" style="height:404px; width:720px" /></p>

<p>&nbsp;</p>

<p>Ở mặt lưng, vivo X Flip c&oacute; m&agrave;n h&igrave;nh k&iacute;ch thước lớn kh&ocirc;ng k&eacute;m cạnh so với Find N2 Flip của OPPO. M&aacute;y c&oacute; m&agrave;n h&igrave;nh phụ k&iacute;ch thước 3 inch, tức chỉ nhỏ hơn một ch&uacute;t so với k&iacute;ch thước 3.26 inch của OPPO, độ ph&acirc;n giải l&agrave; 422 x 682 với tỷ lệ hiển thị l&agrave; 14.5:9.</p>

<p>&nbsp;</p>

<p>Nh&igrave;n chung với k&iacute;ch thước lớn, người d&ugrave;ng c&oacute; thể tận dụng m&agrave;n h&igrave;nh n&agrave;y để thao t&aacute;c nhiều hơn thay v&igrave; chỉ đơn thuần để kiểm tra th&ocirc;ng b&aacute;o. Theo c&aacute;c h&igrave;nh ảnh được đăng tải, người d&ugrave;ng c&oacute; thể nu&ocirc;i cả th&uacute; ảo tr&ecirc;n m&agrave;n h&igrave;nh n&agrave;y, hoặc thậm ch&iacute; sử dụng giao diện dạng tối giản cho bất kỳ ứng dụng n&agrave;o.</p>

<p>&nbsp;</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-9.jpg" style="height:1365px; width:2048px" /><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-8.jpg" style="height:1365px; width:2048px" /><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-7.jpg" style="height:1365px; width:2048px" /><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-12.jpg" style="height:1365px; width:2048px" /><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-11.jpg" style="height:1365px; width:2048px" /></p>

<p>&nbsp;</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-55.jpg" style="height:1368px; width:2048px" /></p>

<p>&nbsp;</p>

<p>Cụm camera ch&iacute;nh l&agrave; một điểm nhấn của vivo X Flip khi m&aacute;y trang bị hệ thống camera k&eacute;p gồm hai ống k&iacute;nh: g&oacute;c rộng 50MP sử dụng cảm biến IMX866V tương tự như vivo X Fold2, đ&acirc;y l&agrave; loại cảm biến được Sony tinh chỉnh d&agrave;nh ri&ecirc;ng cho c&aacute;c mẫu điện thoại cao cấp của vivo, camera thứ hai l&agrave; camera g&oacute;c si&ecirc;u rộng 12MP.</p>

<p>&nbsp;</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-32.jpg" style="height:1368px; width:2048px" /><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-35.jpg" style="height:1368px; width:2048px" /></p>

<p>&nbsp;</p>

<p>Tất nhi&ecirc;n, vivo sẽ vẫn hợp t&aacute;c với thương hiệu Zeiss nhằm cải thiện chất lượng quang học của camera. Ống k&iacute;nh g&oacute;c rộng 50MP sẽ được phủ l&ecirc;n một lớp phủ Zeiss T* tương tự như c&aacute;c ống k&iacute;nh đắt tiền của Zeiss. Ngo&agrave;i ra, camera của m&aacute;y cũng trang bị c&aacute;c thuật to&aacute;n xử l&yacute; ảnh tối ưu ho&aacute; v&agrave; chế độ chụp Zeiss Cinematic, gi&uacute;p trải nghiệm sử dụng camera của chiếc m&aacute;y n&agrave;y trở n&ecirc;n tốt hơn nhiều.</p>

<p>&nbsp;</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-49.jpg" style="height:1368px; width:2048px" /></p>

<p>&nbsp;</p>

<p>Tham khảo một v&agrave;i h&igrave;nh ảnh được chụp từ camera của vivo X Flip.</p>

<p>&nbsp;</p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-48.jpg"><img alt="Sforum - vivo X Flip - 48" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-48.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-47.jpg"><img alt="Sforum - vivo X Flip - 47" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-47.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-46.jpg"><img alt="Sforum - vivo X Flip - 46" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-46.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-45.jpg"><img alt="Sforum - vivo X Flip - 45" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-45.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-44.jpg"><img alt="Sforum - vivo X Flip - 44" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-44.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-43.jpg"><img alt="Sforum - vivo X Flip - 43" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-43.jpg" style="height:853px; width:1280px" /></a></p>

<p>&nbsp;</p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-41.jpg"><img alt="Sforum - vivo X Flip - 41" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-41.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-40.jpg"><img alt="Sforum - vivo X Flip - 40" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-40.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-29.jpg"><img alt="Sforum - vivo X Flip - 29" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-29.jpg" style="height:853px; width:1280px" /></a></p>

<p>&nbsp;</p>

<p>Về hiệu năng, vivo X Flip trang bị con chip Snapdragon 8+ Gen 1, kh&ocirc;ng phải l&agrave; con chip mạnh mẽ nhất v&agrave; mới nhất ở thời điểm hiện tại nhưng vẫn l&agrave; một con chip cho hiệu năng rất mạnh, đ&aacute;p ứng gần như tất cả nhu cầu về hiệu năng của người d&ugrave;ng. M&aacute;y cũng c&oacute; thể chơi mượt c&aacute;c tựa&nbsp;<a href="https://cellphones.com.vn/sforum/s-games">game</a>&nbsp;nặng tr&ecirc;n thị trường ở mức đồ hoạ cao.</p>

<p>&nbsp;</p>

<p><img alt="" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-55.jpg" style="height:1368px; width:2048px" /></p>

<p>&nbsp;</p>

<p>vivo X Flip trang bị vi&ecirc;n pin dung lượng 4400mAh v&agrave; hỗ trợ sạc nhanh 44W giống với OPPO Find N2 Flip. M&aacute;y chạy sẵn tr&ecirc;n Android 13 với giao diện OriginOS 3.</p>

<p>&nbsp;</p>

<p>vivo X Flip l&ecirc;n kệ tại thị trường Trung Quốc với mức gi&aacute; khởi điểm từ 5999 tệ, tương đương 20.5 triệu đồng. Mức gi&aacute; n&agrave;y đắt hơn một ch&uacute;t so với gi&aacute; của chiếc Find N2 Flip.</p>

<p>&nbsp;</p>

<p>Một v&agrave;i h&igrave;nh ảnh kh&aacute;c của vivo X Flip.</p>

<p>&nbsp;</p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-27.jpg"><img alt="Sforum - vivo X Flip - 27" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-27.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-26.jpg"><img alt="Sforum - vivo X Flip - 26" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-26.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-25.jpg"><img alt="Sforum - vivo X Flip - 25" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-25.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-24.jpg"><img alt="Sforum - vivo X Flip - 24" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-24.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-23.jpg"><img alt="Sforum - vivo X Flip - 23" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-23.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-22.jpg"><img alt="Sforum - vivo X Flip - 22" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-22.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-21.jpg"><img alt="Sforum - vivo X Flip - 21" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-21.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-20.jpg"><img alt="Sforum - vivo X Flip - 20" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-20.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-19.jpg"><img alt="Sforum - vivo X Flip - 19" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/Sforum-vivo-X-Flip-19.jpg" style="height:853px; width:1280px" /></a></p>
')
INSERT [dbo].[BLOG] ([ID_DMB], [ID_SP], [ANH], [TIEU_DE], [NOI_DUNG]) VALUES (3, NULL, N'cover-Xiaomi-13-Lite-a-1.jpg', N'Trên tay Xiaomi 13 Lite: Camera kép “Dynamic Island”, Snapdragon 7 Gen 1 đầu tiên ở VN, giá từ 11.49 triệu đồng', N'<p><a href="https://cellphones.com.vn/mobile/xiaomi.html">Xiaomi</a>&nbsp;đ&atilde; ch&iacute;nh thức ra mắt Xiaomi 13 Lite ch&iacute;nh h&atilde;ng tại thị trường Việt Nam, m&aacute;y sở hữu thiết kế v&agrave; phần cứng giống với Xiaomi Civi 2 ra mắt c&aacute;ch đ&acirc;y kh&ocirc;ng l&acirc;u. C&oacute; thể n&oacute;i đ&acirc;y l&agrave; phi&ecirc;n bản quốc tế của Civi 2.&nbsp;</p>

<p>&nbsp;</p>

<p><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-24.jpg" /></p>

<p>&nbsp;</p>

<p>C&aacute;ch đ&oacute;ng hộp m&aacute;y vẫn giống như c&aacute;c sản phẩm kh&aacute;c của Xiaomi, b&ecirc;n trong hộp m&aacute;y ngo&agrave;i s&aacute;ch HDSD th&igrave; ch&uacute;ng ta c&ograve;n c&oacute; 1 chiếc ốp lưng trong suốt, d&acirc;y sạc type-C v&agrave; củ sạc 67W.</p>

<p>&nbsp;</p>

<p><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-1.jpg" style="height:853px; width:1280px" /></p>

<p>&nbsp;</p>

<p><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-3.jpg" style="height:853px; width:1280px" />Phi&ecirc;n bản m&igrave;nh tr&ecirc;n tay c&oacute; m&agrave;u hồng &aacute;nh t&iacute;m, khi ra ngo&agrave;i nắng sẽ c&oacute; hiệu ứng chuyển m&agrave;u kh&aacute; bắt mắt. C&aacute; nh&acirc;n m&igrave;nh đ&aacute;nh gi&aacute; m&agrave;u sắc của m&aacute;y kh&aacute; đẹp, ph&ugrave; hợp với c&aacute;c bạn nữ th&iacute;ch sự nhẹ nh&agrave;ng v&agrave; ngọt ng&agrave;o nhưng kh&ocirc;ng qu&aacute; ph&ocirc; trương. Tổng thể m&aacute;y được ho&agrave;n thiện kh&aacute; cao cấp với thiết kế v&aacute;t cong sắc sảo, m&aacute;y chỉ nặng 172g, độ mỏng 7.2mm mang đến cảm gi&aacute;c cầm nắm chắc chắn.&nbsp;</p>

<p>&nbsp;</p>

<p><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-22.jpg" style="height:853px; width:1280px" /></p>

<p>&nbsp;</p>

<p>M&aacute;y sẽ được trang bị khung nhựa thay v&igrave; kim loại, đ&acirc;y l&agrave; một điều m&igrave;nh thấy kh&aacute; đ&aacute;ng tiếc ở Xiaomi 13 Lite. Ở cạnh b&ecirc;n sẽ c&oacute; n&uacute;t nguồn v&agrave; n&uacute;t tăng giảm &acirc;m lượng, khay sim được bố tr&iacute; ở c&ugrave;ng ph&iacute;a với cổng sạc type-C v&agrave; loa.&nbsp;</p>

<p>&nbsp;</p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-6.jpg"><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-6.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-5.jpg"><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-5.jpg" style="height:853px; width:1280px" /></a></p>

<p>&nbsp;</p>

<p>Ph&iacute;a tr&ecirc;n đỉnh sẽ c&oacute; logo Dolby Atmos, cổng hồng ngoại v&agrave; một lỗ mic. Tuy nhi&ecirc;n sản phẩm chỉ được trang bị loa đơn thay v&igrave; loa k&eacute;p, v&igrave; thế ch&uacute;ng ta chỉ n&ecirc;n sử dụng&nbsp;<a href="https://cellphones.com.vn/thiet-bi-am-thanh/tai-nghe.html">tai nghe</a>&nbsp;để c&oacute; thể trải nghiệm &acirc;m thanh Dolby tốt nhất.</p>

<p>&nbsp;</p>

<p><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-7.jpg" style="height:853px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Xiaomi 13 Lite sở hữu một thiết kế cực k&igrave; quyến rũ với phần m&agrave;n h&igrave;nh được v&aacute;t cong 3D. M&aacute;y được trang bị m&agrave;n h&igrave;nh k&iacute;ch thước 6.55inch, sử dụng tấm nền Amoled với độ ph&acirc;n giải&nbsp;FullHD+, tần số qu&eacute;t 120Hz, độ s&aacute;ng 1000 nits, 1 tỉ m&agrave;u, Dolby Vision v&agrave; HDR 10+. Trải nghiệm thực tế sản phẩm thể hiện m&agrave;u sắc kh&aacute; tốt với c&aacute;c d&atilde;y m&agrave;u mang đến độ tương phản cao, m&agrave;u sắc rực rỡ, ph&ugrave; hợp để giải tr&iacute; hằng ng&agrave;y.</p>

<p>&nbsp;</p>

<p><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-19.jpg" style="height:853px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Ngo&agrave;i ra c&ograve;n c&oacute; sự xuất hiện của cụm camera k&eacute;p ấn tượng với thiết kế &ldquo;Dynamic Island&rdquo; như tr&ecirc;n&nbsp;<a href="https://cellphones.com.vn/mobile/apple.html">iPhone</a>&nbsp;14 Pro. Cả hai chiếc camera n&agrave;y đều c&oacute; độ ph&acirc;n giải l&agrave; 32 MP, hỗ trợ chụp g&oacute;c rộng v&agrave; g&oacute;c si&ecirc;u rộng 100 độ, đặc biệt ph&ugrave; hợp để chụp ảnh nh&oacute;m v&agrave; quay Vlog.&nbsp;</p>

<p>&nbsp;</p>

<p><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-25.jpg" style="height:853px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Một điểm ấn tượng kh&ocirc;ng thể kh&ocirc;ng nhắc tới l&agrave; cụm đ&egrave;n flash selfie dual-tone kh&aacute; l&agrave; th&uacute; vị, hỗ trợ chụp thiếu s&aacute;ng cực k&igrave; tốt, gi&uacute;p n&acirc;ng tone m&agrave;u da nhẹ nh&agrave;ng cho chị em.</p>

<p>&nbsp;</p>

<p><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-23.jpg" style="height:853px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Ở mặt sau m&aacute;y cũng được trang bị chất liệu k&iacute;nh cao cấp v&aacute;t cong 3D c&ugrave;ng với đ&oacute; l&agrave; cụm camera được thiết kế kh&aacute; bắt mắt. Ch&uacute;ng ta sẽ c&oacute; camera ch&iacute;nh g&oacute;c rộng độ ph&acirc;n giải 50 MP, sử dụng cảm biến Sony IMX776 tương tự như Xiaomi 12S, camera g&oacute;c si&ecirc;u rộng 20 MP, g&oacute;c nh&igrave;n 115 độ v&agrave; cuối c&ugrave;ng l&agrave; camera macro 2 MP.&nbsp;</p>

<p>&nbsp;</p>

<p><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-8.jpg" style="height:853px; width:1280px" /></p>

<p>&nbsp;</p>

<p><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-9.jpg" style="height:853px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Hiệu năng m&aacute;y kh&aacute; tốt khi được trang bị con chip tầm trung 4nm đầu ti&ecirc;n của Qualcomm l&agrave; Snapdragon 7 Gen 1. Chấm điểm hiệu năng của&nbsp; bằng phần mềm AnTuTu Benchmark 9 v&agrave; Geekbench 6 đều cho ra điểm số kh&aacute; ổn, ph&ugrave; hợp để chơi c&aacute;c tựa&nbsp;<a href="https://cellphones.com.vn/sforum/s-games">game</a>&nbsp;c&oacute; đồ hoạ trung b&igrave;nh. Nhiệt độ của m&aacute;y kh&aacute; m&aacute;t, chỉ loanh quanh 40 độ sau khi chạy xong AnTuTu.&nbsp;</p>

<p>&nbsp;</p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-13.jpg"><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-13.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-12.jpg"><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-12.jpg" style="height:853px; width:1280px" /></a></p>

<p>&nbsp;</p>

<p>Về thời lượng pin, Xiaomi 13 Lite được trang bị vi&ecirc;n pin 4500 mAh, hỗ trợ&nbsp;<a href="https://cellphones.com.vn/sforum">c&ocirc;ng nghệ</a>&nbsp;sạc nhanh 67W của Xiaomi với bộ sạc đi k&egrave;m. M&aacute;y chạy sẵn tr&ecirc;n Android 12 với giao diện MIUI 14 mới nhất.</p>

<p>&nbsp;</p>

<p><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-20.jpg" style="height:853px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Với thiết kế đẹp mắt, camera ấn tượng mang đến khả năng chụp ảnh Selfie cực k&igrave; tốt th&igrave; đ&acirc;y chắc chắn l&agrave; chiếc&nbsp;<a href="https://cellphones.com.vn/mobile.html">điện thoại</a>&nbsp;sinh ra d&agrave;nh cho c&aacute;c chị em, đặc biệt l&agrave; ph&ugrave; hợp với nhu cầu quay Vlog cơ bản.</p>

<p>&nbsp;</p>

<p><img alt="Xiaomi 13 Lite" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/02/Xiaomi-13-Lite-16.jpg" /></p>

<p>&nbsp;</p>

<p>Xiaomi 13 Lite sẽ được l&ecirc;n kệ với mức gi&aacute; ni&ecirc;m yết tại thị trường Việt Nam l&agrave;&nbsp;<strong>11,490,000 VND</strong>&nbsp;cho phi&ecirc;n bản 8GB/256GB, c&oacute; 3 m&agrave;u sắc l&agrave; hồng, xanh dương v&agrave; đen. Đặc biệt m&agrave;u hồng sẽ l&agrave; phi&ecirc;n bản được b&aacute;n độc quyền tại&nbsp;<a href="https://cellphones.com.vn/">CellphoneS</a>. Thời gian đặt h&agrave;ng từ 23/02 - 10/03 v&agrave; bắt đầu trả h&agrave;ng từ 11/03. Khi đặt h&agrave;ng tại CellphoneS bạn sẽ nhận được nhiều ưu đ&atilde;i hấp dẫn giảm trực tiếp&nbsp;<strong>1.5 triệu đồng</strong>&nbsp;hoặc tặng k&egrave;m m&aacute;y h&uacute;t bụi Vaccum Cleaner v&agrave; giảm th&ecirc;m&nbsp;<strong>500,000 VND.</strong></p>
')
INSERT [dbo].[BLOG] ([ID_DMB], [ID_SP], [ANH], [TIEU_DE], [NOI_DUNG]) VALUES (4, NULL, N'vivo-X-Fold2-13.jpg', N'Cận cảnh vivo X Fold2: Mặt lưng da cao cấp, camera Zeiss 50MP, Snapdragon 8 Gen 2, sạc 120W và giá chỉ từ 30.7 triệu đồng', N'<p><a href="https://cellphones.com.vn/mobile/vivo.html">vivo</a>&nbsp;X Fold2 l&agrave; chiếc điện thoại m&agrave;n h&igrave;nh gập thế hệ thứ hai của vivo với nhiều cải tiến đ&aacute;ng kể. Với cơ chế bản lề được l&agrave;m lại, vi xử l&yacute; Snapdragon 8 Gen 2 mới nhất, camera mới v&agrave; c&ocirc;ng suất sạc nhanh l&ecirc;n đến 120W. Những n&acirc;ng cấp đ&aacute;ng chủ &yacute; kể tr&ecirc;n, vivo X Fold2 hứa hẹn sẽ mang đến cho người d&ugrave;ng trải nghiệm mới lạ khi sử dụng điện thoại m&agrave;n h&igrave;nh gập. V&agrave; trong b&agrave;i viết n&agrave;y, h&atilde;y c&ugrave;ng m&igrave;nh tr&ecirc;n tay em n&oacute; trong b&agrave;i viết n&agrave;y nh&eacute;.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-11.jpg" style="height:720px; width:1280px" /></p>

<p>&nbsp;</p>

<p>vivo X Fold2 sở hữu phong c&aacute;ch thiết kế m&agrave;n h&igrave;nh gập trong tương tự những d&ograve;ng Galaxy Z series đến từ Samsung. Sau đ&oacute;, c&aacute;c thương hiệu kh&aacute;c đến từ Trung Quốc cũng học hỏi theo như&nbsp;<a href="https://cellphones.com.vn/mobile/huawei.html">Huawei</a>,&nbsp;<a href="https://cellphones.com.vn/mobile/xiaomi.html">Xiaomi</a>,&nbsp;<a href="https://cellphones.com.vn/mobile/oppo.html">OPPO</a>&nbsp;v&agrave; Honor.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-17.jpeg" style="height:960px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Sản phẩm được vivo cho biết sẽ mỏng hơn thế hệ tiền nhiệm 2mm v&agrave; nhẹ hơn đến 33g. Cụ thể sản phẩm được xem l&agrave; một trong những chiếc điện thoại m&agrave;n h&igrave;nh gập mỏng v&agrave; nhẹ nhất tr&ecirc;n thị trường thời điểm hiện tại với lần lượt chỉ 12.9mm v&agrave; 279g.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-15.jpeg" style="height:960px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Kh&ocirc;ng chỉ vậy, với cơ chế bản lề mới c&ugrave;ng chất liệu FS54 đạt chuẩn h&agrave;ng kh&ocirc;ng do ch&iacute;nh vivo ph&aacute;t triển đ&atilde; gi&uacute;p chiếc điện thoại tối ưu hơn trong việc đ&oacute;ng mở. Khi đ&oacute;ng lại, 2 phần m&agrave;n h&igrave;nh sẽ kh&eacute;p k&iacute;n ho&agrave;n to&agrave;n v&agrave; hạn chế tối đa nếp gấp kh&oacute; chịu khi sử dụng.</p>

<p>&nbsp;</p>

<p><img alt="Cùng với đó, tấm nền màn hình Foldable LTPO4 AMOLED sẽ giúp cho thiết bị dễ dàng thay đổi tần số quét linh hoạt để tiết kiệm năng lượng hơn. Viền màn hình khá mỏng giúp cho tỷ lệ màn hình so với thân máy lên đến 89.3%." src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-7-1.jpg" style="height:720px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Ngo&agrave;i ra, độ bền cũng được h&atilde;ng đảm bảo l&ecirc;n đến 400,000 lần gập li&ecirc;n tục. Điều n&agrave;y gi&uacute;p cho người d&ugrave;ng c&oacute; thể an t&acirc;m sử dụng chiếc điện thoại trong thời gian m&agrave; kh&ocirc;ng lo về hư hỏng bản lề hay m&agrave;n h&igrave;nh.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-10.jpeg" style="height:960px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Ở mặt trước, vivo X Fold2 cung cấp m&agrave;n h&igrave;nh phụ cong c&oacute; k&iacute;ch thước 6.53 inch với độ ph&acirc;n giải 1080 x 2520 pixels v&agrave; tỷ lệ m&agrave;n h&igrave;nh 21:9. M&agrave;n h&igrave;nh phụ kh&ocirc;ng bị qu&aacute; d&agrave;i m&agrave; vẫn c&acirc;n đối như nhiều chiếc điện thoại b&igrave;nh thường kh&aacute;c đ&aacute;p ứng khả năng sử dụng thoải m&aacute;i.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-11.jpeg" style="height:960px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Phần m&agrave;n h&igrave;nh phụ được trang bị tấm nền AMOLED, hỗ trợ c&aacute;c&nbsp;<a href="https://cellphones.com.vn/sforum">c&ocirc;ng nghệ</a>&nbsp;hiển thị phổ biến như HDR10+, Dolby Vision v&agrave; t&iacute;ch hợp tần số qu&eacute;t 120Hz. Điều n&agrave;y gi&uacute;p cho m&agrave;n h&igrave;nh c&oacute; thể thoải m&aacute;i trải nghiệm chất lượng hiển thị tốt nhất v&agrave; sẵn s&agrave;ng sử dụng ở những điều kiện c&oacute; &aacute;nh s&aacute;ng phức tạp nhờ v&agrave;o độ s&aacute;ng tối đa l&ecirc;n đến 1600 nits.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-15.jpg" style="height:720px; width:1280px" /></p>

<p>&nbsp;</p>

<p>B&ecirc;n cạnh đ&oacute;, m&agrave;n h&igrave;nh phụ cũng sẽ chứa th&ecirc;m hệ thống camera trước với độ ph&acirc;n giải 16MP v&agrave; khẩu độ f/2.5. Viền m&agrave;n h&igrave;nh cũng tương đối mỏng với c&aacute;c sản phẩm trong c&ugrave;ng ph&acirc;n kh&uacute;c đem lại cảm gi&aacute;c rất thoải m&aacute;i khi sử dụng.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-8-1.jpg" style="height:720px; width:1280px" /></p>

<p>&nbsp;</p>

<p>vivo X Fold2 cung cấp đa dạng t&ugrave;y chọn m&agrave;u sắc bao gồm đỏ, đen v&agrave; xanh với chất liệu ho&agrave;n thiện từ da v&agrave; k&iacute;nh. Module camera được thiết kế theo dạng h&igrave;nh tr&ograve;n lớn, kh&aacute; nổi bật kết hợp với logo ống k&iacute;nh Zeiss trứ danh từng g&acirc;y b&atilde;o với thế hệ điện thoại đến từ&nbsp;<a href="https://cellphones.com.vn/mobile/nokia.html">Nokia</a>.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-12.jpg" style="height:720px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Điểm nhấn ấn tượng ở mặt lưng đến từ dải k&iacute;nh chạy dọc ở b&ecirc;n phải tạo cảm gi&aacute;c như đang sử dụng với quyển sổ. Điểm xuyết c&ugrave;ng logo vivo ở ph&iacute;a tr&aacute;i cạnh dưới vừa đơn giản lại vừa h&agrave;i h&ograve;a đẹp mắt.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-16.jpg" style="height:720px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Trước khi n&oacute;i về m&agrave;n h&igrave;nh ch&iacute;nh, h&atilde;y n&oacute;i về bản lề của vivo X Fold2. Sản phẩm cung cấp bản lề với đa dạng g&oacute;c mở cho ph&eacute;p bạn sử dụng được trong nhiều trường hợp kh&aacute;c nhau.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-16.jpeg" style="height:960px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Khi mở ho&agrave;n to&agrave;n m&agrave;n h&igrave;nh bạn sẽ nhận được k&iacute;ch thước l&ecirc;n đến 8.03 inch với độ ph&acirc;n giải 1916 x 2160 pixels cho trải nghiệm rộng lớn v&agrave; sắc n&eacute;t. Với những m&agrave;n h&igrave;nh lớn th&igrave; việc tối ưu c&aacute;c t&iacute;nh năng trong phần mềm l&agrave; điều cực kỳ quan trọng.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-5.jpeg" style="height:960px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Điều n&agrave;y đ&atilde; được vivo giải quyết với c&aacute;c t&iacute;nh năng tương tự như chế độ Flex Mode của Samsung. Khi gập ph&acirc;n nửa m&agrave;n h&igrave;nh, chiếc điện thoại sẽ tự động chia l&agrave;m 2 m&agrave;n h&igrave;nh độc lập với c&aacute;c t&iacute;nh năng kh&aacute;c nhau như trong ứng dụng chụp hay khi xem video.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-5-1.jpg" style="height:720px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Trong phần mềm, ở m&agrave;n h&igrave;nh ch&iacute;nh vivo cung cấp rất nhiều icon với k&iacute;ch thước c&oacute; thể t&ugrave;y chỉnh c&ugrave;ng h&agrave;ng loạt widget nổi bật. Ở cạnh dưới, vivo c&ograve;n cung cấp th&ecirc;m cho vivo X Fold2 thanh dock ứng dụng tương tự như tr&ecirc;n những chiếc Galaxy Z Fold để đem lại khả năng đa nhiệm tốt hơn.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-3-1.jpg" style="height:720px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Ngo&agrave;i ra, m&agrave;n h&igrave;nh c&ograve;n hỗ trợ đầy đủ c&aacute;c c&ocirc;ng nghệ hiển thị như m&agrave;n h&igrave;nh phụ với HDR10+, Dolby Vision v&agrave; tần số qu&eacute;t 120Hz. Từ đ&oacute;, mang lại trải nghiệm giải tr&iacute; ấn tượng với m&agrave;u sắc rực rỡ c&ugrave;ng độ mượt m&agrave; cao khi vuốt chạm.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-1-1.jpg" style="height:720px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Sản phẩm cũng t&iacute;ch hợp cảm biến v&acirc;n tay b&ecirc;n trong m&agrave;n h&igrave;nh gi&uacute;p bạn tiện lợi hơn trong qu&aacute; tr&igrave;nh sử dụng. M&agrave;n h&igrave;nh ch&iacute;nh cũng cung cấp th&ecirc;m camera trước cho ph&eacute;p bạn gọi điện hay họp trực tuyến với c&ugrave;ng độ ph&acirc;n giải 16MP v&agrave; khẩu độ f/2.5.</p>

<p>&nbsp;</p>

<p>C&ugrave;ng với đ&oacute;, tấm nền m&agrave;n h&igrave;nh Foldable LTPO4 AMOLED sẽ gi&uacute;p cho thiết bị dễ d&agrave;ng thay đổi tần số qu&eacute;t linh hoạt để tiết kiệm năng lượng hơn. Viền m&agrave;n h&igrave;nh kh&aacute; mỏng gi&uacute;p cho tỷ lệ m&agrave;n h&igrave;nh so với th&acirc;n m&aacute;y l&ecirc;n đến 89.3%.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-2-1.jpg" style="height:720px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Về cấu h&igrave;nh, vivo X Fold2 trang bị vi xử l&yacute; Snapdragon 8 Gen 2 với hiệu suất CPU cải thiện 37%, hiệu suất GPU cải thiện 42% v&agrave; hiệu quả sử dụng năng lượng cải thiện 15% so với thế hệ tiền nhiệm. Sản phẩm sẽ đi k&egrave;m với dung lượng RAM LPDDR5X 12GB v&agrave; dung lượng bộ nhớ trong UFS 4.0 l&ecirc;n đến 512GB.</p>

<p>&nbsp;</p>

<p>Trong b&agrave;i kiểm tra với phần mềm chấm điểm hiệu năng nổi tiếng AnTuTu Benchmark. vivo X Fold2 mang lại số điểm kh&aacute; cao l&ecirc;n đến 1,319,638 điểm. Trong đ&oacute;, nổi bật với số điểm GPU l&ecirc;n đến 580,468 điểm hứa hẹn về hiệu suất xử l&yacute; đồ họa vượt trội trong h&agrave;ng loạt ứng dụng.</p>

<p>&nbsp;</p>

<p><img alt="Cùng với đó, tấm nền màn hình Foldable LTPO4 AMOLED sẽ giúp cho thiết bị dễ dàng thay đổi tần số quét linh hoạt để tiết kiệm năng lượng hơn. Viền màn hình khá mỏng giúp cho tỷ lệ màn hình so với thân máy lên đến 89.3%." src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-10.jpg" style="height:1494px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Điểm số m&agrave; vivo X Fold2 đạt được c&oacute; thể s&aacute;nh ngang với d&ograve;ng điện thoại chuy&ecirc;n chơi&nbsp;<a href="https://cellphones.com.vn/sforum/s-games">game</a>&nbsp;ROG Phone 7 Ultimate với điểm số m&agrave; bạn c&oacute; thể tham khảo ở h&igrave;nh b&ecirc;n dưới.</p>

<p>&nbsp;</p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-10-1.jpg"><img alt="vivo X Fold2 (10)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-10-1.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-11-1.jpg"><img alt="vivo X Fold2 (11)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-11-1.jpg" style="height:853px; width:1280px" /></a></p>

<p>&nbsp;</p>

<p>Ngo&agrave;i ra, vivo X Fold2 c&ograve;n được trang bị hệ thống tản nhiệt bằng chất lỏng VC đảm bảo cho chiếc điện thoại lu&ocirc;n m&aacute;t mẻ khi hoạt động với c&aacute;c ứng dụng nặng k&eacute;o d&agrave;i, đặc biệt l&agrave; chơi game hay quay video.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-17.jpeg" style="height:960px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Về camera, vivo X Fold2 sở hữu bộ ba camera ở mặt lưng với cảm biến ch&iacute;nh 50MP, cảm biến g&oacute;c si&ecirc;u rộng 12MP v&agrave; cảm biến tele 12MP. Chất lượng ảnh m&agrave; vivo X Fold2 mang lại kh&aacute; tốt trong điều kiện đủ s&aacute;ng với chi tiết đầy đủ v&agrave; m&agrave;u sắc ch&acirc;n thật.</p>

<p>&nbsp;</p>

<p><img alt="Cùng với đó, tấm nền màn hình Foldable LTPO4 AMOLED sẽ giúp cho thiết bị dễ dàng thay đổi tần số quét linh hoạt để tiết kiệm năng lượng hơn. Viền màn hình khá mỏng giúp cho tỷ lệ màn hình so với thân máy lên đến 89.3%." src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-9.jpeg" style="height:960px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Trong khi đ&oacute;, ở điều kiện trong nh&agrave; khi chụp ch&acirc;n dung x&oacute;a ph&ocirc;ng. vivo X Fold2 thể hiện khả năng t&aacute;ch biệt vật thể kh&aacute; chỉnh chu nhờ v&agrave;o ống k&iacute;nh Zeiss trứ danh. Tuy nhi&ecirc;n, về phần m&agrave;u sắc c&oacute; vẻ hơi nhợt nhạt v&agrave; chi tiết suy giảm so với điều kiện đủ s&aacute;ng.</p>

<p>&nbsp;</p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-7.jpg"><img alt="vivo X Fold2 (7)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-7.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-8.jpg"><img alt="vivo X Fold2 (8)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-8.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-6.jpg"><img alt="vivo X Fold2 (6)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-6.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-5.jpg"><img alt="vivo X Fold2 (5)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-5.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-4.jpg"><img alt="vivo X Fold2 (4)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-4.jpg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-6.jpeg"><img alt="vivo X Fold2 (6)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-6.jpeg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-2.jpeg"><img alt="vivo X Fold2 (2)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-2.jpeg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-2.jpg"><img alt="vivo X Fold2 (2)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-2.jpg" style="height:853px; width:1280px" /></a></p>

<p>&nbsp;</p>

<p>Cuối c&ugrave;ng trong điều kiện thiếu s&aacute;ng, những bức ảnh thể hiện được sự t&aacute;ch bạch trong việc ph&acirc;n t&iacute;ch chủ thể. Độ nổi khối tốt v&agrave; tạo sự tương phản ấn tượng kh&ocirc;ng bị lẹm m&agrave;u sắc v&agrave;o nhau.</p>

<p>&nbsp;</p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-1.jpeg"><img alt="vivo X Fold2 (1)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-1.jpeg" style="height:853px; width:1280px" /></a></p>

<p><a href="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-8.jpeg"><img alt="vivo X Fold2 (8)" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-8.jpeg" style="height:853px; width:1280px" /></a></p>

<p>&nbsp;</p>

<p>Cung cấp năng lượng cho vivo X Fold2 đến từ vi&ecirc;n pin 4800mAh kh&aacute; lớn đối với chiếc điện thoại m&agrave;n h&igrave;nh gập. Thiết bị c&ograve;n tương th&iacute;ch với sạc nhanh 120W, hỗ trợ sạc kh&ocirc;ng d&acirc;y 50W v&agrave; sạc ngược kh&ocirc;ng d&acirc;y 10W.</p>

<p>&nbsp;</p>

<p><img alt="vivo X Fold2" src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/04/vivo-X-Fold2-9.jpg" style="height:1443px; width:1280px" /></p>

<p>&nbsp;</p>

<p>Nh&igrave;n chung, vivo X Fold2 l&agrave; chiếc điện thoại m&agrave;n h&igrave;nh gập rất hứa hẹn với cấu h&igrave;nh mạnh mẽ nhờ v&agrave;o vi xử l&yacute; Snapdragon 8 Gen 2, m&agrave;n h&igrave;nh sắc n&eacute;t v&agrave; phần mềm được tối ưu. Tuy nhi&ecirc;n, chiếc điện thoại lại c&oacute; nhiều điểm tương đồng so với c&aacute;c đối thủ cạnh tr&ecirc;n đến từ OPPO hay Huawei. V&igrave; thế với mức gi&aacute; 30.7 triệu đồng kh&ocirc;ng chắc chắn rằng vivo X Fold2 c&oacute; thể cạnh tranh tối với c&aacute;c sản phẩm kh&aacute;c.</p>
')
INSERT [dbo].[BLOG] ([ID_DMB], [ID_SP], [ANH], [TIEU_DE], [NOI_DUNG]) VALUES (5, 28, N'iphone-14-pro-max-10.png', N'iPhone 14 Pro Max cháy hàng ngay trong ngày đầu mở bán', N'<h2><strong>iPhone 14 Pro Max ch&aacute;y h&agrave;ng ngay trong ng&agrave;y đầu mở b&aacute;n</strong></h2>

<p><em>(Cập nhật ng&agrave;y 15/10/2022)</em></p>

<p>Chỉ trong ng&agrave;y đầu mở b&aacute;n, lượng kh&aacute;ch h&agrave;ng đặt mua iPhone 14 Pro Max tăng đột biến. Trong đ&oacute;, phi&ecirc;n bản iPhone 14 Pro Max bản 128GB chỉ trong thời gian ngắn nhanh ch&oacute;ng hết h&agrave;ng, chỉ c&ograve;n lại c&aacute;c bản 256GB, 512GB v&agrave; 1TB. Nhiều kh&aacute;ch h&agrave;ng đăng k&yacute; sau phải chờ đến đợt giao h&agrave;ng tiếp theo. Dự kiến tại Việt Nam sẽ xảy ra t&igrave;nh trạng khan hiếm h&agrave;ng trong tuần đầu trả h&agrave;ng. Tại CellphoneS, bạn ho&agrave;n to&agrave;n c&oacute; thể nhận được ưu đ&atilde;i cực khủng khi tham gia chương tr&igrave;nh thu cũ đổi mới v&agrave; nhận ho&agrave;n tiền từ c&aacute;c đối t&aacute;c li&ecirc;n kết.</p>

<p><img alt="iPhone 14 Pro Max" src="https://cdn2.cellphones.com.vn/x,webp,q100/media/wysiwyg/Phone/Apple/iphone-14/iphone-14-pro-max-10.jpg" /></p>

<h2><strong>iPhone 14 Pro Max l&agrave; smartphone c&oacute; m&agrave;n h&igrave;nh tốt nhất</strong></h2>

<p><em>(Cập nhật ng&agrave;y 26/9/2022)</em></p>

<p>Theo nguồn th&ocirc;ng tin đ&aacute;ng tin cậy, iPhone 14 Pro Max sở hữu m&agrave;n h&igrave;nh được chấm điểm l&ecirc;n đến 149. Đ&acirc;y l&agrave; điểm số cao nhất ở ph&acirc;n kh&uacute;c sản phẩm cao cấp v&agrave; l&agrave; điểm số tốt tr&ecirc;n thị trường. Chất lượng hiển thị được đ&aacute;nh gi&aacute; cao, đặc biệt l&agrave; khi sử dụng ở ngo&agrave;i trời với độ s&aacute;ng tối đa 2000 nit. Đồng thời, nhờ tần số qu&eacute;t cao m&agrave; m&agrave;n h&igrave;nh cũng th&iacute;ch hợp để chơi game, xem phim, hoặc xem video HD.</p>

<p><img alt="Đánh giá iPhone 14 Pro Max " src="https://cdn2.cellphones.com.vn/x,webp,q100/media/wysiwyg/Phone/Apple/iphone-14/iphone-14-pro-max-3.jpg" /></p>

<p>Th&ecirc;m v&agrave;o đ&oacute;, về mặt &acirc;m thanh DxOMark c&ograve;n đ&aacute;nh gi&aacute; si&ecirc;u phẩm đến từ nh&agrave; Apple th&iacute;ch hợp để nghe nhạc kịch, ho&agrave; tấu, kịch n&oacute;i, xem phim v&agrave; chơi game. Trong c&aacute;c danh s&aacute;ch sản phẩm c&oacute; chất lượng &acirc;m thanh tốt, iPhone 14 Pro Max xếp hạng nằm ở vị tr&iacute; thứ 9 với 142 điểm.</p>

<h2><strong>Đ&aacute;nh gi&aacute; iPhone 14 Pro Max - Si&ecirc;u ph&acirc;̉m khẳng định đẳng c&acirc;́p</strong></h2>

<p>Những chiếc&nbsp;<a href="https://cellphones.com.vn/mobile/apple/iphone-14.html">điện thoại iPhone 14 2022</a>&nbsp;được gọi t&ecirc;n trong h&agrave;ng ngũ si&ecirc;u phẩm smartphone thế hệ mới bởi c&ocirc;ng nghệ h&agrave;ng đầu, thiết kế ho&agrave;n hảo c&ugrave;ng nhiều đột ph&aacute; đ&aacute;ng kinh ngạc. Độ ho&agrave;n hảo của thế hệ Flagship mới nhất của Apple được tạo th&agrave;nh từ sự thống nhất giữa c&aacute;c yếu tố thiết kế, m&agrave;n h&igrave;nh, cấu h&igrave;nh, hệ điều h&agrave;nh, camera, pin v&agrave; c&aacute;c t&iacute;nh năng cải tiến.</p>

<h3>M&agrave;n h&igrave;nh Dynamic Island - Sự biến mất của m&agrave;n h&igrave;nh tai thỏ thay thế bằng thiết kế vi&ecirc;n thuốc</h3>

<p>Sau nhiều thế hệ li&ecirc;n tiếp giữ thiết kế tai thỏ, cuối c&ugrave;ng Apple đ&atilde; c&oacute; đột ph&aacute; trong thiết kế để chiều l&ograve;ng người h&acirc;m mộ. Theo đ&oacute;, ở mặt trước của những chiếc iPhone 14 Pro Max nơi c&oacute; chiếc tai thỏ quen thuộc n&agrave;y đ&atilde; được thay thế bằng thiết kế vi&ecirc;n thuốc độc đ&aacute;o. Vi&ecirc;n thuốc tr&ecirc;n m&agrave;n h&igrave;nh iPhone 14 Pro Max l&agrave; nơi chứa camera face ID v&agrave; camera trước.</p>

<p><img alt="Đánh giá màn hình iPhone 14 Pro Max" src="https://cdn2.cellphones.com.vn/x,webp,q100/media/wysiwyg/Phone/Apple/iphone-14/iphone-14-pro-max-10.jpg" /></p>

<p>Thiết kế m&agrave;n h&igrave;nh Dynamic Island mới n&agrave;y sẽ đưa c&aacute;c th&ocirc;ng b&aacute;o v&agrave;o trong thiết kế vi&ecirc;n thuốc để c&aacute;c hoạt động tr&ecirc;n m&agrave;n h&igrave;nh diễn ra liền mạch. Cụ thể c&aacute;c th&ocirc;ng b&aacute;o cuộc gọi, nghẹ sẽ được th&iacute;ch hợp v&agrave;o trong thiết kế mới n&agrave;y v&agrave; người d&ugrave;ng c&oacute; thể thực hiện c&aacute;c thao t&aacute;c chạm vuốt mở rộng, trở về trang chủ khi cần thiết.</p>

<p>Cảm biến tiện cậm được Apple thiết kế lại v&agrave; di chuyển ra ph&iacute;a sau m&agrave;n h&igrave;nh nhờ đ&oacute; mang lại kh&ocirc;ng gian hiển thị rộng hơn. Camera TrueDepth cũng được thiết kế nhỏ hơn tới 31% so với thế hệ tiền nhiệm.</p>

<h3><strong>M&agrave;n h&igrave;nh&nbsp;Dynamic Island&nbsp;OLED 6,7 inch, hỗ trợ always-on display</strong></h3>

<p>Sự th&agrave;nh c&ocirc;ng của thiết kế m&agrave;n h&igrave;nh đến từ những chiếc điện thoại iPhone 13 pro m&atilde; l&agrave; điểm nhấn khiến sự ch&uacute; &yacute; dồn v&agrave;o những chiếc điện thoại thế hệ mới của Apple. Những &ldquo;quả t&aacute;o ch&iacute;n&rdquo; lần n&agrave;y đến từ c&ocirc;ng ty c&ocirc;ng nghệ h&agrave;ng đầu thế giới c&oacute; k&iacute;ch thước 6,7 inch v&agrave; được trang bị tấm nền OLED M12 cực sắc n&eacute;t. Đặc biệt, Apple c&ograve;n trang bị cho m&agrave;n h&igrave;nh iPhone 14 Pro Max t&iacute;nh năng tự động giảm s&aacute;ng khi thiết bị được đ&uacute;t trong t&uacute;i hoặc &uacute;p xuống mặt b&agrave;n để tiết kiệm pin.</p>

<p>Độ ph&acirc;n giải được ghi nhận của những chiếc điện thoại n&agrave;y đạt mức 2796 ‑ x 1290 pixel sẵn s&agrave;ng cho ra những khung h&igrave;nh chất lượng đến từng micro micrometer. Tần số qu&eacute;t 120Hz ấn tượng vẫn được giữ nguy&ecirc;n tr&ecirc;n tấm m&agrave;n n&agrave;y c&ugrave;ng mật độ điểm ảnh cao khiến trải nghiệm lướt, qu&eacute;t tr&ecirc;n iPhone 14 Pro Max diễn ra như một giấc mộng tuyệt vời.</p>

<p><img alt="Đánh giá màn hình iPhone 14 Pro Max" src="https://cdn2.cellphones.com.vn/x,webp,q100/media/wysiwyg/Phone/Apple/iphone-14/iphone-14-pro-max-11.jpg" /></p>

<p>G&oacute;c nh&igrave;n cũng được tối ưu hơn ở những chiếc Flagship mới nh&agrave; &ldquo;T&aacute;o Khuyết&rdquo; khi thiết kế vi&ecirc;n thuốc thay thế cho thiết kế tai thỏ. B&ecirc;n cạnh đ&oacute; l&agrave; h&agrave;ng loạt cải tiến t&iacute;nh năng m&agrave;n h&igrave;nh cực ấn tượng khiến iPhone 14 Pro Max sẵn s&agrave;ng c&agrave;n qu&eacute;t tr&ecirc;n mọi mặt trận.</p>

<p>M&agrave;n h&igrave;nh được trang bị độ tương phản cao (2.000.000: 1) c&ugrave;ng độ s&aacute;ng tối đa l&ecirc;n đến 2000 nits gi&uacute;p hiển thị r&otilde; n&eacute;t trong mọi điều kiện &aacute;nh s&aacute;ng, kể cả dưới trời nắng. Apple cũng trang bị cho m&agrave;n h&igrave;nh lớp phủ oleophobic gi&uacute;p chống b&aacute;m v&acirc;n tay hiệu quả.</p>

<p>iPhone 14 Pro Max sẽ được trang bị m&agrave;n h&igrave;nh&nbsp;always-on display nhờ đ&oacute; người d&ugrave;ng c&oacute; thể xem nhanh c&aacute;c th&ocirc;ng b&aacute;o, lời nhắc hay thời tiết m&agrave; kh&ocirc;ng cần mở kh&oacute;a m&agrave;n h&igrave;nh.</p>

<h3>Cấu h&igrave;nh iPhone 14 Pro Max mạnh mẽ, hiệu năng cực khủng từ chipset A16 Bionic</h3>

<p>Chưa bao giờ Apple đặt ra giới hạn cho bản th&acirc;n ở hiệu năng cho những thiết kế của m&igrave;nh. Ch&iacute;nh bởi vậy n&ecirc;n những con chip A16 Bionic được trang bị cho iPhone 14 Pro Max l&agrave; điều kh&ocirc;ng c&oacute; g&igrave; đ&aacute;ng ngạc nhi&ecirc;n. Dẫu vậy con chip n&agrave;y vẫn nhận được rất nhiều sự kỳ vọng về những t&iacute;nh năng cải tiến.</p>

<p>Con chip Apple A16 Bionic với gần 6 tỷ b&oacute;ng b&aacute;n dẫn cũng CPU 6 nh&acirc;n mang lại khả năng xử l&yacute; c&aacute;c t&aacute;c vụ hiệu quả. C&ugrave;ng với đ&oacute; l&agrave; GPU 5 nh&acirc;n gi&uacute;p tăng th&ecirc;m 50% băng th&ocirc;ng bộ nhớ mang lại khả năng xử l&yacute; c&aacute;c game đồ họa phức tạp. Con chip A16 Bionic cũng hỗ trợ tiết kiệm điện năng một c&aacute;ch hiệu quả c&ugrave;ng khả năng bảo mật dữ liệu n&acirc;ng cao với Secure Enclave.</p>

<p><img alt="Cấu hình iPhone 14 Pro Max mạnh mẽ, hiệu năng cực khủng từ chipset A16 Bionic" src="https://cdn2.cellphones.com.vn/x,webp,q100/media/wysiwyg/Phone/Apple/iphone-14/iphone-14-pro-max-2.jpg" /></p>

<p>Theo đo lường Antutu mức điểm đạt được của iPhone 14 Pro Max l&agrave; 896.000, GPU tăng l&ecirc;n đến 35%, trong khi CPU cũng đạt mức tăng 42%. Số điểm l&yacute; tưởng n&agrave;y gi&uacute;p những chiếc flagship đến từ Apple nhận được đ&aacute;nh gi&aacute; t&iacute;ch cực từ giới game thủ. Nhiều bằng chứng cho thấy rằng những chiếc smartphone n&agrave;y sẽ trở th&agrave;nh 1 trong những chiếc điện thoại chơi game cực đẳng cấp. Đặc biệt l&agrave; khi iPhone 14 Pro Max kh&ocirc;ng chỉ sở hữu cấu h&igrave;nh khủng m&agrave; c&ograve;n c&oacute; m&agrave;n h&igrave;nh xuất sắc để chơi mọi tựa game đồ họa khủng.</p>

<p>&gt;&gt;&gt; B&ecirc;n cạnh đ&oacute; c&oacute; thể tham khảo th&ecirc;m&nbsp;<a href="https://cellphones.com.vn/iphone-14.html">gi&aacute; iPhone 14</a>&nbsp;ngay nh&eacute;!!!</p>

<h3>Hệ điều h&agrave;nh iOS 16 bứt ph&aacute; c&ocirc;ng nghệ</h3>

<p>Ngay từ khi ra mắt trong sự kiện c&ocirc;ng nghệ WWDC 2022 hệ điều h&agrave;nh iOS 16 đ&atilde; được giới thiệu c&ugrave;ng với những cải tiến cực lớn mang đậm bản sắc c&aacute; nh&acirc;n h&oacute;a cho người sử dụng. Bởi vậy n&ecirc;n khi được trang bị hệ điều h&agrave;nh n&agrave;y, những chiếc điện thoại iPhone 14 Pro Max sẽ mang đến những trải nghiệm cực tối ưu với mỗi người d&ugrave;ng.</p>

<p><img alt="Đánh giá hệ điều hành iOS 16" src="https://cdn2.cellphones.com.vn/x,webp,q100/media/wysiwyg/Phone/Apple/iPhone-14-pro-max-1.jpg" /></p>

<p>Theo đ&oacute; những chiếc điện thoại n&agrave;y sẽ được bổ sung nhiều t&ugrave;y biến với m&agrave;n h&igrave;nh kh&oacute;a với đa dạng c&aacute;c font chữ (l&ecirc;n đến 12 font kh&aacute;c nhau) để người d&ugrave;ng tự tin thể hiện c&aacute; t&iacute;nh hơn. Widget ứng dụng cũng được thay đổi đ&ocirc;i ch&uacute;t đặc biệt ở h&igrave;nh nền tr&aacute;i đất. Lịch sẽ được tạm kh&oacute;a c&aacute;c sự kiện để bảo mật th&ocirc;ng tin của người d&ugrave;ng.</p>

<p>B&ecirc;n cạnh đ&oacute; những chiếc iPhone 14 Pro Max c&ograve;n được bổ sung th&ecirc;m c&aacute;c t&iacute;nh năng th&ocirc;ng minh như t&ugrave;y chỉnh m&agrave;n h&igrave;nh kh&oacute;a.</p>

<h3>Camera sau 48MP, cảm biến TOF sống động</h3>

<p>Khả năng chụp ảnh của những chiếc điện thoại iPhone lu&ocirc;n l&agrave; niềm tự h&agrave;o của Apple. Bước sang thế hệ flagship n&agrave;y Apple đ&atilde; c&oacute; một bước nhảy vọt cực lớn trong cảm biến của m&aacute;y ảnh ch&iacute;nh. Từ cảm biến 12MP ở những chiếc iPhone 13 Pro Max, những chiếc điện thoại thế hệ mới n&agrave;y được trang bị camera cảm biến ch&iacute;nh l&agrave; 48MP.</p>

<p>Cụ thể, thế hệ iPhone 14 Pro Max sẽ sở hữu camera ch&iacute;nh 48MP với thấu k&iacute;nh bảy th&agrave;nh phần c&ugrave;ng ti&ecirc;u cự 24mm, hỗ trợ ổn định h&igrave;nh ảnh quang học. Camera g&oacute;c si&ecirc;u rộng 13MP với ti&ecirc;u cự 13 mm, thấu k&iacute;nh 6 th&agrave;nh phần, hỗ trợ g&oacute;c chụp l&ecirc;n đến 120 độ. Cuối c&ugrave;ng l&agrave; camera tele 2x 12MP với ti&ecirc;u cự 48mm.</p>

<p><img alt="Đánh giá camera iPhone 14 Pro Max" src="https://cdn2.cellphones.com.vn/x,webp,q100/media/wysiwyg/Phone/Apple/iphone-14/iphone-14-pro-max-4.jpg" /></p>

<p>Với sự cải tiến lớn ở độ ph&acirc;n giải những chiếc điện thoại iPhone 14 Pro Max đ&aacute;p ứng tối đa nhu cầu quay video 4K cũng như ho&agrave;n thiện hơn khả năng chụp ảnh. Kh&ocirc;ng chỉ c&oacute; cho m&igrave;nh camera ch&iacute;nh ưu việt hơn, hệ thống camera bổ trợ cũng phần n&agrave;o khiến bức ảnh được ghi lại th&ecirc;m phần sống động v&agrave; sắc n&eacute;t.</p>

<p>Ngo&agrave;i th&ocirc;ng số ấn tượng, camera sau của iPhone 14 Pro Max c&ograve;n được trang bị c&ocirc;ng nghệ cảm biến TOF đem đến những bức ảnh c&oacute; g&oacute;c si&ecirc;u rộng v&agrave; độ s&acirc;u ấn tượng. Khả năng zoom quang học 3x ấn tượng vẫn được duy tr&igrave; để mang đến những bức h&igrave;nh n&eacute;t từ khoảng c&aacute;ch xa.</p>

<h3>Camera selfie g&oacute;c rộng lưu giữ nhiều khoảnh khắc đ&aacute;ng nhớ</h3>

<p>Với sự thay đổi từ thiết kế tai thỏ sang vi&ecirc;n thuốc, sự cải tiến trong c&ocirc;ng nghệ của camera selfie của iPhone 14 Pro Max l&agrave; điều được chờ đ&oacute;n bậc nhất trong lần trở lại n&agrave;y của Apple. Theo đ&oacute; những chiếc camera trước của những chiếc Flagship nh&agrave; t&aacute;o c&oacute; độ cảm biến l&ecirc;n đến 12MP c&ugrave;ng g&oacute;c rộng&nbsp; &fnof; / 1.9.</p>

<p>Những chiếc camera selfie thế hệ mới của Apple sẽ c&oacute; sự cải tiến vượt bậc v&agrave; vượt trội nhất trong v&agrave;i năm trở lại đ&acirc;y. Theo đ&oacute; ch&uacute;ng sẽ được trang bị t&iacute;nh năng tự động lấy n&eacute;t để hiệu quả hơn trong c&ocirc;ng cuộc ghi lại những khoảnh khắc đ&aacute;ng nhớ. Đồng thời ống k&iacute;nh n&agrave;y gồm 6 th&agrave;nh phần với khẩu độ lớn hơn hứa hẹn mang đến những khung h&igrave;nh nghệ thuật hơn.</p>

<p><img alt="Đánh giá camera trước iPhone 14 Pro Max " src="https://cdn2.cellphones.com.vn/x,webp,q100/media/wysiwyg/Phone/Apple/iphone-14/iphone-14-pro-max-5.jpg" /></p>

<p>C&ugrave;ng với đ&oacute;, iPhone 14 Pro Max cũng được trang bị nhiều chế độ chụp ảnh th&ocirc;ng minh tr&ecirc;n camera trước n&agrave;y như Animoji v&agrave; Memoji, chế độ Apple ProRAW, chụp đ&ecirc;m, chụp phong cảnh, chụp ch&acirc;n dung với bokeh n&acirc;ng cao,...</p>

<h3><strong>Pin liền lithium-ion kết hợp c&ugrave;ng c&ocirc;ng nghệ sạc nhanh cải tiến</strong></h3>

<p>Dung lượng pin chưa bao giờ l&agrave; thế mạnh của những chiếc điện thoại đến từ Apple nhưng hiệu năng sử dụng năng lượng của iPhone lại l&agrave; điều m&agrave; bất cứ chiếc smartphone n&agrave;o cũng đều muốn sở hữu. Để so s&aacute;nh về dung lượng Pin, những chiếc điện thoại iPhone 14 Pro Max sẽ được trang bị vi&ecirc;n pin 4.352 mAh cho thời gian sử dụng đ&aacute;ng kinh ngạc.</p>

<p><img alt="Đánh giá dung lượng pin điện thoại iPhone 14 Pro Max" src="https://cdn2.cellphones.com.vn/x,webp,q100/media/wysiwyg/Phone/Apple/iphone-14/iphone-14-pro-max-9.jpg" /></p>

<p>Cụ thể, theo nh&agrave; sản xuất c&ocirc;ng bố, điện thoại cho thời gian ph&aacute;t lại video l&ecirc;n đến 29 giờ hoặc 95 giờ ph&aacute;t &acirc;m thanh.</p>

<p>Để n&acirc;ng cao hiệu quả sử dụng, Apple đ&atilde; trang bị cho iPhone 14 Pro Max c&ocirc;ng nghệ sạc nhanh c&ocirc;ng suất 20W (Củ sạc được b&aacute;n ri&ecirc;ng). Nhờ đ&oacute; người d&ugrave;ng c&oacute; thể bổ sung 50% dung lượng pin chỉ trong v&ograve;ng 30 ph&uacute;t. Ngo&agrave;i ra, thiết bị c&ograve;n hỗ trợ sạc&nbsp;nhanh kh&ocirc;ng d&acirc;y MagSafe l&ecirc;n đến 15W v&agrave; sạc kh&ocirc;ng d&acirc;y Qi với c&ocirc;ng suất l&ecirc;n đến 7,5W.</p>

<p>Kh&ocirc;ng giống như nhiều đồn đo&aacute;n loại bỏ ho&agrave;n to&agrave;n cổng sạc hay chuyển sang cổng sạc USB-C, iPhone 14 Pro Max vẫn sẽ sử dụng cổng sạc lightning quen thuộc.</p>

<h3>iPhone 14 Pro Max đa dạng t&iacute;nh năng cải tiến: Face ID, chống nước&hellip;</h3>

<p>B&ecirc;n cạnh những cải tiến mang tầm dấu mốc kể tr&ecirc;n th&igrave; những cải tiến trong t&iacute;nh năng cũng l&agrave; điều dễ d&agrave;ng nhận thấy ở những chiếc điện thoại nh&agrave; T&aacute;o. iPhone 14 Pro Max vẫn được trang bị Face ID được đặt trong phần vi&ecirc;n thuốc ở mặt trước. Đồng thời t&iacute;nh năng n&agrave;y ở những chiếc flagship được n&acirc;ng cấp l&ecirc;n với khả năng nhận diện khu&ocirc;n mặt đa chiều hơn c&oacute; thể nhận diện ngay cả khi sử dụng khẩu trang.</p>

<p>iPhone 14 Pro Max cũng được n&acirc;ng cấp ở c&ocirc;ng nghệ chống bụi v&agrave; nước chuẩn IP68. Theo đ&oacute;, những chiếc điện thoại n&agrave;y sở hữu khả năng chống nước ở độ s&acirc;u khoảng 6 m&eacute;t trong khoảng thời gian khoảng 30 ph&uacute;t.</p>

<p>Một t&iacute;nh năng th&ocirc;ng minh phải kể đến tr&ecirc;n iPhone 14 Pro Max đ&oacute; l&agrave; cuộc gọi khẩn cấp qua vệ tinh. Theo đ&oacute;, khi điện thoại kh&ocirc;ng thể kết nối với c&aacute;c dịch vụ di động hoặc wifi, người d&ugrave;ng c&oacute; thể gọi SOS khẩn cấp th&ocirc;ng qua vệ tinh. Tuy nhi&ecirc;n, để t&iacute;nh năng c&oacute; thể hoạt động ổn định người sử dụng cần ở ngo&agrave;i trời với tầm nh&igrave;n tho&aacute;ng đ&atilde;ng.</p>

<p><img alt="iPhone 14 Pro Max đa dạng tính năng cải tiến: Face ID, chống nước…" src="https://cdn2.cellphones.com.vn/x,webp,q100/media/wysiwyg/Phone/Apple/iPhone-14-pro-max-2.jpg" /></p>

<p>T&iacute;nh năng m&agrave;n h&igrave;nh lu&ocirc;n mở - Always On ở những chiếc điện thoại n&agrave;y gi&uacute;p mọi th&ocirc;ng b&aacute;o được cập nhật dễ d&agrave;ng c&aacute;c th&ocirc;ng b&aacute;o, tin nhắn hay cuộc gọi m&agrave; kh&ocirc;ng cần mở m&agrave;n h&igrave;nh kh&oacute;a.</p>

<p>Khả năng theo d&otilde;i sức khỏe sẽ được cải tiến l&ecirc;n với t&iacute;nh năng lịch sử rung nhĩ với khả năng ghi lại số lần cơ thể bị rung nhĩ (nhiễu loạn nhịp đập của tim) từ đ&oacute; ph&aacute;t hiện bất thường về tim sớm hơn ngăn ngừa những nguy cơ sức khỏe nguy hiểm.</p>

<p>Tư động ph&aacute;t hiện sự cố v&agrave; k&ecirc;u gọi sự trợ gi&uacute;p cũng l&agrave; một t&iacute;nh năng đ&aacute;ng được ch&uacute; &yacute; tr&ecirc;n iPhone 14 Pro Max. Theo đ&oacute;, điện thoại sẽ ph&aacute;t hiện ra c&aacute;c vụ tai nạn nghi&ecirc;m trọng dựa theo c&aacute;c thay đổi về vận tốc, &aacute;p suất, &acirc;m thanh,...</p>

<p>Ngo&agrave;i ra, tại thị trường Mỹ, Apple cũng đ&atilde; loại bỏ ho&agrave;n to&agrave;n khay sim vật l&yacute; để sử dụng esim 100%. C&aacute;c thị trường kh&aacute;c, trong đ&oacute; c&oacute; Việt Nam vẫn sử dụng kết hợp sim vật l&yacute; v&agrave; esim.</p>
')
SET IDENTITY_INSERT [dbo].[BLOG] OFF
SET IDENTITY_INSERT [dbo].[CHI_NHANH] ON 

INSERT [dbo].[CHI_NHANH] ([ID_CN], [TEN_CHI_NHANH], [DIA_CHI], [SDT]) VALUES (1, N'An Giang', N'912-915 Trần Hưng Đạo, p. Bình Khánh, Thành phố Long Xuyên, An Giang 880000', N'1800 2097')
INSERT [dbo].[CHI_NHANH] ([ID_CN], [TEN_CHI_NHANH], [DIA_CHI], [SDT]) VALUES (2, N'Tp.Cần Thơ', N'131A-133, Đ. Cách Mạng Tháng 8, An Hoà, Ninh Kiều, Cần Thơ 94100', N'1800 2097')
INSERT [dbo].[CHI_NHANH] ([ID_CN], [TEN_CHI_NHANH], [DIA_CHI], [SDT]) VALUES (3, N'Tp.HCM', N'159 Đ. Nguyễn Thị Minh Khai, P. Phú Thuận, Quận 1, Thành phố Hồ Chí Minh 700000', N'1800 2097')
INSERT [dbo].[CHI_NHANH] ([ID_CN], [TEN_CHI_NHANH], [DIA_CHI], [SDT]) VALUES (4, N'Tp.Hà Nội', N'160 Nguyễn Khánh Toàn, P, Cầu Giấy, Hà Nội 100000', N'1800 2097')
INSERT [dbo].[CHI_NHANH] ([ID_CN], [TEN_CHI_NHANH], [DIA_CHI], [SDT]) VALUES (5, N'Tp.Đà Nẵng', N'131A-133, Đ. Cách Mạng Tháng 8, An Hoà, Ninh Kiều, Cần Thơ 94100', N'1800 2097')
SET IDENTITY_INSERT [dbo].[CHI_NHANH] OFF
SET IDENTITY_INSERT [dbo].[CHI_TIET_HOA_DON] ON 

INSERT [dbo].[CHI_TIET_HOA_DON] ([ID_CTHD], [ID_SP], [ID_KH], [ID_CN], [ID_ACC], [ID_HD], [SO_LUONG], [TONG_TIEN], [TRANG_THAI]) VALUES (1, 28, 1, 1, 2, 1, 2, 25690000, N'true')
INSERT [dbo].[CHI_TIET_HOA_DON] ([ID_CTHD], [ID_SP], [ID_KH], [ID_CN], [ID_ACC], [ID_HD], [SO_LUONG], [TONG_TIEN], [TRANG_THAI]) VALUES (2, 3, 1, 1, 2, 2, 2, 25690000, N'true')
INSERT [dbo].[CHI_TIET_HOA_DON] ([ID_CTHD], [ID_SP], [ID_KH], [ID_CN], [ID_ACC], [ID_HD], [SO_LUONG], [TONG_TIEN], [TRANG_THAI]) VALUES (3, 3, 1, 1, 2, 3, 2, 25690000, N'true')
INSERT [dbo].[CHI_TIET_HOA_DON] ([ID_CTHD], [ID_SP], [ID_KH], [ID_CN], [ID_ACC], [ID_HD], [SO_LUONG], [TONG_TIEN], [TRANG_THAI]) VALUES (4, 28, 1, 1, 2, 4, 2, 25690000, N'true')
INSERT [dbo].[CHI_TIET_HOA_DON] ([ID_CTHD], [ID_SP], [ID_KH], [ID_CN], [ID_ACC], [ID_HD], [SO_LUONG], [TONG_TIEN], [TRANG_THAI]) VALUES (6, 1, 1, 1, 4, 4, 1, 25690000, N'true')
INSERT [dbo].[CHI_TIET_HOA_DON] ([ID_CTHD], [ID_SP], [ID_KH], [ID_CN], [ID_ACC], [ID_HD], [SO_LUONG], [TONG_TIEN], [TRANG_THAI]) VALUES (7, 28, NULL, 1, 2, NULL, 1, NULL, NULL)
INSERT [dbo].[CHI_TIET_HOA_DON] ([ID_CTHD], [ID_SP], [ID_KH], [ID_CN], [ID_ACC], [ID_HD], [SO_LUONG], [TONG_TIEN], [TRANG_THAI]) VALUES (8, 2, NULL, 1, 2, NULL, 1, NULL, NULL)
INSERT [dbo].[CHI_TIET_HOA_DON] ([ID_CTHD], [ID_SP], [ID_KH], [ID_CN], [ID_ACC], [ID_HD], [SO_LUONG], [TONG_TIEN], [TRANG_THAI]) VALUES (9, 46, NULL, 1, 2, NULL, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[CHI_TIET_HOA_DON] OFF
SET IDENTITY_INSERT [dbo].[DANH GIA] ON 

INSERT [dbo].[DANH GIA] ([ID_DG], [ID_SP], [DIEM], [NOI_DUNG], [KIEM_TRA], [ID_ACC]) VALUES (1, 28, 5, N'HELLO', N'true', 2)
INSERT [dbo].[DANH GIA] ([ID_DG], [ID_SP], [DIEM], [NOI_DUNG], [KIEM_TRA], [ID_ACC]) VALUES (2, 28, 5, N'HOW ARE YOU', NULL, 2)
INSERT [dbo].[DANH GIA] ([ID_DG], [ID_SP], [DIEM], [NOI_DUNG], [KIEM_TRA], [ID_ACC]) VALUES (3, 29, 5, N'HELLO', N'true', 2)
INSERT [dbo].[DANH GIA] ([ID_DG], [ID_SP], [DIEM], [NOI_DUNG], [KIEM_TRA], [ID_ACC]) VALUES (4, 29, 5, N'HOW ARE YOU', NULL, 2)
INSERT [dbo].[DANH GIA] ([ID_DG], [ID_SP], [DIEM], [NOI_DUNG], [KIEM_TRA], [ID_ACC]) VALUES (5, 1, 5, N'HELLO', N'true', 3)
SET IDENTITY_INSERT [dbo].[DANH GIA] OFF
SET IDENTITY_INSERT [dbo].[HOA_DON] ON 

INSERT [dbo].[HOA_DON] ([ID_HD], [NGAY_XUAT], [TRANG_THAI_GIAO]) VALUES (1, CAST(N'2023-05-16 14:56:26.990' AS DateTime), N'Ðã giao hàng')
INSERT [dbo].[HOA_DON] ([ID_HD], [NGAY_XUAT], [TRANG_THAI_GIAO]) VALUES (2, CAST(N'2023-06-17 14:56:26.990' AS DateTime), N'Ðã giao hàng')
INSERT [dbo].[HOA_DON] ([ID_HD], [NGAY_XUAT], [TRANG_THAI_GIAO]) VALUES (3, CAST(N'2023-07-19 14:56:26.990' AS DateTime), N'Ðã giao hàng')
INSERT [dbo].[HOA_DON] ([ID_HD], [NGAY_XUAT], [TRANG_THAI_GIAO]) VALUES (4, CAST(N'2023-08-20 14:56:26.990' AS DateTime), N'Ðã giao hàng')
SET IDENTITY_INSERT [dbo].[HOA_DON] OFF
SET IDENTITY_INSERT [dbo].[KHACH_HANG] ON 

INSERT [dbo].[KHACH_HANG] ([ID_KH], [TEN_KHACH_HANG], [DIA_CHI], [SDT], [EMAIL]) VALUES (1, N'Nguyễn Gia Thiên', N'can tho', N'0772140934', N'giathien0ro000@gmail.com')
SET IDENTITY_INSERT [dbo].[KHACH_HANG] OFF
SET IDENTITY_INSERT [dbo].[SAN_PHAM] ON 

INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (1, N'Apple', N'Laptop', N'Apple Macbook Air M2 2022 8GB 256GB', NULL, 25690000, N'macbook_air_m2.png', 28690000, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (2, N'Apple', N'Laptop', N'Apple Macbook Pro 13 M2 2022 8GB 256GB', NULL, 28690000, N'pro-m2.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (3, N'Apple', N'Laptop', N'MacBook Pro 14 inch M2 Pro 2023 (10 CPU - 16 GPU - 16GB - 512GB)', NULL, 48290000, N'm2_pro_14.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (4, N'Apple', N'Laptop', N'Macbook Pro 14 inch 2021', NULL, 45990000, N'pro_2021.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (5, N'Apple', N'Laptop', N'Apple MacBook Pro 13 M2 2022 16GB 512GB', NULL, 37790000, N'mac_pro_16gb.png', 379790000, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (6, N'HP', N'Laptop', N'Laptop HP Gaming Victus 15-FA0031DX 6503849', N'I5-12450H/8GB/512GB PCIE/VGA 4GB GTX1650/15.6 FHD 144HZ/WIN11/ĐEN/Nhập khẩu chính hãng', 16790000, N'laptop-hp-gaming-victus-15-fa0031dx-6503849-6.png', 18790000, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (7, N'HP', N'Laptop', N'Laptop HP 15-DY2795WM 6M0Z7UA', N'
I5-1135G7/8GB/256GB SSD/15.6 HD/WIN10 Nhập Khẩu Chính Hãng', 12990000, N'text_ng_n_1__1_59.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (8, N'HP', N'Laptop', N'Laptop HP Pavilion X360 14-EK0134TU 7C0P8PA', N'I5-1235U/8GB/512GB PCIE/14.0 FHD/CẢM ỨNG/BÚT/WIN11/VÀNG', 18690000, N'text_ng_n_36__3.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (9, N'Dell', N'Laptop', N'Laptop Dell Inspiron 3511 5829BLK', N'I5-1135G7/8GB/256GB PCIE/15.6 FHD/CẢM ỨNG/WIN11/ĐEN/NHẬP KHẨU CHÍNH HÃNG', 13490000, N'text_ng_n_3__1_71.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (10, N'Dell', N'Laptop', N'Laptop Dell Inspiron 15 3511 JNM5H', N'
I5-1135G7/8GB/256GB PCIE/15.6 FHD/WIN11/ĐEN/NHẬP KHẨU CHÍNH HÃNG', 12990000, N'laptop-dell-inspiron-15-3511-jnm5h-8.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (11, N'Dell', N'Laptop', N'Laptop Dell Latitude 3520 70251592', N'I5-1135G7/4GB/256GB PCIE/15.6 FHD/FREE OS/ĐEN', 15990000, N'dell_latitude_3520_70251592.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (12, N'ASUS', N'Laptop', N'Laptop Asus Gaming Rog Strix G15 G513IH HN015W', N'
R7-4800H/8GB/512GB PCIE/15.6 IPS 144Hz/VGA 4GB GTX1650/WIN11/XÁM', 18590000, N'4h43.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (13, N'ASUS', N'Laptop', N'Laptop ASUS VivoBook 15X A1503ZA-L1422W', N'
I5-12500H/8GB/512GB PCIE/15.6 FHD OLED/WIN11/XANH', 17490000, N'gaming_003_5__4.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (14, N'ASUS', N'Laptop', N'Laptop Asus Zenbook 14X UM5401QA KN209W', N'
R5-5600H/8GB/512GB PCIE/14.0 2.8K OLED/CẢM ỨNG/WIN11/ĐEN', 19490000, N'2.5_1.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (15, N'Lenovo', N'Laptop', N'Laptop Lenovo Ideapad Gaming 3 15ARH7', N'R7-6800H/8GB/512GB PCIE/15.6 FHD 120HZ/VGA 4GB RTX3050/WIN11/TRẮNG', 23990000, N'1h47.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (16, N'Lenovo', N'Laptop', N'Laptop Lenovo Ideapad Gaming 3 15ARH7', NULL, 21990000, N'thi_t_k_ch_a_c_t_n_3.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (17, N'Lenovo', N'Laptop', N'Laptop Lenovo Yoga Slim 7I 14ITL5', NULL, 21990000, N'yoga-purple.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (18, N'Microsoft', N'Laptop', N'Surface Laptop Go Core i5 / 8GB / 128 GB / 12.4 inch', NULL, 15790000, N'text_ng_n_2__3.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (19, N'Microsoft', N'Laptop', N'Surface Pro 7 Core i5 / 8GB / 128GB', NULL, 19990000, N'text_ng_n_1__8.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (20, N'Microsoft', N'Laptop', N'Surface Laptop Go 12.4', NULL, 14690000, N'text_ng_n_10__2.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (21, N'Acer', N'Laptop', N'Laptop Gaming Acer Nitro 5 Eagle AN515-57-54MV NH.QENSV.003', NULL, 22990000, N'text_ng_n_7.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (22, N'Acer', N'Laptop', N'Laptop Acer Swift 3 SF314-43-R4X3 NX.AB1SV.004', NULL, 18990000, N'4h00.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (23, N'Acer', N'Laptop', N'Laptop Acer Gaming Predator Helios 300 H315-53-70U6 NH.Q7YSV.002', NULL, 35090000, N'text_ng_n_6__1.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (24, N'Xiaomi', N'Laptop', N'Laptop Xiaomi RedmiBook 15 JYU4505AP', NULL, 9790000, N'text_ng_n_7__16.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (25, N'MSI', N'Laptop', N'Laptop MSI Gaming GF63 10SC 804VN', NULL, 17450000, N'9h26.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (26, N'MSI', N'Laptop', N'Laptop MSI Gaming GF63 Thin 11UD 473VN', NULL, 17890000, N'5h24.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (27, N'MSI', N'Laptop', N'Laptop MSI Modern 14 C11M-011VN', NULL, 10490000, N'text_ng_n_17__1_32.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (28, N'Apple', N'Phone', N'iPhone 14 Pro Max 128GB', NULL, 26890000, N't_m_18.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (29, N'Apple', N'Phone', N'iPhone 13 128GB', NULL, 16990000, N'14_1_9_2_9.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (30, N'Apple', N'Phone', N'iPhone 14 128GB', NULL, 19290000, N'iphone-14-storage-select-202209-6-1inch-y889.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (31, N'SamSung', N'Phone', N'Samsung Galaxy S23 Ultra 256GB', NULL, 26990000, N's23-ultra-tim.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (32, N'SamSung', N'Phone', N'Samsung Galaxy Z Flip4 128GB', NULL, 17270000, N'samsung_galaxy_z_flip_m_i_2022-1_1.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (33, N'SamSung', N'Phone', N'Samsung Galaxy A34 5G 8GB 128GB', NULL, 8490000, N'sm-a346_galaxy_a34_5g_awesome_silver_front.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (34, N'Xiaomi', N'Phone', N'Xiaomi Redmi Note 12', NULL, 4690000, N'gtt_7766_3__1.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (35, N'Xiaomi', N'Phone', N'Xiaomi Redmi Note 12 Pro 5G', NULL, 9190000, N'gtt7766.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (36, N'Xiaomi', N'Phone', N'Xiaomi Redmi Note 11 Pro Plus 5G', NULL, 8990000, N'11-pro-plus-blue.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (37, N'OPPO', N'Phone', N'OPPO Reno8 T 5G (8GB - 128GB)', NULL, 9990000, N'oppo-reno8t-vang1-thumb-600x600.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (38, N'OPPO', N'Phone', N'OPPO A77s', NULL, 6290000, N'combo_a77s-_en_2.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (39, N'OPPO', N'Phone', N'OPPO Reno7 Z (5G)', NULL, 7390000, N'combo_product_-_rainbow_spectrum_-_reno7_z.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (40, N'VIVO', N'Phone', N'vivo Y35', NULL, 6090000, N'2_282.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (41, N'VIVO', N'Phone', N'vivo V23e', NULL, 5590000, N'c91ba5bf721d5b2d4eae4f821b8e4ced.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (42, N'VIVO', N'Phone', N'vivo X80', NULL, 15990000, N'53_2_11.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (43, N'realme', N'Phone', N'realme 9 Pro', NULL, 4990000, N'real_me_pro_002.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (44, N'realme', N'Phone', N'realme 10 8GB 256GB', NULL, 6490000, N'white-7e6a0f537b.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (45, N'realme', N'Phone', N'realme C55 8GB 256GB', NULL, 5390000, N'rgrgrtyt6_1.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (46, N'Apple', N'Tablet', N'iPad 10.2 2021 WiFi 64GB', NULL, 7390000, N'x_mmas.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (47, N'Apple', N'Tablet', N'iPad Air 5 (2022) 64GB', NULL, 14390000, N'1_253_3.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (48, N'Apple', N'Tablet', N'iPad Air 10.9 2020 WiFi 64GB', NULL, 13990000, N'1_255.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (49, N'SamSung', N'Tablet', N'Samsung Galaxy Tab S8 Ultra 5G', NULL, 26990000, N'tab_s8_ultra.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (50, N'SamSung', N'Tablet', N'Samsung Galaxy Tab S8 WIFI', NULL, 13390000, N'tab_s8_2.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (51, N'SamSung', N'Tablet', N'Samsung Galaxy Tab S7 FE (4G)', NULL, 10290000, N'samsung-galaxy-tab-s7-fe-chinh-hang_1_1_2_1.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (52, N'Xiaomi', N'Tablet', N'Xiaomi Pad 5 (6GB/256GB)', NULL, 9190000, N'o1cn01ijop4f1slqk1fdzto_-2201438992231_1628774717_2.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (53, N'Xiaomi', N'Tablet', N'Xiaomi Pad 6 Pro', NULL, 1090000, N'ccvv_2.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (54, N'Lenovo', N'Tablet', N'Máy Tính Bảng Lenovo Tab M8 Gen 2 3GB 32GB (ZA630033VN)', NULL, 2190000, N'1_293_4.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (55, N'Lenovo', N'Tablet', N'Máy tính bảng Lenovo Tab P11 Plus 4GB 64GB ZA9L0163VN', NULL, 5990000, N'tab_p11_plus.png', NULL, 50)
INSERT [dbo].[SAN_PHAM] ([ID_SP], [THUONG_HIEU], [DANH_MUC], [TEN_SAN_PHAM], [THONG_TIN_TONG_QUAT], [GIA], [ANH], [GIAM_GIA], [SO_LUONG_TON]) VALUES (56, N'Lenovo', N'Tablet', N'Lenovo Yoga Tab 11', NULL, 9390000, N'lenovo-yoga-tab-11-600x600_1.png', NULL, 50)
SET IDENTITY_INSERT [dbo].[SAN_PHAM] OFF
INSERT [dbo].[THONG_TIN_CUA_HANG] ([TEN_CUA_HANG], [FB], [TIKTOK], [YOUTUBE]) VALUES (N'TechZone', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[THONG_TIN_SAN_PHAM] ON 

INSERT [dbo].[THONG_TIN_SAN_PHAM] ([ID_TTSP], [ID_SP], [XUAT_XU], [KICH_THUOC], [CONG_NGHE_MAN_HINH], [CAMERA_SAU], [CAMERA_TRUOC], [CHIP], [RAM], [BO_NHO], [PIN], [THE_SIM], [HE_DIEU_HANH], [DO_PHAN_GIAI], [TAN_SO_QUET], [GPU], [CONG], [HO_TRO_MANG], [WI_FI], [BLUETOOTH], [KICH_THUOC_MAN_HINH], [TRONG_LUONG], [CHAT_LIEU], [CAM_BIEN_VAN_TAY], [TINH_NANG_DAC_BIET], [SO_KHE_RAM], [THOI_DIEM_RA_MAT]) VALUES (1, 1, N'Trung Quốc', N'13.6 inches', N'Liquid Retina Display', N'Không công bố', N'1080p FaceTime HD camera', N'Apple M2', N'8GB', N'256GB', N'52,6 Wh', N'Không công bố', N'MacOS', N'2560 x 1664 pixels', N'Không công bố', N'10 nhân GPU, 16 nhân Neural Engine', N'2 x Thunderbolt 3 Jack tai nghe 3.5 mm MagSafe 3', N'5G', N'802.11ax Wi-Fi 6', N'V5.0', N'13.6 inches', N'1.27 kg', N'Vỏ kim loại', N'Không công bố', N'Ổ cứng SSD', N'Không công bố', CAST(N'2022-01-01' AS Date))
INSERT [dbo].[THONG_TIN_SAN_PHAM] ([ID_TTSP], [ID_SP], [XUAT_XU], [KICH_THUOC], [CONG_NGHE_MAN_HINH], [CAMERA_SAU], [CAMERA_TRUOC], [CHIP], [RAM], [BO_NHO], [PIN], [THE_SIM], [HE_DIEU_HANH], [DO_PHAN_GIAI], [TAN_SO_QUET], [GPU], [CONG], [HO_TRO_MANG], [WI_FI], [BLUETOOTH], [KICH_THUOC_MAN_HINH], [TRONG_LUONG], [CHAT_LIEU], [CAM_BIEN_VAN_TAY], [TINH_NANG_DAC_BIET], [SO_KHE_RAM], [THOI_DIEM_RA_MAT]) VALUES (2, 2, N'Trung Quốc', N'13 inches', N'Không công bố', N'Không công bố', N'720p FaceTime HD', N'Apple M2 tám nhân CPU', N'8GB', N'256GB SSD', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'5G', N'Không công bố', N'V5.0', N'Không công bố', N'1.27 kg', N'Vỏ kim loại', N'Không công bố', N'Ổ cứng SSD', N'Không công bố', CAST(N'2022-01-01' AS Date))
INSERT [dbo].[THONG_TIN_SAN_PHAM] ([ID_TTSP], [ID_SP], [XUAT_XU], [KICH_THUOC], [CONG_NGHE_MAN_HINH], [CAMERA_SAU], [CAMERA_TRUOC], [CHIP], [RAM], [BO_NHO], [PIN], [THE_SIM], [HE_DIEU_HANH], [DO_PHAN_GIAI], [TAN_SO_QUET], [GPU], [CONG], [HO_TRO_MANG], [WI_FI], [BLUETOOTH], [KICH_THUOC_MAN_HINH], [TRONG_LUONG], [CHAT_LIEU], [CAM_BIEN_VAN_TAY], [TINH_NANG_DAC_BIET], [SO_KHE_RAM], [THOI_DIEM_RA_MAT]) VALUES (3, 3, N'Trung Quốc', N'14.2 inches', N'Liquid Retina, Mini LED, XDR', N'Không công bố', N'1080p Camera', N'Apple M2 Pro chip', N'16GB', N'512GB SSD', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'120Hz', N'Không công bố', N'Không công bố', N'5G', N'Không công bố', N'V5.0', N'Không công bố', N'1.27 kg', N'Vỏ kim loại', N'Không công bố', N'Ổ cứng SSD', N'Không công bố', CAST(N'2022-01-01' AS Date))
INSERT [dbo].[THONG_TIN_SAN_PHAM] ([ID_TTSP], [ID_SP], [XUAT_XU], [KICH_THUOC], [CONG_NGHE_MAN_HINH], [CAMERA_SAU], [CAMERA_TRUOC], [CHIP], [RAM], [BO_NHO], [PIN], [THE_SIM], [HE_DIEU_HANH], [DO_PHAN_GIAI], [TAN_SO_QUET], [GPU], [CONG], [HO_TRO_MANG], [WI_FI], [BLUETOOTH], [KICH_THUOC_MAN_HINH], [TRONG_LUONG], [CHAT_LIEU], [CAM_BIEN_VAN_TAY], [TINH_NANG_DAC_BIET], [SO_KHE_RAM], [THOI_DIEM_RA_MAT]) VALUES (4, 4, N'Trung Quốc', N'14.2 inches', N'Liquid Retina, Mini LED, XDR', N'Không công bố', N'1080p Camera, FaceTime', N'M1 Pro/M1 Max', N'16GB', N'512GB SSD', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'120Hz', N'Không công bố', N'Không công bố', N'5G', N'Không công bố', N'V5.0', N'Không công bố', N'1.27 kg', N'Vỏ kim loại', N'Không công bố', N'Ổ cứng SSD', N'Không công bố', CAST(N'2022-01-01' AS Date))
INSERT [dbo].[THONG_TIN_SAN_PHAM] ([ID_TTSP], [ID_SP], [XUAT_XU], [KICH_THUOC], [CONG_NGHE_MAN_HINH], [CAMERA_SAU], [CAMERA_TRUOC], [CHIP], [RAM], [BO_NHO], [PIN], [THE_SIM], [HE_DIEU_HANH], [DO_PHAN_GIAI], [TAN_SO_QUET], [GPU], [CONG], [HO_TRO_MANG], [WI_FI], [BLUETOOTH], [KICH_THUOC_MAN_HINH], [TRONG_LUONG], [CHAT_LIEU], [CAM_BIEN_VAN_TAY], [TINH_NANG_DAC_BIET], [SO_KHE_RAM], [THOI_DIEM_RA_MAT]) VALUES (5, 5, N'Trung Quốc', N'13 inches', N'Không công bố', N'Không công bố', N'720p FaceTime HD', N'Apple M2 tám nhân CPU', N'16GB', N'512GB SSD', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'5G', N'Không công bố', N'V5.0', N'Không công bố', N'1.27 kg', N'Vỏ kim loại', N'Không công bố', N'Ổ cứng SSD', N'Không công bố', CAST(N'2022-01-01' AS Date))
INSERT [dbo].[THONG_TIN_SAN_PHAM] ([ID_TTSP], [ID_SP], [XUAT_XU], [KICH_THUOC], [CONG_NGHE_MAN_HINH], [CAMERA_SAU], [CAMERA_TRUOC], [CHIP], [RAM], [BO_NHO], [PIN], [THE_SIM], [HE_DIEU_HANH], [DO_PHAN_GIAI], [TAN_SO_QUET], [GPU], [CONG], [HO_TRO_MANG], [WI_FI], [BLUETOOTH], [KICH_THUOC_MAN_HINH], [TRONG_LUONG], [CHAT_LIEU], [CAM_BIEN_VAN_TAY], [TINH_NANG_DAC_BIET], [SO_KHE_RAM], [THOI_DIEM_RA_MAT]) VALUES (6, 28, N'Trung Quốc', N'6.7 inches', N'Super Retina XDR OLED', N'48 MP', N'12 MP', N'Apple A16 Bionic 6-core', N'6 GB', N'128 GB', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'5G', N'Không công bố', N'V5.0', N'Không công bố', N'1.27 kg', N'Vỏ kim loại', N'Không công bố', N'Ổ cứng SSD', N'Không công bố', CAST(N'2022-01-01' AS Date))
INSERT [dbo].[THONG_TIN_SAN_PHAM] ([ID_TTSP], [ID_SP], [XUAT_XU], [KICH_THUOC], [CONG_NGHE_MAN_HINH], [CAMERA_SAU], [CAMERA_TRUOC], [CHIP], [RAM], [BO_NHO], [PIN], [THE_SIM], [HE_DIEU_HANH], [DO_PHAN_GIAI], [TAN_SO_QUET], [GPU], [CONG], [HO_TRO_MANG], [WI_FI], [BLUETOOTH], [KICH_THUOC_MAN_HINH], [TRONG_LUONG], [CHAT_LIEU], [CAM_BIEN_VAN_TAY], [TINH_NANG_DAC_BIET], [SO_KHE_RAM], [THOI_DIEM_RA_MAT]) VALUES (7, 29, N'Trung Quốc', N'6.1 inches', N'Super Retina XDR OLED', N'12MP', N'12MP', N'Apple A15', N'4 GB', N'128 GB', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'5G', N'Không công bố', N'V5.0', N'Không công bố', N'1.27 kg', N'Vỏ kim loại', N'Không công bố', N'Ổ cứng SSD', N'Không công bố', CAST(N'2022-01-01' AS Date))
INSERT [dbo].[THONG_TIN_SAN_PHAM] ([ID_TTSP], [ID_SP], [XUAT_XU], [KICH_THUOC], [CONG_NGHE_MAN_HINH], [CAMERA_SAU], [CAMERA_TRUOC], [CHIP], [RAM], [BO_NHO], [PIN], [THE_SIM], [HE_DIEU_HANH], [DO_PHAN_GIAI], [TAN_SO_QUET], [GPU], [CONG], [HO_TRO_MANG], [WI_FI], [BLUETOOTH], [KICH_THUOC_MAN_HINH], [TRONG_LUONG], [CHAT_LIEU], [CAM_BIEN_VAN_TAY], [TINH_NANG_DAC_BIET], [SO_KHE_RAM], [THOI_DIEM_RA_MAT]) VALUES (8, 30, N'Trung Quốc', N'6.1 inches', N'OLED', N'12MP', N'12MP', N'Apple A15 Bionic 6 nhân', N'6 GB', N'128 GB', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'5G', N'Không công bố', N'V5.0', N'Không công bố', N'1.27 kg', N'Vỏ kim loại', N'Không công bố', N'Ổ cứng SSD', N'Không công bố', CAST(N'2022-01-01' AS Date))
INSERT [dbo].[THONG_TIN_SAN_PHAM] ([ID_TTSP], [ID_SP], [XUAT_XU], [KICH_THUOC], [CONG_NGHE_MAN_HINH], [CAMERA_SAU], [CAMERA_TRUOC], [CHIP], [RAM], [BO_NHO], [PIN], [THE_SIM], [HE_DIEU_HANH], [DO_PHAN_GIAI], [TAN_SO_QUET], [GPU], [CONG], [HO_TRO_MANG], [WI_FI], [BLUETOOTH], [KICH_THUOC_MAN_HINH], [TRONG_LUONG], [CHAT_LIEU], [CAM_BIEN_VAN_TAY], [TINH_NANG_DAC_BIET], [SO_KHE_RAM], [THOI_DIEM_RA_MAT]) VALUES (9, 46, N'Trung Quốc', N'10.2 inches', N'Liquid Retina', N'8MP', N'12MP', N'A13 Bionic', N'4 GB', N'64 GB', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'5G', N'Không công bố', N'V5.0', N'Không công bố', N'1.27 kg', N'Vỏ kim loại', N'Không công bố', N'Ổ cứng SSD', N'Không công bố', CAST(N'2022-01-01' AS Date))
INSERT [dbo].[THONG_TIN_SAN_PHAM] ([ID_TTSP], [ID_SP], [XUAT_XU], [KICH_THUOC], [CONG_NGHE_MAN_HINH], [CAMERA_SAU], [CAMERA_TRUOC], [CHIP], [RAM], [BO_NHO], [PIN], [THE_SIM], [HE_DIEU_HANH], [DO_PHAN_GIAI], [TAN_SO_QUET], [GPU], [CONG], [HO_TRO_MANG], [WI_FI], [BLUETOOTH], [KICH_THUOC_MAN_HINH], [TRONG_LUONG], [CHAT_LIEU], [CAM_BIEN_VAN_TAY], [TINH_NANG_DAC_BIET], [SO_KHE_RAM], [THOI_DIEM_RA_MAT]) VALUES (10, 47, N'Trung Quốc', N'10.9 inches', N'Liquid Retina', N'12MP', N'12MP', N'Chip M1', N'8 GB', N'64 GB', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'5G', N'Không công bố', N'V5.0', N'Không công bố', N'1.27 kg', N'Vỏ kim loại', N'Không công bố', N'Ổ cứng SSD', N'Không công bố', CAST(N'2022-01-01' AS Date))
INSERT [dbo].[THONG_TIN_SAN_PHAM] ([ID_TTSP], [ID_SP], [XUAT_XU], [KICH_THUOC], [CONG_NGHE_MAN_HINH], [CAMERA_SAU], [CAMERA_TRUOC], [CHIP], [RAM], [BO_NHO], [PIN], [THE_SIM], [HE_DIEU_HANH], [DO_PHAN_GIAI], [TAN_SO_QUET], [GPU], [CONG], [HO_TRO_MANG], [WI_FI], [BLUETOOTH], [KICH_THUOC_MAN_HINH], [TRONG_LUONG], [CHAT_LIEU], [CAM_BIEN_VAN_TAY], [TINH_NANG_DAC_BIET], [SO_KHE_RAM], [THOI_DIEM_RA_MAT]) VALUES (11, 48, N'Trung Quốc', N'10.9 inches', N'Liquid Retina', N'12 MP', N'7 MP', N'Apple A14 Bionic', N'4 GB', N'64 GB', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'5G', N'Không công bố', N'V5.0', N'Không công bố', N'1.27 kg', N'Vỏ kim loại', N'Không công bố', N'Ổ cứng SSD', N'Không công bố', CAST(N'2022-01-01' AS Date))
INSERT [dbo].[THONG_TIN_SAN_PHAM] ([ID_TTSP], [ID_SP], [XUAT_XU], [KICH_THUOC], [CONG_NGHE_MAN_HINH], [CAMERA_SAU], [CAMERA_TRUOC], [CHIP], [RAM], [BO_NHO], [PIN], [THE_SIM], [HE_DIEU_HANH], [DO_PHAN_GIAI], [TAN_SO_QUET], [GPU], [CONG], [HO_TRO_MANG], [WI_FI], [BLUETOOTH], [KICH_THUOC_MAN_HINH], [TRONG_LUONG], [CHAT_LIEU], [CAM_BIEN_VAN_TAY], [TINH_NANG_DAC_BIET], [SO_KHE_RAM], [THOI_DIEM_RA_MAT]) VALUES (12, 12, N'Trung Quốc', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'5G', N'Không công bố', N'V5.0', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', N'Không công bố', CAST(N'2022-01-01' AS Date))
SET IDENTITY_INSERT [dbo].[THONG_TIN_SAN_PHAM] OFF
ALTER TABLE [dbo].[BLOG]  WITH CHECK ADD  CONSTRAINT [FK_BLOG_SAN_PHAM] FOREIGN KEY([ID_SP])
REFERENCES [dbo].[SAN_PHAM] ([ID_SP])
GO
ALTER TABLE [dbo].[BLOG] CHECK CONSTRAINT [FK_BLOG_SAN_PHAM]
GO
ALTER TABLE [dbo].[CHI_TIET_HOA_DON]  WITH CHECK ADD  CONSTRAINT [FK_CHI_TIET_FK_ACCOUN_ACCOUNT] FOREIGN KEY([ID_ACC])
REFERENCES [dbo].[ACCOUNT] ([ID_ACC])
GO
ALTER TABLE [dbo].[CHI_TIET_HOA_DON] CHECK CONSTRAINT [FK_CHI_TIET_FK_ACCOUN_ACCOUNT]
GO
ALTER TABLE [dbo].[CHI_TIET_HOA_DON]  WITH CHECK ADD  CONSTRAINT [FK_CHI_TIET_FK_KHACH__KHACH_HA] FOREIGN KEY([ID_KH])
REFERENCES [dbo].[KHACH_HANG] ([ID_KH])
GO
ALTER TABLE [dbo].[CHI_TIET_HOA_DON] CHECK CONSTRAINT [FK_CHI_TIET_FK_KHACH__KHACH_HA]
GO
ALTER TABLE [dbo].[CHI_TIET_HOA_DON]  WITH CHECK ADD  CONSTRAINT [FK_CHI_TIET_HOA_DON_CHI_NHANH] FOREIGN KEY([ID_CN])
REFERENCES [dbo].[CHI_NHANH] ([ID_CN])
GO
ALTER TABLE [dbo].[CHI_TIET_HOA_DON] CHECK CONSTRAINT [FK_CHI_TIET_HOA_DON_CHI_NHANH]
GO
ALTER TABLE [dbo].[CHI_TIET_HOA_DON]  WITH CHECK ADD  CONSTRAINT [FK_CHI_TIET_HOA_DON_HOA_DON] FOREIGN KEY([ID_HD])
REFERENCES [dbo].[HOA_DON] ([ID_HD])
GO
ALTER TABLE [dbo].[CHI_TIET_HOA_DON] CHECK CONSTRAINT [FK_CHI_TIET_HOA_DON_HOA_DON]
GO
ALTER TABLE [dbo].[CHI_TIET_HOA_DON]  WITH CHECK ADD  CONSTRAINT [FK_CHI_TIET_HOA_DON_SAN_PHAM] FOREIGN KEY([ID_SP])
REFERENCES [dbo].[SAN_PHAM] ([ID_SP])
GO
ALTER TABLE [dbo].[CHI_TIET_HOA_DON] CHECK CONSTRAINT [FK_CHI_TIET_HOA_DON_SAN_PHAM]
GO
ALTER TABLE [dbo].[DANH GIA]  WITH CHECK ADD  CONSTRAINT [FK_DANH GIA_ACCOUNT] FOREIGN KEY([ID_ACC])
REFERENCES [dbo].[ACCOUNT] ([ID_ACC])
GO
ALTER TABLE [dbo].[DANH GIA] CHECK CONSTRAINT [FK_DANH GIA_ACCOUNT]
GO
ALTER TABLE [dbo].[DANH GIA]  WITH CHECK ADD  CONSTRAINT [FK_DANH GIA_SAN_PHAM] FOREIGN KEY([ID_SP])
REFERENCES [dbo].[SAN_PHAM] ([ID_SP])
GO
ALTER TABLE [dbo].[DANH GIA] CHECK CONSTRAINT [FK_DANH GIA_SAN_PHAM]
GO
ALTER TABLE [dbo].[THONG_TIN_SAN_PHAM]  WITH CHECK ADD  CONSTRAINT [FK_THONG_TIN_SAN_PHAM_SAN_PHAM] FOREIGN KEY([ID_SP])
REFERENCES [dbo].[SAN_PHAM] ([ID_SP])
GO
ALTER TABLE [dbo].[THONG_TIN_SAN_PHAM] CHECK CONSTRAINT [FK_THONG_TIN_SAN_PHAM_SAN_PHAM]
GO
USE [master]
GO
ALTER DATABASE [DATT] SET  READ_WRITE 
GO
