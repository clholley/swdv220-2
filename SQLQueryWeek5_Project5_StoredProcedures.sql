/**************************************************************************************************
	SDWV 220 PROJECT 5: STORED PROCEDURES

	file name: SQLQueryWeek5_Project5_StoredProcedures.sql

	DATE		PROGRAMMER		DATABASE			DESCRIPTION

	10/19/18	Cindy Holley	disk_inventory_2	Create new db and tables with data	
	10/19/18	Cindy Holley	disk_inventory_2	Project 4, create T-SQL queries
	10/25/18	Cindy Holley	disk_inventory_2	Project 5, stored procedures

***************************************************************************************************/

/**************************************************************************************************
Step 1:  

Document each SQL statement – what it is supposed to do. Stored procs & execute statements.

Step 2: 

If structure changes are needed to the tables from the previous project, 
include the code at the beginning of your script & document it/them.

NOTE:	Column names for Project 4 have been updated in Project 4.
		The View_Individual_Artist in the Views folder has been updated with the new column names. 

***************************************************************************************************/

--drop statements for all Project 5 stored procedures 
USE disk_inventory_2
GO

IF OBJECT_ID('sp_artist_insert') is not null
	DROP PROC sp_artist_insert;
GO

IF OBJECT_ID('sp_artist_update') is not null
	DROP PROC sp_artist_update;
GO

IF OBJECT_ID('sp_artist_delete') is not null
	DROP PROC sp_artist_delete;
GO

IF OBJECT_ID('sp_borrower_insert') is not null
	DROP PROC sp_borrower_insert;
GO

IF OBJECT_ID('sp_borrower_update') is not null
		DROP PROC sp_borrower_update;
GO

IF OBJECT_ID('sp_borrower_delete') is not null
	DROP PROC sp_borrower_delete;
GO

IF OBJECT_ID('sp_media_insert') is not null
		DROP PROC sp_media_insert;
GO

IF OBJECT_ID('sp_media_update') is not null
		DROP PROC sp_media_update;
GO

IF OBJECT_ID('sp_media_delete') is not null
	DROP PROC sp_media_delete;
GO


/**************************************************************************************************
Step 3: 

Create Insert, Update, and Delete stored procedures for the artist table. 
	Insert accepts all columns as input parameters except for identity fields. 
	Update procedure accepts a primary key value and the artist’s names for update. 
	Delete accepts a primary key value for delete.

	new artist to insert: singer Ornella Vanella, update to: Ornella Vanoni, and delete 

Step 6: Script file includes all required ‘GO’ statements.
Step 7: Stored procedures contain error processing (try-catch).
Step 8: Script file includes all execute statements needed to invoke each stored procedure

***************************************************************************************************/

USE disk_inventory_2
GO

/***************************
 * Insert Artist Procedure *
 ***************************/
IF OBJECT_ID('sp_artist_insert') is not null
	DROP PROC sp_artist_insert;
GO

CREATE PROC sp_artist_insert
	@artist_type  varchar(45) 
	,@artist_fname  varchar(45) 
	,@artist_lname  varchar(45) 
	,@group_name  varchar(45) 
AS
BEGIN TRY
	IF	(@artist_fname IS NULL AND 
		@artist_lname IS NULL AND 
		@group_name IS NULL) or 
		(@artist_fname = '' AND 
		@artist_lname = '' AND 
		@group_name = '')
		THROW 50000, 'Missing data.', 1; 
	ELSE
		INSERT Artist 		
		VALUES (@artist_type, @artist_fname, @artist_lname, @group_name)
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
    IF ERROR_NUMBER() >= 50000
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
		PRINT 'Message: Row was not inserted.';
		PRINT 'This is a custom error message.';
END CATCH
GO

--execute insert artist procedure
EXEC sp_artist_insert
	@artist_type = 'singer'
	,@artist_fname = ''
	,@artist_lname = ''
	,@group_name =  '';
GO

