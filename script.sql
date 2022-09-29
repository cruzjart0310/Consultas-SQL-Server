CREATE DATABASE KrispyKreme

USE KrispyKreme

CREATE TABLE Status(
	Id INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME,
)

ALTER TABLE Status ADD PRIMARY KEY(Id)


CREATE TABLE Establishment(
	Id INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME,
)

ALTER TABLE Establishment ADD PRIMARY KEY(Id)

CREATE TABLE Permission(
	Id INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	Description VARCHAR(100) NOT NULL,
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME,
)
ALTER TABLE Permission ADD PRIMARY KEY(Id)

CREATE TABLE Role(
	Id INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	Description VARCHAR(100) NOT NULL,
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME
)
ALTER TABLE Role ADD PRIMARY KEY(Id)


CREATE TABLE Coupon(
	Id INT NOT NULL IDENTITY(1,1),
	Duration DATETIME NOT NULL,
	Serie VARCHAR(20) NOT NULL,
	Description VARCHAR(200),
	StatusId INT NOT NULL,
	EstablishmentId INT NOT NULL,
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME
)

ALTER TABLE Coupon ADD PRIMARY KEY(Id)
ALTER TABLE Coupon ADD FOREIGN KEY(EstablishmentId) REFERENCES Establishment(Id)
ALTER TABLE Coupon ADD FOREIGN KEY(StatusId) REFERENCES Status(Id)
CREATE NONCLUSTERED INDEX IN001COUPONS ON Coupon(Id)

CREATE TABLE Users(
	Id INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(20) NOT NULL,
	LastName VARCHAR(20),
	Email VARCHAR(50),
	Password VARCHAR(250),
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME
)
ALTER TABLE Users ADD PRIMARY KEY(Id)

CREATE TABLE UserRole(
	UserId INT NOT NULL,
	RoleId INT NOT NULL,
)
ALTER TABLE UserRole ADD FOREIGN KEY(UserId) REFERENCES Users(Id)
ALTER TABLE UserRole ADD FOREIGN KEY(RoleId) REFERENCES Role(Id)

CREATE TABLE UserPermission(
	UserId INT NOT NULL,
	PermissionId INT NOT NULL,
)
ALTER TABLE UserPermission ADD FOREIGN KEY(UserId) REFERENCES Users(Id)
ALTER TABLE UserPermission ADD FOREIGN KEY(PermissionId) REFERENCES Permission(Id)


-------------------------------------------------------------------------------

INSERT INTO Establishment VALUES ('Establishment 1',GETDATE(), NULL, NULL)
INSERT INTO Establishment VALUES ('Establishment 2',GETDATE(), NULL, NULL)
INSERT INTO Establishment VALUES ('Establishment 3',GETDATE(), NULL, NULL)

INSERT INTO Permission VALUES ('Permission 1', 'PUEDER VER CUPONES', GETDATE(), NULL, NULL)
INSERT INTO Permission VALUES ('Permission 2', 'PUEDER EDITAR CUPONES', GETDATE(), NULL, NULL)
INSERT INTO Permission VALUES ('Permission 3', 'PUEDER ELIMINAR CUPONES', GETDATE(), NULL, NULL)

INSERT INTO Role VALUES ('SUPERUSER', 'TIENE EL CONTROL TOTAL', GETDATE(), NULL, NULL)
INSERT INTO Role VALUES ('ADMINITRATOR', 'TIENE EL CONTROL PARCIAL', GETDATE(), NULL, NULL)
INSERT INTO Role VALUES ('USER', 'TIENE CONTROL LIMITADO', GETDATE(), NULL, NULL)

INSERT INTO Status VALUES ('DISPONIBLE',GETDATE(), NULL, NULL)
INSERT INTO Status VALUES ('CANJEADO',GETDATE(), NULL, NULL)
INSERT INTO Status VALUES ('VENCIDO',GETDATE(), NULL, NULL)

INSERT INTO Coupon VALUES ('2021-12-31 00:00:00','AC08R9','DESC 1', 1, 1, GETDATE(), NULL, NULL)
INSERT INTO Coupon VALUES ('2021-12-24 00:00:00','AC08R9','DESC 2', 2, 2, GETDATE(), NULL, NULL)
INSERT INTO Coupon VALUES ('2021-12-24 00:00:00','AC08R9','DESC 3', 3, 3, GETDATE(), NULL, NULL)


INSERT INTO Users VALUES ('JOHN', 'CENA', 'john@kuspy.creme', '1256789', GETDATE(), NULL, NULL)
INSERT INTO Users VALUES ('PAUL', 'WALKER', 'paul@kuspy.creme', '1256789', GETDATE(), NULL, NULL)
INSERT INTO Users VALUES ('ADDAN', 'SANDER', 'addan@kuspy.creme', '1256789', GETDATE(), NULL, NULL)


