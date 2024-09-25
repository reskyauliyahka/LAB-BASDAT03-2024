USE library;

DESCRIBE authors;
DESCRIBE books;
DESCRIBE members;
DESCRIBE borrowings;

#Nomor 1
#tabel authors
INSERT INTO authors(`name`, nationality)
VALUES ("Tere Liye", "Indonesian"),
		 ("J.K. Rowling", "British"),
		 ("Andrea Hirata", "")
		 
SELECT * FROM authors;

#tabel books
INSERT INTO books(isbn, title, author_id, published_year, genre, copies_available)
VALUES("7040289780375", "Ayah", 3, 2015, "Fiction", 15),
		("9780375704025", "Bumi", 1, 2014, "Fantasy", 5),
		("8310371703024", "Bulan", 1, 2015, "Fantasy", 3),
		("9780747532699", "Harry Potter and the Philosopher's Stone", 2, 1997, "", 10),
		("7210301703022", "The Running Grave", 2, 2016, "Fiction", 11);
		
ALTER TABLE books
ADD author_name VARCHAR(100);

UPDATE books
SET author_name = (SELECT name FROM authors WHERE authors.id = books.author_id);

SELECT * FROM books;

#tabel members
INSERT INTO members(first_name, last_name, email, phone_number, join_date, membership_type)
VALUES("John", "Doe", "John.doe@example.com", NULL, "2023-04-29", ""),
		("Alice", "Johnson", "alice.johnson@example.com", "1231231231", "2023-05-01", "Standar"),
		("Bob", "Williams", "bob.williams@example.com", "3213214321", "2023-06-20", "Premium");
		

SELECT * FROM members;

#tabel borrowings
INSERT INTO borrowings(member_id, book_id, borrow_date, return_date)
VALUES(1, 4, "2023-07-10", "2023-07-25"),
		(3, 1, "2023-08-01", NULL),
		(2, 5, "2023-09-06", "2023-09-09"),
		(2, 3, "2023-09-08", NULL),
		(3, 2, "2023-09-10", NULL);
		
ALTER TABLE borrowings
ADD book_title VARCHAR(100);

UPDATE borrowings
SET book_title = (SELECT title FROM books WHERE books.id = borrowings.book_id);

SELECT * FROM borrowings;


#Nomor 2
UPDATE books
SET copies_available = copies_available - 1
WHERE id = 1 OR 2 OR 3;
				

SELECT * FROM books;


#Nomor 3
UPDATE members
SET membership_type = "Standar"
WHERE id = 3;

ALTER TABLE borrowings 
DROP FOREIGN KEY borrowings_ibfk_1;


ALTER TABLE borrowings
ADD CONSTRAINT borrowings_ibfk_1 FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE;

DELETE FROM members
WHERE membership_type = "Standar";

#tampilan:
SELECT 
	`name` AS 'Name', 
	 nationality AS 'Nationality'
FROM authors;

SELECT 
	isbn, 
	title AS 'Title', 
	author_name AS 'Author Name', 
	published_year AS 'Published Year', genre AS 'Genre', 
	copies_available AS 'Copies Available' 
FROM books;

SELECT 
	first_name AS 'First Name',
	last_name AS 'Last Name', 
	email AS "Email", 
	phone_number AS 'Phone Number', 
	join_date AS 'Join Date', 
	membership_type AS 'Membership Type' 
FROM members;

SELECT 
	book_title AS 'Book Title',
	borrow_date AS 'Borrow Date', 
	return_date AS 'Return Date' 
FROM borrowings;