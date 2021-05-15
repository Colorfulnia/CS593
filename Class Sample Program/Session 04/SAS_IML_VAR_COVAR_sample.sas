

/****************************************************************** 
• First: Khasha   
• Last Name : Dehnad   
• Variance Covariance in SAS/IML  
• Version 2 
•   
 ******************************************************************/


data class;
  set sashelp.class;
run;

proc iml;
   use class;
   read all var { "Height"  "Weight"} into M;
   print M;
   Mu=mean(M[:,]);
   print Mu;
 
   CntrM= M - Mu;
   print cntrM;

   VarCovar=cntrM`*cntrM*(1/18);
   Print VarCovar;

   Var=diag(VarCovar);
   print var;
   
   std=sqrt(var);
   print std;
   
   std_1=inv(std);
   print std_1;

quit;
