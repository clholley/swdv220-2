/*********************************************************************
SQLQueryProject3_10.12.18_insertdata.sql (located in Sandbox)
Date		Programmer		Database		Description
10/11/18	Cindy Holley	disk_inventory	Project 3, insert data

**********************************************************************/

/*********************************************************************
Project 3, Part C

Disk table:
1. Insert at least 20 rows of data into the table

**********************************************************************/
USE [disk_inventory]
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
		   ,('A Hard Days Night', '1964', 'ALBUM', 'rock', 'IN')
		   ,('Sgt. Peppers Lonely Hearts Club Band', '1967', 'ALBUM', 'rock', 'IN')
		   ,('Yellow Submarine', '1969', 'ALBUM', 'rock', 'IN')
		   ,('Eagles', '1972', 'CD', 'rock', 'IN')	
		   ,('Desperado', '1973', 'CD', 'rock', 'IN')				   
		   ,('Waterloo', '1974', 'CD', 'pop', 'IN')
		   ,('ABBA', '1975', 'CD', 'pop', 'IN')
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
USE [disk_inventory]
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

USE [disk_inventory]
GO

INSERT INTO [dbo].[Artist]
           ([artist_type], [artist_fname], [artist_lname], [group_name])

     VALUES
           ('singer', 'Johnny', 'Cash', '')
		   ,('singer', 'June', 'Carter-Cash', '')
		   ,('singer', 'Hank', 'Williams', '')
		   ,('singer', 'Roy', 'Orbison', '')
		   ,('singer', 'Agnetha', 'Fältskog', 'ABBA') 
		   ,('singer', 'Anni-Frid', 'Lyngstad', 'ABBA')
		   ,('singer', 'Benny', 'Andersson', 'ABBA') 
		   ,('singer', 'Paul', ' McCartney', 'Beatles') 
		   ,('singer', 'John', ' Lennon', 'Beatles')
		   ,('drummer', 'Ringo', ' Starr', 'Beatles')
		   ,('singer', 'George', ' Harrison', 'Beatles')
		   ,('singer', 'Steven', 'Tyler', 'Aerosmith')
		   ,('guitarist', 'Joe', 'Perry', 'Aerosmith') 
		   ,('singer', 'Don', 'Henley', 'Eagles')
		   ,('singer', 'Glenn', 'Frey', 'Eagles')
		   ,('actor', 'Chris', 'Hemsworth', '')
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
	(There are 21 rows)

2. Insert at least 2 different disks
	(There are 14 different media_id numbers)

3. Insert at least 2 different borrowers
	(There are 16 different borrowers)

4. At least 1 disk has been borrowed by the same borrower 2 different times
	(media_id 23 Black Panther checked out twice by borrower 2)
	(media_id 21 Thor: Ragnarok check out twice by borrower 15)

5. At least 1 disk in the disk table does not have a related row here
	(media_id 3, 4, 5, 6)

6. At least 1 disk must have at least 2 different rows here
	(media_id 20 Captain America: Civil War checked out by borrowers 16 and 9)
	(media_id 21 Thor:Ragnarok checked out by borrowers 14 and 15)

7. At least 1 borrower in the borrower table does not have a related row here 
	(borrowers 8, 10, 11, 22, 23, 24)

8. At least 1 borrower must have at least 2 different rows here
	(borrower 2 borrowed media_id 23 Black Panterh DVD twice and media_id 10 ABBA CD once)
	(borrower 14 borrowed media_id 16 and 21 )

**********************************************************************/

USE [disk_inventory]
GO

