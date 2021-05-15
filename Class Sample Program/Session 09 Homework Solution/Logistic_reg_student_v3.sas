

proc copy in=sasdata out=work;
  select   churn  ;
RUN;

data churn2;
  set churn;
    if churn="False." then churn_ind=0;
    else churn_ind=1;
    if VMail_Plan='yes' then voiceplan_ind=1;
    else voiceplan_ind=0;
  
   if CustServ_Calls < 2 then Service_cat=0;
     else if  CustServ_Calls < 4 then  Service_cat=1;
      else  Service_cat=2;
  
  if   CustServ_Calls <2 then do;
      cs_temp1=0 ; 
	  cs_temp2=0;
   end;
   else if CustServ_Calls <4 then do;
      cs_temp1=1 ; 
	  cs_temp2=0 ;
   end;
   else do;
      cs_temp1=0 ; 
	  cs_temp2=1 ;
	end;
    if  CustServ_Calls < 4 then Service_ind=0;
    else   Service_ind=1;
    
    if  Int_l_Plan='no' then int_plan_ind=0;
    else  int_plan_ind=1;

run;



 Proc freq data=churn2; 
  table  churn_ind*voiceplan_ind    ;
 
run;


proc logistic data=churn2  descending;
  class  voiceplan_ind(ref='0')/ param=ref ;
  model   churn_ind=voiceplan_ind   ;
quit;

