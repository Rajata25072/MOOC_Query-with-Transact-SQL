--For each customer list all sales on the last day that they made a sale 
-- (They all have same OrderDate??)
-- Demo use SalesLT.SalesOrder no SalesOrderHeader!!!!

SELECT CustomerID, SalesOrderID, OrderDate
FROM SalesLT.SalesOrderHeader AS SO1
ORDER BY CustomerID,OrderDate

SELECT *
FROM SalesLT.SalesOrderHeader AS SO1
ORDER BY CustomerID


-- Universal last day (Interested only when the OrderDate is the same as Max OrderDate)
SELECT CustomerID, SalesOrderID, OrderDate
FROM SalesLT.SalesOrderHeader AS SO1
WHERE orderdate =
(SELECT MAX(orderdate)
FROM SalesLT.SalesOrderHeader)

-- Interested only when the OrderDate is the same as Each Max OrderDate
-- Something Wrong
SELECT CustomerID, SalesOrderID, OrderDate
FROM SalesLT.SalesOrderHeader AS SO1
WHERE orderdate =
(SELECT MAX(orderdate)
FROM SalesLT.SalesOrderHeader AS SO2
WHERE SO2.CustomerID = SO1.CustomerID)
ORDER BY CustomerID
