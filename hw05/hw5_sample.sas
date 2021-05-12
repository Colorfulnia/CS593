/*****************
*Using the depression dataset, perform logistic regression, use age, sex, log(income), bed days and health as possible variables to predict depression.
*A person is considered depressed when Cat_total>=16;
*使用抑郁数据集，进行逻辑回归，使用年龄，性别，对数（收入），就寝天数和健康状况作为预测抑郁的可能变量。
*当Cat_total> = 16时，一个人被认为是沮丧的。
*****************/

data depression_v2;
  set depression;
  if Cat_total>=16 then depressed=1;
  else depressed=0;
run;
data depression_v3;
   set depression_v2;
   ln_income=log(income);
   
run;

proc freq data=depression_v3;
  table health ;
run; 
proc logistic data=depression_v3  descending   ;
  class health (ref='1')  ;
  model   depressed=age sex ln_income  health     ;  
quit;

proc logistic data=depression_v3  descending   ;
  class health (ref='1')  ;
  model   depressed=age sex   ln_income  health/noint ;  
quit;

data depression_v4;
   set depression_v3;
   if health<3 then dummy=0;
   else dummy=1;
   
run;

proc logistic data=depression_v4  descending   ;
  class  dummy (ref='0')  ;
  model   depressed=age sex   ln_income  dummy/noint ;  
quit;


/******************************/

libname sasdata "/folders/myfolders/sasuser.v94/SAS_data/";

proc copy in=sasdata out=work;
    select depression lung;
run;

proc reg data = lung;
    model FVC_father = Age_father Height_father;
run;

proc reg data = depression;
    model cat_total = income sex age;
run;

proc reg data = lung;
    model height_oldest_child = age_oldest_child height_mother height_father;
run;

/**************************/
libname sasdata "/folders/myfolders/sasuser.v94/SAS_data/";

proc copy in=sasdata out=work;
    select depression;
run;

data depression_b;
    set depression;
    if Cat_total>=16 then depressed=1;
    else depressed=0;
    log_income=log(income);
run;

proc logistic data=depression_b descending;
    model depressed=age sex log_income beddays health; 
run;

