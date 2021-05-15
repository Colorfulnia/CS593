*-------------------------------------------------------------------------;
* Project        :  CS593-Data Mining II Final Exam                       ;
* Developer(s)   :  Yueyang Tao, 10458455                                 ;
* Comments       :  Solution for the Problem 3                            ;
*-------------------------------------------------------------------------;

libname sasdata "O:\CS-593\SAS_data";

proc copy in=sasdata out=work;
    select admission;
run;

proc freq data=admission;
	table rank;
run;

proc logistic data=admission descending;
	class rank (ref='1');
    model admit=rank gre gpa; 
run;
