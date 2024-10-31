-- Nomor 1
(SELECT
	p.productName,
	SUM(od.priceEach * od.quantityOrdered) AS 'TotalRevenue',
	'Pendapatan Tinggi' AS 'Pendapatan'
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o
USING(orderNumber)
WHERE MONTHNAME(o.orderDate) = 'september' 
GROUP BY p.productName
ORDER BY TotalRevenue DESC
LIMIT 5) 
UNION 
(SELECT
	p.productName,
	SUM(od.priceEach * od.quantityOrdered) AS 'TotalRevenue',
	'Pendapatan Pendek (kayak kamu)' AS 'Pendapatan'
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o
USING(orderNumber)
WHERE MONTHNAME(o.orderDate) = 'september' 
GROUP BY p.productName
ORDER BY TotalRevenue
LIMIT 5);

-- Nomor 2
SELECT 
	p.productName
FROM products p
EXCEPT 
SELECT 
	p.productName
FROM products p
JOIN orderdetails od
	USING(productCode)
JOIN orders o
	USING(orderNumber)
WHERE o.customerNumber IN (
	SELECT 
		customerNumber
	FROM orders
	GROUP BY customerNumber
	HAVING COUNT(*) > 10
	INTERSECT 
	SELECT 
		customerNumber
	FROM orders
	JOIN orderdetails 
		USING(orderNumber)
	JOIN products
		USING(productCode)
	WHERE buyPrice > (
		SELECT 
			AVG(buyPrice)
		FROM products			
	)	
);

-- Nomor 3
SELECT 
	c.customerName
FROM customers c
JOIN payments p
	USING(customerNumber)
GROUP BY customerNumber
HAVING SUM(amount) > 2 * (
	SELECT 
		AVG(totalAmount)
	FROM (
		SELECT 
			SUM(amount) AS 'totalAmount'
		FROM payments
		GROUP BY customerNumber
	) AS hasil
)
INTERSECT 
SELECT 
	c.customerName
FROM customers c
JOIN orders
	USING(customerNumber)
JOIN orderdetails od
	USING(orderNumber)
JOIN products
	USING(productCode)
WHERE productLine IN ('planes', 'trains')
GROUP BY customerName
HAVING SUM(priceEach * quantityOrdered) > 20000;

-- Nomor 4
SELECT DISTINCT
   o.orderDate AS 'Tanggal',
   c.customerNumber,
   'Membayar Pesanan dan Memesan Barang' AS 'riwayat'
FROM orders o
JOIN customers c 
	USING(customerNumber)
JOIN payments p
	ON o.orderDate = p.paymentDate 
WHERE o.orderDate LIKE '2003-09%'
UNION 
SELECT 
	o.orderDate,
	customerNumber,
	'memesan barang' 
FROM orders o
WHERE o.orderDate NOT IN (
	SELECT 
		py.paymentDate AS 'tanggal2'
	FROM payments py
) AND o.orderDate LIKE '2003-09%'
UNION 
SELECT 
	py.paymentDate,
	customerNumber,
	'membayar pesanan' 
FROM payments py
WHERE py.paymentDate NOT IN (
	SELECT 
		o.orderDate AS 'tanggal3'
	FROM orders o	
) AND py.paymentDate LIKE '2003-09%'
ORDER BY tanggal ;

-- Nomor 5
SELECT
   p.productCode
FROM products p
JOIN orderdetails od 
	USING(productCode)
JOIN orders o 
	USING(orderNumber)
WHERE 
   p.buyPrice > (
      SELECT 
         AVG(p2.buyPrice) 
      FROM products p2
		JOIN orderdetails od2
		  	USING(productCode)
      JOIN orders o2
		  	USING(orderNumber)
      WHERE 
         o2.orderDate BETWEEN '2001-01-01' AND '2004-03-31'
   )
   AND od.quantityOrdered > 48
   AND LEFT(p.productVendor, 1) IN ('a', 'i', 'u', 'e', 'o') 
EXCEPT 
SELECT 
	p.productCode
FROM products p
JOIN orderdetails od
	USING(productCode)
JOIN orders o
	USING(orderNumber)
JOIN customers c
	USING(customerNumber)
WHERE c.country IN ('germany', 'japan', 'italy')
ORDER BY productCode;
