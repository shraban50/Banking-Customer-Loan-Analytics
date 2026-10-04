-- ================================================================
-- BANKING CUSTOMER & LOAN ANALYTICS
-- SQL ANALYSIS PROJECT
-- ================================================================
-- Database  : banking_analytics
-- Tool      : MySQL Workbench
-- Scope     : Week 3 - SQL Analysis
-- Dataset   : Cleaned Banking Dataset
-- Coverage  : Basic, Intermediate, Subqueries, CTEs,
--             Window Functions, and Advanced Analysis
-- Questions : Q1 - Q60
--
-- IMPORTANT:
-- The queries below use the CLEANED datasets already loaded into
-- MySQL. Raw CSV files are not used for SQL analysis.
--
-- PROJECT TABLES:
-- customers     : CustomerID, Age, Gender, City, Occupation, Income, JoinDate
-- accounts      : AccountID, CustomerID, AccountType, Balance, OpenDate, Branch
-- transactions  : TransactionID, AccountID, TransactionDate,
--                 TransactionType, Amount, Channel, Branch
-- loans         : LoanID, CustomerID, LoanType, LoanAmount, InterestRate,
--                 LoanDate, LoanStatus, RepaymentAmount
-- branches      : BranchID, BranchName, City, ManagerExperienceYears, OpenDate
--
-- NOTE:
-- Customer, account, transaction and loan records are linked using
-- CustomerID / AccountID. Branch information in accounts and
-- transactions is stored as Branch text, while branches has BranchID
-- and BranchName.
-- ================================================================

USE banking_analytics;
show databases;

-- ================================================================
-- 0. DATABASE VERIFICATION
-- ================================================================

SELECT DATABASE() AS CurrentDatabase;

SHOW TABLES;

SELECT 'customers' AS TableName, COUNT(*) AS TotalRows
FROM customers
UNION ALL
SELECT 'accounts', COUNT(*)
FROM accounts
UNION ALL
SELECT 'transactions', COUNT(*)
FROM transactions
UNION ALL
SELECT 'loans', COUNT(*)
FROM loans
UNION ALL
SELECT 'branches', COUNT(*)
FROM branches;


-- ================================================================
-- 1. BASIC SQL ANALYSIS
-- ================================================================

-- Q1. Retrieve customers and filter by income
-- Question: Display customers whose income is greater than 50000.

SELECT
    CustomerID,
    Age,
    Gender,
    City,
    Occupation,
    Income,
    JoinDate
FROM customers
WHERE Income > 50000
LIMIT 100;


-- Q2. Sort customers by income
-- Question: Display customers sorted by income from highest to lowest.

SELECT
    CustomerID,
    Age,
    Gender,
    City,
    Occupation,
    Income
FROM customers
ORDER BY Income DESC
LIMIT 100;


-- Q3. Calculate average customer income

SELECT
    ROUND(AVG(Income), 2) AS average_customer_income
FROM customers;


-- Q4. Calculate average customer age

SELECT
    ROUND(AVG(Age), 2) AS average_customer_age
FROM customers;


-- Q5. Calculate total customer income

SELECT
    ROUND(SUM(Income), 2) AS total_customer_income
FROM customers;


-- Q6. Count total customers

SELECT
    COUNT(*) AS total_customers
FROM customers;


-- Q7. Retrieve customers from a specific city
-- Question: Display customers who live in Kathmandu.

SELECT
    CustomerID,
    Age,
    Gender,
    City,
    Occupation,
    Income
FROM customers
WHERE City = 'Kathmandu'
LIMIT 100;


-- Q8. Group customers by city
-- Question: How many customers are there in each city?

SELECT
    City,
    COUNT(*) AS customer_count
FROM customers
GROUP BY City
ORDER BY customer_count DESC;


-- Q9. Group loans by loan type
-- Question: How many loans are there for each loan type?

SELECT
    LoanType,
    COUNT(*) AS loan_count
FROM loans
GROUP BY LoanType
ORDER BY loan_count DESC;


-- Q10. Calculate total deposits
-- In this project, account Balance represents the account balance
-- used for deposit analysis.

SELECT
    ROUND(SUM(Balance), 2) AS total_deposits
