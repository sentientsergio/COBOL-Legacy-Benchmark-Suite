-- Return Code Logging Table
CREATE TABLE RTNCODES (
    TIMESTAMP       TIMESTAMP NOT NULL,
    PROGRAM_ID      CHAR(8) NOT NULL,
    RETURN_CODE     INTEGER NOT NULL,
    HIGHEST_CODE    INTEGER NOT NULL,
    STATUS_CODE     CHAR(1) NOT NULL,
    MESSAGE_TEXT    VARCHAR(80),
    PRIMARY KEY (TIMESTAMP, PROGRAM_ID)
);

-- Index for program analysis
CREATE INDEX RTNCODES_PRG_IDX ON 
    RTNCODES (PROGRAM_ID, TIMESTAMP);

-- Index for status analysis
CREATE INDEX RTNCODES_STS_IDX ON 
    RTNCODES (STATUS_CODE, TIMESTAMP); 