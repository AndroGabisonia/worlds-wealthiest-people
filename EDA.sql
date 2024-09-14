SELECT * FROM billionaires_edit1

SELECT * FROM billionaires

--Total net worth of billionaires by countrry--
SELECT COUNTRY, SUM(NET_WORTH_FLOAT) [TOTAL] FROM billionaires_edit1
GROUP BY COUNTRY
ORDER BY TOTAL DESC

--Richest people in different countries--
WITH RANKING_BY_COUNTRY AS(
	SELECT COUNTRY, EXECUTIVE_NAME, COMPANY, NET_WORTH_FLOAT, ROW_NUMBER() OVER (PARTITION BY COUNTRY ORDER BY NET_WORTH_FLOAT DESC) AS RANKING
	FROM billionaires_edit1
)
SELECT * FROM RANKING_BY_COUNTRY
WHERE RANKING = 1
ORDER BY NET_WORTH_FLOAT DESC


--Top 10 billionaires--
SELECT * FROM billionaires
WHERE RANK <= 10 

--Companies/Businesses that made most billionaires 
SELECT COMPANY, COUNT(EXECUTIVE_NAME) AS [TOTAL NUMBER OF BILLIONAIRES] FROM billionaires_edit1
GROUP BY COMPANY
ORDER BY [TOTAL NUMBER OF BILLIONAIRES] DESC

--Countries with single billionaires--
SELECT COUNTRY, COUNT(COUNTRY) AS [NUMBER OF BILLIONAIRES] FROM billionaires
GROUP BY COUNTRY
HAVING COUNT(COUNTRY) = 1
ORDER BY COUNTRY

--Countries that have 2 or less billionaires--
SELECT COUNTRY, COUNT(COUNTRY) AS [NUMBER OF BILLIONAIRES] FROM billionaires
GROUP BY COUNTRY
HAVING COUNT(COUNTRY) <= 2
ORDER BY [NUMBER OF BILLIONAIRES] DESC

--Total net-worth of billionaires in Georgia--
SELECT COUNTRY, SUM(NET_WORTH_FLOAT) FROM billionaires_edit1
WHERE COUNTRY = 'Georgia'
GROUP BY COUNTRY

--Billionaires in Georgia--
SELECT * FROM billionaires
WHERE COUNTRY = 'Georgia'

--Which countries has the most billionaires--
SELECT COUNTRY, COUNT(COUNTRY) AS 'NUMBER OF BILLIONAIRES' FROM billionaires
GROUP BY COUNTRY
ORDER BY [NUMBER OF BILLIONAIRES] DESC
-------------------------------------------------------------------------------
WITH CTE AS(
	SELECT COUNTRY, COUNT(COUNTRY) AS 'NUMBER OF BILLIONAIRES' FROM billionaires
	GROUP BY COUNTRY
)
SELECT SUM([NUMBER OF BILLIONAIRES]) FROM CTE

--Approximate net-worth of billionaire families--
SELECT CAST(SUM(NET_WORTH_FLOAT)/1000000000000) AS [TOTAL NET WORTH OF BILLIONAIRE FAMILIES] FROM billionaires_edit1
WHERE EXECUTIVE_NAME LIKE '%family%'

--Billionaires that own family bussiness--
SELECT * FROM billionaires
WHERE EXECUTIVE_NAME LIKE '%family%'
