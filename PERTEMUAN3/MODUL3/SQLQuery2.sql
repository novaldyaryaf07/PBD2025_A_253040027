SELECT * FROM Production.Product;

SELECT Name, ProductNumber, ListPrice
FROM Production.Product;

SELECT Name AS [Nama Barang], ListPrice AS 'Harga Jual'
FROM Production.Product

SELECT Name, ListPrice, (ListPrice*1.1) AS HargaBaru
FROM Production.Product

SELECT  Name, Color, ListPrice
FROM Production.Product
WHERE Color = 'Red';

SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice <= 1000;

SELECT Name, Color, ListPrice
FROM Production.Product
WHERE Color = 'Black' AND ListPrice > 500;

SELECT Name, Color
FROM Production.Product
WHERE Color IN ('Red', 'Blue', 'Black');

SELECT Name, ProductNumber
FROM Production.Product
WHERE Name LIKE '%Road%';

SELECT  COUNT(*) AS TotalProduk
FROM Production.Product;

SELECT Color, COUNT(*) AS JumlahProduk
FROM Production.Product
GROUP BY Color;

SELECT ProductID, SUM(OrderQty) AS TotalTerjual, AVG(UnitPrice) AS RataRataHarga
FROM Sales.SalesOrderDetail
GROUP BY ProductID;

SELECT Color, Size, COUNT(*) AS Jumlah
FROM Production.Product
GROUP BY Color, Size;

SELECT Color, Name, COUNT(*)
FROM Production.Product
GROUP BY Color;