INSERT INTO [dbo].[HasBorrower]
           ([borrower_id]
           ,[checkout_date]
           ,[return_date]
           ,[media_id])
     VALUES
           --(<borrower_id>,<'checkout_date'>,<'return_date'>,<media_id>)
		   (1, '8/20/2018', '8/30/2018', 18) --part 2 and 3 
		   ,(2, '8/20/2018', '8/30/2018', 23) --part 2 and 3, part 4 
		   ,(2, '9/1/2018', '9/3/2018', 23) --part 4 same borrower, same disk, 2 diff times
		   ,(16, '9/1/2018', '9/3/2018', 20) --part 6
		   ,(9, '9/5/2018', '9/10/2018', 20) --part 6
		   ,(14, '9/5/2018', '9/7/2018', 2) --part 8
		   ,(14, '9/7/2018', '9/9/2018', 16) --part 8
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
	(There are at least 21 rows)

2. At least 1 disk must have at least 2 different artist rows here
	(media_id 19 Avengers: Age of Ultron stars both 
	   artist_id 18 Robert Downey Jr and artist_id 16 Chris Hemsworth)
	(media_id 20 Captain America: Civil War stars both
	   artist_id 18 Robert Downey Jr and artist_id 21 Chris Pratt)

3. At least 1 artist must have at least 2 different disk rows here
	(18 Robert Downey Jr has 4 media_id)
	(16 Chris Hemsworth has 3 media_id)

4. Correct variation of disk & artist data similar to DiskHasBorrower

**********************************************************************/

USE [disk_inventory]
GO

INSERT INTO [dbo].[MediaHasArtist]
           ([artist_id],[media_id])
     VALUES
           --(<artist_id, int,>,<media_id, int,>)
		   (18, 15)
		   ,(18, 16)
		   ,(18, 19)
		   ,(18, 20)
		   ,(16, 16)
		   ,(16, 19)
		   ,(16, 21)
		   ,(21, 17)
		   ,(21, 20)
		   ,(1, 1)
		   ,(1, 2)
		   ,(4, 13)
		   ,(4, 14)
		   ,(5, 9)
		   ,(5, 10)
		   ,(6, 9)
		   ,(6, 10)
		   ,(7, 10)
		   ,(8, 4)
		   ,(8, 5)
		   ,(8, 6)
GO



/*********************************************************************
Project 3, Part C

Disk table:
2. Update only 1 row using a where clause

**********************************************************************/

USE [disk_inventory]
GO

UPDATE [dbo].[Media]
   SET [media_name] = <media_name, varchar(45),>
      ,[release_date] = <release_date, varchar(10),>
      ,[media_type_id] = <media_type_id, varchar(10),>
      ,[genre_id] = <genre_id, varchar(10),>
      ,[status_code] = <status_code, varchar(10),>
 WHERE <Search Conditions,,>
GO

--('I Walk the Line','1964', 'ALBUM', 'country', 'IN')

UPDATE [dbo].[Media]
   SET	release_date = '2014',
		media_type_id = 'CD'
WHERE media_id = 1;



/*********************************************************************
Project 3, Part D

Borrower table:
2. Delete only 1 row using a where clause

**********************************************************************/

USE [disk_inventory]
GO

DELETE FROM [dbo].[Borrower]
      WHERE borrower_id = 23;



/*********************************************************************
Project 3, Part H

Create a query to list the disks that are on loan and have not been returned.
Sample Output:
Borrower_id Disk_id Borrowed_date Return_date
9 2 2012-04-02 00:00:00.000 NULL
9 4 2012-04-02 00:00:00.000 NULL**********************************************************************/USE [disk_inventory]
GO

--Insert media_id that is currently checked out
INSERT INTO [dbo].[HasBorrower]
           ([borrower_id]
           ,[checkout_date]
           ,[return_date]
           ,[media_id])
     VALUES
           --(<borrower_id>,<'checkout_date'>,<'return_date'>,<media_id>)
			(7, '10/1/2018', '', 22)
		   ,(12, '10/1/2018', '', 7)
		   ,(2, '10/1/2018', '', 3)
GO

--alter table column to accept null values
ALTER TABLE HasBorrower
ALTER COLUMN return_date datetime null

--query to list the disks that have not been returned.
SELECT *	
FROM [dbo].[HasBorrower]
WHERE return_date is null;

