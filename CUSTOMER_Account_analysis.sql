USE BANKING_ANALYTICS;
## :-: OVERALL TRANSACTION ANALYSIS

## --> WHAT IS THE OVERALL TRANSACTION VOLUME AND VALUE?
SELECT *
from bank_transactions;
create table bank_transactions (
    TransactionID VARCHAR(50),
    AccountID varchar(50),
    TransactionAmount Decimal(12,2),
    TransactionDate DATETIME,
    TransactionType VARCHAR(20),
    Location VARCHAR(100),
    DeviceID VARCHAR(50),
    IP_Address VARCHAR(50),
    MerchantID VARCHAR(50),
    Channel VARCHAR(30),
    CustomerAge INT,
    CustomerOccupation VARCHAR(50),
    TransactionDuration INT,
    LoginAttempts INT,
    AccountBalance DECIMAL(12,2)
);

DESCRIBE bank_transactions;
SELECT COUNT(*) AS Total_Transactions
FROM bank_transactions;
SELECT SUM(TransactionAmount) AS Total_Transaction_Amount
FROM bank_transactions;
SELECT AVG(TransactionAmount) AS Average_Transaction_Amount
FROM bank_transactions;

## :-: TRANSACTION TYPES ANALYSIS

## --> WHAT IS THE DISTRIBUTION BETWEEN CREDIT AND DEBIT TRANSACTIONS? 
select
    TransactionType,
    count(*) as Transaction_Count,
    sum(TransactionAmount) AS Total_Amount,
    AVG(TransactionAmount) AS Average_Amount
    from bank_transactions
    group by TransactionType;
    
select
      channel,
      count(*) AS Transaction_count,
      sum(TransactionAmount) AS total_Amount,
      AVG (TransactionAmount) AS Average_Amount
from bank_Transactions
group  by  channel
order by  total_Amount  DESC;

SELECT 
    Location,
    COUNT(*) AS Transaction_Count,
    SUM(TransactionAmount) AS Total_Amount
FROM bank_transactions
GROUP BY Location
ORDER BY Total_Amount DESC;

SELECT 
    CustomerOccupation,
    COUNT(*) AS Transaction_Count,
    AVG(TransactionAmount) AS Average_Transaction
FROM bank_transactions
GROUP BY CustomerOccupation
ORDER BY Average_Transaction DESC;

SELECT 
    AccountID,
    COUNT(*) AS Transaction_Count,
    SUM(TransactionAmount) AS Total_Amount
FROM bank_transactions
GROUP BY AccountID
ORDER BY Total_Amount DESC
LIMIT 10;

SELECT SUM(TransactionAmount) AS Total_Transaction_Amount
FROM bank_transactions;

SELECT AVG(TransactionAmount) AS Average_Transaction_Amount
FROM bank_transactions;
select
   AccountID,
   count(*) AS Transaction_count,
   Sum(transactionAmount) AS
  Total_Transaction_Amount,
   AVG(TransactionAmount)as
   Average_Transaction_Amount,
    AVG(AccountBalance)as
   Average_Account_Balance
   from bank_Transactions
   group by AccountID
   Order BY Total_Transaction_Amount DESC
   LIMIT 10;
SELECT
    AccountID,
    COUNT(*) AS Transaction_Count,
    SUM(TransactionAmount) AS Total_Transaction_Amount,
    AVG(TransactionAmount) AS Average_Transaction_Amount,
    AVG(AccountBalance) AS Average_Account_Balance
FROM bank_transactions
GROUP BY AccountID
ORDER BY Total_Transaction_Amount DESC
LIMIT 10;   


select count(*) as Total_Rows
from bank_transactions;
select database();
select count(*) as Total_Rows
from bank_transactions;
show variables like'local_infile';
set global local_infile = 1;
show variables like'local_infile';



select database();bank_transactions

create database if not exists
banking_analytics;
use banking_analytics;

