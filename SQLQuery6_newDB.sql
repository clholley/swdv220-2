/****************************************************************
 *  This script creates the database named disk_inventory_2
 *  For SWDV 220 Project 5
 ****************************************************************/

/****************************************************************
 * Date			Programmer		Description
 * 10/18/2018	Cindy Holley	Create disk_inventory_2 database
 ****************************************************************/

USE master
GO

/****** Create Database ****************************************/ 

/****** Object:  Database AP   *********************************/

IF DB_ID('disk_inventory_2') IS NOT NULL
	DROP DATABASE disk_inventory_2
GO

CREATE DATABASE disk_inventory_2
GO 

USE disk_inventory_2;


/****** Create Database Tables   ******************************/ 


/****** Object:  Table  Artist   ****************************/ 

CREATE TABLE Artist (
	artist_id		int not null identity primary key,
	artist_type		varchar(45) null,
	artist_fname	varchar(45) null,
	artist_lname	varchar(45) null,
	group_name		varchar(45) null,
)
GO


/****** Media and 4 tables   ******************************/ 
/****** Object:  Table	MediaType   ***********************/

CREATE TABLE MediaType(
	media_type_id		varchar(10) not null primary key,
	media_description	varchar(100) null,
)
GO

/****** Object:  Table  Genre   ****************************/   

CREATE TABLE Genre (
	genre_id			varchar(10) not null primary key,
	genre_description	varchar(100) null,
)
GO

/****** Object:  Table  Status *****************************/  
 
CREATE TABLE Status (
	status_code			varchar(10) not null primary key,
	status_description	varchar(100) null,
)
GO

/****** Object:  Table	Media *****************************/

--gets data from:  
--MediaType, Genre, Status 

CREATE TABLE Media(
	media_id		int not null identity PRIMARY KEY,
	media_name		varchar(45) not null,
	release_date	varchar(10) not null,

	media_type_id	varchar(10) not null,
	genre_id		varchar(10) not null,
	status_code		varchar(10) not null,

	FOREIGN KEY(media_type_id) references MediaType(media_type_id),
	FOREIGN KEY(genre_id) references Genre(genre_id),
	FOREIGN KEY(status_code) references Status(status_code)
)
GO

/****** Object:  Table  MediaHasArtist **********************/  
 
--gets data from: 
--Artist and Media 

CREATE TABLE MediaHasArtist (
	artist_id		int not null, 
	media_id		int not null,

	PRIMARY KEY(artist_id, media_id),
	FOREIGN KEY(artist_id) references Artist(artist_id),	
	FOREIGN KEY(media_id) references Media(media_id)	
)
GO

/****** Object:  Table  Borrower   *****************************/  

CREATE TABLE Borrower(
	borrower_id		int not null identity primary key,
	borrower_fname	varchar(45),
	borrower_lname	varchar(45),
	borrower_phone	varchar(20)
)
GO

/****** Object:  Table  HasBorrower   *******************************/  

--gets data from:  
--Borrower   

CREATE TABLE HasBorrower (
	borrower_id	int not null,
	checkout_date	datetime not null,
	return_date	datetime not null,
	media_id	int not null,

	PRIMARY KEY (borrower_id, checkout_date, media_id),

	FOREIGN KEY (borrower_id) references Borrower(borrower_id),
	FOREIGN KEY (media_id) references Media(media_id)
)
GO





/*********************************************************************
Date		Programmer		Database		Description
10/18/18	Cindy Holley	disk_inventory	Project 5, recreate tables
**********************************************************************/

/*********************************************************************
Project 3, Part C

Disk table:
1. Insert at least 20 rows of data into the table

**********************************************************************/
USE [disk_inventory_2]
GO

INSERT INTO [dbo].[Genre]
           ([genre_id], [genre_description])
     VALUES
			('classical', 'classical music')
			,('country', 'country music')
			,('folk', 'folk music')
			,('jazz', 'jazz music')
			,('pop', 'pop music')
			,('rb', 'rhythm and blues music')
			,('rock', 'rock music')		   
			,('Sci-Fi', 'Sci-Fi movie')	   
GO

INSERT INTO [dbo].[Status]
           ([status_code], [status_description])
     VALUES
			('IN', 'media is not checked out')
			,('OUT', 'media is checked out')
			,('NA', 'media is not available for check out, may be broken')
GO

INSERT INTO [dbo].[MediaType]
           ([media_type_id], [media_description])
     VALUES
           	('ALBUM', 'music Album')
			,('CD', 'music CD')
           	,('DVD', 'movie DVD')
			,('VHS', 'movie VHS tape')
			,('Sci-Fi', 'Sci-Fi movie')
GO

