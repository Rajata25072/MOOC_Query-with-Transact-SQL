-- Create a stored procedure (similar to function)
CREATE PROCEDURE SalesLT.GetProductsByCategory (@CategoryID INT = NULL)
AS
IF @CategoryID IS NULL
	SELECT ProductID, ProductCategoryID, Name, Color, Size, ListPrice
	FROM SalesLT.Product
ELSE
	SELECT ProductID, ProductCategoryID, Name, Color, Size, ListPrice
	FROM SalesLT.Product
	WHERE ProductCategoryID = @CategoryID;


-- Execute the procedure without a parameter
EXEC SalesLT.GetProductsByCategory

-- Execute the procedure with a parameter
EXEC SalesLT.GetProductsByCategory 6