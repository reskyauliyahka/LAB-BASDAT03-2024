-- Nomor 1
SELECT 
	c.customerName,
	CONCAT(e.firstName," ", e.lastName) AS 'salesRep',
	(c.creditLimit - SUM(p.amount)) AS 'remainingCredit'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING(customerNumber)
GROUP BY c.customerName
HAVING remainingCredit > 0;

-- Nomor 2
SELECT 
	pr.productName AS 'Nama Produk',
	GROUP_CONCAT(c.customerName ORDER BY c.customerName) AS 'Nama Customer',
	COUNT(DISTINCT c.customerName) AS 'Jumlah Customer',
	SUM(od.quantityOrdered)
FROM products pr
JOIN orderdetails od
USING(productCode)
JOIN orders o
USING(orderNumber)
JOIN customers c
USING(customerNumber)
GROUP BY pr.productName;

-- Nomor 3
SELECT 
	CONCAT(e.firstName," ", e.lastName) AS 'employeeName',
 	COUNT(c.customerName) AS 'totalCustomers'
FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY employeeName
ORDER BY totalCustomers DESC;

-- Nomor 4
SELECT
   CONCAT(e.firstname, " ", e.lastname) AS 'Nama Karyawan',
   p.productName AS 'Nama Produk',
   SUM(od.quantityOrdered) AS 'Jumlah Pesanan'
FROM employees AS e
LEFT JOIN customers AS c
    ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders AS o
    ON c.customerNumber = o.customerNumber
LEFT JOIN orderdetails AS od
    ON o.orderNumber = od.orderNumber
LEFT JOIN products AS p
    ON od.productCode = p.productCode
LEFT JOIN offices AS of
    ON e.officeCode = of.officeCode
WHERE of.country = 'Australia'
GROUP BY e.employeeNumber, p.productName
ORDER BY SUM(od.quantityOrdered) DESC;

-- Nomor 5
SELECT  
	c.customerName AS 'Nama Pelanggan',
	GROUP_CONCAT(p.productName ORDER BY p.productName ) AS 'Nama Produk',
	COUNT(p.productCode) AS 'Banyak Jenis Produk'
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o
USING(orderNumber)
JOIN customers c
USING(customerNumber)
WHERE o.shippedDate IS NULL
GROUP BY c.customerName;


