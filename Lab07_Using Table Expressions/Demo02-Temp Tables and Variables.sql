-- Temporary table (stay for the whole process)
CREATE TABLE #Colors
(Color varchar(15));

INSERT INTO #Colors
SELECT DISTINCT Color FROM SalesLT.Product;

SELECT * FROM #Colors;

-- Table variable (Must execute all query simultaneously)
DECLARE @Colors AS TABLE (Color varchar(15));

INSERT INTO @Colors
SELECT DISTINCT Color FROM SalesLT.Product;

SELECT * FROM @Colors;

-- New batch
SELECT * FROM #Colors;

SELECT * FROM @Colors; -- now out of scope