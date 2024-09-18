#Nama : Resky Auliyah Kartini Askin
#Nim : H071231009

#No.1
SELECT * FROM products;
SELECT productCode AS 'Kode Produk', productName AS 'Nama Produk', quantityInStock AS 'Jumlah Stok' FROM products
WHERE quantityInStock >= 5000 AND quantityInStock <=6000 
ORDER BY quantityInStock; 

#No.2
SELECT * FROM orders;
SELECT orderNumber AS 'Nomor Pesanan', orderDate  AS 'Tanggal Pesanan', `status`,  customerNumber AS 'Nomor Pelanggan' FROM orders
WHERE `status` != "shipped"
ORDER BY customerNumber;

#No.3
SELECT * FROM employees;
SELECT employeeNumber AS 'Nomor Karyawan', firstName, lastName, email, jobTitle AS 'Jabatan' FROM employees
WHERE jobTitle = 'Sales Rep'
ORDER BY firstName
LIMIT 10;

#No.4
SELECT * FROM products;
SELECT productCode AS 'Kode Produk', productName AS 'Nama Produk', productLine AS 'Lini Produk', buyPrice AS 'buyPrice' FROM products
ORDER BY buyprice DESC
LIMIT 5, 10;

#No.5
SELECT * FROM customers;
SELECT DISTINCT country, city FROM customers
ORDER BY country, city; 
