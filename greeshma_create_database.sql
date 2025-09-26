CREATE DATABASE LibraryDB;
USE LibraryDB;

CREATE TABLE Books(
book_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
author VARCHAR(255) NOT NULL,
genre VARCHAR(100),
published_year YEAR,
is_available BOOLEAN DEFAULT TRUE
);

CREATE TABLE Members (
member_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
email VARCHAR(255),
phone_number VARCHAR(15),
join_date DATE DEFAULT '2025-09-26');

CREATE TABLE Librarians (
librarian_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
email VARCHAR(255),
phone_number VARCHAR(15),
hire_date DATE DEFAULT '2025-09-15'
);

CREATE TABLE Borrowing(
loan_id INT AUTO_INCREMENT PRIMARY KEY,
book_id INT,
member_id INT,
borrow_date DATE DEFAULT '2025-09-6',
return_date DATE,
librarian_id INT,
FOREIGN KEY (book_id) REFERENCES Books(book_id),
FOREIGN KEY (member_id) REFERENCES Members(member_id),
FOREIGN KEY (librarian_id) REFERENCES Librarians(librarian_id)
);


INSERT INTO Books (title, author, genre, published_year) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925),
('1984', 'George Orwell', 'Dystopian', 1949),
('To Kill a Mockingbird', 'Harper Lee', 'Classic', 1960);

INSERT INTO Books (title, author, genre, published_year) VALUES
('The Great ', ' Fitzgerald', 'Fiction', 2003);


INSERT INTO Members(name,email,phone_number) VALUES
('Alen King', 'alenking@example.com', '1234567890'),
('Alece Hofman', 'alecehofman@example.com', '9876543210');

INSERT INTO Librarians (name, email, phone_number) VALUES
('Nail Horn', 'nail@example.com', '4567891230'),
('Garden McGraw', 'garden@example.com', '7894561230');

INSERT INTO Borrowing (book_id, member_id, librarian_id)
VALUES (1, 1, 1);
INSERT INTO Borrowing (book_id, member_id, librarian_id)
VALUES (2, 2, 1);

UPDATE Books SET is_available = FALSE WHERE book_id = 1;
UPDATE Books SET is_available = FALSE WHERE book_id = 2;
UPDATE Books SET is_available = FALSE WHERE book_id = 3;

UPDATE Borrowing SET return_date = CURRENT_DATE WHERE loan_id = 1;
UPDATE Borrowing SET return_date = CURRENT_DATE WHERE loan_id = 2;

UPDATE Books SET is_available = TRUE WHERE book_id = 1;

SELECT * FROM Books WHERE is_available = TRUE;

SELECT m.name, b.title, br.borrow_date, br.return_date
FROM Borrowing br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id
WHERE m.member_id = 1;

SELECT m.name, b.title, br.borrow_date
FROM Borrowing br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id
WHERE br.return_date IS NULL
AND br.borrow_date < CURRENT_DATE - INTERVAL 14 DAY;

SELECT title, genre, published_year
FROM Books
WHERE author = 'George Orwell';

SELECT title, author, published_year
FROM Books
WHERE published_year > 2000;

SELECT COUNT(*) AS total_books FROM Books;

SELECT m.name, br.borrow_date, br.return_date
FROM Borrowing br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id
WHERE b.title = '1984';

SELECT b.title, br.borrow_date, br.return_date
FROM Borrowing br
JOIN Books b ON br.book_id = b.book_id
WHERE br.member_id = 1;

SELECT title, author, published_year
FROM Books
WHERE genre = 'Fiction' AND is_available = TRUE;

SELECT m.name, COUNT(br.loan_id) AS total_books_borrowed
FROM Borrowing br
JOIN Members m ON br.member_id = m.member_id
GROUP BY m.name;

SELECT m.name, b.title, br.borrow_date
FROM Borrowing br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id
WHERE br.return_date IS NULL
AND br.borrow_date < CURRENT_DATE - INTERVAL 30 DAY;

SELECT l.name, COUNT(br.loan_id) AS total_borrowings
FROM Borrowing br
JOIN Librarians l ON br.librarian_id = l.librarian_id
GROUP BY l.name
ORDER BY total_borrowings DESC;

SELECT m.name, b.title, br.borrow_date
FROM Borrowing br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id
WHERE br.return_date IS NULL;
