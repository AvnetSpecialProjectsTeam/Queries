INSERT INTO MDM.dbo.ConditionHeader
SELECT *
FROM OPENQUERY(AVR80, 'SELECT *
FROM GOLDEN.C_BO_CONDITION_HEADER')