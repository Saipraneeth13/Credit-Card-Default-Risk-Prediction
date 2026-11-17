-- sql/data_quality.sql
-- Post-Import Data Quality Validation Checks in MySQL

USE credit_risk_db;

-- 1. Verify exact row count (Expected: 30,000)
SELECT COUNT(*) AS total_rows FROM credit_card_clients;

-- 2. Verify primary key uniqueness
SELECT COUNT(DISTINCT ID) AS unique_ids FROM credit_card_clients;

-- 3. Check for unexpected NULL values in critical fields
SELECT
    SUM(CASE WHEN LIMIT_BAL IS NULL THEN 1 ELSE 0 END) AS null_limit,
    SUM(CASE WHEN PAY_1 IS NULL THEN 1 ELSE 0 END) AS null_pay1,
    SUM(CASE WHEN DEFAULT_NEXT_MONTH IS NULL THEN 1 ELSE 0 END) AS null_target
FROM credit_card_clients;

-- 4. Validate cleaned categorical code domains
SELECT EDUCATION, EDUCATION_LABEL, COUNT(*) AS cnt
FROM credit_card_clients
GROUP BY EDUCATION, EDUCATION_LABEL
ORDER BY EDUCATION;

SELECT MARRIAGE, MARRIAGE_LABEL, COUNT(*) AS cnt
FROM credit_card_clients
GROUP BY MARRIAGE, MARRIAGE_LABEL
ORDER BY MARRIAGE;
