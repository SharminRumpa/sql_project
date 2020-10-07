--- Object: Database 'LibraryManagementBD' -------------

GO
USE master;
GO
If DB_ID ('LibraryManagementBD') IS NOT NULL DROP DATABASE LibraryManagementBD;

GO

CREATE DATABASE LibraryManagementBD
	ON (
			NAME			=	LibraryManagementBD_data,
			FILENAME		=	'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\LibraryManagementBD_data.mdf',
			SIZE			=	10mb,
			MAXSIZE			=	50mb,
			FILEGROWTH		=	5mb)
LOG ON (
			NAME			=	LibraryManagementBD_log,
			FILENAME		=	'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\LibraryManagementBD_log.ldf',
			SIZE			=	5mb,
			MAXSIZE			=	25mb,
			FILEGROWTH		=	2mb);

GO
USE LibraryManagementBD;


GO
---1. Table Author ------------------------------------------------------------------------------------

CREATE TABLE Author (	  AuthorID			INT				IDENTITY		PRIMARY KEY,
						  AuthorName		VARCHAR(50)		NOT NULL);


GO
---2. Table FACULTY ------------------------------------------------------------------------------------

CREATE TABLE Faculty (    FacultyID			INT				IDENTITY		PRIMARY KEY,
						  FacultyName		VARCHAR(20)		NOT NULL);


						
GO
---3. Table Depertment --------------------------------------------------------------------------------

CREATE TABLE Department ( DepartmentID		INT				IDENTITY		PRIMARY KEY,
						  DepartmentName	VARCHAR(20)		NOT NULL,
						  FacultyID			INT				REFERENCES		Faculty (FacultyID));


GO
---4. Table Publisher ---------------------------------------------------------------------------------

CREATE TABLE Publisher ( PublisherID		INT				IDENTITY		PRIMARY KEY,
						 PublisherName		VARCHAR(30)		NOT NULL);


GO
---5. Table  Students ---------------------------------------------------------------------------------

CREATE TABLE Students (	 StudentID			INT				IDENTITY		PRIMARY KEY,
						 StudentName		VARCHAR (30)	NOT NULL,
						 Gender				VARCHAR(10)		NOT NULL,
						 [Address]			VARCHAR (50)	NOT NULL,
						 ContactNo			VARCHAR(15)		NOT NULL,
						 Email				VARCHAR(30)		NOT NULL,
						 DepartmentID		INT				REFERENCES		Department (DepartmentID),
						 AdmissionYear		INT				NOT NULL);

							
GO
---6. Table Books -------------------------------------------------------------------------------------

CREATE TABLE Books (	BookID				INT				IDENTITY		PRIMARY KEY,
						BookTitle			VARCHAR(100),
						ISBN				VARCHAR(20),
						AuthorID			INT				REFERENCES		Author (AuthorID),
						DepartmentID		INT				REFERENCES		Department (DepartmentID),
						NoOfPage			INT,
						PublisherID			INT				REFERENCES		Publisher(PublisherID),
						PublishYear			INT	,
						RackNo				INT	);


GO
---7.Table IssueingBookDetails--------------------------------------------------------------------------------------
				
CREATE TABLE IssueingBookDetails (
						SerialID			INT				IDENTITY		PRIMARY KEY,
						StudentID			INT				REFERENCES		Students (StudentID),
						BookID				INT				REFERENCES		Books (BookID),
						DateofIssue			DATE,
						DateofReceived 		DATE,  
						ActualReturnDate	VARCHAR(30));



GO
---8. Insert raw into Author Table-----------------------------------------------------------------------------------

INSERT INTO Author		VALUES		('G.B.Shaw'),				('William Shakespere'),			('Rabindranath Tagor'), 
									('F W Taylor'),				('Toni Morrison'),				('Aliki Greenwillow'), 
									('Kazi Nazrul Islam'),		('Ahsan Habib'),				('Enlert'),
									('Arnosky'),('Grey Egan'),	('Linus Pauling'),				('Jonathan Clayden'), 
									('Charles E. Menifield'),	('Boldt, Mike'),				('Stills Caroline'), 
									('Charless T. Harnogren'),	('Jerry J. Keygandt'),			('Ray H. Garrison'), 
									('Joan Magretta'),			('Richard Templar'),			('M. S. Longarir'), 
									('Jearle Walkerr'),			('Robert S. Witte & John E. Wittte'), ('Reaz Simbar'),
									('James T. Macclave'),		('Jeo Pullizzi'),				('Michacl Proter'), 
									('Eugene F.Brigham'),		('Tariq Jalil');


