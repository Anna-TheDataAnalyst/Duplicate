-----Running this code you will get the dates in the first column.-----
-----Then for each joined table you will get a column where it shows the dates that are missing and if not missing, it will return NULL.-----
-----If you get everything NULL then you don't have any missing dates.-----
-----This code runs for current month only, from the 1st to today. If you want a different time period, change @start_date and @end_date to your desired period.-----


DECLARE @start_date DATETIME
SELECT @start_date = GETDATE()
SELECT @start_date = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(@start_date)-1),@start_date),111)
DECLARE @end_date DATETIME = CONVERT(VARCHAR(30),GETDATE(),111)
IF (@start_date =  @end_date)
	SELECT @start_date = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1,0)

DECLARE @DateSequence TABLE(
DATES DATE
)

WHILE (@start_date < @end_date)
BEGIN
INSERT @DateSequence
SELECT  CONVERT(DATE, @start_date)
SET @start_date = CONVERT(DATE,DATEADD(DAY,1,@start_date))
END
SELECT *
FROM @DateSequence D

LEFT JOIN (
SELECT ColName1 = DATES
FROM @DateSequence
EXCEPT
SELECT DISTINCT CAST(( CONVERT(DATE, DateFromTable1)) AS DATE) ColName1
FROM Table1) d1 on D.DATES = d1.ColName1

LEFT JOIN (
SELECT ColName2 = DATES
FROM @DateSequence
EXCEPT
SELECT DISTINCT CAST(( CONVERT(DATE, DateFromTable2)) AS DATE) ColName2
FROM Table2) d2 on D.DATES = d2.ColName2

LEFT JOIN (
SELECT ColName3 = DATES
FROM @DateSequence
EXCEPT
SELECT DISTINCT CAST(( CONVERT(DATE, DateFromTable3)) AS DATE) ColName3
FROM Table3) d3 on D.DATES = d3.ColName3