FROM accounts;


-- Q11. Find unique cities

SELECT DISTINCT
    City
FROM customers
ORDER BY City;


-- Q12. Find unique account types

SELECT DISTINCT
    AccountType
FROM accounts
ORDER BY AccountType;


-- Q13. Find unique loan types

SELECT DISTINCT
    LoanType
FROM loans
ORDER BY LoanType;


-- Q14. Count customers with accounts

SELECT
    COUNT(DISTINCT CustomerID) AS customers_with_accounts
FROM accounts;


-- Q15. Count customers with loans

SELECT
    COUNT(DISTINCT CustomerID) AS customers_with_loans
FROM loans;


-- Q16. Calculate total loan amount

SELECT
    ROUND(SUM(LoanAmount), 2) AS total_loan_amount
FROM loans;


-- Q17. Calculate average loan amount

SELECT
    ROUND(AVG(LoanAmount), 2) AS average_loan_amount
FROM loans;


-- Q18. Find minimum and maximum loan amount

SELECT
    MIN(LoanAmount) AS minimum_loan_amount,
    MAX(LoanAmount) AS maximum_loan_amount
FROM loans;


-- Q19. Calculate total transaction amount

SELECT
    ROUND(SUM(Amount), 2) AS total_transaction_amount
FROM transactions;


-- Q20. Count transactions by transaction type

SELECT
    TransactionType,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY TransactionType
ORDER BY transaction_count DESC;


-- ================================================================
-- 2. INTERMEDIATE SQL ANALYSIS
-- ================================================================

-- 2.1 JOIN
-- ================================================================

-- Q21. Find customers who have taken loans

SELECT DISTINCT
    c.CustomerID,
    c.Age,
    c.Gender,
    c.City,
    c.Occupation,
    c.Income,
    l.LoanType,
    l.LoanAmount,
    l.LoanStatus
FROM customers c
INNER JOIN loans l
    ON c.CustomerID = l.CustomerID
LIMIT 100;


-- Q22. Find customers who have accounts but never taken a loan

SELECT DISTINCT
    c.CustomerID,
    c.Age,
    c.Gender,
    c.City,
    c.Income
FROM customers c
INNER JOIN accounts a
    ON c.CustomerID = a.CustomerID
LEFT JOIN loans l
    ON c.CustomerID = l.CustomerID
WHERE l.CustomerID IS NULL
LIMIT 100;


-- Q23. Find accounts with their customer information

SELECT
    a.AccountID,
    a.CustomerID,
    c.City,
    c.Occupation,
    a.AccountType,
    a.Balance,
    a.OpenDate,
    a.Branch
FROM accounts a
INNER JOIN customers c
    ON a.CustomerID = c.CustomerID
LIMIT 100;


-- Q24. Find loans with customer information

SELECT
    l.LoanID,
    l.CustomerID,
    c.City,
    c.Occupation,
    c.Income,
    l.LoanType,
    l.LoanAmount,
    l.InterestRate,
    l.LoanStatus
FROM loans l
INNER JOIN customers c
    ON l.CustomerID = c.CustomerID
LIMIT 100;


-- Q25. Find transactions with account and customer information

SELECT
    t.TransactionID,
    t.AccountID,
    a.CustomerID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount,
    t.Channel,
    t.Branch
FROM transactions t
INNER JOIN accounts a
    ON t.AccountID = a.AccountID
LIMIT 100;


-- ================================================================
-- 2.2 GROUP BY
-- ================================================================

-- Q26. Calculate branch-wise number of customers
-- Branch is stored in the accounts table as text.

SELECT
    Branch,
    COUNT(DISTINCT CustomerID) AS customer_count
FROM accounts
GROUP BY Branch
ORDER BY customer_count DESC;


-- Q27. Calculate branch-wise deposits

SELECT
    Branch,
    ROUND(SUM(Balance), 2) AS total_deposits
FROM accounts
GROUP BY Branch
ORDER BY total_deposits DESC;


-- Q28. Calculate branch-wise loans
-- Loan records do not contain a Branch column in this dataset.
-- Therefore branch-wise loans are linked through the customer's
-- account branch.

