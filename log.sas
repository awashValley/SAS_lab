*------------------------------------------------------------------------------;
* Define pathname for log file.                                                ;
*------------------------------------------------------------------------------;
proc printto log="&path.\mylog.log" new;
run;

*------------------------------------------------------------------------------;
* Create output of log file.                                                   ;
*------------------------------------------------------------------------------;
proc printto log=log;
run;
