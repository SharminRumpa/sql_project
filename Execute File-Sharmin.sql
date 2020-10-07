USE master;

GO

USE LibraryManagementBD;

GO

SELECT * FROM Author;
SELECT * FROM Faculty;
SELECT * FROM Department;
SELECT * FROM Publisher;
SELECT * FROM Students;
SELECT * FROM Books;
SELECT * FROM IssueingBookDetails;


GO

--- Alter Table IssueingBookDetails------------------------------------------------------------------------------ 

ALTER TABLE IssueingBookDetails  ADD  TotalDuration	 INT;

GO

--- Delect column from table---------------------------------------------------------------------------------------

ALTER TABLE IssueingBookDetails DROP COLUMN TotalDuration;

GO

--- Update ROW------------------------------------------------------------------------------------------

UPDATE Books SET ISBN = '4662-2314-25' WHERE BookID = 34;

GO
--- DELECT ROW------------------------------------------------------------------------------------------

DELETE FROM Students WHERE StudentID = 27;

GO
---15.Justify Index--(IX_Books_BookTitle)------------------------------------
EXEC sp_helpIndex Books; 

GO
---16.Justify Index--(IX_Author)------------------------------------
EXEC Sp_helpindex Author;

GO
---17.Justify Index--(IX_Books_BookID)------------------------------------
EXEC Sp_helpindex BooksCopy;

GO
---18.Justify Index--(sp_All_Index_Information)------------------------------------
EXEC sp_All_Index_Information;


GO
---19.A Read-Only View that Find Out TopBook---------------------------------
SELECT * FROM VW_TopBooks;

GO
---20.A Updateable View Find Out BookTitleWithAuthorName---------------------------------
SELECT * FROM VW_BookTitleWithAuthorName;

----21.A View with Encryption Find Out students--------------------------------------------------------
SELECT * FROM VW_Student;

---A select statment---------------------------------------------------------------------------------

SELECT BookID, BookTitle,ISBN, NoOfPage, RackNo FROM Books ORDER BY BookTitle; 


GO
---A Select statemant that concatenate data---------------------------------------------------------------
SELECT StudentName, Address, ContactNo + '  ' + Email AS FullContactInformation FROM Students;


GO
---A Select statemant that Eliminates duplicate rows-------------------------------------------------------
SELECT DISTINCT ADDRESS FROM Students;


GO
---A Select statemant that Use IN Phrase------------------------------------------------------------------
SELECT * FROM Books WHERE BookID IN (1,2,3,5,8,10);

SELECT * FROM Books WHERE BookID NOT IN (1,2,3,5,8,10);


GO
---A Select statemant that Use BETWEEN Phrase------------------------------------------------------------------
SELECT * FROM IssueingBookDetails WHERE DateofIssue BETWEEN '2016-01-01' AND '2018-12-01';

SELECT * FROM IssueingBookDetails WHERE DateofIssue NOT BETWEEN '2016-01-01' AND '2018-01-01';


GO
---A Join Query that show all the information about Libaray---------------------------------------------

SELECT Books.BookID, Books.BookTitle, Author.AuthorName, Books.ISBN, Books.NoOfPage, Faculty.FacultyID,
		Department.DepartmentName, Students.StudentID, Students.StudentName, Students.AdmissionYear, Students.ContactNo,
		Publisher.PublisherName, Books.PublishYear, Books.RackNo
FROM Books JOIN Author
	ON Books.AuthorID = Author.AuthorID
JOIN Publisher
	ON Publisher.PublisherID = Books.PublisherID
JOIN Students 
	ON Books.DepartmentID = Students.DepartmentID
JOIN Department
	ON Students.DepartmentID = Department.DepartmentID
JOIN Faculty
	ON Faculty.FacultyID = Department.FacultyID
ORDER BY FacultyID;           

---Join Query------------------------------------------------------------------------------------------

SELECT Books.BookID, Books.BookTitle, Author.AuthorName, Department.DepartmentName, Publisher.PublisherName, Books.PublishYear
From Books join Author
	ON Books.AuthorID = Author.AuthorID
JOIN Department
	ON Books.DepartmentID = Department.DepartmentID
JOIN Publisher
	ON Books.PublisherID = Publisher.PublisherID;

GO
---Implicit Join Query----------------------------------------------------------------------------------------------

SELECT Students.StudentID, Students.StudentName, IssueingBookDetails.BookID, Books.BookTitle, 
		IssueingBookDetails.DateOfIssue, IssueingBookDetails.DateOfreceived, IssueingBookDetails.ActualReturnDate
FROM Students, IssueingBookDetails, Books 
		WHERE Students.StudentID = IssueingBookDetails.StudentID
		AND IssueingBookDetails.BookID = Books.BookID
ORDER BY StudentID;



GO
---Outer join Query----------------------------------------------------------------------------------------------------
SELECT AuthorName, Books.BookID, BookTitle FROM Author LEFT JOIN Books ON Author.AuthorID = Books.BookID;


GO
---Union-------------------------------------------------------------------------------------------------------------

