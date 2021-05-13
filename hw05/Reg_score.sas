


libname sasdata "W:\___Data\SASdata" access=read;run;
proc copy in=sasdata out=work;
  select cereal_ds churn;
run;

data training test;
  set cereal_ds;
  if mod(_n_,3)=0 then output test;
  else output training;
run; 
proc reg data=  training  outest=regout   ;
     model     rating = sugars fiber /STB SS1 SS2    ;
     *model     rating =  fiber /STB SS1 SS2    ;
      OUTPUT OUT=reg_cerealOUT  PREDICTED=c_predict
      RESIDUAL=c_Res   L95M=c_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=Cookd  dffits=dffit
         ;      
  quit; ;

  proc score
  proc score 
    
