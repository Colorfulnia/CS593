*-------------------------------------------------------------------------;
* Project        :  CS593-Data Mining II Final Exam                       ;
* Developer(s)   :  Yueyang Tao, 10458455                                 ;
* Comments       :  Solution for the Problem 1 & 2                        ;
*-------------------------------------------------------------------------;

libname sasdata "O:\CS-593\SAS_data";

proc copy in=sasdata out=work;
   select  baseball_100 ;
run;

/* Suppose that we are interested in
    estimating the number of home runs based on the other
      numerical variables in the data set
*/

PROC STANDARD 
     DATA=Baseball_100   MEAN=0 STD=1 
     OUT= Baseball2_z ;
  VAR age games	at_bats	runs hits doubles
      triples		RBIs	walks
      strikeouts	bat_ave
      on_base_pct	slugging_pct
      stolen_bases	caught_stealing
   ;
RUN;
/* Suppose that we are interested in
    estimating the number of home runs based on the other
      numerical variables in the data set
*/
title "Principal Component Analysis"; 
title2 " Univariate Analysis"; 
proc univariate data=Baseball2_z;
  VAR age games	at_bats	runs hits doubles
      triples		RBIs	walks
      strikeouts	bat_ave
      on_base_pct	slugging_pct
      stolen_bases	caught_stealing
   ;
run;
proc princomp   data= Baseball2_z  out=pca_Baseball ;
   VAR age games	at_bats	runs hits doubles
      triples		RBIs	walks
      strikeouts	bat_ave
      on_base_pct	slugging_pct
      stolen_bases	caught_stealing
   ;
run;
proc sgplot data= pca_Baseball  ;
    scatter      x=Prin1   y=homeruns  ; 
    ellipse      x=Prin1   y=homeruns    ;
run;


/**** Problem 2 ****/
proc reg data= pca_Baseball  outest=Reg_baseball ;
     model    homeruns    =  age games	at_bats	runs hits doubles
      triples		RBIs	walks
      strikeouts	bat_ave
      on_base_pct	slugging_pct
      stolen_bases	caught_stealing
                                 /   dwProb STB selection=MAXR ; 
 quit; 
