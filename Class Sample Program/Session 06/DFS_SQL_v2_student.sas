*** Task A **;
option autosignon=yes;
option sascmd="!sascmd"; 
rsubmit taskA wait=no  sysrputsync=yes;
 libname sasdata "C:\AIMS\Stevens_\_2020_S_CS593\SASdataA";


*proc print data=max_income;run;
*%sysrput pathtaskA=%sysfunc(pathname(work));
endrsubmit;

   RDISPLAY;
   RGET taskA;
signoff taskA;
