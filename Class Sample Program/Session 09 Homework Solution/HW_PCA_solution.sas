



proc iml;
 use Depression;
 read all var{Cat_01 Cat_02 Cat_03 Cat_04 Cat_05 Cat_06 Cat_07 Cat_08 Cat_09 Cat_10
              Cat_11 Cat_12 Cat_13 Cat_14 Cat_15 Cat_16 Cat_17 Cat_18 Cat_19 Cat_20 
       } into M;
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
 evecs=eigvec(corr );print evecs;
 ort_test=t(evecs)*evecs;print ort_test;

 NewCols=M_z* evecs; Print NewCols;

 create Newdata from NewCols;
 append from  NewCols;
 close Newdata;
 quit;

proc corr data=Depression  cov; 
var  cat_01 - cat_20 ;
run;

PROC STANDARD DATA= Depression
                     MEAN=0 STD=1 OUT=Dep_z ;
  VAR   cat_01 - cat_20 ;
RUN;
proc princomp   data=Dep_z   out=dep_pca;
   var cat_01 - cat_20   ;
run;



