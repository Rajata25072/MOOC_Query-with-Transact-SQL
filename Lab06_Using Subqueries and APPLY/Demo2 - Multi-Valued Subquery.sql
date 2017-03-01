--List products that have an order quantity greater than 20

SELECT Name, ProductID
FROM SalesLT.Product
WHERE ProductID IN
(SELECT ProductID from SalesLT.SalesOrderDetail
WHERE OrderQty>20)

SELECT Name, P.ProductID
FROM SalesLT.Product P
JOIN SalesLT.SalesOrderDetail SOD
ON P.ProductID=SOD.ProductID
WHERE OrderQty>20