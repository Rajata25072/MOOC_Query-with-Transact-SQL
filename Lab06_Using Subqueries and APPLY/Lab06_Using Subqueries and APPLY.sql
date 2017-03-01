--Challenge 1: Retrieve Product Price Information
--Adventure Works products each have a standard cost price that indicates the cost of manufacturing 
--the product, and a list price that indicates the recommended selling price for the product. 
--This data is stored in the SalesLT.Product table. Whenever a product is ordered, the actual unit 
--price at which it was sold is also recorded in the SalesLT.SalesOrderDetail table. You must use 
--subqueries to compare the cost and list prices for each product with the unit prices charged in 
--each sale. 
	--Tip: Review the documentation for subqueries in Subquery Fundamentals.

	--1. Retrieve products whose list price is higher than the average unit price
	--Retrieve the product ID, name, and list price for each product where the list price is higher 
	--than the average unit price for all products that have been sold.
	SELECT ProductID, Name, ListPrice
	FROM SalesLT.Product p
	WHERE ListPrice > 
		(SELECT AVG(UnitPrice)
		FROM SalesLT.SalesOrderDetail od);


	--2. Retrieve Products with a list price of $100 or more that have been sold for less than $100
	--Retrieve the product ID, name, and list price for each product where the list price is $100 or 
	--more, and the product has been sold for less than $100.
	SELECT ProductID, Name, ListPrice
	FROM SalesLT.Product p
	WHERE ListPrice > 100 AND ProductID IN
		(SELECT ProductID 
		FROM SalesLT.SalesOrderDetail od
		WHERE UnitPrice < 100);


	--3. Retrieve the cost, list price, and average selling price for each product
	--Retrieve the product ID, name, cost, and list price for each product along with the average unit 
	--price for which that product has been sold.
	SELECT p.ProductID, Name, StandardCost, ListPrice, AvgUnitPrice
	FROM SalesLT.Product p
	LEFT JOIN (SELECT ProductID, AVG(UnitPrice) AS AvgUnitPrice -- Show unsold product too
			FROM SalesLT.SalesOrderDetail od
			GROUP BY ProductID) av
	ON p.ProductID = av.ProductID
	ORDER BY P.ProductID;

	-- OR

	SELECT ProductID, Name, StandardCost, ListPrice,
	(SELECT AVG(UnitPrice)
	 FROM SalesLT.SalesOrderDetail AS SOD
	 WHERE P.ProductID = SOD.ProductID) AS AvgSellingPrice
	FROM SalesLT.Product AS P
	ORDER BY P.ProductID;


	--4. Retrieve products that have an average selling price that is lower than the cost
	--Filter your previous query to include only products where the cost price is higher than 
	--the average selling price.
	SELECT p.ProductID, Name, StandardCost, ListPrice, AvgUnitPrice
	FROM SalesLT.Product p
	LEFT JOIN (SELECT ProductID, AVG(UnitPrice) AS AvgUnitPrice -- Show unsold product too
			FROM SalesLT.SalesOrderDetail od
			GROUP BY ProductID) av
	ON p.ProductID = av.ProductID
	WHERE StandardCost > AvgUnitPrice
	ORDER BY P.ProductID;

	--OR 

	SELECT ProductID, Name, StandardCost, ListPrice,
		(SELECT AVG(UnitPrice)
		FROM SalesLT.SalesOrderDetail AS SOD
		WHERE P.ProductID = SOD.ProductID) AS AvgSellingPrice
	FROM SalesLT.Product AS P
	WHERE StandardCost >
		(SELECT AVG(UnitPrice)
		FROM SalesLT.SalesOrderDetail AS SOD
		WHERE P.ProductID = SOD.ProductID)
	ORDER BY P.ProductID;


--Challenge 2: Retrieve Customer Information
--The AdventureWorksLT database includes a table-valued user-defined function named 
--dbo.ufnGetCustomerInformation. You must use this function to retrieve details of customers 
--based on customer ID values retrieved from tables in the database. 
	--Tip: Review the documentation for the APPLY operator in Using APPLY.

	--1. Retrieve customer information for all sales orders
	--Retrieve the sales order ID, customer ID, first name, last name, and total due for all 
	--sales orders from the SalesLT.SalesOrderHeader table and the dbo.ufnGetCustomerInformation 
	--function.
	SELECT oh.SalesOrderID, oh.CustomerID, FirstName, LastName, oh.TotalDue
	FROM SalesLT.SalesOrderHeader oh
	CROSS APPLY dbo.ufnGetCustomerInformation(oh.CustomerID) AS CUI
	ORDER BY oh.SalesOrderID;


	--2. Retrieve customer address information
	--Retrieve the customer ID, first name, last name, address line 1 and city for all customers
	 --from the SalesLT.Address and SalesLT.CustomerAddress tables, and the 
	 --dbo.ufnGetCustomerInformation function.
	SELECT ca.CustomerID, FirstName, LastName, a.AddressLine1
	FROM SalesLT.Address a
	JOIN SalesLT.CustomerAddress ca
	ON a.AddressID = ca.AddressID
	CROSS APPLY dbo.ufnGetCustomerInformation(ca.CustomerID) AS CUI
	ORDER BY ca.CustomerID;


--Next Steps
--Well done! You’ve completed the lab, and you’re ready to learn how to use table expressions in Module 7 – Using Table Expressions in the Course Querying with Transact-SQL.