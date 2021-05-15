
*-------------------------------------------------------------------------;
* Project        :  SQL in Map Reduce                                         ;
* Developer(s)   :  Khasha Dehand                                         ;
* Comments       :  Distribute SAS data over multiple node                  ;
*-------------------------------------------------------------------------;
*** Task A **;
option autosignon=yes;
option sascmd="!sascmd"; 
rsubmit taskA wait=no  sysrputsync=yes;
 libname sasdata "\\apporto.com\dfs\STVN\Users\s24_stvn\Desktop\SAS_dataA";


endrsubmit;

   RDISPLAY;
  * RGET taskA;

*** Task B **;
option autosignon=yes;
option sascmd="!sascmd"; 
rsubmit taskB wait=no  sysrputsync=yes;
 libname sasdata "\\apporto.com\dfs\STVN\Users\s24_stvn\Desktop\SAS_dataB";

endrsubmit;

   RDISPLAY;
  *RGET taskB;
 
*** Task C **;
option autosignon=yes;
option sascmd="!sascmd"; 
rsubmit taskC wait=no  sysrputsync=yes;
 libname sasdata "\\apporto.com\dfs\STVN\Users\s24_stvn\Desktop\SAS_dataC";

endrsubmit;

   RDISPLAY;

  *RGET taskD;
option autosignon=yes;
option sascmd="!sascmd"; 
rsubmit taskD wait=no  sysrputsync=yes;
 libname sasdata "\\apporto.com\dfs\STVN\Users\s24_stvn\Desktop\SAS_dataC";

endrsubmit;


   RDISPLAY;
rsubmit taskA wait=no  sysrputsync=yes;
   proc sql;
     create table max_income as
	   select max(Gross_income) as max_income from
       sasdata.spanish_bank
  ;
  
 quit;

endrsubmit;
rsubmit taskB wait=no  sysrputsync=yes;
   proc sql;
     create table max_income as
	   select max(Gross_income) as max_income from
       sasdata.spanish_bank
  ;
 quit;
endrsubmit;

rsubmit taskC wait=no  sysrputsync=yes;
   proc sql;
     create table max_income as
	   select max(Gross_income) as max_income from
       sasdata.spanish_bank
  ;
 quit;
endrsubmit;
rsubmit taskD wait=no  sysrputsync=yes;
   proc sql;
     create table max_income as
	   select max(Gross_income) as max_income from
       sasdata.spanish_bank
  ;
 quit;
endrsubmit;


LISTTASK _ALL_;
rget    taskA; 
rget    taskB;
rget    taskC;
rget    taskD; 

waitfor _all_ taskA taskB taskC taskD;
*%put &pathtask1;
*%put &pathtask2;
libname rworkA slibref=work server=taskA;
libname rworkB slibref=work server=taskB;
libname rworkC slibref=work server=taskC;
libname rworkD slibref=work server=taskD;
 
proc sql;
  create table max_all as
     select max(max_income) as Max_all from
          (  select max_income  from rworkA.max_income
	      union
		select max_income   from rworkB.max_income
             union
		select max_income  from rworkC.max_income
		union
             select max_income  from rworkD.max_income
	      )
;
quit;
signoff taskA;
signoff taskB;
signoff taskC;
signoff _all_;


