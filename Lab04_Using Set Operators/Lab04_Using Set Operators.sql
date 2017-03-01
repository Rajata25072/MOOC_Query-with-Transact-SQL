-- Challenge 1: Retrieve Customer Addresses
-- Customers can have two kinds of address: a main office address and a shipping address. 
-- The accounts department want to ensure that the main office address is always used for billing, 
-- and have asked you to write a query that clearly identifies the different types of address 
-- for each customer. 
	-- Tip: Review the documentation for the UNION operator in the Transact-SQL Reference.

	-- 1. Retrieve billing addresses
	-- Write a query that retrieves the company name, first line of the street address, city, 
	-- and a column named AddressType with the value ‘Billing’ for customers where the address type in 
	-- the SalesLT.CustomerAddress table is ‘Main Office’.
	SELECT c.CompanyName, a.AddressLine1, a.City, 'Billing' AS AddressType
	FROM SalesLT.CustomerAddress ca
	JOIN SalesLT.Address a
	ON ca.AddressID = a.AddressID
	JOIN SalesLT.Customer c
	ON ca.CustomerID = c.CustomerID
	WHERE AddressType = 'Main Office'
	ORDER BY CompanyName;


	-- 2. Retrieve shipping addresses
	-- Write a similar query that retrieves the company name, first line of the street address, city, 
	-- and a column named AddressType with the value ‘Shipping’ for customers where the address type 
	-- in the SalesLT.CustomerAddress table is ‘Shipping’.
	SELECT c.CompanyName, a.AddressLine1, a.City, 'Shipping' AS AddressType
	FROM SalesLT.CustomerAddress ca
	JOIN SalesLT.Address a
	ON ca.AddressID = a.AddressID
	JOIN SalesLT.Customer c
	ON ca.CustomerID = c.CustomerID
	WHERE AddressType = 'Shipping'
	ORDER BY CompanyName;


	-- 3. Combine billing and shipping addresses
	-- Combine the results returned by the two queries to create a list of all customer addresses that 
	-- is sorted by company name and then address type.
	SELECT c.CompanyName, a.AddressLine1, a.City, 'Billing' AS AddressType
	FROM SalesLT.CustomerAddress ca
	JOIN SalesLT.Address a
	ON ca.AddressID = a.AddressID
	JOIN SalesLT.Customer c
	ON ca.CustomerID = c.CustomerID
	WHERE AddressType = 'Main Office'
	
	UNION

	SELECT c.CompanyName, a.AddressLine1, a.City, 'Shipping' AS AddressType
	FROM SalesLT.CustomerAddress ca
	JOIN SalesLT.Address a
	ON ca.AddressID = a.AddressID
	JOIN SalesLT.Customer c
	ON ca.CustomerID = c.CustomerID
	WHERE AddressType = 'Shipping'

	ORDER BY CompanyName, AddressType;



-- Challenge 2: Filter Customer Addresses
-- You have created a master list of all customer addresses, but now you have been asked to create 
-- filtered lists that show which customers have only a main office address, and which customers have 
-- both a main office and a shipping address. 
	-- Tip: Review the documentation for the EXCEPT and INTERSECT operators in the Transact-SQL Reference.

	-- 1. Retrieve customers with only a main office address
	-- Write a query that returns the company name of each company that appears in a table of customers with 
	-- a ‘Main Office’ address, but not in a table of customers with a ‘Shipping’ address.
	SELECT c.CompanyName
	FROM SalesLT.CustomerAddress ca
	JOIN SalesLT.Address a
	ON ca.AddressID = a.AddressID
	JOIN SalesLT.Customer c
	ON ca.CustomerID = c.CustomerID
	WHERE AddressType = 'Main Office'
	
	EXCEPT

	SELECT c.CompanyName
	FROM SalesLT.CustomerAddress ca
	JOIN SalesLT.Address a
	ON ca.AddressID = a.AddressID
	JOIN SalesLT.Customer c
	ON ca.CustomerID = c.CustomerID
	WHERE AddressType = 'Shipping'

	ORDER BY CompanyName;


	-- 2. Retrieve only customers with both a main office address and a shipping address
	-- Write a query that returns the company name of each company that appears in a table of customers with 
	-- a ‘Main Office’ address, and also in a table of customers with a ‘Shipping’ address.
	SELECT c.CompanyName
	FROM SalesLT.CustomerAddress ca
	JOIN SalesLT.Address a
	ON ca.AddressID = a.AddressID
	JOIN SalesLT.Customer c
	ON ca.CustomerID = c.CustomerID
	WHERE AddressType = 'Main Office'
	
	INTERSECT

	SELECT c.CompanyName
	FROM SalesLT.CustomerAddress ca
	JOIN SalesLT.Address a
	ON ca.AddressID = a.AddressID
	JOIN SalesLT.Customer c
	ON ca.CustomerID = c.CustomerID
	WHERE AddressType = 'Shipping'

	ORDER BY CompanyName;


	-- Next Steps
	-- Well done! You’ve completed the lab, and you’re ready to learn how to add aggregate functions and 
	-- groupings to your queries in Module 5 – Using Functions and Aggregating Data in the Course Querying 
	-- with Transact-SQL.