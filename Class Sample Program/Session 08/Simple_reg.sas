

/****************************************************************** 
• Name:  
• Purpose: Simple Reg.
• SAS Program: Simple_reg  
• Date:   
• Description:
• Program Dependencies:  
• Data Dependencies:   
 ******************************************************************/


libname sasdata "C:\AIMS\Stevens_\___Data\SASdata";

proc copy in=sasdata out=work;
   select Cereal_ds ;
 run;

proc univariate data=Cereal_ds   normal plot;
var  rating  sugars  ;  
run;

proc corr data= Cereal_ds cov;
  var    rating  sugars  ;  
run;

proc reg data=Cereal_ds    ;
     model       rating =sugars     ;    
    OUTPUT OUT=Cereal_reg_out   
         h=Lev cookd=Cereal_cookd  dffits=cereal_dffits;
        
  quit;

proc univariate data= Cereal_reg_out    ;
var  Lev  Cereal_cookd cereal_dffits;  
run;
