

proc standard data=cereal_ds mean=0 std=1 
                                out=stnd_cereals;
var rating sugars fiber sodium;
run;


proc reg data=cereal_ds  outest=est_cereal ;
     model     rating = sugars fiber shelf  sodium fat protein carbo calories vitamins 
                        /   dwProb   VIF ;
      OUTPUT OUT=reg_cerealOUT  PREDICTED=   RESIDUAL=Res   L95M=C_l95m  U95M=C_u95m  L95=C_l95 U95=C_u95
       rstudent=C_rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=C_spredicted  STDR=C_s_residual       ;  
    
  quit;
