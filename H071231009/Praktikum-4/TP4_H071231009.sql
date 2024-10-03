-- nomor 1
USE classicmodels;

SELECT * FROM customers;
SELECT 
	customerNumber, 
	customerName, 
	country 
FROM customers
WHERE  (country = 'USA' AND creditLimit BETWEEN 50000 AND 100000) OR 
		 ( country != 'USA' AND creditLimit BETWEEN 100000 AND 200000)
ORDER BY creditLimit DESC;


-- Nomor 2
SELECT * FROM products;
SELECT 
	productCode, 
	productName, 
	quantityInStock, 
	buyPrice 
FROM products
WHERE (quantityInStock BETWEEN 1000 AND 2000) AND 
		(buyPrice <= 50 OR buyPrice >= 150) AND 
		(productLine NOT LIKE 'Vintage%');


-- Nomor 3
SELECT * FROM products;
SELECT 
	productCode, 
	productName, 
	MSRP 
FROM products
WHERE productLine LIKE '%Classic%' AND 
		buyPrice >= 50;


-- Nomor 4

SELECT * FROM orders;
SELECT 
	orderNumber, 
	orderDate, 
	`status`, 
	customerNumber 
FROM orders
WHERE (orderNumber > 10250) AND 
	(`status` != 'shipped' AND `status` != 'cancelled') AND 
	(orderDate LIKE '2004%' OR '2005%');


-- Nomor 5

SELECT *, 
	(priceEach - (priceEach * 5/100)) AS 'discountedTotalPrice' 
FROM orderdetails
WHERE (quantityOrdered > 50) AND 
		(priceEach > 100) AND 
		(productCode NOT LIKE 's18%')
ORDER BY discountedTotalPrice DESC;