SELECT
    a.Branch,
    COUNT(DISTINCT l.LoanID) AS loan_count,
    ROUND(SUM(l.LoanAmount), 2) AS total_loans
FROM accounts a
INNER JOIN loans l
    ON a.CustomerID = l.CustomerID
GROUP BY a.Branch
ORDER BY total_loans DESC;


-- Q29. Calculate branch-wise transactions

SELECT
    Branch,
    COUNT(*) AS transaction_count,
    ROUND(SUM(Amount), 2) AS total_transaction_amount
FROM transactions
GROUP BY Branch
ORDER BY total_transaction_amount DESC;


-- ================================================================
-- 2.3 CUSTOMER-WISE TOTALS
-- ================================================================

-- Q30. Total account balance for each customer

SELECT
    CustomerID,
    ROUND(SUM(Balance), 2) AS total_account_balance
FROM accounts
GROUP BY CustomerID
ORDER BY total_account_balance DESC;


-- Q31. Total transaction amount for each customer

SELECT
    a.CustomerID,
    ROUND(SUM(t.Amount), 2) AS total_transaction_amount
FROM accounts a
INNER JOIN transactions t
    ON a.AccountID = t.AccountID
GROUP BY a.CustomerID
ORDER BY total_transaction_amount DESC;


-- Q32. Total loan amount for each customer

SELECT
    CustomerID,
    ROUND(SUM(LoanAmount), 2) AS total_loan_amount
FROM loans
GROUP BY CustomerID
ORDER BY total_loan_amount DESC;


-- ================================================================
-- 2.4 HAVING
-- ================================================================

-- Q33. Find cities with more than 1000 customers

SELECT
    City,
    COUNT(*) AS customer_count
FROM customers
GROUP BY City
HAVING COUNT(*) > 1000
ORDER BY customer_count DESC;


-- Q34. Find customers whose total account balance is above 100000

SELECT
    CustomerID,
    ROUND(SUM(Balance), 2) AS total_balance
FROM accounts
GROUP BY CustomerID
HAVING SUM(Balance) > 100000
ORDER BY total_balance DESC;


-- Q35. Find loan types with more than 10000 loans

SELECT
    LoanType,
    COUNT(*) AS loan_count
FROM loans
GROUP BY LoanType
HAVING COUNT(*) > 10000
ORDER BY loan_count DESC;


-- ================================================================
-- 2.5 CASE
-- ================================================================

-- Q36. Categorize customers based on income

SELECT
    CustomerID,
    Income,
    CASE
        WHEN Income < 30000 THEN 'Low Income'
        WHEN Income < 70000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS IncomeSegment
FROM customers
LIMIT 100;


-- Q37. Categorize loans based on loan amount

SELECT
    LoanID,
    LoanAmount,
    CASE
        WHEN LoanAmount < 1000000 THEN 'Small Loan'
        WHEN LoanAmount < 5000000 THEN 'Medium Loan'
        ELSE 'Large Loan'
    END AS LoanCategory
FROM loans
LIMIT 100;


-- Q38. Categorize accounts based on balance

SELECT
    AccountID,
    CustomerID,
    Balance,
    CASE
        WHEN Balance < 50000 THEN 'Low Balance'
        WHEN Balance < 200000 THEN 'Medium Balance'
        ELSE 'High Balance'
    END AS BalanceCategory
FROM accounts
LIMIT 100;


-- Q39. Categorize loan repayment performance

SELECT
    LoanID,
    LoanAmount,
    RepaymentAmount,
    CASE
        WHEN RepaymentAmount >= LoanAmount THEN 'Fully Repaid or Above'
        WHEN RepaymentAmount > 0 THEN 'Partially Repaid'
        ELSE 'No Repayment'
    END AS RepaymentCategory
FROM loans
LIMIT 100;


-- ================================================================
-- 2.6 UNION
-- ================================================================

-- Q40. Combine customers from Kathmandu and Pokhara
-- UNION removes duplicate rows.

SELECT
    CustomerID,
    City,
    Income
FROM customers
WHERE City = 'Kathmandu'

UNION

SELECT
    CustomerID,
    City,
    Income
