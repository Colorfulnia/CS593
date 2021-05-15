
/*
data yx;
 
  do  i=-3 to 3;
     x=5+i;
     y=x;
     output;
  end;
run;
*/
data yx;
  infile datalines;
  input x;
  y=x+rand('NORMAL')/3;;
datalines;
1.4600
2.2500
2.7433
2.0000
3.0000
4.0000
3.2567
3.7500
4.5400

;
run;

proc sgplot data=yx;
  scatter  x=x y=y;
run;
proc corr data=yx cov; 
var   y x  ;
run;

PROC STANDARD DATA=yx(keep=x y) 
                     MEAN=0 STD=1 OUT=xy_z(rename=(x=x_z Y=y_z));
  VAR   x y ;
RUN;

title "Principal Component Analysis"; 
title2 " corrolation between components"; 
proc corr data=xy_z cov; 
var  x_z  y_z ;
run;
proc sgplot data=xy_z  ;
    scatter     x=x_z    y=y_z ; 
    ellipse     x=x_z    y=y_z  ;
run;
proc princomp   data=xy_z  out=XY_pca;
   var  x_z  y_z  ;
run;
proc sgplot data=XY_pca  ;
    scatter     x=prin1    y=prin2 ;
     ellipse     x=prin1   y=prin2  ;
 	xaxis min=-3 max=-3;
	yaxis min=-3 max=3; 
 
run;



proc iml;
 use yx;
 read all var{x y} into M;
 print M;
 
 Mu=mean(M[:,]); print Mu;
 Mctr=M-Mu; Print Mctr;
 SSMctr=t(Mctr)*Mctr; print SSMctr;
 n=nrow(M); print n;
  varcovar=SSMctr*1/(n-1);print varcovar;
 var=diag(varcovar);print var;
 std=sqrt(var);print std;
 std_1=inv(std); print std_1;
 M_z=Mctr*std_1; print M_z;
 corr=t(std_1)*varcovar*std_1 ;print  corr;
 evals=eigval(corr );print evals;
 evecs=eigvec(corr);print evecs;
 ort_test=t(evecs)*evecs;print ort_test;

 NewCols=M_z* evecs; Print NewCols;

 create Newdata from NewCols;
 append from  NewCols;
 close Newdata;
 quit;

proc sgplot data=Newdata  ;
    scatter     x=col1    y=col2 ;
     ellipse     x=col1   y=col2  ;
 	xaxis min=-3 max=-3;
	yaxis min=-3 max=3; 
 
run;




