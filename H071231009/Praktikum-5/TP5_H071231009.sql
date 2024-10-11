-- Nomor 1
SELECT DISTINCT 
	c.customerName AS namaKustomer,
	p.productName AS namaProduk,
	pd.textDescription AS textDescription
FROM customers AS c
INNER JOIN orders AS o
USING (customerNumber)
INNER JOIN orderdetails AS od
USING (orderNumber)
INNER JOIN products AS p
USING(productCode)
INNER JOIN productlines AS pd
USING(productLine)
WHERE p.productName LIKE '%titanic%'
ORDER BY c.customerName;

-- Nomor 2
SELECT 
	c.customerName,
	p.productName,
	o.`status`,
	o.shippedDate
FROM customers AS c
INNER JOIN orders AS o
USING (customerNumber)
INNER JOIN orderdetails AS od
USING (orderNumber)
INNER JOIN products AS p
USING(productCode)
WHERE p.productName LIKE '%ferrari%' AND 
		o.`status` = 'shipped' AND 
		o.shippedDate >= '2003-10-01' AND o.shippedDate <= '2004-09-31'
ORDER BY o.shippedDate DESC;


-- Nomor 3				
SELECT 
	e.firstName AS supervisor,
	s.firstName AS karyawan
FROM employees AS e
INNER JOIN employees AS s
ON e.employeeNumber = s.reportsTo
WHERE e.firstName LIKE '%gerard%'
ORDER BY s.firstName ASC;


-- Nomor 4
-- bagian a
SELECT 
	c.customerName,
	p.paymentDate,
	e.firstName AS 'employeeName',
	p.amount
FROM customers AS c
INNER JOIN payments AS p
USING(customerNumber)
INNER JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber 
WHERE p.paymentDate LIKE '%-11-%';

-- bagian b
SELECT 
	c.customerName,
	p.paymentDate,
	e.firstName AS 'employeeName',
	p.amount
FROM customers AS c
INNER JOIN payments AS p
USING(customerNumber)
INNER JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber 
WHERE p.paymentDate LIKE '%-11-%'
ORDER BY p.amount DESC
LIMIT 1;

-- bagian c
SELECT 
	c.customerName,
	p.productName
FROM customers AS c
INNER JOIN orders AS o
USING(customerNumber)
INNER JOIN orderdetails AS od
USING(orderNumber)
INNER JOIN products AS p
USING(productCode)
WHERE c.customerName LIKE 'corporate%';

