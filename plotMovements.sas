/* [12MAR2016]. Movements of subjects over time per group. */

%macro plotMovements(sdata     =
                    ,interval  =
                    ,covariate =
                    ,response  =
                    ,gender    =
                    ,parameter =);

  * Get number of groups. ;
  proc sql noprint;
    select count(distinct &covariate.) into :num_groups
    from &sdata.;
  quit;

  * Group mean counts per interval. ;
  proc means data=&sdata mean;
    class &covariate &interval;
    var &response;
    ods output Summary=out_summary;
  run;

  proc sort data=work.out_summary 
              out=work.out_summary;
    by &covariate &interval;
  run;

  proc contents data=work.out_summary
                  out =work.contents (keep  = name label
                                      rename=(label=labell))
			      noprint;
  run;

  proc sql noprint;
    select name into :mean_label
    from work.contents
    where upcase(labell) ="MEAN";
  quit;


  * Start plot. ;
  goptions reset=all;

  * Define the title. ;                                                                                                    
  title1 "&parameter.: &gender" font=verdana h=0.5;                                                                                      
                                                                                                                                        
  * Define symbol characteristics. ;                                                                                                  
  symbol1 i=join v=diamondfilled  c=green  h=1;     /* Temporary */                                                                         
  symbol2 i=join v=squarefilled   c=orange h=1;                                                                         
  symbol3 i=join v=trianglefilled c=blue   h=1; 
  symbol4 i=join v=star           c=red    h=1;  
                                                                                                                                        
  * Define legend characteristics. ;                                                                                                    
  legend1 label    =none
          value    =(h=1.10 font=verdana "Group 1" "Group 2" "Group 3" "Group 4")   /* Temporary */
          across   =1 down=&num_groups    
          position =(top right inside)
          mode     =share
          cborder  =black;                                                                                                               
                                                                                                                                        
  * Define axis characteristics. ;                                                                      
  axis1 label =(font=verdana "Interval (5 min.)");
  axis2 label =(angle=90 font=verdana "Counts")
        order =(0 to 1300 by 200);      /* Temporary */   

  * Plot animal movements per group. ;
  proc gplot data=work.out_summary;
    plot &mean_label*&interval = &covariate  / haxis=axis1 vaxis=axis2 legend=legend1;
  run;

  quit;

  * Delete temporary data sets. ;
  proc datasets library=work;
    delete contents out_summary;
  run;

%mend plotMovements;