INSERT INTO UserRole VALUES (1, 1)
INSERT INTO UserRole VALUES (2, 2)
INSERT INTO UserRole VALUES (3,3)

INSERT INTO UserPermission VALUES (1, 1)
INSERT INTO UserPermission VALUES (2, 2)
INSERT INTO UserPermission VALUES (3,3)

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GET_USER_BY_ID 
	@piId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT US.Id, US.Name, US.LastName,
		R.Id AS RoleID, R.Name AS RoleName,
		P.Id AS PermisionId, P.Name AS PermissionName
		FROM USERS US 
		LEFT JOIN UserRole UR ON US.Id=UR.UserId
		LEFT JOIN Role R ON UR.RoleId= R.Id
		LEFT JOIN UserPermission UP ON US.Id = UP.UserId
		LEFT JOIN Permission P ON UP.PermissionId= P.Id
	WHERE US.Id = @piId AND US.DeletedAt IS NULL

END
GO

--DROP PROCEDURE GET_USER_BY_ID
--GET_USER_BY_ID 3


/****** Object:  StoredProcedure [dbo].[INSERT_COUPONS]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_COUPONS] 
	@pcDuration DATETIME,
	@pcSerie VARCHAR(20),
	@pcDescription VARCHAR(200),
	@piStatusId INT,
	@piEstablishmentId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO Coupon VALUES (@pcDuration,@pcSerie,@pcDescription,@piStatusId,@piEstablishmentId, GETDATE(), NULL, NULL)

END

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GET_COUPON_BY_ID 
	@piId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		CP.Id, CP.Description,CP.Duration, CP.Serie,CP.CreatedAt,CP.DeletedAt,
		ST.Id AS StId, ST.Name AS Status,
		EST.Id AS EstId, EST.Name AS Establishment
		FROM COUPON CP 
		INNER JOIN Status ST ON CP.StatusId=ST.Id
		INNER JOIN Establishment EST ON CP.EstablishmentId=EST.Id
	WHERE CP.Id = @piId AND CP.DeletedAt IS NULL

END
GO


/****** Object:  StoredProcedure [dbo].[GET_COUPON_BY_ID]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_COUPONS] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		CP.Id, CP.Description,CP.Duration, CP.Serie,CP.CreatedAt,CP.DeletedAt,
		ST.Id AS StId, ST.Name AS Status,
		EST.Id AS EstId, EST.Name AS Establishment
		FROM COUPON CP 
		INNER JOIN Status ST ON CP.StatusId=ST.Id
		INNER JOIN Establishment EST ON CP.EstablishmentId=EST.Id
	WHERE CP.DeletedAt IS NULL

END

/****** Object:  StoredProcedure [dbo].[UPDATE_COUPONS_BY_ID]  ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UPDATE_COUPONS_BY_ID]
@piId INT,
@pcDuration DATETIME,
@pcSerie VARCHAR(20),
@pcDescription VARCHAR(200),
@piStatusId INT,
@piEstablishmentId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE COUPON
		SET 
		Duration =@pcDuration,
		Serie = @pcSerie,
		Description = @pcDescription,
		StatusId = @piStatusId,
		EstablishmentId = @piEstablishmentId,
		UpdatedAt = GETDATE()
	WHERE Id=@piId

END


/****** Object:  StoredProcedure [dbo].[DELETE_COUPONS_BY_ID] ******/   
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DELETE_COUPONS_BY_ID]
@piId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE COUPON
		SET 
		DeletedAt =GETDATE()
	WHERE Id=@piId

END


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GET_ROLES_USER_BY_ID 
	@piId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT R.Id, R.Name, R.Description
	FROM UserRole PR
	INNER JOIN Users US ON PR.UserId=US.Id
	INNER JOIN Role R ON PR.RoleId = R.Id
	WHERE US.Id=@piId
END
GO

/****** Object:  StoredProcedure [dbo].[GetPermissionsUserById] ******/  
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_PERMISSIONS_USER_BY_ID] 
	-- Add the parameters for the stored procedure here
	@piId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT P.Id,P.Name, P.Description
	FROM UserPermission PR
	INNER JOIN Users US ON PR.UserId=US.Id
	INNER JOIN Permission P ON PR.PermissionId = p.Id
	WHERE US.Id=@piId
END


