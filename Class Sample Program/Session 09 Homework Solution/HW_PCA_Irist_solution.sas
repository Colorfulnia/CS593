
*-------------------------------------------------------------------------;
* Project        :  BIA652  Mulivariate Analysis                          ;
* Developer(s)   : Khasha Dehand                                          ;
* Comments       :  Lecture Principal Component                            ;
*                  Iris dataset                                           ;
*-------------------------------------------------------------------------;

* initalize the data ;
proc copy in=sashelp out=work;
   select iris ;
run;

title "Principal Component Analysis"; 
title2 " Univariate Analysis"; 
proc univariate data=iris;
   var SepalLength SepalWidth   PetalLength PetalWidth;
run;
title " "; 
title2 " ";
proc sgplot data= iris ;
  scatter     x=PetalWidth   y=PetalLength; 
run;

*** Normalize the data ***;
PROC STANDARD DATA=iris(keep= species  SepalLength  SepalWidth PetalLength PetalWidth)
              MEAN=0 STD=1 
             OUT=iris_z(rename=(SepalLength=SepalLength_z SepalWidth=SepalWidth_z  
                      PetalLength=PetalLength_z PetalWidth=PetalWidth_z  ));
  VAR  SepalLength  SepalWidth PetalWidth PetalLength ;
RUN;


*** calculate corrolations between variables ***;
title "Principal Component Analysis"; 
title2 " corrolation between variables"; 
proc corr data=iris_z; 
var  SepalLength_z SepalWidth_z PetalLength_z PetalWidth_z;
run;

 




proc princomp   data=iris_z  out=iris_pca_out;
   var  SepalLength_z SepalWidth_z PetalLength_z PetalWidth_z  ;
run;



