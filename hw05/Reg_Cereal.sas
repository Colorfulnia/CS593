
*-------------------------------------------------------------------------;
* Project        :  BIA652  Mulivariate Analysis                          ;
* Developer(s)   : Khasha Dehand                                          ;
* Comments       : Multiple regression                                    ;
*                  see cereal load for dataset                            ;
* Dependencies   : libnames.sas                                           ;
*-------------------------------------------------------------------------;

/*
COOKD= Cook’s  influence statistic
* Cook’s  statistic lies above the horizontal reference line at value 4/n *;
COVRATIO=standard influence of observation on covariance of betas
DFFITS=standard influence of observation on predicted value
H=leverage, 
LCL=lower bound of a % confidence interval for an individual prediction. This includes the variance of the error, as well as the variance of the parameter estimates.
LCLM=lower bound of a % confidence interval for the expected value (mean) of the dependent variable
PREDICTED | P= predicted values
RESIDUAL | R= residuals, calculated as ACTUAL minus PREDICTED
RSTUDENT=a studentized residual with the current observation deleted
STDI=standard error of the individual predicted value
STDP= standard error of the mean predicted value
STDR=standard error of the residual
STUDENT=studentized residuals, which are the residuals divided by their standard errors
UCL= upper bound of a % confidence interval for an individual prediction
UCLM= upper bound of a % confidence interval for the expected value (mean) of the dependent variable 
* DFFITS’ statistic is greater in magnitude than 2sqrt(n/p);
* Durbin watson around 2 *;
* VIF over 10 multicolinear **;


*/

proc copy in=sasdata out=work;
   select cereal_ds vif_data;
run;
*Example of vars rating  sugars fiber shelf 
sodium fat protein carbo calories vitamins ;



proc corr data=cereal_ds  cov;
  var sugars fiber;
run;

proc standard data=cereal_ds mean=0 std=1 
                                out=stnd_cereals;
var rating sugars fiber sodium;
run;
title " Multipe Regression for the cereal dataset rating vs. sugars and fiber";
proc reg data=  cereal_ds   ;
     model     rating = sugars fiber /STB SS1 SS2    ;
     *model     rating =  fiber /STB SS1 SS2    ;
      OUTPUT OUT=reg_cerealOUT  PREDICTED=c_predict
      RESIDUAL=c_Res   L95M=c_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=Cookd  dffits=dffit
         ;  
     
  quit;
proc corr data=cereal_ds  cov;
  var rating fiber;
run;

*fiber sodium;

title  " Simple Regression for the cereal dataset rating vs. sugars";
title2 " Univariate analysis for the reg output dataset ";
  proc univariate data=reg_cerealout;
  var lev cookd dffit;
  run;

  /*
selection=forward
selection=backward
selection=stepwise
selection=MAXR
*/
*Cook’s  statistic lies above the horizontal reference line at value 4/n *; 
* DFFITS’ statistic is greater in magnitude than 2sqrt(n/p);
* Durbin watson around 2 *;
* VIF over 10 multicolinear **;
title  " Multiple Regression for the cereal dataset rating vs. sugars";
title2 " rating vs. sugars fiber  sodium fat protein carbo calories vitamins  shelf ";
proc reg data=cereal_ds  outest=est_cereal ;
     model     rating = sugars shelf  
                        /   dwProb pcorr1  VIF ;
      OUTPUT OUT=reg_cerealOUT  PREDICTED=   RESIDUAL=Res   L95M=C_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=C_spredicted  STDR=C_s_residual  STUDENT=C_student     ;  
    
  quit;


proc reg data=cereal_ds  outest=est_cereal ;
     model     rating = sugars fiber shelf  sodium fat protein carbo calories vitamins 
                        /   dwProb pcorr1  VIF ;
      OUTPUT OUT=reg_cerealOUT  PREDICTED=   RESIDUAL=Res   L95M=C_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=C_spredicted  STDR=C_s_residual  STUDENT=C_student     ;  
    
  quit;




title  " Multiple Regression for the cereal dataset rating vs. sugars";
title2 " rating vs. sugars fiber  sodium fat protein carbo calories vitamins  shelf ";

proc reg data=cereal_ds  outest=est_cereal ;
     model     rating = sugars fiber shelf  sodium fat protein carbo calories vitamins 
                        /   dwProb pcorr1  VIF selection=stepwise;
      OUTPUT OUT=reg_cerealOUT  PREDICTED=   RESIDUAL=Res   L95M=C_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=C_spredicted  STDR=C_s_residual  STUDENT=C_student     ;  
    
  quit;


proc reg data=cereal_ds  outest=est_cereal ;
     model     rating =  calories   fiber
                       sugars  potass  vitamins
                         shelf   weight   cups
                        /  SS1 SS2 dwProb pcorr1  VIF selection=MAXR;
      OUTPUT OUT=reg_cerealOUT  PREDICTED=   RESIDUAL=Res   L95M=C_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=C_spredicted  STDR=C_s_residual  STUDENT=C_student     ;  
    
  quit;


proc reg data=cereal_ds  outest=est_cereal ;
     model     rating =  sugars  fiber  shelf
                         potass  
                        /  SS1 SS2 dwProb pcorr1  VIF selection=forward ;
      OUTPUT OUT=reg_cerealOUT  PREDICTED=   RESIDUAL=Res   L95M=C_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=C_spredicted  STDR=C_s_residual  STUDENT=C_student     ;  
    
  quit;


  data cereal_ds2;
    set cereal_ds;
    if shelf=1 then shelf1=1;
    else shelf1=0;
    if shelf=2 then shelf2=1;
    else shelf2=0;
    if shelf=3 then  shelf3=1;   
    else  shelf3=0;     
    shelf2_cal=shelf2*calories ;
	seq=_n_;
run;



/* dummy variables */

proc reg data=cereal_ds2  outest=est_cereal ;
     model     rating = calories shelf2    
                        /      VIF;
quit; 
      OUTPUT OUT=reg_cerealOUT  PREDICTED=PRED   RESIDUAL=Res   L95M=C_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=C_spredicted  STDR=C_s_residual  STUDENT=C_student     ;  
    
  quit;


proc reg data=cereal_ds2  outest=est_cereal ;
     model     rating = sugars fiber  sodium fat protein carbo calories vitamins 
                   
                        /   dwProb pcorr1  VIF selection=forward;
      OUTPUT OUT=reg_cerealOUT  PREDICTED=PRED   RESIDUAL=Res   L95M=C_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=C_spredicted  STDR=C_s_residual  STUDENT=C_student     ;  
    
  quit;


proc reg data=cereal_ds2  outest=est_cereal ;
     model     rating = sugars fiber shelf2 potass
                   
                        /   dwProb   VIF ;
      OUTPUT OUT=reg_cerealOUT  PREDICTED=PRED   RESIDUAL=Res   L95M=C_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=C_spredicted  STDR=C_s_residual  STUDENT=C_student     ;  
    
  quit;