/****** Object:  StoredProcedure [dbo].[FilterCoupons] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FilterCoupons] 
	@pcFechaInicial varchar(20),
	@pcFechaFinal varchar(20),
	@piStatusId int,
	@piEstablismentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @vcFiltro NVARCHAR(MAX)
	DECLARE @vcQuery NVARCHAR(MAX)

	IF (LEN(@pcFechaInicial) >0 AND LEN(@pcFechaFinal)>0)
	BEGIN
		SET @vcFiltro = ' AND Duration BETWEEN '''+ @pcFechaInicial+ ''' AND '''+@pcFechaFinal+''''
	END
	ELSE
		SET @vcFiltro = @vcFiltro+ ' AND Duration='''+ @pcFechaInicial+ ''''
	END
	
	IF (LEN(@piStatusId) >0)
	BEGIN
	PRINT('ENTRO')
		SET @vcFiltro = @vcFiltro+ ' AND StatusId='+CAST(@piStatusId AS NVARCHAR(10))
	END
	--ELSE
	--	SET @vcFiltro =  @vcFiltro+ ' AND StatusId='+CAST(1 AS NVARCHAR(10))
	--END

	IF (LEN(@piEstablismentId ) >0)
	BEGIN
		SET @vcFiltro = @vcFiltro+' AND EstablishmentId='++CAST(@piEstablismentId AS NVARCHAR(10))
	END
	--ELSE
	--	SET @vcFiltro = ''
	--	--SET @vcFiltro = ' AND Duration BETWEEN '''+ @pcFechaInicial+ ''' AND '''+@pcFechaFinal+''''
	--END

	print(@vcFiltro)

	SET @vcQuery = N'SELECT 
		CP.Id, CP.Description,CP.Duration, CP.Serie,CP.CreatedAt,CP.DeletedAt,
		ST.Id AS StId, ST.Name AS Status,
		EST.Id AS EstId, EST.Name AS Establishment
		FROM COUPON CP 
		INNER JOIN Status ST ON CP.StatusId=ST.Id
		INNER JOIN Establishment EST ON CP.EstablishmentId=EST.Id
	WHERE CP.DeletedAt IS NULL' + @vcFiltro

	
	print(@vcQuery)

	EXEC sp_executesql @vcQuery



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GET_STATUS 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Status ORDER BY 1 DESC

END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EXCHANGE_COUPONS_BY_ID]
@piId INT
AS
BEGIN
	--DECLARE @piId INT
	--SET @piId = 1
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;
	
	DECLARE @RESULT INT
	
	IF EXISTS(SELECT StatusId FROM Coupon WHERE StatusId IN (2,3) AND Id = @piId )
	BEGIN
		SET @RESULT = (SELECT StatusId FROM Coupon WHERE Id = @piId)
		PRINT (@RESULT)
	END

	IF EXISTS(SELECT Duration FROM Coupon WHERE GETDATE() > Duration AND StatusId=1 AND Id = @piId)
	BEGIN
		UPDATE COUPON
			SET 
			StatusId = 2,
			UpdatedAt = GETDATE()
			WHERE Id=@piId

		-- Insert statements for procedure here
		SET @RESULT = (SELECT StatusId FROM Coupon WHERE Id = @piId)
		PRINT (@RESULT)
	END
	SET NOCOUNT ON

	SELECT 'Status' = @RESULT
END


CREATE DATABASE KrispyKreme

USE KrispyKreme

CREATE TABLE Status(
	Id INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME,
)

ALTER TABLE Status ADD PRIMARY KEY(Id)


CREATE TABLE Establishment(
	Id INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME,
)

ALTER TABLE Establishment ADD PRIMARY KEY(Id)

CREATE TABLE Permission(
	Id INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	Description VARCHAR(100) NOT NULL,
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME,
)
ALTER TABLE Permission ADD PRIMARY KEY(Id)

CREATE TABLE Role(
	Id INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	Description VARCHAR(100) NOT NULL,
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME
)
ALTER TABLE Role ADD PRIMARY KEY(Id)


CREATE TABLE Coupon(
	Id INT NOT NULL IDENTITY(1,1),
	Duration DATETIME NOT NULL,
	Serie VARCHAR(20) NOT NULL,
	Description VARCHAR(200),
	StatusId INT NOT NULL,
	EstablishmentId INT NOT NULL,
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME
)

ALTER TABLE Coupon ADD PRIMARY KEY(Id)
ALTER TABLE Coupon ADD FOREIGN KEY(EstablishmentId) REFERENCES Establishment(Id)
ALTER TABLE Coupon ADD FOREIGN KEY(StatusId) REFERENCES Status(Id)
CREATE NONCLUSTERED INDEX IN001COUPONS ON Coupon(Id)

CREATE TABLE Users(
	Id INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(20) NOT NULL,
	LastName VARCHAR(20),
	Email VARCHAR(50),
	Password VARCHAR(250),
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME
)
ALTER TABLE Users ADD PRIMARY KEY(Id)

CREATE TABLE UserRole(
	UserId INT NOT NULL,
	RoleId INT NOT NULL,
)
ALTER TABLE UserRole ADD FOREIGN KEY(UserId) REFERENCES Users(Id)
ALTER TABLE UserRole ADD FOREIGN KEY(RoleId) REFERENCES Role(Id)

CREATE TABLE UserPermission(
	UserId INT NOT NULL,
	PermissionId INT NOT NULL,
)
ALTER TABLE UserPermission ADD FOREIGN KEY(UserId) REFERENCES Users(Id)
ALTER TABLE UserPermission ADD FOREIGN KEY(PermissionId) REFERENCES Permission(Id)


-------------------------------------------------------------------------------

INSERT INTO Establishment VALUES ('Establishment 1',GETDATE(), NULL, NULL)
INSERT INTO Establishment VALUES ('Establishment 2',GETDATE(), NULL, NULL)
INSERT INTO Establishment VALUES ('Establishment 3',GETDATE(), NULL, NULL)

INSERT INTO Permission VALUES ('Permission 1', 'PUEDER VER CUPONES', GETDATE(), NULL, NULL)
INSERT INTO Permission VALUES ('Permission 2', 'PUEDER EDITAR CUPONES', GETDATE(), NULL, NULL)
INSERT INTO Permission VALUES ('Permission 3', 'PUEDER ELIMINAR CUPONES', GETDATE(), NULL, NULL)

INSERT INTO Role VALUES ('SUPERUSER', 'TIENE EL CONTROL TOTAL', GETDATE(), NULL, NULL)
INSERT INTO Role VALUES ('ADMINITRATOR', 'TIENE EL CONTROL PARCIAL', GETDATE(), NULL, NULL)
INSERT INTO Role VALUES ('USER', 'TIENE CONTROL LIMITADO', GETDATE(), NULL, NULL)

INSERT INTO Status VALUES ('DISPONIBLE',GETDATE(), NULL, NULL)
INSERT INTO Status VALUES ('CANJEADO',GETDATE(), NULL, NULL)
INSERT INTO Status VALUES ('VENCIDO',GETDATE(), NULL, NULL)

INSERT INTO Coupon VALUES ('2021-12-31 00:00:00','AC08R9','DESC 1', 1, 1, GETDATE(), NULL, NULL)
INSERT INTO Coupon VALUES ('2021-12-24 00:00:00','AC08R9','DESC 2', 2, 2, GETDATE(), NULL, NULL)
INSERT INTO Coupon VALUES ('2021-12-24 00:00:00','AC08R9','DESC 3', 3, 3, GETDATE(), NULL, NULL)


INSERT INTO Users VALUES ('JOHN', 'CENA', 'john@kuspy.creme', '1256789', GETDATE(), NULL, NULL)
INSERT INTO Users VALUES ('PAUL', 'WALKER', 'paul@kuspy.creme', '1256789', GETDATE(), NULL, NULL)
INSERT INTO Users VALUES ('ADDAN', 'SANDER', 'addan@kuspy.creme', '1256789', GETDATE(), NULL, NULL)


INSERT INTO UserRole VALUES (1, 1)
INSERT INTO UserRole VALUES (2, 2)
INSERT INTO UserRole VALUES (3,3)

INSERT INTO UserPermission VALUES (1, 1)
INSERT INTO UserPermission VALUES (2, 2)
INSERT INTO UserPermission VALUES (3,3)

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GET_USER_BY_ID 
	@piId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT US.Id, US.Name, US.LastName,
		R.Id AS RoleID, R.Name AS RoleName,
		P.Id AS PermisionId, P.Name AS PermissionName
		FROM USERS US 
		LEFT JOIN UserRole UR ON US.Id=UR.UserId
		LEFT JOIN Role R ON UR.RoleId= R.Id
		LEFT JOIN UserPermission UP ON US.Id = UP.UserId
		LEFT JOIN Permission P ON UP.PermissionId= P.Id
	WHERE US.Id = @piId AND US.DeletedAt IS NULL

END
GO

--DROP PROCEDURE GET_USER_BY_ID
--GET_USER_BY_ID 3


/****** Object:  StoredProcedure [dbo].[INSERT_COUPONS]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_COUPONS] 
	@pcDuration DATETIME,
	@pcSerie VARCHAR(20),
	@pcDescription VARCHAR(200),
	@piStatusId INT,
	@piEstablishmentId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO Coupon VALUES (@pcDuration,@pcSerie,@pcDescription,@piStatusId,@piEstablishmentId, GETDATE(), NULL, NULL)

END

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GET_COUPON_BY_ID 
	@piId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		CP.Id, CP.Description,CP.Duration, CP.Serie,CP.CreatedAt,CP.DeletedAt,
		ST.Id AS StId, ST.Name AS Status,
		EST.Id AS EstId, EST.Name AS Establishment
		FROM COUPON CP 
		INNER JOIN Status ST ON CP.StatusId=ST.Id
		INNER JOIN Establishment EST ON CP.EstablishmentId=EST.Id
	WHERE CP.Id = @piId AND CP.DeletedAt IS NULL

END
GO


/****** Object:  StoredProcedure [dbo].[GET_COUPON_BY_ID]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_COUPONS] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		CP.Id, CP.Description,CP.Duration, CP.Serie,CP.CreatedAt,CP.DeletedAt,
		ST.Id AS StId, ST.Name AS Status,
		EST.Id AS EstId, EST.Name AS Establishment
		FROM COUPON CP 
		INNER JOIN Status ST ON CP.StatusId=ST.Id
		INNER JOIN Establishment EST ON CP.EstablishmentId=EST.Id
	WHERE CP.DeletedAt IS NULL

END

/****** Object:  StoredProcedure [dbo].[UPDATE_COUPONS_BY_ID]  ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UPDATE_COUPONS_BY_ID]
@piId INT,
@pcDuration DATETIME,
@pcSerie VARCHAR(20),
@pcDescription VARCHAR(200),
@piStatusId INT,
@piEstablishmentId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE COUPON
		SET 
		Duration =@pcDuration,
		Serie = @pcSerie,
		Description = @pcDescription,
		StatusId = @piStatusId,
		EstablishmentId = @piEstablishmentId,
		UpdatedAt = GETDATE()
	WHERE Id=@piId

END


/****** Object:  StoredProcedure [dbo].[DELETE_COUPONS_BY_ID] ******/   
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DELETE_COUPONS_BY_ID]
@piId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE COUPON
		SET 
		DeletedAt =GETDATE()
	WHERE Id=@piId