GO
---9. Insert raw into Faculty Table---------------------------------------------------------------------------------------

INSERT INTO Faculty		 VALUES		('Arts'), ('Science'), ('Business Studies');


Go
---10. Insert row into Depertment Table------------------------------------------------------------------------------------

INSERT INTO Department	 VALUES		('Islamic Studes', 1 ),		('Physics', 2),					('Bengali', 1),		
									('English', 1),				('Management', 3),				('Accounting', 3),	
									('Marketing', 3),			('Methmates', 2),				('Finance', 3),				
									('Chemistry', 2),			('Staticstics', 2),				('History', 1) ;


Go
---11. Insert row into Publisher Table--------------------------------------------------------------------------------------------

INSERT INTO Publisher	VALUES		('Somoy Prokashon'),		('Agamee Prakshani'),			('Lyall Publication'), 
									('Anyaprokash'),			('Kakoli Prokashoni'),			('Clarlon Books'), 
									('Lippincott'),				('Oboshor'),					('Shahity Prakash'),
									('Anupam Prokashoni'),		('Shuchipotro');



GO
---12. Insert row into Students Table-------------------------------------------------------------------------------------------------

INSERT INTO Students VALUES			('Sharmin Akter',	 'Female', 'AdamjeeNagar, Narayanganj', '01688-656198', 'SR@gmail.com', 2, 2014),
									('Jewel Rana',		 'Male', 'Puran Dhaka',		'01678-656198',	 'jw@gmail.com', 1, 2015),
									('Israt Jahan',		'Female', 'Barishal',		'01777-656198',	 'IJ@gmail.com', 3, 2014),
									('Kawser Ahmed',	 'Male', 'PoltonD haka',	'01778-656198',		'KA@gmail.com', 4, 2018),
									('Benojir Khanom',	 'FeMale', 'Kararigonj Dhaka', '01778-756198', 'BK@gmail.com', 5, 2013),
									('Md. Akram Hossain', 'Male', 'Dhandmondi Dhaka', '01668-656198', 'AH@gmail.com', 6, 2018),
									('Ala Uddin',		 'Male', 'Sadorghat Dhaka', '01878-656198', 'AU@gmail.com', 9, 2015),
									('Rokey Akter',		 'FeMale', 'Meghna Sonarga', '01818-656198', 'RK@gmail.com', 11, 2014),
									('Robiul Hossain',	 'Male', 'Gulistan Dhaka', '01678-656198',	 'RH@gmail.com', 8, 2018),
									('Md. Imarn Hossain', 'Male', 'Sonarga',		'01678-656198',	 'IH@gmail.com', 12, 2019),
									('Sharmin Rumpa',	  'FeMale', 'Narayanganj', '01558-656198',	'SR2@gmail.com', 9, 2019),
									('Ariful Islam',	'Male', 'Dhaka',			'01638-656198',	 'AI@gmail.com', 10, 2017),
									('Masud Hossain',	'Male', 'Mirpur',			'01678-655198', 'MH@gmail.com', 2, 2019),
									('Farjana Akter',	 'FeMale', 'Farmgate Dhaka', '01678-366198', 'FA@gmail.com', 7, 2016),
									('Md.Sakil Ahmed',	 'Male', 'Mirpur Dhaka',	'01678-655198', 'SH@gmail.com', 3, 2017),
									('Hasan Sharif',	'Male', 'Mirpur Dhaka',		'01828-656198', 'SHO@gmail.com', 4, 2016),
									('Md.Ala Uddin',	'Male', 'Dhaka',			'01928-656198', 'MAU@gmail.com', 1, 2015),
									('Sharmin Rupa',	'FeMale', 'Barishel',	 '01558-656198',	'SSR@gmail.com', 2, 2014),
									('Rafiqul Islam',	 'Male', 'Khulna',		 '01718-656198',	'RI@gmail.com', 1, 2014),
									('Sathee Parven',	'FeMale', 'Dhaka',		 '01958-656198',	 'SP@gmail.com', 4, 2018),
									('Liza Akter',		'FeMale', 'Karaniganj Dhaka', '01688-656167', 'LA@gmail.com', 12, 2018),
									('Obaidur Rahman', 'Male', 'Puran Dhaka',		'01678-656134', 'OB@gmail.com', 11, 2019),
									('Israt Munny',		'FeMale', 'Cumilla',		'01678-656145', 'IM@gmail.com', 6, 2017),
									('Shamim Ahamed',	 'Male', 'Feni',		'01678-656156',		'SHH@gmail.com', 5, 2017),
									('Aysha Bugum',		'FeMale', 'Chittagong', '01678-656145',		'AB@gmail.com', 1, 2015),
									('Jubayer Ahmed',	'Male', 'Barguna',		'01678-656134',		'JA@gmail.com', 3, 2016),
									('Jubaer Ahmed',	'Male', 'Bakergonj',	'01778-656134',		'JA@gmail.com', 3, 2018);

									 