EXEC sp_artist_insert
	@artist_type = 'singer'
	,@artist_fname = 'Elvis'
	,@artist_lname = 'Pelvis'
	,@group_name =  '';
GO

EXEC sp_artist_insert
	@artist_type = 'band'
	,@artist_fname = ''
	,@artist_lname = ''
	,@group_name =  'Red Hot Chili Peppers';
GO


/***************************
 * Update Artist Procedure *
 ***************************/
IF OBJECT_ID('sp_artist_update') is not null
	DROP PROC sp_artist_update;
GO

CREATE PROC sp_artist_update
	@artist_id  int 
	,@artist_type  varchar(45) null
	,@artist_fname  varchar(45) null
	,@artist_lname  varchar(45) null
	,@group_name  varchar(45) null
AS
BEGIN TRY
	IF EXISTS(SELECT * FROM Artist WHERE artist_id = @artist_id)
		UPDATE Artist  
		SET artist_type = @artist_type
			,artist_fname = @artist_fname
			,artist_lname = @artist_lname
			,group_name = @group_name
		WHERE artist_id = @artist_id;  
	ELSE
		THROW 50001, 'Not a valid artist_id.', 1;
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
    IF ERROR_NUMBER() >= 50000
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
		PRINT 'Message: Row was not updated.';
		PRINT 'This is a custom error message.';
END CATCH
GO

--execute update artist procedure
EXEC sp_artist_update
	@artist_id = '500' --invalid number
	,@artist_type =	'singer' 	
	,@artist_fname	= 'Elvis'
	,@artist_lname	= 'Presley' 
	,@group_name =	''
GO

EXEC sp_artist_update
	@artist_id = '41' --valid number
	,@artist_type =	'singer' 	
	,@artist_fname	= 'Elvis'
	,@artist_lname	= 'Presley' 
	,@group_name =	''
GO

/***************************
 * Delete Artist Procedure *
 ***************************/
IF OBJECT_ID('sp_artist_delete') is not null
	DROP PROC sp_artist_delete;
GO

CREATE PROC sp_artist_delete
	@artist_id  int 
AS
BEGIN TRY
	IF EXISTS(SELECT * FROM Artist WHERE artist_id = @artist_id)
		DELETE Artist
		WHERE artist_id = @artist_id;
	ELSE
		THROW 50001, 'Not a valid artist_id.', 1; 
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
    IF ERROR_NUMBER() >= 50000
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
		PRINT 'Message: Row was not deleted.';
        PRINT 'This is a custom error message.';
END CATCH
GO

--execute delete artist procedure
EXEC sp_artist_delete	
	@artist_id = '4200'  --invalid number
GO

EXEC sp_artist_delete	
	@artist_id = '42'  
GO


/**************************************************************************************************
Step 4: 

Create Insert, Update, and Delete stored procedures for the borrower table. 
	Insert accepts all columns as input parameters except for identity fields.
	Update procedure accepts a primary key value and the borrower’s names for update. 
	Delete accepts a primary key value for delete.

	new borrower to insert: Cruella DeVille, update to: Cruella de Vil, and delete
	borrower_phone: 555-288-8459 (or 555-but-ugly)

Step 6: Script file includes all required ‘GO’ statements.
Step 7: Stored procedures contain error processing (try-catch).
Step 8: Script file includes all execute statements needed to invoke each stored procedure

***************************************************************************************************/

USE disk_inventory_2
GO

--alter table to require first and last names and phone #
ALTER TABLE Borrower
ALTER COLUMN borrower_fname	 varchar(45) not null;

ALTER TABLE Borrower
ALTER COLUMN borrower_lname  varchar(45) not null;

ALTER TABLE Borrower
ALTER COLUMN borrower_phone  varchar(20) not null;


/*****************************
 * Insert Borrower Procedure *
 *****************************/
IF OBJECT_ID('sp_borrower_insert') is not null
	DROP PROC sp_borrower_insert;
GO

