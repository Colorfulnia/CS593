/****************************************************************** 
• First: Khasha   
• Last Name : Dehnad   
• Variance Covariance in SAS/IML  
• SAS_IML_covar 
•   
 ******************************************************************/

PROC IMPORT OUT= WORK.covar_insurance 
            DATAFILE= "O:\_1_CS593_DataMinigII\Lecture\Covar_insurance.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;


proc iml;
   use covar_insurance;
   read all var { "X"  } into X;
   read all var {  "Y" } into Y;
   read all var {"P"} into p;
   print X Y P;
   
   xbar=t(x)*p;
   ybar=t(y)*p;
   print xbar ybar ;

 
   xctr= x - xbar;
   yctr=y-ybar;
   print  xctr yctr;
     Pd=diag(p);
	print Pd;

    covar=t(xctr)*Pd*yctr;
    print covar;

   

quit;
