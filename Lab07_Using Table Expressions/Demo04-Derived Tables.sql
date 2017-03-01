SELECT Category, COUNT(ProductID) AS Products
FROM
	(SELECT p.ProductID, p.Name AS Product, c.Name AS Category
	 FROM SalesLT.Product AS p
	 JOIN SalesLT.ProductCategory AS c
	 ON p.ProductCategoryID = c.ProductCategoryID) AS ProdCats
GROUP BY Category
ORDER BY Category;


-- Define column aliases inline
SELECT OrderYear, COUNT(DISTINCT CustomerID) AS Cust_Count
FROM
	(SELECT YEAR(OrderDate) AS OrderYear, CustomerID
	FROM SalesLT.SalesOrderHeader) AS derived_year
GROUP BY OrderYear;

-- Define column aliases externally
SELECT OrderYear, COUNT(DISTINCT CustomerID) AS Cust_Count
FROM
	(SELECT YEAR(OrderDate), CustomerID
	FROM SalesLT.SalesOrderHeader) AS derived_year(OrderYear, CustomerID)
GROUP BY OrderYear;