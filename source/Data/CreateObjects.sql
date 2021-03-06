CREATE DATABASE Paging
USE [Paging]
GO
/****** Object:  Table [dbo].[TBL_CUSTOMERS]    Script Date: 07/14/2011 15:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_CUSTOMERS](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[FIRSTNAME] [varchar](20) NULL,
	[LASTNAME] [varchar](20) NULL,
	[INSERTIONTIME] [smalldatetime] NULL CONSTRAINT [DF_Customers_INSERTIONTIME]  DEFAULT (getdate()),
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetCustomers]
  @PageIndex int=1, --varsayılan
  @PageSize int=3,
  @RowCount int out,
  @PageCount int out
AS
BEGIN
     DECLARE @Start INT
     DECLARE @Finish INT

     SET @Start=(@PageIndex*@PageSize)-@PageSize+1;
     SET @Finish=(@Start+@PageSize)-1;

     WITH TEMP_TBL AS(
		SELECT row_number() OVER (ORDER BY RID DESC) as RowNumber,
		* FROM TBL_CUSTOMERS)
	 SELECT * FROM TEMP_TBL WHERE RowNumber BETWEEN @Start AND @Finish     

     SET @RowCount =(SELECT count(*) FROM TBL_CUSTOMERS)

     IF ((@RowCount % @PageSize)=0) -- kalan 0 ise tam bölünüyordur
          SET @PageCount=@RowCount / @PageSize
        ELSE        --tam bölünmüyorsa
          SET @PageCount=(@RowCount / @PageSize)+1 --sayfa sayısına 1 ekle
END

/*
@PageIndex ->> Sayfa Numarası anlamına gelir."
@PageSize  ->> Sayfalık kayıt sayısıdır.
@RowCount  ->> Toplam Kayıt Sayısıdır"
@PageCount ->> Toplam sayfa sayısıdır"
@Start	   ->> Aralık Başlangıçı"
@Finish    ->> Aralık Bitişi"
*/