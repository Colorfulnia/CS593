/****************************************************************** 
• First: Khasha   
• Last Name : Dehnad   
• Variance Covariance in SAS/IML  
• Version 1 
•   
 ******************************************************************/
/*
   X	          0	        2	    4	    10	  Total
p(x)	         0.25	    0.25	0.25	0.25	
x*p(x)	          0	        0.5	     1	     2.5	  4
(x-mean)^2        16	    4	     0	     36	
p(x)*(x-mean)^2	   4	    1	     0	     9       14
*/

proc iml;
  x={0	2 4 10};
  print x;
  
  P={.25 .25 .25 .25};
  print p;

  mu=x*t(p);
  print mu;
  
   ctrx= x-mu;
   print ctrx;

  

   Pd=diag(p);
   print Pd;

   var=ctrx*Pd*t(ctrx);
   print var;
  ; 
  quit;
