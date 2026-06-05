use  project01;
CREATE TABLE Books(
book_id INT PRIMARY KEY,
title VARCHAR(100),
author VARCHAR(100),
category VARCHAR(50),
available_copies INT
);

CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    join_date DATE
);

CREATE TABLE Issued_Books (
    issue_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    issue_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

INSERT INTO Books VALUES
(1,'Database Systems','Korth','Education',5),
(2,'Python Programming','Mark Lutz','Programming',4),
(3,'AI Basics','John Smith','Technology',3),
(4,'Web Development','David Miller','Programming',6),
(5,'Data Science','Andrew Ng','Technology',2);

INSERT INTO Members VALUES
(101,'Raju','raju@gmail.com','2025-01-15'),
(102,'Rahul Sharma','rahul@gmail.com','2025-02-10'),
(103,'Priya Gupta','priya@gmail.com','2025-03-05');

INSERT INTO Issued_Books VALUES
(1,1,101,'2025-04-01','2025-04-10'),
(2,2,102,'2025-04-03','2025-04-12'),
(3,3,103,'2025-04-05','2025-04-15');

SELECT * FROM Books;

SELECT * FROM Members;

SELECT * FROM Issued_Books;

use project01

SELECT * FROM Books;

SELECT * FROM Members;

SELECT * FROM Issued_Books;

SELECT * FROM Books
WHERE category='Programming';

UPDATE Books
SET available_copies=3
WHERE book_id=2;

-- DELETE FROM Books
-- WHERE book_id=5;

SELECT * FROM Books
ORDER BY title ASC;

SELECT COUNT(*) AS TotalBooks
FROM Books;

SELECT AVG(available_copies)
FROM Books;

SELECT MAX(available_copies)
FROM Books;

SELECT MIN(available_copies)
FROM Books;

SELECT SUM(available_copies)
FROM Books;

SELECT category, COUNT(*) AS TotalBooks
FROM Books
GROUP BY category;

SELECT category, COUNT(*)
FROM Books
GROUP BY category
HAVING COUNT(*) > 1;

SELECT
m.name,
b.title,
i.issue_date
FROM Members m
INNER JOIN Issued_Books i
ON m.member_id=i.member_id
INNER JOIN Books b
ON b.book_id=i.book_id;


SELECT
m.name,
i.issue_id
FROM Members m
LEFT JOIN Issued_Books i
ON m.member_id=i.member_id;

SELECT
m.name,
i.issue_id
FROM Members m
RIGHT JOIN Issued_Books i
ON m.member_id=i.member_id;

SELECT title
FROM Books
WHERE book_id IN
(
SELECT book_id
FROM Issued_Books
);

SELECT *
FROM Members m
WHERE EXISTS
(
SELECT *
FROM Issued_Books i
WHERE i.member_id=m.member_id
);

CREATE VIEW Library_Report AS
SELECT
m.name,
b.title,
i.issue_date
FROM Members m
JOIN Issued_Books i
ON m.member_id=i.member_id
JOIN Books b
ON b.book_id=i.book_id;

SELECT * FROM Library_Report;

CREATE INDEX idx_book_title
ON Books(title);

DELIMITER //

CREATE PROCEDURE ShowBooks()
BEGIN
SELECT * FROM Books;
END //

DELIMITER ;

CALL ShowBooks();

DELIMITER //

CREATE TRIGGER UpdateCopies
AFTER INSERT ON Issued_Books
FOR EACH ROW
BEGIN
UPDATE Books
SET available_copies = available_copies - 1
WHERE book_id = NEW.book_id;
END //

DELIMITER ;

START TRANSACTION;

UPDATE Books
SET available_copies = available_copies - 1
WHERE book_id = 1;

COMMIT;

START TRANSACTION;

UPDATE Books
SET available_copies = available_copies - 5
WHERE book_id = 1;

ROLLBACK;

SELECT * from books;
SELECT * from members;

UPDATE Members
SET name = 'Raju'
WHERE member_id = 101;

UPDATE Members
SET email = 'raju@example.com'
WHERE member_id = 101;

SELECT * from members;