CREATE PROC sp_borrower_insert
	@borrower_fname	 varchar(45) 
	,@borrower_lname  varchar(45) 
	,@borrower_phone  varchar(20) 
AS
BEGIN TRY
	IF  @borrower_fname IS NULL OR @borrower_fname = '' OR
		@borrower_lname IS NULL OR @borrower_lname = ''  OR
		@borrower_phone IS NULL OR @borrower_phone = '' 
		THROW 50000, 'Missing data.', 1;
	ELSE
		INSERT Borrower 	
		VALUES (@borrower_fname, @borrower_lname, @borrower_phone)
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
    IF ERROR_NUMBER() >= 50000
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
		PRINT 'Message: Row was not inserted.';
		PRINT 'This is a custom error message.';
END CATCH
GO

--execute insert borrower procedure
EXEC sp_borrower_insert
	@borrower_fname = 'Cruella'
	,@borrower_lname =''	--missing data
	,@borrower_phone = '555-288-8459'	
GO

EXEC sp_borrower_insert
	@borrower_fname = 'Cruella'
	,@borrower_lname ='DeVille'	
	,@borrower_phone = '555-288-8459'	
GO



/*****************************
 * Update Borrower Procedure *
 *****************************/
IF OBJECT_ID('sp_borrower_update') is not null
		DROP PROC sp_borrower_update;
GO

CREATE PROC sp_borrower_update
	@borrower_id int
	,@borrower_fname varchar(45) null
	,@borrower_lname varchar(45) null
	,@borrower_phone varchar(20) null
AS
BEGIN TRY
	IF EXISTS(SELECT * FROM Borrower WHERE borrower_id = @borrower_id)
		UPDATE Borrower 
		SET borrower_fname = @borrower_fname, 
			borrower_lname = @borrower_lname, 
			borrower_phone = @borrower_phone	
		WHERE borrower_id = @borrower_id;  
	ELSE
		THROW 50002, 'Not a valid borrower_id.', 1;
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
    IF ERROR_NUMBER() >= 50000
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
		PRINT 'Message: Row was not updated.';
		PRINT 'This is a custom error message.';
END CATCH
GO

--execute update borrower procedure
EXEC sp_borrower_update
	@borrower_id = '3100'	--invalid number
	,@borrower_fname = 'Cruella'
	,@borrower_lname = 'de Vil'
	,@borrower_phone = '555-288-8459'
GO

EXEC sp_borrower_update
	@borrower_id = '31' 
	,@borrower_fname = 'Cruella'
	,@borrower_lname = 'de Vil'
	,@borrower_phone = '555-288-8459'
GO


/*****************************
 * Delete Borrower Procedure *
 *****************************/
IF OBJECT_ID('sp_borrower_delete') is not null
	DROP PROC sp_borrower_delete;
GO

CREATE PROC sp_borrower_delete
	@borrower_id int 
AS
BEGIN TRY
	IF EXISTS(SELECT * FROM Borrower WHERE borrower_id = @borrower_id)
		DELETE Borrower
		WHERE borrower_id = @borrower_id;
	ELSE
		THROW 50002, 'Not a valid borrower_id.', 1;
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
    IF ERROR_NUMBER() >= 50000
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
		PRINT 'Message: Row was not deleted.';
		PRINT 'This is a custom error message.';
END CATCH
GO

--execute delete borrower procedure
EXEC sp_borrower_delete	
	@borrower_id = '3000'  
GO

EXEC sp_borrower_delete	
	@borrower_id = '29'  
GO



/**************************************************************************************************
Step 5: 

Create Insert, Update, and Delete stored procedures for the disk table. 
	Insert accepts all columns as input parameters except for identity fields. 
	Update procedure accepts a primary key value and the disk information for update. 
	Delete accepts a primary key value for delete.

Step 6: Script file includes all required ‘GO’ statements.
Step 7: Stored procedures contain error processing (try-catch).
Step 8: Script file includes all execute statements needed to invoke each stored procedure

***************************************************************************************************/

USE disk_inventory_2
GO

