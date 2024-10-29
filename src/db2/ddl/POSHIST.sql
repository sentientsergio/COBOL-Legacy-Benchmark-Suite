--=====================================================================
-- Position History Table Definition
-- Version: 1.0
-- Date: 2024
--=====================================================================

CREATE DATABASE POSMVP
  BUFFERPOOL BP0
  INDEXBP    BP1
  STOGROUP   POSMVPSG;

CREATE TABLESPACE POSHIST
  IN POSMVP
  USING STOGROUP POSMVPSG
  PRIQTY 7200
  SECQTY 1440
  SEGSIZE 64
  COMPRESS YES
  PARTITION BY RANGE(TRANS_DATE)
  (PARTITION 1 ENDING AT ('2024-03-31'),
   PARTITION 2 ENDING AT ('2024-06-30'),
   PARTITION 3 ENDING AT ('2024-09-30'),
   PARTITION 4 ENDING AT ('2024-12-31'));

CREATE TABLE POSHIST
  (ACCOUNT_NO        CHAR(8)         NOT NULL,
   PORTFOLIO_ID      CHAR(10)        NOT NULL,
   TRANS_DATE        DATE            NOT NULL,
   TRANS_TIME        TIME            NOT NULL,
   TRANS_TYPE        CHAR(2)         NOT NULL,
   SECURITY_ID       CHAR(12)        NOT NULL,
   QUANTITY          DECIMAL(15,3)   NOT NULL,
   PRICE            DECIMAL(15,3)   NOT NULL,
   AMOUNT           DECIMAL(15,2)   NOT NULL,
   FEES             DECIMAL(15,2)   NOT NULL WITH DEFAULT 0,
   TOTAL_AMOUNT     DECIMAL(15,2)   NOT NULL,
   COST_BASIS       DECIMAL(15,2)   NOT NULL,
   GAIN_LOSS        DECIMAL(15,2)   NOT NULL,
   PROCESS_DATE     DATE            NOT NULL,
   PROCESS_TIME     TIME            NOT NULL,
   PROGRAM_ID       CHAR(8)         NOT NULL,
   USER_ID          CHAR(8)         NOT NULL,
   AUDIT_TIMESTAMP  TIMESTAMP       NOT NULL WITH DEFAULT)
  IN POSMVP.POSHIST;

-- Primary Key
CREATE UNIQUE INDEX POSHIST_PK
  ON POSHIST
  (ACCOUNT_NO ASC,
   PORTFOLIO_ID ASC,
   TRANS_DATE ASC,
   TRANS_TIME ASC)
  CLUSTER;

ALTER TABLE POSHIST
  ADD CONSTRAINT POSHIST_PK
  PRIMARY KEY (ACCOUNT_NO, PORTFOLIO_ID, TRANS_DATE, TRANS_TIME);

-- Secondary Indexes
CREATE INDEX POSHIST_IX1
  ON POSHIST
  (SECURITY_ID ASC,
   TRANS_DATE ASC);

CREATE INDEX POSHIST_IX2
  ON POSHIST
  (PROCESS_DATE ASC,
   PROGRAM_ID ASC);

-- Table Comments
COMMENT ON TABLE POSHIST IS
  'Position History Table - Stores all portfolio transaction history';

COMMENT ON COLUMN POSHIST.ACCOUNT_NO IS
  'Account Number';
COMMENT ON COLUMN POSHIST.PORTFOLIO_ID IS
  'Portfolio Identifier';
COMMENT ON COLUMN POSHIST.TRANS_DATE IS
  'Transaction Date';
COMMENT ON COLUMN POSHIST.TRANS_TYPE IS
  'Transaction Type (BU=Buy, SL=Sell, TR=Transfer)';
COMMENT ON COLUMN POSHIST.SECURITY_ID IS
  'Security Identifier';
COMMENT ON COLUMN POSHIST.QUANTITY IS
  'Transaction Quantity';
COMMENT ON COLUMN POSHIST.PRICE IS
  'Transaction Price';
COMMENT ON COLUMN POSHIST.AMOUNT IS
  'Transaction Amount';
COMMENT ON COLUMN POSHIST.TOTAL_AMOUNT IS
  'Total Amount Including Fees';
COMMENT ON COLUMN POSHIST.COST_BASIS IS
  'Cost Basis Amount';
COMMENT ON COLUMN POSHIST.GAIN_LOSS IS
  'Realized Gain/Loss Amount';

-- Grants
GRANT SELECT, INSERT ON POSHIST TO POSAPP;
GRANT SELECT ON POSHIST TO POSRPT; 