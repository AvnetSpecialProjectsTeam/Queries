ALTER PROC [dbo].[MarkPriceIncreaseComplete] @EmployeeNbr VARCHAR(40) ,@CustNbr VARCHAR(40)
AS
BEGIN
		DECLARE @EmployeeFilter varchar(45)
		SET @EmployeeFilter = @EmployeeNbr
		
		

		DECLARE @CustFilter varchar(45)
		SET @CustFilter = @CustNbr 


		

		DECLARE @MyQuery varchar(max)
		Set @MyQuery = 'Update LightTheTarget..ActionsList
		                Set PriceChangeComplete = ''X'', PriceIncreaseDateCompleted = GetDate()
		 WHERE PriceIncreaseFlag is not null and (PriceChangeComplete <> ''X'' or  PriceChangeComplete  is null) and EmployeeNbr ='''+ @EmployeeFilter +'''AND CustNbr ='+ @CustFilter
		
			BEGIN
				EXEC (@myquery)

			END
END
