/**************************************************************************************************
	SDWV 220 PROJECT 4: T-SQL using disk_inventory_2

	DATE		PROGRAMMER		DATABASE			DESCRIPTION

	10/19/18	Cindy Holley	disk_inventory_2	Create new db and tables with data	
	10/19/18	Cindy Holley	disk_inventory_2	Project 4, create T-SQL queries
	10/25/18	Cindy Holley	disk_inventory_2	Project 4, add column name aliases 

***************************************************************************************************/

/**************************************************************************************************
Step 1:  
Document each SQL statement – what it is supposed to do. 
Include a modification log.


Step 2: 
If structure changes are needed to the tables from Project 2, 
include the code at the beginning of your script & document.

NOTE:  I created a new database called disk_inventory_2. I had to change about 3 tables and
change some data types from NOT NULL. I was afraid that changing only part of the database
might somehow mess up other parts of the database that use those tables. I was worried about 
the "unintended consequences" that tend to pop up when you change one tiny little thing
and forget about the effect that will ripple through and create chaos elsewhere.

I was afraid to delete disk_inventory at this time in case I screwed up on disk_inventory_2. 

***************************************************************************************************/

/**************************************************************************************************
Step 3: 

Show the disks in your database and any associated Individual artists only. 
Sort by Artist Last Name, First Name & Disk Name.

Sample Output:
Disk Name			Release Date	Artist First Name	Artist Last Name
Home				2004-11-19		Chris				Daughtry
Jagged Little Pill	1995-04-09		Alanis				Morrisette
Blizzard of Oz		1981-09-28		Ozzy				Osborne
No More Tears		1991-11-11		Ozzy				Osborne
Red					2011-9-24		Taylor				Swift

My output returned 15 rows.

***************************************************************************************************/

USE disk_inventory_2
GO

SELECT media_name, release_date, artist_fname, artist_lname
FROM Media
	JOIN MediaHasArtist	
		ON Media.media_id = MediaHasArtist.media_id
	JOIN Artist
		ON MediaHasArtist.artist_id = Artist.artist_id
WHERE artist_fname != ''
ORDER BY artist_lname, artist_fname, media_name



/**************************************************************************************************
Step 4: 

Create a view called View_Individual_Artist that shows the artists’ names and not group names.

Sample Output:
FirstName	LastName
Ozzy		Osbourne
Willie		Nelson
Taylor		Swift
Alanis		Morrisette
Patsy		Cline

My output returned 12 rows. The other 8 rows in the Artist table are groups

NOTE:  I added the artist_id into the View_Individual_Artist 
because I STILL could not figure out how to do Step 5 even 
after recreating the Artist table.

***************************************************************************************************/

USE disk_inventory_2
GO

CREATE VIEW View_Individual_Artist
AS
SELECT artist_id AS 'Artist ID', artist_fname AS 'First Name', artist_lname AS 'Last Name'
FROM Artist
WHERE artist_fname != ''
GO
SELECT * FROM View_Individual_Artist   
GO 




/**************************************************************************************************
Step 5: 

Show the disks in your database and any associated Group artists only. 
Use the View_Individual_Artist view. (Not Exists or Outer Join)
Sort by Group Name & Disk Name.

Sample Output:
Disk Name									Release Date	Group Name
Blender										1993-04-09		Collective Soul
Hints, Allegations, and Things Left Unsaid	1995-12-12		Collective Soul
Paranoic									1970-05-01		Black Sabbath
Hotel California							1985-07-09		The Eagles
One of These Nights							1977-04-09		The Eagles
The Long Run								1984-03-03		The Eagles

I created two queries, both show the same 12 rows. 

I had to go back to Step 4 and add the artist_id because I could not figure 
out how to write the WHERE clause stating that something was in the 
Artist table but not in the View_Individual_Artist without a common
denominator. 

(I counted up the media names in the Media table that were put out by groups
and got 12 rows as well so I believe this is finally the correct number.)

***************************************************************************************************/

USE disk_inventory_2
GO

--simple query that shows only the groups 
SELECT media_name AS 'Disk Name', release_date AS 'Release Date', group_name AS 'Group Name'
FROM Media
	JOIN MediaHasArtist	
		ON Media.media_id = MediaHasArtist.media_id
	JOIN Artist
		ON MediaHasArtist.artist_id = Artist.artist_id
WHERE group_name != ''	  	--12 rows
ORDER BY group_name, media_name
GO 


/*
--alternate using a NOT IN clause
Generates error:  "Msg 116, Level 16, State 1, Line 153
Only one expression can be specified in the select list when the subquery is not introduced with EXISTS."

SELECT media_name AS 'Disk Name', release_date AS 'Release Date', group_name AS 'Group Name'
FROM Media
	JOIN MediaHasArtist	
		ON Media.media_id = MediaHasArtist.media_id
	JOIN Artist
		ON MediaHasArtist.artist_id = Artist.artist_id
WHERE MediaHasArtist.artist_id NOT IN
	(SELECT *
	FROM View_Individual_Artist)
ORDER BY group_name, media_name
GO  
*/



/**************************************************************************************************
Step 6:

Show which disks have been borrowed and who borrowed them. Sort by Borrower’s Last Name.

Sample Output:
First	Last		Disk Name
Jiminy	Cricket		Human Clay
Donald	Duck		Red
Donald	Duck		Hints, Allegations, and Things Left Unsaid

My output returned 24 rows. 

***************************************************************************************************/

USE disk_inventory_2
GO

SELECT borrower_fname AS 'First', borrower_lname AS 'Last', media_name AS 'Disk Name'
FROM Borrower
	JOIN HasBorrower	
		ON Borrower.borrower_id = HasBorrower.borrower_id
	JOIN Media	
		ON HasBorrower.media_id = Media.media_id
ORDER BY borrower_lname
GO



/**************************************************************************************************
Step 7:
In disk_id order, show the number of times each disk has been borrowed.

Sample Output:
DiskId	Disk Name			Times Borrowed
2		No More Tears		4
3		Red					3
4		Jagged Little Pill	8

My output has 17 rows.
 
7 disks have been borrowed multiple times, 
10 rows borrowed only once.

***************************************************************************************************/

USE disk_inventory_2
GO

SELECT Media.media_id AS 'Disk ID', media_name AS 'Disk Name', COUNT(checkout_date) as 'Times Borrowed'
FROM Media
	JOIN HasBorrower	
	ON HasBorrower.media_id = Media.media_id

GROUP BY Media.media_id, Media.media_name
ORDER BY Media.media_id



/**************************************************************************************************
Step 8: 
Show the disks outstanding or on-loan and who has each disk. Sort by disk name.

Sample Output:
Disk Name									Borrowed	Returned	Last Name
Hints, Allegations, and Things Left Unsaid	2012-04-02	NULL		Fudd
Jagged Little Pill							2012-04-02	NULL		Fudd

My output returns 3 rows.

***************************************************************************************************/

USE disk_inventory_2
GO

SELECT media_name AS 'Disk Name', checkout_date AS 'Borrowed', return_date AS 'Returned', borrower_lname AS 'Last Name'
FROM Media
	JOIN HasBorrower
	ON Media.media_id = HasBorrower.media_id
	JOIN Borrower
	ON HasBorrower.borrower_id = Borrower.borrower_id
WHERE return_date IS NULL
ORDER BY Media.media_name
GO