select count(*) as total_rows
from bank_transactions;
USE banking_analytics;

SELECT COUNT(*) AS total_transactions
FROM bank_transactions;
show tables;
USE banking_analytics;
SELECT COUNT(*) AS total_transactions
from bank_transactions_sql_final;
USE banking_analytics;
rename table bank_transactions_sql_final
TO bank_transactions;
show tables;
SELECT COUNT(*) AS total_transactions
from bank_transactions;
describe bank_transactions;
select*
from bank_transactions
limit 10;
alter table bank_transactions
add column'year'INT;

UPDATE bank_transactions
SET Year =
CASE
    WHEN TransactionDate LIKE '% %'
        THEN YEAR(STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i'))
    ELSE YEAR(STR_TO_DATE(TransactionDate, '%m/%d/%Y'))
END;

describe bank_transactions;
select TransactionDate
from bank_transactions
limit 10;

UPDATE bank_transactions
SET `Year` = YEAR(STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i'));

## -- CHECK DATA QUALITY
select count(*) as total_rows
from bank_transactions;

SELECT
    SUM(TransactionID IS NULL) AS TransactionID_NULL,
    SUM(AccountID IS NULL) AS AccountID_NULL,
    SUM(TransactionAmount IS NULL) AS Amount_NULL,
    SUM(TransactionDate IS NULL) AS Date_NULL,
    SUM(TransactionType IS NULL) AS Type_NULL,
    SUM(Location IS NULL) AS Location_NULL,
    SUM(DeviceID IS NULL) AS DeviceID_NULL,
    SUM(`IP Address` IS NULL) AS IP_NULL,
    SUM(MerchantID IS NULL) AS MerchantID_NULL,
    SUM(Channel IS NULL) AS Channel_NULL,
    SUM(CustomerAge IS NULL) AS Age_NULL,
    SUM(CustomerOccupation IS NULL) AS Occupation_NULL,
    SUM(TransactionDuration IS NULL) AS Duration_NULL,
    SUM(LoginAttempts IS NULL) AS LoginAttempts_NULL,
    SUM(AccountBalance IS NULL) AS Balance_NULL
FROM bank_transactions;
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT TransactionID) AS unique_transactions
FROM bank_transactions;

SELECT 
    TransactionType,
    COUNT(*) AS transaction_count
FROM bank_transactions
GROUP BY TransactionType;

## -- DUPLICATE TRANSACTIONS
SELECT 
   COUNT(*) AS total_rows,
   COUNT(distinct TransactionID) AS 
unique_transactions
from bank_transactions;

## --BUSINESS QUESTION :- WHAT IS THE TOTAL,AVERAGE,MINIMUM AND MAXIMUM TRANSACTION AMOUNT?
Select
  COUNT(*) AS total_transactions,
  sum(transactionAmount) AS
Total_transaction_amount,
   Round(avg(TransactionAmount),2)AS
average_transaction_amount,
   min(TransactionAmount) AS
Minimum_Transaction,
   max(TransactionAmount) AS
maximum_transaction
from bank_transactions; 

SELECT
    TransactionType,
    COUNT(*) AS transaction_count,
    ROUND(SUM(TransactionAmount), 2) AS total_amount,
    ROUND(AVG(TransactionAmount), 2) AS average_amount
FROM bank_transactions
GROUP BY TransactionType
ORDER BY total_amount DESC;  

## -> CHANNEL ANALYSIS
SELECT
    Channel,
    COUNT(*) AS transaction_count,
    ROUND(SUM(TransactionAmount), 2) AS total_amount,
    ROUND(AVG(TransactionAmount), 2) AS average_amount
FROM bank_transactions
GROUP BY Channel
ORDER BY total_amount DESC;

## -> TRANSACTION TYPE X CHANNEL
SELECT
    Channel,
    TransactionType,
    COUNT(*) AS transaction_count,
    ROUND(SUM(TransactionAmount), 2) AS total_amount
  from bank_transactions
  Group by channel,TransactionType
  order by channel,total_amount DESC;
  
  SELECT
    CustomerOccupation,
    COUNT(*) AS transaction_count,
    ROUND(SUM(TransactionAmount), 2) AS total_amount,
    ROUND(AVG(TransactionAmount), 2) AS average_amount
FROM bank_transactions
GROUP BY CustomerOccupation
ORDER BY total_amount DESC;

## -> AGE GROUP ANALYSIS

## QUESTION -> WHICH AGE GROUPS ARE THE MOST FINANCIALLY ACTIVE?
SELECT
    CASE
        WHEN CustomerAge BETWEEN 18 AND 25 THEN '18-25'
        WHEN CustomerAge BETWEEN 26 AND 35 THEN '26-35'
        WHEN CustomerAge BETWEEN 36 AND 50 THEN '36-50'
        WHEN CustomerAge BETWEEN 51 AND 65 THEN '51-65'
        ELSE '66-80'
    END AS age_group,
    COUNT(*) AS transaction_count,
    ROUND(SUM(TransactionAmount), 2) AS total_amount,
    ROUND(AVG(TransactionAmount), 2) AS average_amount
FROM bank_transactions
GROUP BY age_group
ORDER BY total_amount DESC;

## -> LOCATION ANALYSIS
SELECT
    Location,
    COUNT(*) AS transaction_count,
    ROUND(SUM(TransactionAmount), 2) AS total_amount,
    ROUND(AVG(TransactionAmount), 2) AS average_amount
FROM bank_transactions
GROUP BY Location
ORDER BY total_amount DESC;

## -> MONTHLY TRANSACTIONS TREND ANALYSIS
SELECT
    `Year`,
    `Month`,
    COUNT(*) AS transaction_count,
    ROUND(SUM(TransactionAmount), 2) AS total_amount,
    ROUND(AVG(TransactionAmount), 2) AS average_amount
FROM bank_transactions
GROUP BY `Year`, `Month`
ORDER BY `Year`, `Month`;

SELECT
    Year,
    MONTH(
        COALESCE(
            STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i'),
            STR_TO_DATE(TransactionDate, '%m/%d/%Y')
        )
    ) AS Month,
    COUNT(*) AS transaction_count,
    ROUND(SUM(TransactionAmount), 2) AS total_amount,
    ROUND(AVG(TransactionAmount), 2) AS average_amount
FROM bank_transactions
GROUP BY Year, Month
ORDER BY Year, Month;

SELECT 
    TransactionDate,
    Year
FROM bank_transactions
LIMIT 10;

UPDATE bank_transactions
SET Year = YEAR(
    COALESCE(
        STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i'),
        STR_TO_DATE(TransactionDate, '%m/%d/%Y')
    )
);
select year,count(*) AS
transaction_count
from bank_transactions
group by year
order by year;

UPDATE bank_transactions
SET Year = YEAR(
    COALESCE(
        STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i'),
        STR_TO_DATE(TransactionDate, '%m/%d/%Y')
    )
);

SELECT
    YEAR(STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i')) AS transaction_year,
    COUNT(*) AS transaction_count,
    ROUND(SUM(TransactionAmount), 2) AS total_amount,
    ROUND(AVG(TransactionAmount), 2) AS average_amount
FROM bank_transactions
GROUP BY transaction_year
ORDER BY transaction_year;

## -> HIGH - VALUE TRANSACTIONS
SELECT
    TransactionID,
    AccountID,
    TransactionAmount,
    TransactionType,
    Channel,
    Location
FROM bank_transactions
ORDER BY TransactionAmount DESC
LIMIT 10;

## -> CUSTOMER/ACCOUNT ANALYSIS
## QUESTION--> WHICH ACCOUNTS HAVE THE HIGHEST TRANSACTION ACTIVITY?
select
   accountID,
   COUNT(*)AS total_transactions,
   sum(TransactionAmount)as total_amount,
   AVG(TransactionAmount) as Avg_Transaction_Amount,
   MIN(TransactionAmount)as min_Transaction,
   MAX(TransactionAmount) AS max_transaction
   from bank_transactions
   group by accountID
   order BY Total_amount DESC;
   
   ##--QUESTION -> WHICH ACCOUNTS HAVE THE HIGHEST TRANSACTION ACTIVITY AND VALUE?
    
   select
   accountID,
   COUNT(*)AS total_transactions,
   sum(TransactionAmount)as total_amount
   from bank_transactions
   group by accountID
   order by total_transactions DESC
   limit 10;
   
   Select 
	 accountID,
     AVG(AccountBalance) as avg_account_balance,
     max(accountbalance) as Highest_balance,
     min(Accountbalance) as lowest_balance
    from bank_transactions
    group by accountID
    ORDER BY Avg_account_balance DESC;

## CUSTOMER AGE- WISE TRANSACTION ANALYSIS

## -> WHICH AGE GROUPS ARE MORE ACTIVE IN BANKING TRANSACTIONS ?
SELECT
    CustomerAge,
    COUNT(*) AS Total_Transactions,
    SUM(TransactionAmount) AS Total_Amount,
    AVG(TransactionAmount) AS Avg_Transaction_Amount
FROM bank_transactions
GROUP BY CustomerAge
ORDER BY CustomerAge;

## - OCCUPATION-WISE CUSTOMER ANALYSIS
SELECT
    CustomerOccupation,
    COUNT(*) AS Total_Transactions,
    SUM(TransactionAmount) AS Total_Amount,
    AVG(TransactionAmount) AS Avg_Transaction_Amount,
    AVG(AccountBalance) AS Avg_Account_Balance
FROM bank_transactions
GROUP BY CustomerOccupation
ORDER BY Total_Amount DESC;

## CUSTOMER AGE GROUP ANALYSIS
SELECT
    CASE
        WHEN CustomerAge < 25 THEN '18-24'
        WHEN CustomerAge BETWEEN 25 AND 34 THEN '25-34'
        WHEN CustomerAge BETWEEN 35 AND 44 THEN '35-44'
        WHEN CustomerAge BETWEEN 45 AND 54 THEN '45-54'
        WHEN CustomerAge >= 55 THEN '55+'
    END AS Age_Group,
    COUNT(*) AS Total_Transactions,
    SUM(TransactionAmount) AS Total_Amount,
    AVG(TransactionAmount) AS Avg_Transaction_Amount,
    AVG(AccountBalance) AS Avg_Account_Balance
FROM bank_transactions
GROUP BY Age_Group
ORDER BY Total_Amount DESC;

## QUESTION--> Which customer age group contributes the most transaction value and maintains the highest average account balance?
SELECT
    CASE
        WHEN CustomerAge < 25 THEN '18-24'
        WHEN CustomerAge BETWEEN 25 AND 34 THEN '25-34'
        WHEN CustomerAge BETWEEN 35 AND 44 THEN '35-44'
        WHEN CustomerAge BETWEEN 45 AND 54 THEN '45-54'
        WHEN CustomerAge >= 55 THEN '55+'
    END AS Age_Group,
    COUNT(*) AS Total_Transactions,
    SUM(TransactionAmount) AS Total_Amount,
    AVG(TransactionAmount) AS Avg_Transaction_Amount,
    AVG(AccountBalance) AS Avg_Account_Balance
FROM bank_transactions
GROUP BY Age_Group
ORDER BY Total_Amount DESC;

-- MONTHLY TRANSACTION TREND
SELECT
    YEAR(TransactionDate) AS Year,
    MONTH(TransactionDate) AS Month,
    COUNT(*) AS Total_Transactions,
    SUM(TransactionAmount) AS Total_Amount,
    AVG(TransactionAmount) AS Avg_Transaction_Amount
FROM bank_transactions
WHERE TransactionDate IS NOT NULL
GROUP BY YEAR(TransactionDate), MONTH(TransactionDate)
ORDER BY Year, Month;

Select transactionDate
from bank_transactions
limit10;

SELECT
    YEAR(STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i')) AS Year,
    MONTH(STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i')) AS Month,
    COUNT(*) AS Total_Transactions,
    SUM(TransactionAmount) AS Total_Amount,
    AVG(TransactionAmount) AS Avg_Transaction_Amount
FROM bank_transactions
GROUP BY
    YEAR(STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i')),
    MONTH(STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i'))
ORDER BY Year, Month;

## QUESTION:-> WHICH ACCOUNTS HAVE THE HIGHEST DEBIT AND CREDIT ACTIVITY?
SELECT
    AccountID,
    SUM(CASE WHEN TransactionType = 'Credit' THEN TransactionAmount ELSE 0 END) AS Total_Credit,
    SUM(CASE WHEN TransactionType = 'Debit' THEN TransactionAmount ELSE 0 END) AS Total_Debit,
    COUNT(*) AS Total_Transactions
FROM bank_transactions
GROUP BY AccountID
ORDER BY Total_Debit DESC
LIMIT 10;

## RISK AND CUSTOMER BEHAVIOUR ANALYSIS

SELECT
    AccountID,
    COUNT(*) AS Total_Transactions,
    AVG(LoginAttempts) AS Avg_Login_Attempts,
    MAX(LoginAttempts) AS Max_Login_Attempts
FROM bank_transactions
GROUP BY AccountID
HAVING MAX(LoginAttempts) >= 3
ORDER BY Max_Login_Attempts DESC, Avg_Login_Attempts DESC;

## WHICH ACCOUNTS SHOW UNUSUALLY HIGH LOGIN_ATTEMPT ACTIVITY AND MAY REQUIRE ADDITIONAL MONITORING?

-- ANS-> THIS DATASET ALONE DOES NOT PROVE FRAUDLENT ACTIVITY. I USED LOGIN-ATTEMPT BEHAVIOUR AS A RISK INDICATOR,NOT AS PROOF OF FRAUD.

## :-: LOGIN / RISK ANALYSIS

## QUESTION:->Which accounts have both relatively high transaction value and elevated login attempts?
SELECT
    AccountID,
    COUNT(*) AS Total_Transactions,
    SUM(TransactionAmount) AS Total_Amount,
    AVG(LoginAttempts) AS Avg_Login_Attempts,
    MAX(LoginAttempts) AS Max_Login_Attempts
FROM bank_transactions
GROUP BY AccountID
HAVING MAX(LoginAttempts) >= 4
   AND SUM(TransactionAmount) > 50000
ORDER BY Total_Amount DESC;

## :-: FINAL BUSINESS INSIGHTS 
## QUESTION --> WHAT ARE THE KEY OVERALL BANKING PERFORMANCE METRICS ?
SELECT
    COUNT(*) AS Total_Transactions,
    COUNT(DISTINCT AccountID) AS Total_Accounts,
    SUM(TransactionAmount) AS Total_Transaction_Value,
    AVG(TransactionAmount) AS Avg_Transaction_Value,
    MAX(TransactionAmount) AS Highest_Transaction,
    AVG(AccountBalance) AS Avg_Account_Balance
FROM bank_transactions;

## -> “I analyzed 50,000 banking transactions across 495 accounts using SQL to understand TRANSACTIONS BEHAVIOUR,
## --> CUSTOMER SEGMENTS,CHANNELS,ACCOUNT ACTIVITY AND POTENTIAL RISK INDICATORS. I THEN PLANNED TO VISUALIZE THE KEY FINDINGS IN TABLEAU ".


