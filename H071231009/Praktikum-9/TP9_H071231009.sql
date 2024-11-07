-- Nomor 1
CREATE DATABASE sepakbola;

USE sepakbola;

CREATE TABLE klub (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(20) NOT NULL
);

CREATE TABLE pemain (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_pemain VARCHAR(50) NOT NULL,
	posisi VARCHAR(20) NOT NULL,
	id_klub INT,
	FOREIGN KEY(id_klub) REFERENCES klub(id)
);

CREATE TABLE pertandingan (
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_klub_tuan_rumah INT,
	FOREIGN KEY(id_klub_tuan_rumah) REFERENCES klub(id),
	id_klub_tamu INT,
	FOREIGN KEY(id_klub_tamu) REFERENCES klub(id),
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT 0,
	skor_tamu INT DEFAULT 0
);

ALTER TABLE pemain
ADD INDEX index_posisi(posisi);

ALTER TABLE klub
ADD INDEX index_kota_asal(kota_asal);

DESCRIBE klub;
DESCRIBE pemain;
DESCRIBE pertandingan;

-- Nomor 2
SELECT 
	c.customerName,
	c.country,
	FORMAT(SUM(amount), 2)  AS TotalPayment,
	COUNT(orderNumber) AS orderCount,
	MAX(paymentDate) AS LastPaymentDate,
	
	case
		when SUM(amount) > 100000 then 'VIP'
		when SUM(amount) > 5000 AND SUM(amount) < 100000 then 'Loyal'
		ELSE 'New'
	END AS `status`	
FROM customers c
LEFT JOIN orders o
	ON c.customerNumber = o.customerNumber
LEFT JOIN payments py
	ON c.customerNumber = py.customerNumber
GROUP BY c.customerName;

-- Nomor 3
SELECT 
	c.customerNumber,
	c.customerName,
	SUM(od.quantityOrdered) total_quantity,
	CASE
		when SUM(od.quantityOrdered) > (SELECT AVG(quantityOrdered) FROM orderdetails) then 'di atas rata-rata'
		when SUM(od.quantityOrdered) < (SELECT AVG(quantityOrdered) FROM orderdetails) then 'di bawah rata-rata'
	END AS kategori_pembelian
FROM customers c
JOIN orders o
	USING(customerNumber)
JOIN orderdetails od
	USING(orderNumber)
GROUP BY c.customerName	
ORDER BY total_quantity DESC ;


-- Soal Tambahan
# update productnya kalau misalkan priceeach * buyprice itu angkanya ganjil maka ubah productnamenya jadi 'ganjil'

START TRANSACTION ;

UPDATE products
SET productName = 'ganjil'
WHERE productName IN (
	SELECT 
		productName
	FROM products
	JOIN orderdetails 
		USING(productCode)
	WHERE (buyPrice * priceEach) % 2 != 0
);


COMMIT;


