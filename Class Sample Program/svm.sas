
*-------------------------------------------------------------------------;
* Project        : SVM                              ;
* Developer(s)   : Khasha Dehand                                          ;
* Comments       :                                     ;
*                                           ;
* Dependencies   : none                                          ;
 *-------------------------------------------------------------------------;

data iris;
  set sashelp.iris;
run;


proc hpsvm data=iris(where=(species not in ("Setosa") )) METHOD=ACTIVESET ;
input SepalLength Sepalwidth petallength petalwidth  /level=interval;
target Species;
output out=svm_out copyvar=Species ;
run;
proc freq data=svm_out;
  table Species*I_Species;
run;
