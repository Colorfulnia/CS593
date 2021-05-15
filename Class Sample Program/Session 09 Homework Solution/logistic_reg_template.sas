/*************************************************************************
**          
**  Developed by:  
**  Prupose     : BIA 652
**  comments    : Logistic reg template  
**              
**
**************************************************************************/



/*************************************************************************
**  Step 0:        
**  Developed by:  
**  Prupose     :  
**  comments    :  load and prep data        
**************************************************************************/

libname  MYLIB  "C:\AIMS\Stevens_Spring_2014\CS593\SAS_Data";
proc copy in=MYLIB out=work;
  select  DSN1 DSN2 .... ;
RUN;



 Proc freq data=churn2; 
  tables  VAR1 VAR2 .... VAR1*VAR2 ....;
run;
/*************************************************************************
**  Step 3:        
**  Prupose     :  
**  comments    :          
**************************************************************************/
proc logistic data=DSN  descending;
  class VAR1 VAR2 (ref='0')/ param=ref ;
  model TARGET = PREDICTOR1  PREDICTOR2 .... ;
run;
