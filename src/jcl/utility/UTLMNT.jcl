//UTLMNT00 JOB (ACCT#),'FILE MAINTENANCE',
//             CLASS=A,MSGCLASS=X,MSGLEVEL=(1,1)
//*
//* File Maintenance Utility
//*
//STEP01   EXEC PGM=UTLMNT00
//STEPLIB  DD   DSN=PROD.LOAD.LIBRARY,DISP=SHR
//CTLFILE  DD   DSN=PROD.CONTROL.FILE,DISP=SHR
//ARCHFILE DD   DSN=PROD.ARCHIVE.FILE,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(CYL,(100,50),RLSE),
//             DCB=(RECFM=VB,LRECL=32756,BLKSIZE=0)
//RPTFILE  DD   DSN=PROD.MAINTENANCE.REPORT,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(CYL,(10,5),RLSE),
//             DCB=(RECFM=FB,LRECL=132,BLKSIZE=0)
//SYSOUT   DD   SYSOUT=*
//SYSUDUMP DD   SYSOUT=*
//SYSPRINT DD   SYSOUT=* 