INSERT INTO [dbo].[Media]
           (--[media_id]
           [media_name],[release_date],[media_type_id],[genre_id],[status_code])
     VALUES
		   ('I Walk the Line','1964', 'ALBUM', 'country', 'IN')
		   ,('Ring of Fire: The Best of Johnny Cash', '1963', 'ALBUM', 'country', 'IN')
		   ,('Ramblin Man', '1954', 'ALBUM', 'country', 'IN')
		   ,('Patsy Clines Golden Hits', '1962', 'ALBUM', 'rock', 'IN')
		   ,('A Hard Days Night', '1964', 'ALBUM', 'rock', 'IN')
		   ,('Good Vibrations', '1966', 'ALBUM', 'rock', 'IN')
		   ,('Yellow Submarine', '1969', 'ALBUM', 'rock', 'IN')
		   ,('Led Zeppelin II', '1969', 'ALBUM', 'rock', 'IN')
		   ,('Eagles', '1972', 'CD', 'rock', 'IN')	
		   ,('Desperado', '1973', 'CD', 'rock', 'IN')				   
		   ,('Waterloo', '1974', 'CD', 'pop', 'IN')
		   ,('ABBA', '1975', 'CD', 'pop', 'IN')
		   ,('A Night at the Opera', '1975', 'ALBUM', 'rock', 'IN')
		   ,('Blondie', '1976', 'ALBUM', 'rock', 'IN')
		   ,('Hotel California', '1978', 'CD', 'pop', 'IN')  
		   ,('Classic Aerosmith', '2002','CD', 'rock', 'IN')	
		   ,('Crying', '1962', 'ALBUM', 'country', 'IN')
		   ,('Oh, Pretty Woman', '1964', 'ALBUM', 'country', 'IN')	   
		   ,('Iron Man 3', '2013', 'DVD', 'Sci-Fi', 'IN')  
		   ,('Thor: The Dark World', '2013', 'DVD', 'Sci-Fi', 'IN') 
		   ,('Guardians of the Galaxy', '2014', 'DVD', 'Sci-Fi', 'IN')
		   ,('Captain America: The Winter Soldier', '2014', 'DVD', 'Sci-Fi', 'IN')
		   ,('Avengers: Age of Ultron', '2015', 'DVD', 'Sci-Fi', 'IN')
		   ,('Captain America: Civil War', '2016', 'DVD', 'Sci-Fi', 'IN')	   
		   ,('Thor: Ragnarok', '2017', 'DVD', 'Sci-Fi', 'IN') 	   
		   ,('Avengers: Infinity War', '2018', 'DVD', 'Sci-Fi', 'IN')
		   ,('Black Panther', '2018', 'DVD', 'Sci-Fi', 'IN')
GO



/*********************************************************************
Project 3, Part D

Borrower table:
1. Insert at least 20 rows of data into the table

**********************************************************************/
USE [disk_inventory_2]
GO

INSERT INTO [dbo].[Borrower]
           ([borrower_fname], [borrower_lname], [borrower_phone])
     VALUES
		('Mickey', 'Mouse', '208-555-1234'),
		('Minnie', 'Mouse', '208-555-1234'),
		('Donald', 'Duck','707-205-6003'),
		('Daisy', 'Duck', '661-275-5570'),
		('Huey', 'Duck', '388-345-8226'),
		('Dewey', 'Duck', '411-683-1892'),
		('Louie', 'Duck', '155-594-4790'),
		('Goofy', 'Canine', '155-594-4792'),
		('Pluto', 'Canine', '934-984-2101'),
		('Clarabelle', 'Cow', '961-048-4901'),
		('Max', 'Goof', '178-749-9379'),
		('Horace', 'Horsecollar', '822-588-8694'),
		('Clara', 'Cluck', '813-651-0187'),
		('Bashful', 'Dwarf', '558-489-6507'),
		('Doc', 'Dwarf', '408-889-0547'),
		('Dopey', 'Dwarf', '506-375-4058'),
		('Grumpy', 'Dwarf', '893-240-1188'),
		('Happy', 'Dwarf', '837-553-4772'),
		('Humbert', 'Huntsman', '168-542-0018'),
		('Sleepy', 'Dwarf', '190-436-6301'),
		('Sneezy', 'Dwarf', '266-531-2468'),
		('Gideon', 'Cat', '624-209-3395'),
		('Jiminy', 'Cricket', '454-303-0398'),
		('Timothy', 'Mouse', '262-596-8897')
GO



/*********************************************************************
Project 3, Part E

Artist table:
1. Insert at least 20 rows of data into the table

**********************************************************************/

USE [disk_inventory_2]
GO

INSERT INTO [dbo].[Artist]
           ([artist_type], [artist_fname], [artist_lname], [group_name])

     VALUES
           	('singer', 'Johnny', 'Cash', '')
			,('singer', 'Hank', 'Williams', '')
			,('singer', 'Roy', 'Orbison', '')
			,('singer', 'Patsy', 'Cline', '')
			,('group', '', '', 'ABBA') 
			,('group', '', ' ', 'Beatles') 
			,('group', '', '', 'Aerosmith')
			,('group', '', '', 'Eagles')
			,('group', '', '', 'Blondie')
			,('group', '', '', 'Led Zeppelin')
			,('group', '', '', 'Queen')
			,('group', '', '', 'The Beach Boys')	
			,('actor', 'Chris', 'Hemsworth', '')
			,('actor', 'Robert', 'Downey Jr', '')
			,('actor', 'Chris', 'Evans', '')
			,('actor', 'Scarlett', 'Johansson', '')
			,('actor', 'Chris', 'Pratt', '')
			,('actor', 'Jeremy', 'Renner', '')
			,('actor', 'Chadwick', 'Boseman', '') 
			,('actor', 'Sebastian', 'Stan', '')