/**************************
 * Insert Media Procedure *
 **************************/
IF OBJECT_ID('sp_media_insert') is not null
		DROP PROC sp_media_insert;
GO

CREATE PROC sp_media_insert
	@media_name	  varchar(45) 
	,@release_date   varchar(10) 
	,@media_type_id   varchar(10)
	,@genre_id   varchar(10) 
	,@status_code   varchar(10) 
AS
BEGIN TRY
	IF	@media_name	IS NULL OR @media_name	= '' OR
		@release_date IS NULL OR @release_date = '' OR
		@media_type_id IS NULL OR @media_type_id = '' OR
		@genre_id IS NULL OR @genre_id = '' OR
		@status_code IS NULL OR @status_code = ''
		THROW 50000, 'Missing data.', 1;
	ELSE
		INSERT Media	
		VALUES (@media_name, @release_date, @media_type_id, @genre_id, @status_code)
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
    IF ERROR_NUMBER() >= 50000
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
		PRINT 'Message: Row was not inserted.';
		PRINT 'This is a custom error message.';
END CATCH
GO

--execute insert media procedure
EXEC sp_media_insert
	@media_name = 'Ornella Vanoni 1'
	,@release_date = '1973'
	,@media_type_id = '' --missing data
	,@genre_id = 'pop'
	,@status_code = 'IN'
GO

EXEC sp_media_insert
	@media_name = 'Ornella Vanoni 1'
	,@release_date = '1973'
	,@media_type_id = 'CD'
	,@genre_id = 'pop'
	,@status_code = 'IN'
GO


/**************************
 * Update Media Procedure *
 **************************/
IF OBJECT_ID('sp_media_update') is not null
		DROP PROC sp_media_update;
GO

CREATE PROC sp_media_update
	@media_id  int
	,@media_name  varchar(45) 
	,@release_date  varchar(10)
	,@media_type_id  varchar(10)
	,@genre_id  varchar(10)
	,@status_code  varchar(10)
AS
BEGIN TRY
	IF EXISTS(SELECT * FROM Media WHERE media_id = @media_id)
		UPDATE Media
		SET media_name = @media_name 
			,release_date = @release_date  
			,media_type_id = @media_type_id 
			,genre_id = @genre_id  
			,status_code = @status_code 
		WHERE media_id = @media_id
	ELSE
		THROW 50003, 'Not a valid media_id.', 1;
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
    IF ERROR_NUMBER() >= 50000
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
		PRINT 'Message: Row was not updated.';
		PRINT 'This is a custom error message.';
END CATCH
GO

--execute update media procedure
EXEC sp_media_update
	@media_id = '2900' --invalid number
	,@media_name = 'Ornella Vanoni e altre storie'
	,@release_date = '1973'
	,@media_type_id = 'CD'
	,@genre_id = 'pop'
	,@status_code = 'IN'
GO

EXEC sp_media_update
	@media_id = '47'
	,@media_name = 'Ornella Vanoni e altre storie'
	,@release_date = '1973'
	,@media_type_id = 'CD'
	,@genre_id = 'pop'
	,@status_code = 'IN'
GO


/**************************
 * Delete Media Procedure *
 **************************/
IF OBJECT_ID('sp_media_delete') is not null
	DROP PROC sp_media_delete;
GO

CREATE PROC sp_media_delete
	@media_id  int
AS
BEGIN TRY
	IF EXISTS(SELECT * FROM Media WHERE media_id = @media_id)
		DELETE Media
		WHERE media_id = @media_id
	ELSE
		THROW 50003, 'Not a valid media_id.', 1;
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
    IF ERROR_NUMBER() >= 50000
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
		PRINT 'Message: Row was not deleted.';
        PRINT 'This is a custom error message.';
END CATCH
GO

--execute delete media procedure
EXEC sp_media_delete	
	@media_id = '2800'
GO

EXEC sp_media_delete	
	@media_id = '47'
GO


/**************************************************************************************************
	End of Project 5
***************************************************************************************************/