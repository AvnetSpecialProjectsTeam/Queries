USE [LightTheTarget]
GO
/****** Object:  StoredProcedure [dbo].[MarkNCNRComplete]    Script Date: 6/1/2018 3:06:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[MarkNCNRComplete]
	@EmployeeNbr VARCHAR(40),
	@CustNbr VARCHAR(40)
AS
	BEGIN
		DECLARE @EmployeeFilter varchar(45)
		SET @EmployeeFilter = @EmployeeNbr
		
		

		DECLARE @CustFilter varchar(45)
		SET @CustFilter = @CustNbr 


		

		DECLARE @MyQuery varchar(max)
		Set @MyQuery = 'Update LightTheTarget..ActionsList
		                Set NcnrComplete = ''X'', NcnrDateCompleted = GetDate()
		 WHERE NcnrChangeFlag is not null and (NcnrComplete <> ''X'' or  NcnrComplete  is null) and EmployeeNbr ='
		 + @EmployeeFilter + 'AND CustNbr =' + @CustFilter + ''
		
			BEGIN
				EXEC (@myquery)

			END
	END