SELECT 'Return' AS Status, SerialID, StudentID, BookID, DateOfIssue, ActualReturnDate 
		FROM IssueingBookDetails 
		WHERE DateOfIssue BETWEEN '2018-01-10' AND '2019-01-10'
UNION
		
SELECT 'Not Return' AS Status, SerialID, StudentID, BookID, DateOfIssue, ActualReturnDate 
		FROM IssueingBookDetails 
		WHERE DateOfIssue > '2019-01-15';

GO

---Summary-------------------------------------------------------------------------------------------------------------

SELECT COUNT (*) AS [Number Of Department] FROM Department;


SELECT IssueingBookDetails.BookID, COUNT (StudentID) AS [Total Student], BookTitle 
FROM IssueingBookDetails JOIN Books
	ON IssueingBookDetails.BookID = Books.BookID
GROUP BY IssueingBookDetails.BookID, BookTitle
HAVING COUNT (StudentID) > 1;


GO
----Sub-Query-----------------------------------------------------------------------------------------------------------
SELECT * FROM Books WHERE DepartmentID  IN (SELECT  DISTINCT DepartmentID FROM Books);


GO
----CTE---------------------------------------------------------------------------------------------------------------
WITH CTE1 AS
	(	SELECT COUNT (BookID) AS NumberofBook, IssueingBookDetails.StudentID, StudentName 
		FROM IssueingBookDetails JOIN Students
		ON IssueingBookDetails.StudentID = Students.StudentID
		GROUP BY IssueingBookDetails.StudentID, StudentName
	)
SELECT StudentID, StudentName, NumberofBook FROM CTE1 WHERE NumberofBook = 2;


---22.Justify---Sp_BooksReport-----------------------------------------------
EXEC Sp_BooksReport;

GO
---23.Justufy-----Sp_BookTotal -------------------------------------------------
INSERT Author VALUES ('S. R. Sharmin');


----24.Justify--Scalar-valued Function-- Fn_TotalStudent--------------------------------------------------------------------------------
PRINT 'Total Student: ' + CONVERT(VARCHAR, dbo.Fn_TotalStudent(),1);

GO
----25.Justify - Simple Table-valued Function - Fn_ArtsDepertmentBooks------------------------------------------------------------------------------
SELECT * FROM dbo.Fn_ArtsDepartmentBooks();


GO
---27.Justufy--Tr_StudentDetails--------------------------------------------------------------------

DELETE FROM StudentsCopy
WHERE StudentID =2;

SELECT * FROM StudentArchive;

GO
---28.JUSTIFY--Trigger Statemant-Trg_VerifyStudent---------------
BEGIN TRY
	INSERT INTO Students VALUES ('Sharmin Akter', 'Female', 'Tejgaon', '01688-667864', 'srr@gmail.com', 2, 2014);
END TRY
BEGIN CATCH
	PRINT 'Error No.: '		+ CAST (@@ERROR AS VARCHAR);
	PRINT 'Error Message: ' + ERROR_MESSAGE();
	PRINT 'Severity: '		+ CAST (ERROR_SEVERITY() AS VARCHAR);
END CATCH;



GO
---29.Transaction that Rollback--------------------------------------------------------------------------------
DECLARE @DepartmentID INT;
BEGIN TRY
	BEGIN TRAN;
		INSERT INTO Depertment VALUES ('English', 5);
		SET @DepartmentID = @@IDENTITY;
	COMMIT TRAN;
END TRY
BEGIN CATCH
	ROLLBACK TRAN;
END CATCH;

GO
---30. A script that performs a test before commmitting Transaction
BEGIN TRAN;
	DELETE Department WHERE FacultyID = 3;
IF @@ROWCOUNT > 1
	BEGIN
		ROLLBACK TRAN;
		PRINT 'More deperetment than expected. Deletion rolled back.';
	END;
ELSE
	BEGIN
		COMMIT TRAN;
		PRINT 'Deletions committed to the database.';
	END;


---A Transaction with Save Points------------------------------------------------------------------------
GO
IF OBJECT_ID ('tempdb..#FacultyCopy') IS NOT NULL
	DROP TABLE tempdb.. #FacultyCopy;

SELECT FacultyID, FacultyName INTO #FacultyCopy FROM Faculty WHERE FacultyID <= 3;

BEGIN TRAN;
	DELETE #FacultyCopy WHERE FacultyID = 1;
	SAVE TRAN Faculty1;

	DELETE #FacultyCopy WHERE FacultyID = 2;
	SAVE TRAN Faculty2;
	SELECT * FROM #FacultyCopy;

	DELETE #FacultyCopy WHERE FacultyID = 3;
	SAVE TRAN Faculty3;
	SELECT * FROM #FacultyCopy;

	ROLLBACK TRAN Faculty2;
	SELECT * FROM #FacultyCopy;

	ROLLBACK TRAN Faculty1;
	SELECT * FROM #FacultyCopy;
COMMIT TRAN;
SELECT * FROM #FacultyCopy;


----------------------------------------------------End-----------------------------------------------------------------