GO
----13. Insert row into Books Table ----------------------------------------------------------------------------------------------

INSERT INTO Books	 VALUES			('The Bluest Eye', 'O-671-854216', 5, 12, 230, 7, 1965, 4),	
									('Major Barbara', '1-875-2545-5', 1, 12, 200, 7, 1986, 4),
									('Mrityukshuda', 'O-688-1433-4', 7, 3, 150, 1, 1890, 3), 
									('She Stoop', 'O-525-67520-5', 2, 4, 290, 4, 1949, 2),
									('Color Farm', 'O-14-0505867', 12, 8, 150, 6, 1990, 7),
									('Cast Account','Q-15-S788', 14, 6, 300, 7, 1850, 1),
									('Agni Bani', 'O-14-0125867', 7, 3, 290, 10, 1922, 3),
									('Ratri Shesh', 'O-14-11205867', 8, 3,300, 5, 1930, 3),
									('What Management Is', 'F-2154-2215', 20, 5, 310, 8, 1800, 5),
									('Theretical concept in physics', '1255-36598-89', 22, 2, 260, 11, 1985, 6),
									('Permutation city', '58-25256-85', 11, 2, 310,  1, 1997, 6), 
									('General Chemistry', '123-35353-62', 12, 10, 190, 4, 1899, 8), 
									('Financial Management', 'O-12535-55', 29, 9, 340, 2, 1657, 9),
									('Epic Content Marketing', 'E-1269877', 27, 7, 400, 3, 1985, 10),	
									('Basic Principal of Marketing', 'B-3695478', 28, 7, 290, 9, 1975, 10),
									('Introduction to Islam and Islamic Dawah', 'I-1568795', 30, 1, 170, 10, 1996, 11),
									('The Basis of Public Budgeting and Financial Management', 'F-98756412', 14, 9, 410, 2, 1920, 9),
									('Noukadubi','122365448', 3, 3, 120, 2, 1954, 3),
									('Hello! Good-bye', 'X-3548-9654', 6, 4, 150, 6, 1984, 2),
									('Mouse shapes', 'X-2544-8594', 18, 8, 290, 10, 1979, 7),
									('123 Versur Abc', '45854654', 15, 8, 190, 11, 1895, 7),
									('Pricipal of Account', 'A-2356-9658', 18, 6, 340, 10, 1925, 1),
									('You never can tell', '5684-4568-52', 1, 4, 200, 9, 1969, 2), 
									('Midsummer nights Dream', 'A-4254-36589', 2, 4, 270, 7, 1988, 2),
									('The Economist Guid to Financial Managemant', 'E-12348797', 20, 9, 290, 8, 1955, 9),
									('International Relation in Islam', '12456987', 25, 1, 410, 8, 1750, 11),
									('Staticstics 10th Edition', 'S-35469-89', 24, 11, 310, 5, 1999, 12),
									('Statistics for Business and Economies', '123654-587-458', 26, 11, 280, 5, 1940, 12),
									('Principal of Management', '475-5686-5446', 4, 5, 255, 6, 2015, 5), 
									('The Rules of Management', '125-86457-65', 21, 5, 240,  1, 2013, 5), 
									('The Flying Circus of Physics', '1257-3598-58', 23, 2, 184,  2, 2017, 6), 
									('Organic Chemistry', '258-1585-84', 13, 10, 201, 2, 1858, 8), 
									('Managerial Accounting', '258-6497-74', 19, 6, 201, 3, 2008, 1), 
									('Financial Accounting', '46564-678945-58', 18, 6, 148, 4, 1974, 1),
									('Statistics for Business and Economies', '5468-785525-52', 26, 11, 154, 10, 1995, 12);


