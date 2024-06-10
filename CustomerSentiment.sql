-- Let's take a look at the table
SELECT *
FROM [CustomerSentiments].[dbo].[Call-Center-Sentiment-Sample-Data]



-- Create a column which shows the day of the week on which the calls were made
SELECT ID, Customer_Name, Sentiment, Call_Timestamp, Reason, City, State, Channel, Response_Time, Call_Duration_Minutes, Call_Center,DATENAME(DW, Call_Timestamp) AS DayOfWeek
FROM [CustomerSentiments].[dbo].[Call-Center-Sentiment-Sample-Data]

-- A temp table with the day of the week column
CREATE TABLE #CallsByDay
(ID nvarchar(50) NOT NULL,                      
Customer_Name nvarchar(50) NOT NULL,
Sentiment nvarchar(50) NOT NULL,
Call_Timestamp date NOT NULL,
Reason nvarchar(50) NOT NULL,
City nvarchar(50) NOT NULL,
State nvarchar(50) NOT NULL,
Channel nvarchar(50) NOT NULL,
Response_Time nvarchar(50) NOT NULL,
Call_Duration_Minutes tinyint NOT NULL,
Call_Center nvarchar(50) NOT NULL,
DayOfWeek nvarchar(50)
)

INSERT INTO #CallsByDay
SELECT ID, Customer_Name, Sentiment, Call_Timestamp, Reason, City, State, Channel, Response_Time, Call_Duration_Minutes, Call_Center, DATENAME(DW, Call_Timestamp) AS DayOfWeek
FROM [CustomerSentiments].[dbo].[Call-Center-Sentiment-Sample-Data]


-- Has any customer called more than once?
SELECT Customer_Name, COUNT(Customer_Name)
FROM [CustomerSentiments].[dbo].[Call-Center-Sentiment-Sample-Data]
GROUP BY Customer_Name
HAVING COUNT(Customer_Name) > 1


-- What is the most common sentiment of the callers
SELECT Sentiment, count(*) AS SentiCount
FROM  [CustomerSentiments].[dbo].[Call-Center-Sentiment-Sample-Data]
GROUP BY Sentiment
ORDER BY SentiCount DESC


-- What is the common reason for calls
SELECT Reason, count(*) AS ReasonCount
FROM  [CustomerSentiments].[dbo].[Call-Center-Sentiment-Sample-Data]
GROUP BY Reason
ORDER BY ReasonCount DESC


-- Which channel is used most often
SELECT Channel, count(*) AS CommonChannel
FROM  [CustomerSentiments].[dbo].[Call-Center-Sentiment-Sample-Data]
GROUP BY Channel
ORDER BY CommonChannel DESC


-- Store table for visualization.
CREATE VIEW CustomerSentimentsData AS
SELECT ID, Customer_Name, Sentiment, Call_Timestamp, Reason, City, State, Channel, Response_Time, Call_Duration_Minutes, Call_Center, DATENAME(DW, Call_Timestamp) AS DayOfWeek
FROM [CustomerSentiments].[dbo].[Call-Center-Sentiment-Sample-Data]


SELECT *
FROM CustomerSentimentsData


