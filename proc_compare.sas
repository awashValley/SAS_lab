
/* [Thur, 09-Mar-2017]. Compare two datasets using some variable(s). Use ID statement. */
proc compare base=work.ds1 compare=work.ds2;
  id subjid activity; /* ID statement is useful when you have extra subject in one dataset but not in the other one. */
run;