FROM customers
WHERE City = 'Pokhara';


-- ================================================================
-- 2.7 UNION ALL
-- ================================================================

-- Q41. Combine customers from Kathmandu and Pokhara
-- UNION ALL keeps all rows from both queries.

SELECT
    CustomerID,
    City,
    Income
FROM customers
WHERE City = 'Kathmandu'

UNION ALL

SELECT
    CustomerID,
    City,
    Income
FROM customers
WHERE City = 'Pokhara';


-- ================================================================
-- 3. SUBQUERIES
-- ================================================================

-- Q42. Find customers earning above average income

SELECT
    CustomerID,
    City,
    Occupation,
    Income
FROM customers
WHERE Income > (
    SELECT AVG(Income)
    FROM customers
)
ORDER BY Income DESC
LIMIT 100;


-- Q43. Find customers who have taken at least one loan

SELECT
    CustomerID,
    City,
    Occupation,
    Income
FROM customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM loans
)
LIMIT 100;


-- Q44. Find customers whose total loan amount is greater than
-- the average individual loan amount

SELECT
    CustomerID,
    ROUND(SUM(LoanAmount), 2) AS total_loan_amount
FROM loans
GROUP BY CustomerID
HAVING SUM(LoanAmount) > (
    SELECT AVG(LoanAmount)
    FROM loans
)
ORDER BY total_loan_amount DESC
LIMIT 100;


-- Q45. Find accounts with balance above the average account balance

SELECT
    AccountID,
    CustomerID,
    AccountType,
    Balance,
    Branch
FROM accounts
WHERE Balance > (
    SELECT AVG(Balance)
    FROM accounts
)
ORDER BY Balance DESC
LIMIT 100;


-- ================================================================
-- 4. CTE - COMMON TABLE EXPRESSIONS
-- ================================================================

-- Q46. Find customers with total account balance above 100000

WITH customer_balances AS (
    SELECT
        CustomerID,
        SUM(Balance) AS total_balance
    FROM accounts
    GROUP BY CustomerID
)
SELECT
    CustomerID,
    ROUND(total_balance, 2) AS total_balance
FROM customer_balances
WHERE total_balance > 100000
ORDER BY total_balance DESC
LIMIT 100;


-- Q47. Calculate customer-wise total balance and loan amount

WITH customer_balances AS (
    SELECT
        CustomerID,
        SUM(Balance) AS total_balance
    FROM accounts
    GROUP BY CustomerID
),
customer_loans AS (
    SELECT
        CustomerID,
        SUM(LoanAmount) AS total_loan_amount
    FROM loans
    GROUP BY CustomerID
)
SELECT
    cb.CustomerID,
    ROUND(cb.total_balance, 2) AS total_balance,
    ROUND(COALESCE(cl.total_loan_amount, 0), 2) AS total_loan_amount
FROM customer_balances cb
LEFT JOIN customer_loans cl
    ON cb.CustomerID = cl.CustomerID
ORDER BY total_balance DESC
LIMIT 100;


-- Q48. Create a customer-level banking summary

WITH limited_customers AS (
    SELECT CustomerID, City, Income 
    FROM customers 
    LIMIT 100
),
customer_balances AS (
    SELECT
        CustomerID,
        SUM(Balance) AS total_balance
    FROM accounts
    WHERE CustomerID IN (SELECT CustomerID FROM limited_customers)
    GROUP BY CustomerID
),
customer_transactions AS (
    SELECT
        a.CustomerID,
        COUNT(t.TransactionID) AS transaction_count,
        SUM(t.Amount) AS total_transaction_amount
    FROM accounts a
    INNER JOIN transactions t
        ON a.AccountID = t.AccountID
    WHERE a.CustomerID IN (SELECT CustomerID FROM limited_customers)
    GROUP BY a.CustomerID
),
customer_loans AS (
    SELECT
        CustomerID,
        COUNT(LoanID) AS loan_count,
        SUM(LoanAmount) AS total_loan_amount,
        SUM(RepaymentAmount) AS total_repayment_amount
    FROM loans
    WHERE CustomerID IN (SELECT CustomerID FROM limited_customers)
    GROUP BY CustomerID
)
SELECT
    ROW_NUMBER() OVER (ORDER BY c.CustomerID) AS `S.N.`,
    c.CustomerID,
    c.City,
    c.Income,
    ROUND(COALESCE(cb.total_balance, 0), 2) AS total_balance,
    COALESCE(ct.transaction_count, 0) AS transaction_count,
    ROUND(COALESCE(ct.total_transaction_amount, 0), 2) AS total_transaction_amount,
    COALESCE(cl.loan_count, 0) AS loan_count,
    ROUND(COALESCE(cl.total_loan_amount, 0), 2) AS total_loan_amount,
    ROUND(COALESCE(cl.total_repayment_amount, 0), 2) AS total_repayment_amount
