-- KPI 1: Total Collection
SELECT
    ROUND(SUM(`Total Payment`) / 10000000, 2) AS Total_Collection_Cr
FROM bank_data_complete;

-- KPI 2: Total Interest
SELECT
    ROUND(SUM(`Total Interest`) / 10000000, 2) AS Total_Interest_Cr
FROM bank_data_complete;

-- KPI 3: No Verified Loans
SELECT
    COUNT(*) AS No_Verified_Loans
FROM bank_data_complete
WHERE `Verification Status` = 'Not Verified';

-- KPI 4: Verified / Not Verified
SELECT
    `Verification Status`,
    COUNT(*) AS Loan_Count
FROM bank_data_complete
GROUP BY `Verification Status`;

-- KPI 5: Delinquent Loan Rate
SELECT
    ROUND(
        SUM(`Delinquent Flag`) / SUM(`Loan Count`) * 100,
        2
    ) AS Delinquent_Loan_Rate
FROM bank_data_complete;

-- KPI 6: Default Loan Rate
SELECT
    ROUND(
        SUM(`Default Flag`) / SUM(`Loan Count`) * 100,
        2
    ) AS Default_Loan_Rate
FROM bank_data_complete;

-- KPI 7: Branch Wise Fee
SELECT
    ROUND(AVG(Branch_Fee), 2) AS Branch_Wise_Fee
FROM (
    SELECT
        `Branch Name`,
        SUM(`Total Fees`) AS Branch_Fee
    FROM bank_data_complete
    WHERE `Branch Name` IS NOT NULL
      AND TRIM(`Branch Name`) <> ''
    GROUP BY `Branch Name`
) AS BranchTotals;

-- KPI 8: Total Amount Funded
SELECT
    ROUND(SUM(`Funded Amount`) / 10000000, 2) AS Total_Amount_Funded_Cr
FROM bank_data_complete;

-- KPI 9: Total Loans
SELECT
    SUM(`Loan Count`) AS Total_Loans
FROM bank_data_complete;

-- KPI 10: Default Loan Count
SELECT
    SUM(`Default Flag`) AS Default_Loan_Count
FROM bank_data_complete;

-- KPI 11: Delinquent Client
SELECT
    SUM(`Delinquent Flag`) AS Delinquent_Client
FROM bank_data_complete;

-- CHART 1: Top Branches by Loan Amount
SELECT
    `Branch Name`,
    ROUND(SUM(`Loan Amount`) / 10000000, 2) AS Loan_Amount_Cr
FROM bank_data_complete
WHERE `Branch Name` IS NOT NULL
  AND TRIM(`Branch Name`) <> ''
GROUP BY `Branch Name`
ORDER BY Loan_Amount_Cr DESC
LIMIT 10;

-- CHART 2: State Wise Performance
SELECT
    `State Name`,
    ROUND(SUM(`Loan Amount`) / 10000000, 2) AS Loan_Amount_Cr
FROM bank_data_complete
WHERE `State Name` IS NOT NULL
  AND TRIM(`State Name`) <> ''
GROUP BY `State Name`
ORDER BY Loan_Amount_Cr DESC;

-- CHART 3: Religion Wise Loan Distribution
SELECT
    `Religion`,
    SUM(`Loan Count`) AS Loan_Count
FROM bank_data_complete
WHERE `Religion` IS NOT NULL
  AND TRIM(`Religion`) <> ''
GROUP BY `Religion`
ORDER BY Loan_Count DESC;

-- CHART 4: Branch Revenue & Interest Analysis
SELECT
    ROUND(SUM(`Total Payment` - `Total Principal Received`), 2) 
        AS Revenue_Generated,
    ROUND(SUM(`Total Interest`), 2) 
        AS Total_Interest_Received
FROM bank_data_complete;

-- CHART 5: Loan Disbursement Trend
SELECT
    `Disbursement Year`,
    `Month Number`,
    `Disbursement Month`,
    ROUND(SUM(`Loan Amount`) / 10000000, 2) AS Loan_Amount_Cr
FROM bank_data_complete
GROUP BY
    `Disbursement Year`,
    `Month Number`,
    `Disbursement Month`
ORDER BY
    `Disbursement Year`,
    `Month Number`;
    
    -- CHART 6: Loan Distribution by Product
SELECT
    `Purpose Category`,
    ROUND(SUM(`Loan Amount`) / 10000000, 2) AS Loan_Amount_Cr
FROM bank_data_complete
WHERE `Purpose Category` IS NOT NULL
  AND TRIM(`Purpose Category`) <> ''
GROUP BY `Purpose Category`
ORDER BY Loan_Amount_Cr DESC;

-- CHART 7: Loan Grade Distribution
SELECT
    `Grade`,
    ROUND(SUM(`Loan Amount`) / 10000000, 2) AS Loan_Amount_Cr
FROM bank_data_complete
WHERE `Grade` IS NOT NULL
  AND TRIM(`Grade`) <> ''
GROUP BY `Grade`
ORDER BY `Grade`;

-- CHART 8: Age Group Wise Loan
SELECT
    CASE
        WHEN `Age` BETWEEN 18 AND 25 THEN '18-25'
        WHEN `Age` BETWEEN 26 AND 35 THEN '26-35'
        WHEN `Age` BETWEEN 36 AND 45 THEN '36-45'
        WHEN `Age` BETWEEN 46 AND 55 THEN '46-55'
        WHEN `Age` >= 56 THEN '55+'
        ELSE '(blank)'
    END AS Age_Group,
    ROUND(SUM(`Loan Amount`) / 10000000, 2) AS Loan_Amount_Cr
FROM bank_data_complete
GROUP BY Age_Group
ORDER BY
    CASE Age_Group
        WHEN '18-25' THEN 1
        WHEN '26-35' THEN 2
        WHEN '36-45' THEN 3
        WHEN '46-55' THEN 4
        WHEN '55+' THEN 5
        ELSE 6
    END;
    
    -- CHART 9: Loan Maturity Distribution
SELECT
    `Loan Maturity`,
    ROUND(SUM(`Loan Amount`) / 10000000, 2) AS Loan_Amount_Cr
FROM bank_data_complete
WHERE `Loan Maturity` IS NOT NULL
  AND TRIM(`Loan Maturity`) <> ''
GROUP BY `Loan Maturity`
ORDER BY Loan_Amount_Cr DESC;

-- CHART 10: Loan Status Distribution
SELECT
    `Loan Portfolio` AS Loan_Status,
    SUM(`Loan Count`) AS Loan_Count
FROM bank_data_complete
WHERE `Loan Portfolio` IS NOT NULL
  AND TRIM(`Loan Portfolio`) <> ''
GROUP BY `Loan Portfolio`
ORDER BY Loan_Count DESC;

