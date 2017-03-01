--Challenge 1: Logging Errors
--You are implementing a Transact-SQL script to delete orders, and you want to handle any errors that occur during 
--the deletion process. 
--	Tip: Review the documentation for THROW and TRY…CATCH in the Transact-SQL Language Reference.

--	1. Throw an error for non-existent orders
--	You are currently using the following code to delete order data:
	DECLARE @SalesOrderID int = <the_order_ID_to_delete>
	DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
	DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
--	This code always succeeds, even when the specified order does not exist. 
--	Modify the code to check for the existence of the specified order ID before attempting to delete it. 
--	If the order does not exist, your code should throw an error. 
--	Otherwise, it should go ahead and delete the order data.
	
	DECLARE @SalesOrderID int = 0

	IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID)
		BEGIN
		-- Throw a custom error if id not exist
		DECLARE @ErrorMsg varchar(50)
		SET @ErrorMsg = 'SalesOrderID#' + CONVERT(varchar(20), @SalesOrderID) + ' is not existed.';
		THROW 50001, @ErrorMsg, 0
		END
	ELSE
		BEGIN
		PRINT 'SalesOrderID#' + CONVERT(varchar(20), @SalesOrderID) + ' is existed.';
		DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
		DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
		END


--	2. Handle errors
--	Your code now throws an error if the specified order does not exist. You must now refine your code to catch this 
--	(or any other) error and print the error message to the user interface using the PRINT command.
	DECLARE @SalesOrderID int = 0

	BEGIN TRY
		IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID)
			BEGIN
			-- Throw a custom error if id not exist
			DECLARE @ErrorMsg varchar(50)
			SET @ErrorMsg = 'SalesOrderID#' + CONVERT(varchar(20), @SalesOrderID) + ' is not existed.';
			THROW 50001, @ErrorMsg, 0
			END
		ELSE
			BEGIN
			PRINT 'SalesOrderID#' + CONVERT(varchar(20), @SalesOrderID) + ' is existed.';
			DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
			DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
			END
	END TRY
	BEGIN CATCH 
		--Catch and print error
		PRINT ERROR_MESSAGE()
	END CATCH

--Challenge 2: Ensuring Data Consistency
--You have implemented error handling logic in some Transact-SQL code that deletes order details and order headers. 
--However, you are concerned that a failure partway through the process will result in data inconsistency in the form of
--undeleted order headers for which the order details have been deleted. 
--Tip: Review the documentation for Transaction Statements in the Transact-SQL Language Reference.

--	1. Implement a transaction
--	Enhance the code you created in the previous challenge so that the two DELETE statements are treated as a 
--	single transactional unit of work. In the error handler, modify the code so that if a transaction is in process, 
--	it is rolled back and the error is re-thrown to the client application. If not transaction is in process the error handler 
--	should continue to simply print the error message.
--	To test your transaction, add a THROW statement between the two DELETE statements to simulate an unexpected error. 
--	When testing with a valid, existing order ID, the error should be re-thrown by the error handler and no rows should be 
--	deleted from either table.

	DECLARE @SalesOrderID int = 0

	BEGIN TRY
		IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID)
			BEGIN
			-- Throw a custom error if id not exist
			DECLARE @ErrorMsg varchar(50)
			SET @ErrorMsg = 'SalesOrderID#' + CONVERT(varchar(20), @SalesOrderID) + ' is not existed.';
			THROW 50001, @ErrorMsg, 0
			END
		ELSE
			BEGIN
			PRINT 'SalesOrderID#' + CONVERT(varchar(20), @SalesOrderID) + ' is existed.';
			BEGIN TRANSACTIOn
				DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
				DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
			COMMIT TRANSACTION
			END
	END TRY
	BEGIN CATCH 
		--Catch and print error
		BEGIN 
			ROLLBACK TRANSACTION;
			THROW;
		END
		PRINT ERROR_MESSAGE()
	END CATCH