-- sql/schema.sql
-- MySQL Database & Table Schema for Credit Risk & Customer Default Analysis

CREATE DATABASE IF NOT EXISTS credit_risk_db;
USE credit_risk_db;

DROP TABLE IF EXISTS credit_card_clients;

CREATE TABLE credit_card_clients (
    ID INT PRIMARY KEY,
    LIMIT_BAL DECIMAL(12, 2) NOT NULL,
    SEX TINYINT NOT NULL,
    EDUCATION TINYINT NOT NULL,
    MARRIAGE TINYINT NOT NULL,
    AGE INT NOT NULL,
    PAY_1 TINYINT NOT NULL,
    PAY_2 TINYINT NOT NULL,
    PAY_3 TINYINT NOT NULL,
    PAY_4 TINYINT NOT NULL,
    PAY_5 TINYINT NOT NULL,
    PAY_6 TINYINT NOT NULL,
    BILL_AMT1 DECIMAL(12, 2) NOT NULL,
    BILL_AMT2 DECIMAL(12, 2) NOT NULL,
    BILL_AMT3 DECIMAL(12, 2) NOT NULL,
    BILL_AMT4 DECIMAL(12, 2) NOT NULL,
    BILL_AMT5 DECIMAL(12, 2) NOT NULL,
    BILL_AMT6 DECIMAL(12, 2) NOT NULL,
    PAY_AMT1 DECIMAL(12, 2) NOT NULL,
    PAY_AMT2 DECIMAL(12, 2) NOT NULL,
    PAY_AMT3 DECIMAL(12, 2) NOT NULL,
    PAY_AMT4 DECIMAL(12, 2) NOT NULL,
    PAY_AMT5 DECIMAL(12, 2) NOT NULL,
    PAY_AMT6 DECIMAL(12, 2) NOT NULL,
    DEFAULT_NEXT_MONTH TINYINT NOT NULL,
    SEX_LABEL VARCHAR(10),
    EDUCATION_LABEL VARCHAR(30),
    MARRIAGE_LABEL VARCHAR(20),
    Total_Bill_Amount DECIMAL(14, 2),
    Average_Bill_Amount DECIMAL(12, 2),
    Total_Payment_Amount DECIMAL(14, 2),
    Average_Payment_Amount DECIMAL(12, 2),
    Maximum_Delay_Status TINYINT,
    Delayed_Payment_Count TINYINT,
    Average_Repayment_Status DECIMAL(6, 3),
    Payment_to_Bill_Ratio DECIMAL(8, 4),
    Credit_Utilization_Ratio DECIMAL(8, 4),
    Bill_Trend_Change DECIMAL(12, 2),
    Age_Group VARCHAR(15),
    Credit_Limit_Tier VARCHAR(25)
);

CREATE INDEX idx_default ON credit_card_clients(DEFAULT_NEXT_MONTH);
CREATE INDEX idx_limit_tier ON credit_card_clients(Credit_Limit_Tier);
CREATE INDEX idx_pay1 ON credit_card_clients(PAY_1);