GO
---14. Insert row into IssueingBookDetails Table -------------------------------------------------------------------------------------------------

INSERT INTO IssueingBookDetails VALUES  (5, 30, '2014-01-10', '2014-01-15', '2014-01-14');

INSERT INTO IssueingBookDetails VALUES  (3, 3, '2014-01-10', '2014-01-15', '2014-01-16'),		(8, 27, '2014-05-10', '2014-05-20', '2014-05-14'),
										(1, 10, '2014-05-10', '2014-05-25', '2014-05-27'),		(7, 13, '2014-06-1', '2014-06-10', '2014-06-14'),
										(1, 31, '2014-07-15', '2014-07-20', '2014-07-20'),		(19, 26, '2014-12-10', '2014-12-15', '2014-12-15'),
										(25, 16, '2015-01-01', '2015-01-10', '2015-01-10'),		(2, 26, '2015-01-10', '2015-01-20', '2015-01-15'),
										(26, 8, '2016-04-11', '2016-04-22', '2016-04-20'),		(16, 13, '2016-09-20', '2016-09-30', '2016-09-25'),
										(9, 5, '2018-02-20',  '2018-02-25', '2018-02-25'),		(4, 19,'2018-05-10', '2018-05-15', '2018-05-14'),
										(6, 22, '2018-01-10', '2018-01-15', '2018-01-14'),		(6, 33, '2018-01-10', '2018-01-15', '2018-01-14'),
										(4, 24, '2018-11-25', '2018-12-05', '2018-12-05'),		(20, 23, '2018-12-25', '2019-01-05', '2019-01-05'),
										(10, 1, '2019-01-5',  '2019-01-15', '2019-01-14'),		(13, 11,'2019-01-10', '2019-01-15', '2019-01-15' ),
										(22, 35, '2019-07-10', '2019-07-25', 'Not Back Yet'),	(10, 2, '2019-07-20', '2019-07-30', 'Not Back Yet');


										
GO
---15. Create index on the table --------------------------------------------------------------------------------------------------------

CREATE INDEX IX_Books_BookTitle ON Books (BookTitle);


GO
---16.Create Non-Clustered Index------------------------------------------------------------------------------------------

CREATE NONCLUSTERED INDEX IX_Author ON Author (AuthorID, AuthorName);



GO
---17.Create Non-Clustered Index------------------------------------------------------------------------------------------

SELECT BookID, BookTitle, ISBN INTO BooksCopy FROM Books;

CREATE CLUSTERED INDEX IX_Books_BookID ON  BooksCopy (BookID);


GO
---18. Create Procedure that show the all information about Index
CREATE PROC Sp_All_Index_Information
AS
SELECT 
     TableName	=	t.name,
     IndexName	=	ind.name,
     IndexId	=	ind.index_id,
     ColumnId	=	ic.index_column_id,
     ColumnName =	col.name,
     ind.*,
     ic.*,
     col.* 
FROM 
     sys.indexes ind 
INNER JOIN 
     sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
INNER JOIN 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN 
     sys.tables t ON ind.object_id = t.object_id 
WHERE 
	 t.is_ms_shipped = 0 
ORDER BY 
     t.name, ind.name, ind.index_id, ic.index_column_id;


