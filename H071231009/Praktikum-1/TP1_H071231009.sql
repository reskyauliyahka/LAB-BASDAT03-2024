#Nama : Resky Auliyah Kartini Askin
#Nim : H071231009

#No.1
CREATE DATABASE library

USE library

CREATE TABLE authors (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL
)

CREATE TABLE books(
id INT PRIMARY KEY AUTO_INCREMENT,
isbn VARCHAR(13),
title VARCHAR(100) NOT NULL,
author_id INT,
FOREIGN KEY(author_id) REFERENCES authors(id)
)

#No.2
ALTER TABLE authors
ADD nationality VARCHAR(50)

#No.3
ALTER TABLE books
MODIFY isbn VARCHAR(13) UNIQUE

#No.4
DESCRIBE authors
DESCRIBE books

#No.5

#modif table authors
ALTER TABLE authors
MODIFY nationality VARCHAR(50) NOT NULL 

#modif table books
ALTER TABLE books
MODIFY title VARCHAR(150) NOT NULL,
MODIFY author_id INT NOT NULL,
ADD published_year YEAR NOT NULL,
ADD genre VARCHAR(50) NOT NULL,
ADD copies_available INT NOT NULL

ALTER TABLE books
MODIFY isbn CHAR(13) NOT NULL 

#membuat table members
CREATE TABLE members(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone_number CHAR(10),
join_date DATE NOT NULL,
membership_type VARCHAR(50) NOT NULL
)

DESCRIBE members

#membuat table borrowings
CREATE TABLE borrowings (
id INT PRIMARY KEY AUTO_INCREMENT,
member_id INT NOT NULL,
FOREIGN KEY(member_id) REFERENCES members(id),
book_id INT NOT NULL,
FOREIGN KEY(book_id) REFERENCES books(id),
borrow_date DATE NOT NULL,
return_date DATE
)

DESCRIBE borrowings



