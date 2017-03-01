-- 2 Batch
-- Batch 1: Drop table if already exist
IF OBJECT_ID('SalesLT.DemoTable') IS NOT NULL
	BEGIN
	DROP TABLE SalesLT.DemoTable
	END
GO

-- Batch 2: Create new table
CREATE TABLE SalesLT.DemoTable
(ID INT IDENTITY(1,1),
Description Varchar(20),
CONSTRAINT [PK_DemoTable] PRIMARY KEY CLUSTERED(ID) 
)
GO

SELECT * FROM SalesLT.DemoTable