GO



/*********************************************************************
Project 3, Part F

DiskHasBorrower table:
1. Insert at least 20 rows of data into the table
2. Insert at least 2 different disks
3. Insert at least 2 different borrowers
4. At least 1 disk has been borrowed by the same borrower 2 different times
5. At least 1 disk in the disk table does not have a related row here
6. At least 1 disk must have at least 2 different rows here
7. At least 1 borrower in the borrower table does not have a related row here 
8. At least 1 borrower must have at least 2 different rows here


**********************************************************************/

USE [disk_inventory_2]
GO

INSERT INTO [dbo].[HasBorrower]
           ([borrower_id]
           ,[checkout_date]
           ,[return_date]
           ,[media_id])
     VALUES
           --(<borrower_id>,<'checkout_date'>,<'return_date'>,<media_id>)
		   (1, '8/20/2018', '8/30/2018', 18) 
		   ,(2, '8/20/2018', '8/30/2018', 23) 
		   ,(2, '9/1/2018', '9/3/2018', 23) 
		   ,(16, '9/1/2018', '9/3/2018', 20) 
		   ,(9, '9/5/2018', '9/10/2018', 20) 
		   ,(14, '9/5/2018', '9/7/2018', 2) 
		   ,(14, '9/7/2018', '9/9/2018', 16) 
		   ,(14, '9/7/2018', '9/9/2018', 21)
		   ,(15, '9/10/2018', '9/13/2018', 21)
		   ,(17, '9/10/2018', '9/13/2018', 1)
		   ,(18, '9/10/2018', '9/13/2018', 10)
		   ,(19, '9/10/2018', '9/13/2018', 2)
		   ,(20, '9/10/2018', '9/13/2018', 12)
		   ,(15, '10/1/2018', '10/13/2018', 21)
		   ,(3, '10/1/2018', '10/13/2018', 17)
		   ,(4, '10/1/2018', '10/13/2018', 15)
		   ,(5, '10/1/2018', '10/13/2018', 14)
		   ,(6, '10/1/2018', '10/13/2018', 13)
		   ,(7, '10/1/2018', '10/13/2018', 12)
		   ,(12, '10/1/2018', '10/13/2018', 11)
		   ,(2, '10/1/2018', '10/13/2018', 10)
GO



/*********************************************************************
Project 3, Part F

DiskHasArtist table:
1. Insert at least 20 rows of data into the table
2. At least 1 disk must have at least 2 different artist rows here
3. At least 1 artist must have at least 2 different disk rows here
4. Correct variation of disk & artist data similar to DiskHasBorrower

**********************************************************************/

USE [disk_inventory_2]
GO

INSERT INTO [dbo].[MediaHasArtist]
           ([artist_id],[media_id])
     VALUES
           --(<artist_id, int,>,<media_id, int,>)

		    (1, 1)
		   ,(1, 2)
		   ,(2, 3)
		   ,(3, 17)
		   ,(3, 18)
		   ,(4, 4)
		   ,(5, 11)
		   ,(5, 12)
		   ,(6, 5)
		   ,(6, 7)
		   ,(7, 15)
		   ,(7, 16)
		   ,(8, 9)
		   ,(8, 10)
		   ,(9, 14)
		   ,(10, 8)
		   ,(11, 13)
		   ,(12, 6)
		   ,(13, 20)
		   ,(14, 19)
		   ,(15, 22)
		   ,(15, 24)
		   ,(16, 23)
		   ,(17, 21)
		   ,(18, 23)
		   ,(19, 24)
		   ,(20, 22)
GO



/*********************************************************************
Project 3, Part C

Disk table:
2. Update only 1 row using a where clause

**********************************************************************/

USE [disk_inventory_2]
GO

--('I Walk the Line','1964', 'ALBUM', 'country', 'IN')

UPDATE [dbo].[Media]
   SET	release_date = '2014',
		media_type_id = 'CD'
WHERE media_id = 1;



/*********************************************************************
Project 3, Part H

Create a query to list the disks that are on loan and have not been returned.
Sample Output:
Borrower_id Disk_id Borrowed_date			Return_date
9			2		2012-04-02 00:00:00.000 NULL
9			4		2012-04-02 00:00:00.000 NULL


**********************************************************************/

USE [disk_inventory_2]
GO

--alter table column to accept null values
ALTER TABLE HasBorrower
ALTER COLUMN return_date datetime null

--Insert media_id that is currently checked out
INSERT INTO [dbo].[HasBorrower]
           ([borrower_id]
           ,[checkout_date]
           ,[return_date]
           ,[media_id])
     VALUES
		(7, '10/1/2018', '', 22)
		,(12, '10/1/2018', '', 7)
		,(2, '10/1/2018', '', 3)
GO

--query to list the disks that have not been returned.
SELECT *	
FROM [dbo].[HasBorrower]
WHERE return_date is null;





