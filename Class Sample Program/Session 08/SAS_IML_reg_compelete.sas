data example;
infile datalines;
  input x1 x2 x3 y;
datalines;
1 1 1  1
1 2 4  5
1 3 9  9
1 4 16 23
1 5 25 36
;
run;

proc reg data=example;
  model y= x2 x3;
run;


proc iml;

x = {1 1 1,
     1 2 4,
     1 3 9,
     1 4 16,
     1 5 25};
y = {1, 5, 9, 23, 36};
print x;
print y;

start Regress;                              /* begin module        */
  xpxi = inv(x`*x); print xpxi;              /* inverse of X'X      */
  beta = xpxi * (x`*y); print beta;          /* parameter estimate  */
  yhat = x*beta;  print yhat;                /* predicted values    */
  resid = y-yhat; print resid;               /* residuals           */

  sse = ssq(resid); print sse;               /* SSE                 */
  n = nrow(x);                               /* sample size         */
  dfe = nrow(x)-ncol(x); print dfe;         /* error DF            */
  mse = sse/dfe;   print mse ;               /* MSE                 */
  cssy = ssq(y-sum(y)/n);  print cssy;                   /* corrected total SS  */
  rsquare = (cssy-sse)/cssy;  print  rsquare;     /* RSQUARE             */
  results = sse || dfe || mse || rsquare; print  results;
  print results[c={"SSE" "DFE" "MSE" "RSquare"}
                L="Regression Results"];

  stdb = sqrt(vecdiag(xpxi)*mse); print stdb; /* std of estimates    */
  t = beta/stdb;   print t;               /* parameter t tests   */
  prob = 1-probf(t#t,1,dfe);  print prob;    /* p-values            */
  paramest = beta || stdb || t || prob;
  print paramest[c={"Estimate" "StdErr" "t" "Pr>|t|"}
                 L="Parameter Estimates" f=Best6.];
  print y yhat resid;
finish Regress;                   /* end module          */

run Regress; /* run module           */


quit;