FROM limited_customers c
LEFT JOIN customer_balances cb
    ON c.CustomerID = cb.CustomerID
LEFT JOIN customer_transactions ct
    ON c.CustomerID = ct.CustomerID
LEFT JOIN customer_loans cl
    ON c.CustomerID = cl.CustomerID;



-- ================================================================
-- 5. ADVANCED SQL - WINDOW FUNCTIONS
-- ================================================================

-- 5.1 RANK
-- ================================================================

-- Q49. Rank customers based on total account balance

WITH customer_balances AS (
    SELECT
        CustomerID,
        SUM(Balance) AS total_balance
    FROM accounts
    GROUP BY CustomerID
)
SELECT
    CustomerID,
    ROUND(total_balance, 2) AS total_balance,
    RANK() OVER (
        ORDER BY total_balance DESC
    ) AS balance_rank
FROM customer_balances
ORDER BY balance_rank
LIMIT 100;


-- Q50. Rank branches based on total deposits

WITH branch_deposits AS (
    SELECT
        Branch,
        SUM(Balance) AS total_deposits
    FROM accounts
    GROUP BY Branch
)
SELECT
    Branch,
    ROUND(total_deposits, 2) AS total_deposits,
    RANK() OVER (
        ORDER BY total_deposits DESC
    ) AS deposit_rank
FROM branch_deposits
ORDER BY deposit_rank;


-- ================================================================
-- 5.2 ROW_NUMBER
-- ================================================================

-- Q51. Find top 3 customers by loan amount within each loan type

WITH customer_loan_type AS (
    SELECT
        LoanType,
        CustomerID,
        SUM(LoanAmount) AS total_loan_amount
    FROM loans
    GROUP BY LoanType, CustomerID
),
ranked_loans AS (
    SELECT
        LoanType,
        CustomerID,
        total_loan_amount,
        ROW_NUMBER() OVER (
            PARTITION BY LoanType
            ORDER BY total_loan_amount DESC
        ) AS rn
    FROM customer_loan_type
)
SELECT
    LoanType,
    CustomerID,
    ROUND(total_loan_amount, 2) AS total_loan_amount,
    rn
FROM ranked_loans
WHERE rn <= 3
ORDER BY LoanType, rn;


-- ================================================================
-- 5.3 DENSE_RANK
-- ================================================================

-- Q52. Rank customers using DENSE_RANK based on total balance

WITH customer_balances AS (
    SELECT
        CustomerID,
        SUM(Balance) AS total_balance
    FROM accounts
    GROUP BY CustomerID
)
SELECT
    CustomerID,
    ROUND(total_balance, 2) AS total_balance,
    DENSE_RANK() OVER (
        ORDER BY total_balance DESC
    ) AS balance_rank
FROM customer_balances
ORDER BY balance_rank
LIMIT 100;


-- ================================================================
-- 5.4 LAG
-- ================================================================

-- Q53. Calculate month-over-month transaction growth

WITH monthly_transactions AS (
    SELECT
        DATE_FORMAT(TransactionDate, '%Y-%m') AS transaction_month,
        SUM(Amount) AS total_transactions
    FROM transactions
    GROUP BY DATE_FORMAT(TransactionDate, '%Y-%m')
),
previous_month AS (
    SELECT
        transaction_month,
        total_transactions,
        LAG(total_transactions) OVER (
            ORDER BY transaction_month
        ) AS previous_month_transactions
    FROM monthly_transactions
)
SELECT
    transaction_month,
    ROUND(total_transactions, 2) AS total_transactions,
    ROUND(previous_month_transactions, 2)
        AS previous_month_transactions,
    ROUND(
        (
            (total_transactions - previous_month_transactions)
            / NULLIF(previous_month_transactions, 0)
        ) * 100,
        2
    ) AS growth_percentage