GO
---19.CRAETE Read-Only View-----------------------------------------------------------------------------

CREATE VIEW VW_TopBooks AS
	SELECT TOP 20 PERCENT BookID, BookTitle, ISBN, NoOfPage, PublishYear FROM Books ORDER BY BookID;


GO
---20.Create Updateable View-----------------------------------------------------------------------------

CREATE VIEW VW_BookTitleWithAuthorName AS
	SELECT  BookID, BookTitle, AuthorName, ISBN, NoOfPage, PublishYear 
	FROM Books JOIN Author ON Books.AuthorID = Author.AuthorID;


GO
---21.Create View with Encryption, Schemabinding---------------------------------------------------------

CREATE VIEW VW_Student WITH ENCRYPTION AS
	SELECT StudentID, StudentName, Gender, Address, ContactNo, Email, AdmissionYear FROM Students; 

GO

---22.Create Stored Procedures---------------------------------------------------------------------------

CREATE PROC Sp_BooksReport AS
SELECT  BookID, BookTitle, AuthorName, ISBN, NoOfPage, PublishYear 
FROM Books JOIN Author ON Books.AuthorID = Author.AuthorID
WHERE BookID <= 10;



GO
----23.Create Stored Procedures- Use Input & OutPut Paramiters---------------------------------------------

CREATE PROC Sp_BookTotal 
		@BookTitle	VARCHAR(50), @BookTotal		INT OUTPUT
AS
SELECT @BookTotal = COUNT (BookID) FROM Books WHERE BookTitle >= @BookTitle;


GO
---24.Create Scalar-valued Function-------------------------------------------------------------------------

CREATE FUNCTION Fn_TotalStudent()
RETURNS INT
BEGIN
	RETURN (SELECT COUNT(*) FROM Students);
END;



GO 
---25.Create Simple Table-valued Function-------------------------------------------------------------------------
CREATE FUNCTION Fn_ArtsDepartmentBooks()
RETURNS TABLE
AS
RETURN
		(SELECT BookID, BookTitle, ISBN, NoOfPage, PublishYear, Department.DepartmentName, Faculty.FacultyName
		FROM Books JOIN Department ON Books.DepartmentID = Department.DepartmentID
		JOIN Faculty ON Department.FacultyID = Faculty.FacultyID
		WHERE Faculty.FacultyID = 1);


GO
---26.Create Trigger Statemant----After Trigger Insert, Update----------------------------------------------------
CREATE TRIGGER Trg_Author_Insert_Update
	ON Author
	AFTER INSERT, UPDATE
AS
	UPDATE Author SET AuthorName = UPPER(AuthorName) WHERE AuthorID IN (SELECT AuthorID FROM inserted);


GO
---27.Create Trigger Statemant----After Trigger Deleted------------------------------------------------------------

SELECT	StudentID, StudentName, Address, ContactNo, Email INTO StudentsCopy FROM Students;

CREATE TABLE StudentArchive (
							StudentID		INT,
							StudentName		VARCHAR(30),
							Address			VARCHAR(50),
							ContactNo		VARCHAR(20),
							Email			VARCHAR(30));
GO

CREATE TRIGGER Tr_StudentDetails
ON StudentsCopy
AFTER DELETE 
AS 
	INSERT INTO StudentArchive (StudentID, StudentName, Address, ContactNo, Email)
	SELECT	StudentID, StudentName, Address, ContactNo, Email FROM deleted;




GO
---28.Create Trigger Statemant----Instead Trigger------------------------------------------------------------

CREATE TRIGGER Trg_VerifyStudent
	ON Students
	INSTEAD OF INSERT
AS
IF EXISTS 
		(SELECT * FROM Students WHERE StudentName = (SELECT StudentName FROM inserted)
		AND Gender = (SELECT Gender FROM inserted))
		THROW 50016, 'Student already exists!', 1;
ELSE
	INSERT INTO Students SELECT StudentName, Gender, Address, ContactNo, Email, DepartmentID, AdmissionYear FROM inserted;



------------------------------------------------------END-----------------------------------------------------------------------

