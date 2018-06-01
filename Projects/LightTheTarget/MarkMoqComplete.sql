USE [LightTheTarget]
GO
/****** Object:  StoredProcedure [dbo].[MarkMOQComplete]    Script Date: 6/1/2018 3:06:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[MarkMOQComplete]
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
		                Set MoqComplete = ''X'', MoqDateCompleted = GetDate()
		 WHERE MoqChangeFlag is not null and (MoqComplete <> ''X'' or  MoqComplete  is null) and EmployeeNbr ='
		 + @EmployeeFilter + 'AND CustNbr =' + @CustFilter + ''
		
			BEGIN
				EXEC (@myquery)

			END
	END