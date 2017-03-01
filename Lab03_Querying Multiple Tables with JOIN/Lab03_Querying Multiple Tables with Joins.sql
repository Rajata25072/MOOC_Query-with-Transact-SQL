-- Challenge 1: Generate Invoice Reports
-- Adventure Works Cycles sells directly to retailers, who must be invoiced for their orders. You have been
-- tasked with writing a query to generate a list of invoices to be sent to customers.
	-- Tip: Review the documentation for the FROM clause in the Transact-SQL Reference.

	-- 1. Retrieve customer orders
	-- As an initial step towards generating the invoice report, write a query that returns the company name
	-- from the SalesLT.Customer table, and the sales order ID and total due from the
	-- SalesLT.SalesOrderHeader table.
	SELECT CompanyName, SalesOrderID, TotalDue
	FROM SalesLT.Customer c 
	RIGHT JOIN SalesLT.SalesOrderHeader oh
	ON c.CustomerID = oh.CustomerID
	ORDER BY CompanyName, SalesOrderID;


	-- 2. Retrieve customer orders with addresses
	-- Extend your customer orders query to include the Main Office address for each customer, including the
	-- full street address, city, state or province, postal code, and country or region
		-- Tip: Note that each customer can have multiple addressees in the SalesLT.Address table, so the
	-- database developer has created the SalesLT.CustomerAddress table to enable a many-to-many
	-- relationship between customers and addresses. Your query will need to include both of these tables,
	-- and should filter the join to SalesLT.CustomerAddress so that only Main Office addresses are included.
	SELECT CompanyName, AddressLine1, ISNULL(AddressLine2,'') AS AddressLine2, City, StateProvince, CountryRegion,
		SalesOrderID, TotalDue
	FROM SalesLT.Customer c 
	RIGHT JOIN SalesLT.SalesOrderHeader oh
	ON c.CustomerID = oh.CustomerID
	JOIN SalesLT.CustomerAddress ca
	ON c.CustomerID = ca.CustomerID AND ca.AddressType = 'Main Office'
	JOIN SalesLT.Address a
	ON ca.AddressID = a.AddressID 
	ORDER BY c.CustomerID, CompanyName, SalesOrderID;


-- Challenge 2: Retrieve Sales Data
-- As you continue to work with the Adventure Works customer and sales data, you must create queries
-- for reports that have been requested by the sales team.

	-- 1. Retrieve a list of all customers and their orders
	-- The sales manager wants a list of all customer companies and their contacts (first name and last name),
	-- showing the sales order ID and total due for each order they have placed. Customers who have not
	-- placed any orders should be included at the bottom of the list with NULL values for the order ID and
	-- total due.
	SELECT c.CompanyName, c.FirstName, c.LastName, oh.SalesOrderID, oh.TotalDue
	FROM SalesLT.Customer c 
	LEFT JOIN SalesLT.SalesOrderHeader oh
	ON c.CustomerID = oh.CustomerID
	ORDER BY oh.SalesOrderID DESC, oh.TotalDue DESC;


	-- 2. Retrieve a list of customers with no address
	-- A sales employee has noticed that Adventure Works does not have address information for all
	-- customers. You must write a query that returns a list of customer IDs, company names, contact names
	-- (first name and last name), and phone numbers for customers with no address stored in the database.
	SELECT c.CustomerID, c.CompanyName, c.FirstName, c.LastName, c.Phone, ca.AddressID
	FROM SalesLT.Customer c 
	LEFT JOIN SalesLT.CustomerAddress ca
	ON c.CustomerID = ca.CustomerID 
	WHERE ca.AddressID IS NULL;


	-- 3. Retrieve a list of customers and products without orders
	-- Some customers have never placed orders, and some products have never been ordered. Create a query
	-- that returns a column of customer IDs for customers who have never placed an order, and a column of
	-- product IDs for products that have never been ordered. Each row with a customer ID should have a
	-- NULL product ID (because the customer has never ordered a product) and each row with a product ID
	-- should have a NULL customer ID (because the product has never been ordered by a customer).
	SELECT c.CustomerID, p.ProductID
	FROM SalesLT.Customer c 
	FULL JOIN SalesLT.SalesOrderHeader oh
	ON c.CustomerID = oh.CustomerID
	FULL JOIN SalesLT.SalesOrderDetail od
	ON oh.SalesOrderID = od.SalesOrderID 
	FULL JOIN SalesLT.Product p
	ON od.ProductID = p.ProductID 
	WHERE c.CustomerID IS NULL OR p.ProductID IS NULL
	ORDER BY p.ProductID, c.CustomerID;

-- Next Steps
-- Well done! You’ve completed the lab, and you’re ready to move onto Module 4 – Using SET Operators
-- in the course Querying with Transact-SQL.