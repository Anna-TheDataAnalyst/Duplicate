------Find Duplicate Rows and Show Duplicate IDs for Current Month-----

DECLARE @start_date DATETIME
SELECT @start_date = GETDATE()
SELECT @start_date = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(@start_date)-1),@start_date),111)
DECLARE @end_date DATETIME = CONVERT(VARCHAR(30),getdate(),111)
IF (@start_date =  @end_date)
	SELECT @start_date = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1,0)

SELECT *
FROM(
	SELECT T.ID
	FROM TableName T 
	JOIN 
		(SELECT ID, ColName1, ColName2, ColName3, count(*) duplicate_count
		FROM TableName
			WHERE date_time >= @start_date and date_time < @end_date
			GROUP BY ID, ColName1, ColName2, ColName3
			HAVING count(*) > 1
		) T1 on T1.ID = T.ID and T1.date_time = T.date_time --and others that matter
GROUP BY T.ID) cb