END


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GET_ROLES_USER_BY_ID 
	@piId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT R.Id, R.Name, R.Description
	FROM UserRole PR
	INNER JOIN Users US ON PR.UserId=US.Id
	INNER JOIN Role R ON PR.RoleId = R.Id
	WHERE US.Id=@piId
END
GO

/****** Object:  StoredProcedure [dbo].[GetPermissionsUserById] ******/  
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_PERMISSIONS_USER_BY_ID] 
	-- Add the parameters for the stored procedure here
	@piId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT P.Id,P.Name, P.Description
	FROM UserPermission PR
	INNER JOIN Users US ON PR.UserId=US.Id
	INNER JOIN Permission P ON PR.PermissionId = p.Id
	WHERE US.Id=@piId
END


/****** Object:  StoredProcedure [dbo].[FilterCoupons] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FilterCoupons] 
	@pcFechaInicial varchar(20),
	@pcFechaFinal varchar(20),
	@piStatusId int,
	@piEstablismentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @vcFiltro NVARCHAR(MAX)
	DECLARE @vcQuery NVARCHAR(MAX)

	IF (LEN(@pcFechaInicial) >0 AND LEN(@pcFechaFinal)>0)
	BEGIN
		SET @vcFiltro = ' AND Duration BETWEEN '''+ @pcFechaInicial+ ''' AND '''+@pcFechaFinal+''''
	END
	ELSE
		SET @vcFiltro = @vcFiltro+ ' AND Duration='''+ @pcFechaInicial+ ''''
	END
	
	IF (LEN(@piStatusId) >0)
	BEGIN
	PRINT('ENTRO')
		SET @vcFiltro = @vcFiltro+ ' AND StatusId='+CAST(@piStatusId AS NVARCHAR(10))
	END
	--ELSE
	--	SET @vcFiltro =  @vcFiltro+ ' AND StatusId='+CAST(1 AS NVARCHAR(10))
	--END

	IF (LEN(@piEstablismentId ) >0)
	BEGIN
		SET @vcFiltro = @vcFiltro+' AND EstablishmentId='++CAST(@piEstablismentId AS NVARCHAR(10))
	END
	--ELSE
	--	SET @vcFiltro = ''
	--	--SET @vcFiltro = ' AND Duration BETWEEN '''+ @pcFechaInicial+ ''' AND '''+@pcFechaFinal+''''
	--END

	print(@vcFiltro)

	SET @vcQuery = N'SELECT 
		CP.Id, CP.Description,CP.Duration, CP.Serie,CP.CreatedAt,CP.DeletedAt,
		ST.Id AS StId, ST.Name AS Status,
		EST.Id AS EstId, EST.Name AS Establishment
		FROM COUPON CP 
		INNER JOIN Status ST ON CP.StatusId=ST.Id
		INNER JOIN Establishment EST ON CP.EstablishmentId=EST.Id
	WHERE CP.DeletedAt IS NULL' + @vcFiltro

	
	print(@vcQuery)

	EXEC sp_executesql @vcQuery



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GET_STATUS 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Status ORDER BY 1 DESC

END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EXCHANGE_COUPONS_BY_ID]
@piId INT
AS
BEGIN
	--DECLARE @piId INT
	--SET @piId = 1
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;
	
	DECLARE @RESULT INT
	
	IF EXISTS(SELECT StatusId FROM Coupon WHERE StatusId IN (2,3) AND Id = @piId )
	BEGIN
		SET @RESULT = (SELECT StatusId FROM Coupon WHERE Id = @piId)
		PRINT (@RESULT)
	END

	IF EXISTS(SELECT Duration FROM Coupon WHERE GETDATE() > Duration AND StatusId=1 AND Id = @piId)
	BEGIN
		UPDATE COUPON
			SET 
			StatusId = 2,
			UpdatedAt = GETDATE()
			WHERE Id=@piId

		-- Insert statements for procedure here
		SET @RESULT = (SELECT StatusId FROM Coupon WHERE Id = @piId)
		PRINT (@RESULT)
	END
	SET NOCOUNT ON

	SELECT 'Status' = @RESULT
END


CREATE DATABASE KrispyKreme

USE KrispyKreme

CREATE TABLE Status(
	Id INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME,
)

ALTER TABLE Status ADD PRIMARY KEY(Id)


CREATE TABLE Establishment(
	Id INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME,
)

ALTER TABLE Establishment ADD PRIMARY KEY(Id)

CREATE TABLE Permission(
	Id INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	Description VARCHAR(100) NOT NULL,
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME,
)
ALTER TABLE Permission ADD PRIMARY KEY(Id)

CREATE TABLE Role(
	Id INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	Description VARCHAR(100) NOT NULL,
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME
)
ALTER TABLE Role ADD PRIMARY KEY(Id)


CREATE TABLE Coupon(
	Id INT NOT NULL IDENTITY(1,1),
	Duration DATETIME NOT NULL,
	Serie VARCHAR(20) NOT NULL,
	Description VARCHAR(200),
	StatusId INT NOT NULL,
	EstablishmentId INT NOT NULL,
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME
)

ALTER TABLE Coupon ADD PRIMARY KEY(Id)
ALTER TABLE Coupon ADD FOREIGN KEY(EstablishmentId) REFERENCES Establishment(Id)
ALTER TABLE Coupon ADD FOREIGN KEY(StatusId) REFERENCES Status(Id)
CREATE NONCLUSTERED INDEX IN001COUPONS ON Coupon(Id)

CREATE TABLE Users(
	Id INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(20) NOT NULL,
	LastName VARCHAR(20),
	Email VARCHAR(50),
	Password VARCHAR(250),
	CreatedAt DATETIME,
	UpdatedAt DATETIME,
	DeletedAt DATETIME
)
ALTER TABLE Users ADD PRIMARY KEY(Id)

CREATE TABLE UserRole(
	UserId INT NOT NULL,
	RoleId INT NOT NULL,
)
ALTER TABLE UserRole ADD FOREIGN KEY(UserId) REFERENCES Users(Id)
ALTER TABLE UserRole ADD FOREIGN KEY(RoleId) REFERENCES Role(Id)

CREATE TABLE UserPermission(
	UserId INT NOT NULL,
	PermissionId INT NOT NULL,
)
ALTER TABLE UserPermission ADD FOREIGN KEY(UserId) REFERENCES Users(Id)
ALTER TABLE UserPermission ADD FOREIGN KEY(PermissionId) REFERENCES Permission(Id)


-------------------------------------------------------------------------------

INSERT INTO Establishment VALUES ('Establishment 1',GETDATE(), NULL, NULL)
INSERT INTO Establishment VALUES ('Establishment 2',GETDATE(), NULL, NULL)
INSERT INTO Establishment VALUES ('Establishment 3',GETDATE(), NULL, NULL)

INSERT INTO Permission VALUES ('Permission 1', 'PUEDER VER CUPONES', GETDATE(), NULL, NULL)
INSERT INTO Permission VALUES ('Permission 2', 'PUEDER EDITAR CUPONES', GETDATE(), NULL, NULL)
INSERT INTO Permission VALUES ('Permission 3', 'PUEDER ELIMINAR CUPONES', GETDATE(), NULL, NULL)

INSERT INTO Role VALUES ('SUPERUSER', 'TIENE EL CONTROL TOTAL', GETDATE(), NULL, NULL)
INSERT INTO Role VALUES ('ADMINITRATOR', 'TIENE EL CONTROL PARCIAL', GETDATE(), NULL, NULL)
INSERT INTO Role VALUES ('USER', 'TIENE CONTROL LIMITADO', GETDATE(), NULL, NULL)

INSERT INTO Status VALUES ('DISPONIBLE',GETDATE(), NULL, NULL)
INSERT INTO Status VALUES ('CANJEADO',GETDATE(), NULL, NULL)
INSERT INTO Status VALUES ('VENCIDO',GETDATE(), NULL, NULL)

INSERT INTO Coupon VALUES ('2021-12-31 00:00:00','AC08R9','DESC 1', 1, 1, GETDATE(), NULL, NULL)
INSERT INTO Coupon VALUES ('2021-12-24 00:00:00','AC08R9','DESC 2', 2, 2, GETDATE(), NULL, NULL)
INSERT INTO Coupon VALUES ('2021-12-24 00:00:00','AC08R9','DESC 3', 3, 3, GETDATE(), NULL, NULL)


INSERT INTO Users VALUES ('JOHN', 'CENA', 'john@kuspy.creme', '1256789', GETDATE(), NULL, NULL)
INSERT INTO Users VALUES ('PAUL', 'WALKER', 'paul@kuspy.creme', '1256789', GETDATE(), NULL, NULL)
INSERT INTO Users VALUES ('ADDAN', 'SANDER', 'addan@kuspy.creme', '1256789', GETDATE(), NULL, NULL)


INSERT INTO UserRole VALUES (1, 1)
INSERT INTO UserRole VALUES (2, 2)
INSERT INTO UserRole VALUES (3,3)

INSERT INTO UserPermission VALUES (1, 1)
INSERT INTO UserPermission VALUES (2, 2)
INSERT INTO UserPermission VALUES (3,3)

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GET_USER_BY_ID 
	@piId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT US.Id, US.Name, US.LastName,
		R.Id AS RoleID, R.Name AS RoleName,
		P.Id AS PermisionId, P.Name AS PermissionName
		FROM USERS US 
		LEFT JOIN UserRole UR ON US.Id=UR.UserId
		LEFT JOIN Role R ON UR.RoleId= R.Id
		LEFT JOIN UserPermission UP ON US.Id = UP.UserId
		LEFT JOIN Permission P ON UP.PermissionId= P.Id
	WHERE US.Id = @piId AND US.DeletedAt IS NULL

END
GO

--DROP PROCEDURE GET_USER_BY_ID
--GET_USER_BY_ID 3


/****** Object:  StoredProcedure [dbo].[INSERT_COUPONS]******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_COUPONS] 
	@pcDuration DATETIME,
	@pcSerie VARCHAR(20),
	@pcDescription VARCHAR(200),
	@piStatusId INT,
	@piEstablishmentId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO Coupon VALUES (@pcDuration,@pcSerie,@pcDescription,@piStatusId,@piEstablishmentId, GETDATE(), NULL, NULL)

END

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GET_COUPON_BY_ID 
	@piId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		CP.Id, CP.Description,CP.Duration, CP.Serie,CP.CreatedAt,CP.DeletedAt,
		ST.Id AS StId, ST.Name AS Status,
		EST.Id AS EstId, EST.Name AS Establishment
		FROM COUPON CP 
		INNER JOIN Status ST ON CP.StatusId=ST.Id
		INNER JOIN Establishment EST ON CP.EstablishmentId=EST.Id
	WHERE CP.Id = @piId AND CP.DeletedAt IS NULL

END
GO


/****** Object:  StoredProcedure [dbo].[GET_COUPON_BY_ID]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_COUPONS] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		CP.Id, CP.Description,CP.Duration, CP.Serie,CP.CreatedAt,CP.DeletedAt,
		ST.Id AS StId, ST.Name AS Status,
		EST.Id AS EstId, EST.Name AS Establishment
		FROM COUPON CP 
		INNER JOIN Status ST ON CP.StatusId=ST.Id
		INNER JOIN Establishment EST ON CP.EstablishmentId=EST.Id
	WHERE CP.DeletedAt IS NULL

END

/****** Object:  StoredProcedure [dbo].[UPDATE_COUPONS_BY_ID]  ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UPDATE_COUPONS_BY_ID]
@piId INT,
@pcDuration DATETIME,
@pcSerie VARCHAR(20),
@pcDescription VARCHAR(200),
@piStatusId INT,
@piEstablishmentId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE COUPON
		SET 
		Duration =@pcDuration,
		Serie = @pcSerie,
		Description = @pcDescription,
		StatusId = @piStatusId,
		EstablishmentId = @piEstablishmentId,
		UpdatedAt = GETDATE()
	WHERE Id=@piId

END


/****** Object:  StoredProcedure [dbo].[DELETE_COUPONS_BY_ID] ******/   
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DELETE_COUPONS_BY_ID]
@piId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE COUPON
		SET 
		DeletedAt =GETDATE()
	WHERE Id=@piId

