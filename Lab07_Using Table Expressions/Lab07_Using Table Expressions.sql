--Challenge 1: Retrieve Product Information
--Adventure Works sells many products that are variants of the same product model. 
--You must write queries that retrieve information about these products

	--1. Retrieve product model descriptions
	--Retrieve the product ID, product name, product model name, and product model summary for each product from 
	--the SalesLT.Product table and the SalesLT.vProductModelCatalogDescription view.
	SELECT p.ProductID, p.Name AS ProductName, pmd.Name AS ProductModelName, pmd.Summary AS ProductModelSummary
	FROM SalesLT.Product p
	JOIN SalesLT.vProductModelCatalogDescription pmd
		ON p.ProductModelID = pmd.ProductModelID
	ORDER BY p.ProductID;


	--2. Create a table of distinct colors 
	--	Tip: Review the documentation for Variables in Transact-SQL Language Reference.
	--Create a table variable and populate it with a list of distinct colors from the SalesLT.Product table. 
	--Then use the table variable to filter a query that returns the product ID, name, and color from 
	--the SalesLT.Product table so that only products with a color listed in the table variable are returned.
	DECLARE @Color AS TABLE (Color varchar(15));

	INSERT INTO @Color
	SELECT DISTINCT Color FROM SalesLT.Product;

	SELECT ProductID, Name, Color
	FROM SalesLT.Product
	WHERE Color IN (SELECT * FROM @Color); --NULL Color fileter out automatically


	--3. Retrieve product parent categories
	--The AdventureWorksLT database includes a table-valued function named dbo.ufnGetAllCategories, 
	--which returns a table of product categories (for example ‘Road Bikes’) and parent categories 
	--(for example ‘Bikes’). Write a query that uses this function to return a list of all products 
	--including their parent category and category.
	SELECT ProductID, Name AS ProductName, ParentProductCategoryName AS ParentCategory, ProductCategoryName AS Category 
	FROM SalesLT.Product p
	JOIN dbo.ufnGetAllCategories() ac
	ON p.ProductCategoryID = ac.ProductCategoryID
	ORDER BY ParentCategory, Category, ProductID;


--Challenge 2: Retrieve Customer Sales Revenue
--Each Adventure Works customer is a retail company with a named contact. 
--You must create queries that return the total revenue for each customer, including the company and 
--customer contact names. 
--	Tip: Review the documentation for the WITH common_table_expression syntax in the Transact-SQL language 
--	reference.

	--1. Retrieve sales revenue by customer and contact
	--Retrieve a list of customers in the format Company (Contact Name) together with the total revenue 
	--for that customer. Use a derived table or a common table expression to retrieve the details for 
	--each sales order, and then query the derived table or CTE to aggregate and group the data.
	
	-- Using Derived Table
	SELECT CompanyContact, SUM(TotalDue) AS TotalRevenue
	FROM (SELECT CompanyName +' (' + FirstName + ' ' + LastName + ')' AS CompanyContact, TotalDue
		FROM SalesLT.Customer c
		JOIN SalesLT.SalesOrderHeader oh
		ON c.CustomerID = oh.CustomerID) AS DerivedRevenue
	GROUP BY CompanyContact
	ORDER BY CompanyContact;
	
	-- Using Common Table Expression (CTE)
	WITH CTE_rev(CompanyContact, TotalDue)
	AS
	(
		SELECT CompanyName +' (' + FirstName + ' ' + LastName + ')' AS CompanyContact, TotalDue
		FROM SalesLT.Customer c
		JOIN SalesLT.SalesOrderHeader oh
		ON c.CustomerID = oh.CustomerID
	) 
	SELECT CompanyContact, SUM(TotalDue) AS TotalRevenue
	FROM CTE_rev
	GROUP BY CompanyContact
	ORDER BY CompanyContact;



--Next Steps
--Well done! You’ve completed the lab, and you’re ready to learn how to summarize data by specifying 
--grouping sets and pivoting data in Module 8 – Grouping Sets and Pivoting Data in the Course Querying 
--with Transact-SQL.