FROM previous_month
ORDER BY transaction_month;


-- ================================================================
-- 5.5 LEAD
-- ================================================================

-- Q54. Compare each month's transaction amount with the next month

WITH monthly_transactions AS (
    SELECT
        DATE_FORMAT(TransactionDate, '%Y-%m') AS transaction_month,
        SUM(Amount) AS total_transactions
    FROM transactions
    GROUP BY DATE_FORMAT(TransactionDate, '%Y-%m')
),
next_month AS (
    SELECT
        transaction_month,
        total_transactions,
        LEAD(total_transactions) OVER (
            ORDER BY transaction_month
        ) AS next_month_transactions
    FROM monthly_transactions
)
SELECT
    transaction_month,
    ROUND(total_transactions, 2) AS total_transactions,
    ROUND(next_month_transactions, 2)
        AS next_month_transactions,
    ROUND(
        (
            (next_month_transactions - total_transactions)
            / NULLIF(total_transactions, 0)
        ) * 100,
        2
    ) AS next_month_change_percentage
FROM next_month
ORDER BY transaction_month;


-- ================================================================
-- 5.6 CUMULATIVE TOTAL
-- ================================================================

-- Q55. Calculate cumulative monthly deposits

WITH monthly_deposits AS (
    SELECT
        DATE_FORMAT(OpenDate, '%Y-%m') AS deposit_month,
        SUM(Balance) AS monthly_deposits
    FROM accounts
    GROUP BY DATE_FORMAT(OpenDate, '%Y-%m')
)
SELECT
    deposit_month,
    ROUND(monthly_deposits, 2) AS monthly_deposits,
    ROUND(
        SUM(monthly_deposits) OVER (
            ORDER BY deposit_month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS cumulative_deposits
FROM monthly_deposits
ORDER BY deposit_month;


-- ================================================================
-- 5.7 CUSTOMER MONTHLY TRANSACTION CHANGE
-- ================================================================

-- Q56. Identify customers whose transaction amount increased or
-- decreased compared with their previous month.

WITH monthly_customer_transactions AS (
    SELECT
        a.CustomerID,
        DATE_FORMAT(t.TransactionDate, '%Y-%m') AS transaction_month,
        SUM(t.Amount) AS monthly_amount
    FROM accounts AS a
    INNER JOIN transactions AS t
        ON a.AccountID = t.AccountID
    GROUP BY
        a.CustomerID,
        DATE_FORMAT(t.TransactionDate, '%Y-%m')
),

transaction_comparison AS (
    SELECT
        CustomerID,
        transaction_month,
        monthly_amount,

        LAG(monthly_amount) OVER (
            PARTITION BY CustomerID
            ORDER BY transaction_month
        ) AS previous_month_amount

    FROM monthly_customer_transactions
)

SELECT
    CustomerID,
    transaction_month,

    ROUND(monthly_amount, 2) AS monthly_amount,

    ROUND(previous_month_amount, 2) AS previous_month_amount,

    CASE
        WHEN monthly_amount > previous_month_amount
            THEN 'Increased'

        WHEN monthly_amount < previous_month_amount
            THEN 'Decreased'

        ELSE 'No Change'
    END AS transaction_change

FROM transaction_comparison

WHERE previous_month_amount IS NOT NULL

ORDER BY
    CustomerID,
    transaction_month

LIMIT 1000;

-- ==============================================================
-- 6. ADVANCED BANKING ANALYSIS
-- ================================================================

-- Q57. Higher-income customers vs larger loans
-- Compare income groups with their average loan amount.

WITH customer_loan_summary AS (
    SELECT
        CustomerID,
        SUM(LoanAmount) AS total_loan_amount
    FROM loans
    GROUP BY CustomerID
)
SELECT
    CASE
        WHEN c.Income < 30000 THEN 'Low Income'
        WHEN c.Income < 70000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS income_segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(cls.total_loan_amount), 2) AS average_total_loan
FROM customers c
INNER JOIN customer_loan_summary cls
    ON c.CustomerID = cls.CustomerID
GROUP BY
    CASE
        WHEN c.Income < 30000 THEN 'Low Income'
        WHEN c.Income < 70000 THEN 'Medium Income'
        ELSE 'High Income'
    END
ORDER BY average_total_loan DESC;


-- Q58. Interest rate vs repayment performance
-- Repayment ratio = repayment amount / loan amount.

SELECT
    LoanType,
    ROUND(AVG(InterestRate), 2) AS average_interest_rate,
    ROUND(
        AVG(
            RepaymentAmount / NULLIF(LoanAmount, 0)
        ) * 100,
        2
    ) AS average_repayment_percentage
FROM loans
GROUP BY LoanType
ORDER BY average_interest_rate DESC;


-- Q59. High balance but very low transaction activity

WITH customer_balances AS (
    SELECT
        CustomerID,
        SUM(Balance) AS total_balance
    FROM accounts
    GROUP BY CustomerID
),
customer_activity AS (
    SELECT
        a.CustomerID,
        COUNT(t.TransactionID) AS transaction_count
    FROM accounts a
    LEFT JOIN transactions t
        ON a.AccountID = t.AccountID
    GROUP BY a.CustomerID
),
thresholds AS (
    SELECT
        (
            SELECT
                MAX(balance_ranked.total_balance)
            FROM (
                SELECT
                    total_balance,
                    NTILE(4) OVER (
                        ORDER BY total_balance
                    ) AS quartile
                FROM customer_balances
            ) balance_ranked
            WHERE quartile = 3
        ) AS balance_threshold,
        (
            SELECT
                MAX(activity_ranked.transaction_count)
            FROM (
                SELECT
                    transaction_count,
                    NTILE(4) OVER (
                        ORDER BY transaction_count
                    ) AS quartile
                FROM customer_activity
            ) activity_ranked
            WHERE quartile = 1
        ) AS activity_threshold
)
SELECT
    cb.CustomerID,
    ROUND(cb.total_balance, 2) AS total_balance,
    ca.transaction_count
FROM customer_balances cb
INNER JOIN customer_activity ca
    ON cb.CustomerID = ca.CustomerID
CROSS JOIN thresholds th
WHERE cb.total_balance >= th.balance_threshold
  AND ca.transaction_count <= th.activity_threshold
ORDER BY cb.total_balance DESC
LIMIT 100;


-- Q60. Risk indicators for customers
-- This is an analytical project score, NOT a production credit score.

WITH customer_balances AS (
    SELECT
        CustomerID,
        SUM(Balance) AS total_balance
    FROM accounts
    GROUP BY CustomerID
),
customer_loans AS (
    SELECT
        CustomerID,
        COUNT(LoanID) AS loan_count,
        SUM(LoanAmount) AS total_loan_amount,
        SUM(RepaymentAmount) AS total_repayment_amount
    FROM loans
    GROUP BY CustomerID
),
customer_risk AS (
    SELECT
        c.CustomerID,
        c.Income,
        COALESCE(cb.total_balance, 0) AS total_balance,
        COALESCE(cl.loan_count, 0) AS loan_count,
        COALESCE(cl.total_loan_amount, 0) AS total_loan_amount,
        COALESCE(cl.total_repayment_amount, 0)
            AS total_repayment_amount
    FROM customers c
    LEFT JOIN customer_balances cb
        ON c.CustomerID = cb.CustomerID
    LEFT JOIN customer_loans cl
        ON c.CustomerID = cl.CustomerID
),
risk_scored AS (
    SELECT
        CustomerID,
        Income,
        total_balance,
        loan_count,
        total_loan_amount,
        total_repayment_amount,

        CASE
            WHEN total_loan_amount > 500000 THEN 2
            ELSE 0
        END AS HighLoanAmount,

        CASE
            WHEN Income < 30000 THEN 2
            ELSE 0
        END AS LowIncome,

        CASE
            WHEN total_loan_amount > 0
             AND total_repayment_amount / total_loan_amount < 0.50
                THEN 2
            ELSE 0
        END AS PoorRepayment,

        CASE
            WHEN loan_count > 1 THEN 1
            ELSE 0
        END AS MultipleLoans,

        CASE
            WHEN total_balance > 500000 THEN 1
            ELSE 0
        END AS HighBalance
    FROM customer_risk
)
SELECT
    CustomerID,
    Income,
    ROUND(total_balance, 2) AS total_balance,
    loan_count,
    ROUND(total_loan_amount, 2) AS total_loan_amount,
    ROUND(total_repayment_amount, 2) AS total_repayment_amount,
    HighLoanAmount,
    LowIncome,
    PoorRepayment,
    MultipleLoans,
    HighBalance,
    (
        HighLoanAmount
        + LowIncome
        + PoorRepayment
        + MultipleLoans
        + HighBalance
    ) AS RiskScore,
    CASE
        WHEN (
            HighLoanAmount
            + LowIncome
            + PoorRepayment
            + MultipleLoans
            + HighBalance
        ) >= 5
            THEN 'High Risk Indicator'
        WHEN (
            HighLoanAmount
            + LowIncome
            + PoorRepayment
            + MultipleLoans
            + HighBalance
        ) >= 3
            THEN 'Medium Risk Indicator'
        ELSE 'Low Risk Indicator'
    END AS RiskCategory
FROM risk_scored
ORDER BY RiskScore DESC
LIMIT 100;


-- ================================================================
-- 7. FINAL DATA QUALITY / RELATIONSHIP CHECKS
-- ================================================================

-- Check for customers without matching accounts

SELECT
    COUNT(*) AS customers_without_accounts
FROM customers c
LEFT JOIN accounts a
    ON c.CustomerID = a.CustomerID
WHERE a.CustomerID IS NULL;


-- Check for loans without matching customers

SELECT
    COUNT(*) AS loans_without_customers
FROM loans l
LEFT JOIN customers c
    ON l.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;


-- Check for transactions without matching accounts

SELECT
    COUNT(*) AS transactions_without_accounts
FROM transactions t
LEFT JOIN accounts a
    ON t.AccountID = a.AccountID
WHERE a.AccountID IS NULL;


-- Check duplicate customer IDs

SELECT
    CustomerID,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY CustomerID
HAVING COUNT(*) > 1
LIMIT 100;


-- Check duplicate account IDs

SELECT
    AccountID,
    COUNT(*) AS duplicate_count
FROM accounts
GROUP BY AccountID
HAVING COUNT(*) > 1
LIMIT 100;


-- Check duplicate transaction IDs

SELECT
    TransactionID,
    COUNT(*) AS duplicate_count
FROM transactions
GROUP BY TransactionID
HAVING COUNT(*) > 1
LIMIT 100;


-- Check duplicate loan IDs

SELECT
    LoanID,
    COUNT(*) AS duplicate_count
FROM loans
GROUP BY LoanID
HAVING COUNT(*) > 1
LIMIT 100;


-- ================================================================
-- END OF WEEK 3 SQL ANALYSIS
-- ================================================================
-- Covered:
--
-- BASIC:
-- SELECT, WHERE, AND/OR, IN, BETWEEN, ORDER BY, LIMIT, DISTINCT,
-- COUNT, COUNT(DISTINCT), SUM, AVG, MIN, MAX, GROUP BY
--
-- INTERMEDIATE:
-- JOIN, INNER JOIN, LEFT JOIN, GROUP BY + JOIN, HAVING, CASE,
-- UNION, UNION ALL
--
-- SUBQUERIES:
-- IN subquery, aggregate subquery
--
-- CTE:
-- Single and multiple CTEs
--
-- WINDOW FUNCTIONS:
-- ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD
--
-- ADVANCED:
-- MoM transaction growth, cumulative deposits, customer monthly
-- transaction change, income vs loan analysis, interest vs repayment,
-- high-balance/low-activity analysis, risk indicators
--
-- The SQL analysis uses cleaned data already loaded into MySQL.
-- ================================================================
