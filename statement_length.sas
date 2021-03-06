
/* [Fri 01Apr2016]. Set the length of all character variables at once.
  (source: http://stackoverflow.com/questions/35460055/setting-the-length-of-all-character-variables-within-a-dataser). */
  
  proc sql;
    select name into :names separated by ' '
    from dictionary.columns 
    where libname='WORK' and upcase(memname)='SAMPLE' and type='char';
  quit;

  data work.combined;
    length   &names $100;
    format   &names $100.;
    informat &names $100.;
    set work.sample;
    stop;   /* helps to create empty dataset. */
  run;
