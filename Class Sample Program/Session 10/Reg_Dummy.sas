

data cereal_ds2;
    set cereal_ds;
    if shelf=1 then shelf1=1;
    else shelf1=0;
    if shelf=2 then shelf2=1;
    else shelf2=0;
    if shelf=3 then  shelf3=1;   
    else  shelf3=0;     
    *shelf2_cal=shelf2*calories ;
	*seq=_n_;
run;

/* dummy variables */

proc reg data=cereal_ds2  outest=est_cereal ;
     model     rating = calories shelf1 shelf2 shelf3 
                        /      VIF; 
quit;
