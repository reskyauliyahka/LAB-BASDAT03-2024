-- Nomor 1
SELECT 
	p.productCode,
	p.productName,
	p.buyPrice
FROM products p
WHERE p.buyPrice > (
	SELECT AVG(pp.buyPrice)
	FROM products pp
);


-- Nomor 2
SELECT 
    o.orderNumber,
    o.orderDate
FROM orders o
WHERE o.customerNumber IN (
    SELECT 
        c.customerNumber
    FROM customers c
    JOIN employees e 
	 		ON c.salesRepEmployeeNumber = e.employeeNumber
    JOIN offices oc 
	 		ON e.officeCode = oc.officeCode
    WHERE oc.city = 'Tokyo'
);

-- Nomor 3
SELECT 
    c.customerName,
    o.orderNumber,
    o.shippedDate,
    o.requiredDate,
    GROUP_CONCAT(p.productName ORDER BY p.productName) AS 'products',
    SUM(od.quantityOrdered) AS 'total_quantity_ordered',  
    CONCAT(e.firstName, " ", e.lastName) AS 'employeeName'  
FROM employees e
JOIN customers c
    ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o
    USING(customerNumber)
JOIN orderdetails od
    USING(orderNumber)
JOIN products p
    USING(productCode)
WHERE o.orderNumber IN  (
    SELECT oo.orderNumber
    FROM orders oo
    WHERE oo.shippedDate > oo.requiredDate  
)
GROUP BY c.customerName

-- Nomor 4
SELECT 
    p.productName,
    p.productLine,
    SUM(od.quantityOrdered) AS total_quantity
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN (
    SELECT 
        pp.productLine,
        SUM(odd.quantityOrdered) AS 'totalKategori'
    FROM products pp
    JOIN orderdetails odd
    USING(productCode)
    GROUP BY pp.productLine
    ORDER BY totalKategori DESC
    LIMIT 3
) top_productLines 
ON p.productLine = top_productLines.productLine
GROUP BY p.productCode
ORDER BY top_productLines.totalKategori DESC, total_quantity DESC;


