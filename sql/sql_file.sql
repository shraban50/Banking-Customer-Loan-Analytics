-- banking-data-analytics/
-- ├── data/
-- │   ├── raw_dataset/
-- │   │   ├── customers.csv
-- │   │   ├── accounts.csv
-- │   │   ├── transactions.csv
-- │   │   ├── loans.csv
-- │   │   └── branches.csv
-- │   │
-- │   └── cleaned_dataset/
-- │       ├── customers_cleaned.csv
-- │       ├── accounts_cleaned.csv
-- │       ├── transactions_cleaned.csv
-- │       ├── loans_cleaned.csv
-- │       └── branches_cleaned.csv
-- │
-- ├── notebooks/
-- │
-- └── sql/
--     └── banking_analysis.sql

-- Create a relational database for the cleaned banking data.

-- The database will contain five tables:

-- 1. customers
-- 2. accounts
-- 3. transactions
-- 4. loans
-- 5. branches

CREATE DATABASE banking_analytics;
USE banking_analytics;
SELECT DATABASE();
CREATE TABLE customers (
    CustomerID BIGINT,
    Age INT,
    Gender VARCHAR(20),
    City VARCHAR(100),
    Occupation VARCHAR(100),
    Income DECIMAL(15,2),
    JoinDate DATE
);
DESCRIBE customers;
show tables; 

CREATE TABLE accounts (
    AccountID BIGINT,
    CustomerID BIGINT,
    AccountType VARCHAR(50),
    Balance DECIMAL(18,2),
    OpenDate DATE,
    Branch VARCHAR(50)
);
DESCRIBE accounts;

CREATE TABLE transactions (
    TransactionID BIGINT,
    AccountID BIGINT,
    TransactionDate DATE,
    TransactionType VARCHAR(50),
    Amount DECIMAL(18,2),
    Channel VARCHAR(50),
    Branch VARCHAR(50)
);
DESCRIBE transactions;

CREATE TABLE loans (
    LoanID BIGINT,
    CustomerID BIGINT,
    LoanType VARCHAR(50),
    LoanAmount DECIMAL(18,2),
    InterestRate DECIMAL(10,4),
    LoanDate DATE,
    LoanStatus VARCHAR(50),
    RepaymentAmount DECIMAL(18,2)
);
DESCRIBE loans;

CREATE TABLE branches (
    BranchID INT,
    BranchName VARCHAR(100),
    City VARCHAR(100),
    ManagerExperienceYears INT,
    OpenDate DATE
);

DESCRIBE branches;

LOAD DATA LOCAL INFILE
'F:/Data science/intern all file/project/Banking final intern project/data/cleaned_dataset/customers_cleaned.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

SELECT COUNT(*) AS TotalCustomers
FROM customers;

TRUNCATE TABLE customers;

SELECT *
FROM customers
LIMIT 10;

LOAD DATA LOCAL INFILE
'F:/Data science/intern all file/project/Banking final intern project/data/cleaned_dataset/accounts_cleaned.csv'
INTO TABLE accounts
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS TotalAccounts
FROM accounts;

LOAD DATA LOCAL INFILE
'F:/Data science/intern all file/project/Banking final intern project/data/cleaned_dataset/transactions_cleaned.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS TotalTransactions
FROM transactions;

LOAD DATA LOCAL INFILE
'F:/Data science/intern all file/project/Banking final intern project/data/cleaned_dataset/loans_cleaned.csv'
INTO TABLE loans
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS TotalLoans
FROM loans;

LOAD DATA LOCAL INFILE
'F:/Data science/intern all file/project/Banking final intern project/data/cleaned_dataset/branches_cleaned.csv'
INTO TABLE branches
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS TotalBranches
FROM branches;

SHOW TABLES;

