SELECT Name, Size, ISNULL(TRY_CAST(Size AS Integer),0) AS NumericSize
FROM SalesLT.Product;
-- TRY_CAST return NULL for non-integer value and get casted as 0 for NumericSize

SELECT ProductNumber, Color, Size, ISNULL(Color, '') + ', ' + ISNULL(Size, '') AS ProductDetails
FROM SalesLT.Product;

SELECT Name, Color, NULLIF(Color, 'Multi') AS SingleColor
FROM SalesLT.Product;

SELECT Name, DiscontinuedDate, SellEndDate, SellStartDate, COALESCE(DiscontinuedDate, SellEndDate, SellStartDate) AS FirstNonNullDate
FROM SalesLT.Product;

--Searched case
SELECT Name,SellEndDate,
		CASE
			WHEN SellEndDate IS NULL THEN 'On Sale'
			ELSE 'Discontinued'
		END AS SalesStatus
FROM SalesLT.Product;

--Simple case
SELECT Name, Size,
		CASE Size
			WHEN 'S' THEN 'Small'
			WHEN 'M' THEN 'Medium'
			WHEN 'L' THEN 'Large'
			WHEN 'XL' THEN 'Extra-Large'
			ELSE ISNULL(Size, 'n/a')
		END AS ProductSize
FROM SalesLT.Product;