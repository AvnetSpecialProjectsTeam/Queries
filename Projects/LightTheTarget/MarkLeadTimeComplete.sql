USE [LightTheTarget]
GO
/****** Object:  StoredProcedure [dbo].[MarkLeadTimeComplete]    Script Date: 6/1/2018 3:06:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[MarkLeadTimeComplete]
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
		                Set LeadTimeComplete = ''X'', LeadTimeDateCompleted = GetDate()
		 WHERE LeadTimeChangeFlag is not null and (LeadTimeComplete <> ''X'' or  LeadTimeComplete  is null) and EmployeeNbr ='
		 + @EmployeeFilter + 'AND CustNbr =' + @CustFilter + ''
		
			BEGIN
				EXEC (@myquery)

			END
	END