END


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GET_ROLES_USER_BY_ID 
	@piId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT R.Id, R.Name, R.Description
	FROM UserRole PR
	INNER JOIN Users US ON PR.UserId=US.Id
	INNER JOIN Role R ON PR.RoleId = R.Id
	WHERE US.Id=@piId
END
GO

/****** Object:  StoredProcedure [dbo].[GetPermissionsUserById] ******/  
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_PERMISSIONS_USER_BY_ID] 
	-- Add the parameters for the stored procedure here
	@piId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT P.Id,P.Name, P.Description
	FROM UserPermission PR
	INNER JOIN Users US ON PR.UserId=US.Id
	INNER JOIN Permission P ON PR.PermissionId = p.Id
	WHERE US.Id=@piId
END


/****** Object:  StoredProcedure [dbo].[FilterCoupons] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FilterCoupons] 
	@pcFechaInicial varchar(20),
	@pcFechaFinal varchar(20),
	@piStatusId int,
	@piEstablismentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @vcFiltro NVARCHAR(MAX)
	DECLARE @vcQuery NVARCHAR(MAX)

	IF (LEN(@pcFechaInicial) >0 AND LEN(@pcFechaFinal)>0)
	BEGIN
		SET @vcFiltro = ' AND Duration BETWEEN '''+ @pcFechaInicial+ ''' AND '''+@pcFechaFinal+''''
	END
	ELSE
		SET @vcFiltro = @vcFiltro+ ' AND Duration='''+ @pcFechaInicial+ ''''
	END
	
	IF (LEN(@piStatusId) >0)
	BEGIN
	PRINT('ENTRO')
		SET @vcFiltro = @vcFiltro+ ' AND StatusId='+CAST(@piStatusId AS NVARCHAR(10))
	END
	--ELSE
	--	SET @vcFiltro =  @vcFiltro+ ' AND StatusId='+CAST(1 AS NVARCHAR(10))
	--END

	IF (LEN(@piEstablismentId ) >0)
	BEGIN
		SET @vcFiltro = @vcFiltro+' AND EstablishmentId='++CAST(@piEstablismentId AS NVARCHAR(10))
	END
	--ELSE
	--	SET @vcFiltro = ''
	--	--SET @vcFiltro = ' AND Duration BETWEEN '''+ @pcFechaInicial+ ''' AND '''+@pcFechaFinal+''''
	--END

	print(@vcFiltro)

	SET @vcQuery = N'SELECT 
		CP.Id, CP.Description,CP.Duration, CP.Serie,CP.CreatedAt,CP.DeletedAt,
		ST.Id AS StId, ST.Name AS Status,
		EST.Id AS EstId, EST.Name AS Establishment
		FROM COUPON CP 
		INNER JOIN Status ST ON CP.StatusId=ST.Id
		INNER JOIN Establishment EST ON CP.EstablishmentId=EST.Id
	WHERE CP.DeletedAt IS NULL' + @vcFiltro

	
	print(@vcQuery)

	EXEC sp_executesql @vcQuery



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GET_STATUS 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Status ORDER BY 1 DESC

END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EXCHANGE_COUPONS_BY_ID]
@piId INT
AS
BEGIN
	--DECLARE @piId INT
	--SET @piId = 1
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;
	
	DECLARE @RESULT INT
	
	IF EXISTS(SELECT StatusId FROM Coupon WHERE StatusId IN (2,3) AND Id = @piId )
	BEGIN
		SET @RESULT = (SELECT StatusId FROM Coupon WHERE Id = @piId)
		PRINT (@RESULT)
	END

	IF EXISTS(SELECT Duration FROM Coupon WHERE GETDATE() > Duration AND StatusId=1 AND Id = @piId)
	BEGIN
		UPDATE COUPON
			SET 
			StatusId = 2,
			UpdatedAt = GETDATE()
			WHERE Id=@piId

		-- Insert statements for procedure here
		SET @RESULT = (SELECT StatusId FROM Coupon WHERE Id = @piId)
		PRINT (@RESULT)
	END
	SET NOCOUNT ON

	SELECT 'Status' = @RESULT
END


